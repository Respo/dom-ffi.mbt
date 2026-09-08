///|
extern "js" fn add_clipboard_file(
  data : @dom_ffi.DataTransfer,
) -> @dom_ffi.File =
  #| (data) => {
  #|   const file = new File(["abc"], "clipboard.txt", {type: "text/plain"});
  #|   data.items.add(file);
  #|   return file;
  #| }

///|
fn run_clipboard_conformance() -> Unit {
  let data = @dom_ffi.DataTransfer::new()
  let items = data.items()
  browser_assert("clipboard empty types", data.types().length() == 0)
  browser_assert("clipboard empty items", items.length() == 0)
  browser_assert("clipboard negative item", items.item(-1) is None)
  browser_assert("clipboard empty index", items.item(0) is None)
  data.set_data("text/plain", "MoonBit paste")
  data.set_data("text/html", "<b>MoonBit paste</b>")
  let types = data.types()
  browser_assert("clipboard text types", types == ["text/plain", "text/html"])
  browser_assert("clipboard live item list", items.length() == 2)
  let text = items.item(0).unwrap()
  browser_assert("clipboard string kind", text.kind() == "string")
  browser_assert("clipboard string MIME", text.type_() == "text/plain")
  browser_assert("clipboard string not file", text.get_as_file() is None)
  let snapshot = items.to_array()
  let file = add_clipboard_file(data)
  browser_assert(
    "clipboard types snapshot",
    types == ["text/plain", "text/html"],
  )
  browser_assert(
    "clipboard files marker",
    data.types() == ["text/plain", "text/html", "Files"],
  )
  browser_assert(
    "clipboard array snapshot",
    snapshot.length() == 2 && items.length() == 3,
  )
  browser_assert(
    "clipboard snapshot contents",
    snapshot[0].kind() == "string" && snapshot[0].type_() == "text/plain",
  )
  let file_item = items.item(2).unwrap()
  browser_assert("clipboard file kind", file_item.kind() == "file")
  browser_assert("clipboard file MIME", file_item.type_() == "text/plain")
  let received = file_item.get_as_file().unwrap()
  browser_assert(
    "clipboard file identity",
    js_identity(
      @dom_ffi.v_to_js_obscure(file),
      @dom_ffi.v_to_js_obscure(received),
    ),
  )
  browser_assert(
    "clipboard file metadata",
    received.name() == "clipboard.txt" && received.size() == 3,
  )
  browser_assert("clipboard upper boundary", items.item(3) is None)
  browser_assert(
    "clipboard default null",
    @dom_ffi.ClipboardEvent::new("paste").clipboard_data() is None,
  )
  let init = @dom_ffi.ClipboardEventInit::new()
  init.set_clipboard_data(@dom_ffi.DataTransfer::new())
  browser_assert(
    "clipboard empty is present",
    @dom_ffi.ClipboardEvent::new_with_init_dict("paste", init).clipboard_data()
    is Some(_),
  )
  init.set_clipboard_data(data)
  init.set_bubbles(true)
  init.set_cancelable(true)
  let paste = @dom_ffi.ClipboardEvent::new_with_init_dict("paste", init)
  browser_assert(
    "clipboard data identity",
    js_identity(
      @dom_ffi.v_to_js_obscure(paste.clipboard_data().unwrap()),
      @dom_ffi.v_to_js_obscure(data),
    ),
  )
  let doc = @dom_ffi.window().document()
  let parent = doc.create_element("div")
  let child = doc.create_element("div")
  parent.append_child(child.reinterpret_as_node())
  let calls = Ref(0)
  parent
  .reinterpret_as_event_target()
  .add_event_listener("paste", fn(event) {
    calls.val = calls.val + 1
    let clipboard = event.reinterpret_as_clipboard_event()
    browser_assert(
      "clipboard dispatched text",
      clipboard.clipboard_data().unwrap().get_data("text/plain") ==
      "MoonBit paste",
    )
    event.prevent_default()
  })
  browser_assert(
    "clipboard canceled dispatch",
    !child
    .reinterpret_as_event_target()
    .dispatch_event(paste.reinterpret_as_event()),
  )
  browser_assert("clipboard bubbles once", calls.val == 1)
  browser_assert(
    "clipboard default prevented",
    paste.reinterpret_as_event().default_prevented(),
  )
}
