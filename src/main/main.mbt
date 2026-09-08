///|
extern "js" fn begin_conformance_report() -> Unit =
  #| () => {
  #|   globalThis.__domFfiConformance = {
  #|     passed: 0,
  #|     assertions: [],
  #|   };
  #| }

///|
extern "js" fn browser_assert(label : String, condition : Bool) -> Unit =
  #| (label, condition) => {
  #|   if (!condition) throw new Error(`DOM FFI conformance failed: ${label}`);
  #|   globalThis.__domFfiConformance.assertions.push(label);
  #|   globalThis.__domFfiConformance.passed += 1;
  #| }

///|
extern "js" fn js_identity(
  left : @dom_ffi.JsObscure,
  right : @dom_ffi.JsObscure,
) -> Bool =
  #| (left, right) => left === right

///|
extern "js" fn style_property(
  element : @dom_ffi.Element,
  name : String,
) -> String =
  #| (element, name) => element.style.getPropertyValue(name)

///|
extern "js" fn empty_document() -> @dom_ffi.Document =
  #| () => new Document()

///|
extern "js" fn synthetic_drag_event() -> @dom_ffi.DragEvent =
  #| () => new DragEvent("drag")

///|
extern "js" fn text_node(document : @dom_ffi.Document) -> @dom_ffi.Node =
  #| (document) => document.createTextNode("text")

///|
extern "js" fn foreign_data_view() -> @dom_ffi.JsObscure =
  #| () => {
  #|   const iframe = document.createElement("iframe");
  #|   iframe.style.display = "none";
  #|   document.body.appendChild(iframe);
  #|   const foreignWindow = iframe.contentWindow;
  #|   const result = new foreignWindow.DataView(new foreignWindow.ArrayBuffer(8));
  #|   iframe.remove();
  #|   return result;
  #| }

///|
extern "js" fn reset_event_listener(target : @dom_ffi.EventTarget) -> Unit =
  #| (target) => {
  #|   globalThis.__domFfiEventListener = { count: 0, target, currentTargetMatches: false };
  #| }

///|
extern "js" fn record_event(event : @dom_ffi.Event) -> Unit =
  #| (event) => {
  #|   const listener = globalThis.__domFfiEventListener;
  #|   listener.count += 1;
  #|   listener.currentTargetMatches = event.currentTarget === listener.target;
  #| }

///|
extern "js" fn recorded_event_count() -> Int =
  #| () => globalThis.__domFfiEventListener.count

///|
extern "js" fn recorded_current_target_matches() -> Bool =
  #| () => globalThis.__domFfiEventListener.currentTargetMatches

///|
extern "js" fn event_listener_option_enabled(
  options : @dom_ffi.EventListenerOptions,
  name : String,
) -> Bool =
  #| (options, name) => options[name] === true

///|
extern "js" fn attempt_event_prevent_default(event : @dom_ffi.Event) -> Unit =
  #| (event) => event.preventDefault()

///|
extern "js" fn file_input_with_files(
  document : @dom_ffi.Document,
) -> @dom_ffi.Element =
  #| (document) => {
  #|   const input = document.createElement("input");
  #|   input.type = "file";
  #|   const transfer = new DataTransfer();
  #|   transfer.items.add(new File(["one"], "one.txt", { type: "text/plain" }));
  #|   transfer.items.add(new File(["two"], "two.txt", { type: "text/plain" }));
  #|   input.files = transfer.files;
  #|   return input;
  #| }

///|
extern "js" fn data_transfer_with_file() -> @dom_ffi.DataTransfer =
  #| () => {
  #|   const transfer = new DataTransfer();
  #|   transfer.items.add(new File(["drop"], "drop.txt", { type: "text/plain" }));
  #|   return transfer;
  #| }

///|
extern "js" fn text_includes(text : String, part : String) -> Bool =
  #| (text, part) => text.includes(part)

///|
extern "js" fn reset_submit_report() -> Unit =
  #| () => { globalThis.__domFfiSubmitReport = { called: false, submitter: null, prevented: false }; }

///|
extern "js" fn record_submitter(
  submitter : @dom_ffi.Element,
  prevented : Bool,
) -> Unit =
  #| (submitter, prevented) => {
  #|   globalThis.__domFfiSubmitReport.called = true;
  #|   globalThis.__domFfiSubmitReport.submitter = submitter;
  #|   globalThis.__domFfiSubmitReport.prevented = prevented;
  #| }

///|
extern "js" fn record_submit_without_submitter(prevented : Bool) -> Unit =
  #| (prevented) => {
  #|   globalThis.__domFfiSubmitReport.called = true;
  #|   globalThis.__domFfiSubmitReport.submitter = null;
  #|   globalThis.__domFfiSubmitReport.prevented = prevented;
  #| }

///|
extern "js" fn submit_report_called() -> Bool =
  #| () => globalThis.__domFfiSubmitReport.called

///|
extern "js" fn submit_report_matches(submitter : @dom_ffi.Element) -> Bool =
  #| (submitter) => globalThis.__domFfiSubmitReport.submitter === submitter

///|
extern "js" fn submit_report_prevented() -> Bool =
  #| () => globalThis.__domFfiSubmitReport.prevented

///|
extern "js" fn submit_report_has_no_submitter() -> Bool =
  #| () => globalThis.__domFfiSubmitReport.submitter === null

///|
fn record_submit(event : @dom_ffi.Event) -> Unit {
  event.prevent_default()
  match event.reinterpret_as_submit_event().submitter() {
    Some(submitter) => record_submitter(submitter, event.default_prevented())
    None => record_submit_without_submitter(event.default_prevented())
  }
}

///|
fn main {
  begin_conformance_report()
  run_clipboard_conformance()
  let doc = @dom_ffi.window().document()
  browser_assert("document.body is Some", doc.body() is Some(_))
  browser_assert("document.head is Some", doc.head() is Some(_))
  let empty_doc = empty_document()
  browser_assert("empty Document.body is None", empty_doc.body() is None)
  browser_assert("empty Document.head is None", empty_doc.head() is None)
  browser_assert(
    "synthetic DragEvent.dataTransfer is None",
    synthetic_drag_event().data_transfer() is None,
  )
  let body = doc.body().unwrap()
  let fixture = doc.create_element("section")
  fixture.set_attribute("id", "dom-ffi-conformance")
  fixture.set_inner_html(
    "text<span class=\"dom-ffi-item\">one</span><span class=\"dom-ffi-item\">two</span>",
  )
  let fixture_node = fixture.reinterpret_as_node()
  browser_assert(
    "text node children is an empty Array",
    text_node(doc).children().is_empty(),
  )
  browser_assert(
    "cross-realm DataView is not a typed array",
    !foreign_data_view().is_typed_array(),
  )
  browser_assert(
    "detached node has no parent element",
    fixture_node.parent_element() is None,
  )
  browser_assert(
    "created element has an owner document",
    fixture_node.owner_document() is Some(_),
  )
  browser_assert(
    "owner document preserves identity",
    js_identity(
      @dom_ffi.v_to_js_obscure(fixture_node.owner_document().unwrap()),
      @dom_ffi.v_to_js_obscure(doc),
    ),
  )
  let document_node : @dom_ffi.Node = @dom_ffi.js_obscure_to_v(
    @dom_ffi.v_to_js_obscure(doc),
  )
  browser_assert(
    "Document.ownerDocument is None",
    document_node.owner_document() is None,
  )
  let node_snapshot = fixture_node.child_nodes()
  let element_snapshot = fixture_node.children()
  browser_assert("childNodes converts to Array", node_snapshot.length() == 3)
  browser_assert("children converts to Array", element_snapshot.length() == 2)
  browser_assert(
    "children elements keep their tag type",
    element_snapshot[0].tag_name() == "SPAN",
  )
  browser_assert(
    "firstChild is available",
    fixture_node.first_child() is Some(_),
  )
  let extra = doc.create_element("em")
  extra.set_attribute("class", "dom-ffi-item")
  fixture.append_child(extra.reinterpret_as_node())
  browser_assert("childNodes result is a snapshot", node_snapshot.length() == 3)
  browser_assert(
    "children result is a snapshot",
    element_snapshot.length() == 2,
  )
  browser_assert(
    "fresh childNodes sees appended nodes",
    fixture_node.child_nodes().length() == 4,
  )
  browser_assert(
    "fresh children sees appended elements",
    fixture_node.children().length() == 3,
  )
  body.append_child(fixture_node)
  browser_assert(
    "attached node reports parent element",
    fixture_node.parent_element() is Some(_),
  )
  browser_assert(
    "parent element has expected tag",
    fixture_node.parent_element().unwrap().tag_name() == "BODY",
  )
  browser_assert(
    "querySelectorAll returns all matching elements",
    doc.query_selector_all(".dom-ffi-item").length() == 3,
  )
  browser_assert(
    "querySelectorAll returns an empty Array",
    doc.query_selector_all(".dom-ffi-missing").is_empty(),
  )
  browser_assert(
    "missing dataset key maps to None",
    fixture.data_attribute("phase") is None,
  )
  fixture.set_data_attribute("phase", "verified")
  browser_assert(
    "present dataset key maps to Some",
    fixture.data_attribute("phase") == Some("verified"),
  )
  let params = @dom_ffi.new_url_search_params("phase=verified")
  browser_assert(
    "URLSearchParams present value maps to Some",
    params.get("phase") == Some("verified"),
  )
  browser_assert(
    "URLSearchParams missing value maps to None",
    params.get("missing") is None,
  )
  browser_assert(
    "URLSearchParams getAll returns a MoonBit Array",
    params.get_all("phase") == ["verified"],
  )
  browser_assert(
    "URLSearchParams getAll returns an empty Array",
    params.get_all("missing").is_empty(),
  )
  let style = fixture_node.style()
  style.set_property("background-color", "rgb(1, 2, 3)")
  browser_assert(
    "CSS setProperty supports hyphenated names",
    style_property(fixture, "background-color") == "rgb(1, 2, 3)",
  )
  style.remove_property("background-color")
  browser_assert(
    "CSS removeProperty clears hyphenated names",
    style_property(fixture, "background-color") == "",
  )
  let event_target = @dom_ffi.EventTarget::new()
  reset_event_listener(event_target)
  event_target.add_event_listener("dom-ffi", record_event)
  let event = @dom_ffi.Event::new_with_options(
    "dom-ffi",
    bubbles=true,
    cancelable=true,
  )
  browser_assert("Event preserves its type", event.type_() == "dom-ffi")
  browser_assert("Event preserves bubbles", event.bubbles())
  browser_assert("Event preserves cancelable", event.cancelable())
  browser_assert("Event target is None before dispatch", event.target() is None)
  browser_assert(
    "Event dispatch succeeds before cancellation",
    event_target.dispatch_event(event),
  )
  browser_assert("Event listener runs once", recorded_event_count() == 1)
  browser_assert(
    "Event currentTarget matches the listener target",
    recorded_current_target_matches(),
  )
  browser_assert(
    "Event target preserves identity after dispatch",
    js_identity(
      @dom_ffi.v_to_js_obscure(event.target().unwrap()),
      @dom_ffi.v_to_js_obscure(event_target),
    ),
  )
  browser_assert(
    "Event currentTarget is None outside dispatch",
    event.current_target() is None,
  )
  event_target.remove_event_listener("dom-ffi", record_event)
  browser_assert(
    "Event listener removal preserves callback identity",
    event_target.dispatch_event(@dom_ffi.Event::new("dom-ffi")) &&
    recorded_event_count() == 1,
  )
  event.prevent_default()
  browser_assert(
    "Event preventDefault marks a cancelable event",
    event.default_prevented(),
  )
  browser_assert(
    "Canceled Event dispatch returns false",
    !event_target.dispatch_event(event),
  )
  let listener_options = @dom_ffi.EventListenerOptions::new()
  listener_options.set_capture(true)
  listener_options.set_once(true)
  listener_options.set_passive(true)
  browser_assert(
    "Event listener options preserve capture",
    event_listener_option_enabled(listener_options, "capture"),
  )
  browser_assert(
    "Event listener options preserve once",
    event_listener_option_enabled(listener_options, "once"),
  )
  browser_assert(
    "Event listener options preserve passive",
    event_listener_option_enabled(listener_options, "passive"),
  )
  let once_target = @dom_ffi.EventTarget::new()
  reset_event_listener(once_target)
  let once_options = @dom_ffi.EventListenerOptions::new()
  once_options.set_once(true)
  once_target.add_event_listener_with_options(
    "once", record_event, once_options,
  )
  browser_assert(
    "Once listener dispatch succeeds",
    once_target.dispatch_event(@dom_ffi.Event::new("once")),
  )
  browser_assert("Once listener runs once", recorded_event_count() == 1)
  browser_assert(
    "Once listener is removed after its first invocation",
    once_target.dispatch_event(@dom_ffi.Event::new("once")) &&
    recorded_event_count() == 1,
  )
  let capture_target = body.reinterpret_as_event_target()
  reset_event_listener(capture_target)
  let capture_options = @dom_ffi.EventListenerOptions::new()
  capture_options.set_capture(true)
  capture_target.add_event_listener_with_options(
    "capture", record_event, capture_options,
  )
  browser_assert(
    "Capture listener dispatch succeeds",
    fixture
    .reinterpret_as_event_target()
    .dispatch_event(@dom_ffi.Event::new_with_options("capture", bubbles=true)),
  )
  browser_assert(
    "Capture listener receives the event in its phase",
    recorded_event_count() == 1 && recorded_current_target_matches(),
  )
  capture_target.remove_event_listener_with_options(
    "capture", record_event, capture_options,
  )
  browser_assert(
    "Capture listener removal matches its capture setting",
    fixture
    .reinterpret_as_event_target()
    .dispatch_event(@dom_ffi.Event::new_with_options("capture", bubbles=true)) &&
    recorded_event_count() == 1,
  )
  let passive_target = @dom_ffi.EventTarget::new()
  let passive_options = @dom_ffi.EventListenerOptions::new()
  passive_options.set_passive(true)
  passive_target.add_event_listener_with_options(
    "passive", attempt_event_prevent_default, passive_options,
  )
  let passive_event = @dom_ffi.Event::new_with_options(
    "passive",
    cancelable=true,
  )
  browser_assert(
    "Passive listener dispatch remains uncanceled",
    passive_target.dispatch_event(passive_event),
  )
  browser_assert(
    "Passive listener cannot prevent the default action",
    !passive_event.default_prevented(),
  )
  let pointer_init = @dom_ffi.PointerEventInit::new()
  pointer_init.set_button(2)
  pointer_init.set_buttons(3)
  pointer_init.set_pointer_id(42)
  pointer_init.set_pressure(0.5)
  pointer_init.set_client_x(12.5)
  pointer_init.set_client_y(24.5)
  let pointer_event = @dom_ffi.PointerEvent::new_with_init_dict(
    "pointermove", pointer_init,
  )
  browser_assert("PointerEvent preserves button", pointer_event.button() == 2)
  browser_assert("PointerEvent preserves buttons", pointer_event.buttons() == 3)
  browser_assert(
    "PointerEvent preserves pointerId",
    pointer_event.pointer_id() == 42,
  )
  browser_assert(
    "PointerEvent preserves pressure",
    pointer_event.pressure() == 0.5,
  )
  browser_assert(
    "PointerEvent preserves clientX",
    pointer_event.client_x() == 12.5,
  )
  browser_assert(
    "PointerEvent preserves clientY",
    pointer_event.client_y() == 24.5,
  )
  browser_assert(
    "PointerEvent dispatch succeeds",
    @dom_ffi.EventTarget::new().dispatch_event(
      pointer_event.reinterpret_as_event(),
    ),
  )
  let wheel_init = @dom_ffi.WheelEventInit::new()
  wheel_init.set_delta_x(1.25)
  wheel_init.set_delta_y(-2.5)
  wheel_init.set_delta_mode(1)
  let wheel_event = @dom_ffi.WheelEvent::new_with_init_dict("wheel", wheel_init)
  browser_assert("WheelEvent preserves deltaX", wheel_event.delta_x() == 1.25)
  browser_assert("WheelEvent preserves deltaY", wheel_event.delta_y() == -2.5)
  browser_assert(
    "WheelEvent preserves deltaMode",
    wheel_event.delta_mode() == 1,
  )
  browser_assert(
    "WheelEvent dispatch succeeds",
    @dom_ffi.EventTarget::new().dispatch_event(
      wheel_event.reinterpret_as_event(),
    ),
  )
  let blob = @dom_ffi.Blob::new_from_text("hello", type_="text/plain")
  browser_assert("Blob preserves byte size", blob.size() == 5)
  browser_assert("Blob preserves MIME type", blob.type_() == "text/plain")
  let file = @dom_ffi.File::new_from_text(
    "note.txt",
    "hello",
    type_="text/plain",
  )
  browser_assert("File preserves name", file.name() == "note.txt")
  browser_assert("File preserves byte size", file.size() == 5)
  browser_assert("File preserves MIME type", file.type_() == "text/plain")
  browser_assert("File has a lastModified timestamp", file.last_modified() > 0)
  let form_data = @dom_ffi.FormData::new()
  form_data.append_text("tag", "first")
  form_data.append_text("tag", "second")
  browser_assert("FormData records a text key", form_data.has("tag"))
  browser_assert(
    "FormData get returns its first text value",
    match form_data.get("tag") {
      Some(Text("first")) => true
      _ => false
    },
  )
  browser_assert(
    "FormData getAll preserves duplicate text values",
    match form_data.get_all("tag") {
      [Text("first"), Text("second")] => true
      _ => false
    },
  )
  form_data.set_text("tag", "replaced")
  browser_assert(
    "FormData set replaces duplicate text values",
    match form_data.get_all("tag") {
      [Text("replaced")] => true
      _ => false
    },
  )
  form_data.append_file("upload", file)
  browser_assert(
    "FormData get returns a typed file value",
    match form_data.get("upload") {
      Some(File(upload)) =>
        upload.name() == "note.txt" && upload.type_() == "text/plain"
      _ => false
    },
  )
  form_data.delete("tag")
  browser_assert("FormData delete removes every value", !form_data.has("tag"))
  browser_assert(
    "Missing FormData value maps to None",
    form_data.get("tag") is None,
  )
  let checkbox = doc.create_element("input").reinterpret_as_html_input_element()
  checkbox.set_checked(true)
  browser_assert("HtmlInputElement preserves checked", checkbox.checked())
  let file_input = file_input_with_files(doc).reinterpret_as_html_input_element()
  browser_assert("File input files is Some", file_input.files() is Some(_))
  let files = file_input.files().unwrap()
  browser_assert("FileList preserves file count", files.length() == 2)
  browser_assert(
    "FileList item returns the requested file",
    files.item(0).unwrap().name() == "one.txt",
  )
  browser_assert("FileList missing item maps to None", files.item(2) is None)
  let file_snapshot = files.to_array()
  browser_assert(
    "FileList converts to a MoonBit Array",
    file_snapshot.length() == 2,
  )
  browser_assert(
    "FileList snapshot preserves file order",
    file_snapshot[1].name() == "two.txt",
  )
  let dropped_files = data_transfer_with_file().files()
  browser_assert(
    "DataTransfer files exposes FileList",
    dropped_files.length() == 1,
  )
  browser_assert(
    "DataTransfer files preserves file metadata",
    dropped_files.item(0).unwrap().name() == "drop.txt",
  )
  browser_assert(
    "Missing attribute maps to None",
    fixture.get_attribute("role") is None,
  )
  fixture.set_attribute("role", "region")
  browser_assert(
    "getAttribute preserves a present value",
    fixture.get_attribute("role") == Some("region"),
  )
  browser_assert(
    "hasAttribute sees a present value",
    fixture.has_attribute("role"),
  )
  browser_assert(
    "toggleAttribute enables an absent attribute",
    fixture.toggle_attribute("hidden"),
  )
  browser_assert(
    "toggleAttribute records enabled state",
    fixture.has_attribute("hidden"),
  )
  browser_assert(
    "toggleAttribute force removes an attribute",
    !fixture.toggle_attribute_with_force("hidden", false),
  )
  browser_assert(
    "Removed attribute maps to None",
    fixture.get_attribute("hidden") is None,
  )
  let class_list = fixture.class_list()
  class_list.add("active")
  browser_assert(
    "classList add makes a token visible",
    class_list.contains("active"),
  )
  browser_assert(
    "classList toggle adds an absent token",
    class_list.toggle("badge"),
  )
  browser_assert(
    "classList toggle token is present",
    class_list.contains("badge"),
  )
  browser_assert(
    "classList toggle removes a present token",
    !class_list.toggle("badge"),
  )
  browser_assert(
    "classList removes the toggled token",
    !class_list.contains("badge"),
  )
  class_list.remove("active")
  browser_assert(
    "classList remove clears a token",
    !class_list.contains("active"),
  )
  class_list.add("token-a")
  class_list.add("token-b")
  let token_snapshot = class_list.to_array()
  browser_assert(
    "classList converts to a MoonBit Array",
    token_snapshot == ["token-a", "token-b"],
  )
  class_list.remove("token-b")
  browser_assert(
    "classList snapshot remains stable",
    token_snapshot == ["token-a", "token-b"],
  )
  browser_assert(
    "classList live collection updates",
    !class_list.contains("token-b"),
  )
  browser_assert(
    "Element matches its id selector",
    fixture.matches("#dom-ffi-conformance"),
  )
  browser_assert(
    "Element rejects a nonmatching selector",
    !fixture.matches(".missing"),
  )
  let matched_items = fixture.query_selector_all(".dom-ffi-item")
  browser_assert(
    "Element querySelectorAll finds descendants",
    matched_items.length() == 3,
  )
  browser_assert(
    "Element querySelectorAll returns an empty Array when missing",
    fixture.query_selector_all(".missing").is_empty(),
  )
  browser_assert(
    "Element closest finds its containing section",
    js_identity(
      @dom_ffi.v_to_js_obscure(matched_items[0].closest("section").unwrap()),
      @dom_ffi.v_to_js_obscure(fixture),
    ),
  )
  browser_assert(
    "Element closest maps a missing ancestor to None",
    fixture.closest("article") is None,
  )
  browser_assert(
    "firstElementChild skips a text node",
    fixture.first_element_child().unwrap().tag_name() == "SPAN",
  )
  browser_assert(
    "lastElementChild finds the appended element",
    fixture.last_element_child().unwrap().tag_name() == "EM",
  )
  browser_assert(
    "nextElementSibling finds the following item",
    matched_items[0].next_element_sibling().unwrap().tag_name() == "SPAN",
  )
  browser_assert(
    "previousElementSibling finds the preceding item",
    js_identity(
      @dom_ffi.v_to_js_obscure(
        matched_items[1].previous_element_sibling().unwrap(),
      ),
      @dom_ffi.v_to_js_obscure(matched_items[0]),
    ),
  )
  browser_assert(
    "first element sibling maps previous absence to None",
    matched_items[0].previous_element_sibling() is None,
  )
  browser_assert(
    "last element sibling maps next absence to None",
    fixture.last_element_child().unwrap().next_element_sibling() is None,
  )
  browser_assert(
    "Element contains its descendant",
    fixture.contains(extra.reinterpret_as_node()),
  )
  browser_assert(
    "Element does not contain its ancestor",
    !extra.contains(fixture_node),
  )
  browser_assert(
    "Element textContent preserves text",
    fixture.text_content() == "textonetwo",
  )
  browser_assert(
    "Node textContent preserves text-node content",
    fixture_node.first_child().unwrap().text_content() == Some("text"),
  )
  browser_assert(
    "Document textContent maps null to None",
    document_node.text_content() is None,
  )
  browser_assert(
    "Element innerHTML exposes contained markup",
    text_includes(fixture.inner_html(), "dom-ffi-item"),
  )
  let form_element = doc.create_element("form")
  let form = form_element.reinterpret_as_html_form_element()
  form.set_submission_method("post")
  browser_assert(
    "HtmlFormElement preserves method",
    form.submission_method() == "post",
  )
  browser_assert(
    "HtmlFormElement validates valid controls",
    form.check_validity(),
  )
  let input_element = doc.create_element("input")
  input_element.set_attribute("name", "title")
  input_element.set_attribute("value", "default title")
  let input = input_element.reinterpret_as_html_input_element()
  input.set_value("MoonBit")
  form_element.append_child(input_element.reinterpret_as_node())
  let select_element = doc.create_element("select")
  select_element.set_attribute("name", "level")
  select_element.set_inner_html(
    "<option value=\"basic\">Basic</option><option value=\"advanced\">Advanced</option>",
  )
  let select = select_element.reinterpret_as_html_select_element()
  select.set_value("advanced")
  browser_assert(
    "HtmlSelectElement preserves selected value",
    select.value() == "advanced",
  )
  form_element.append_child(select_element.reinterpret_as_node())
  let button_element = doc.create_element("button")
  button_element.set_attribute("type", "submit")
  button_element.set_attribute("name", "intent")
  let button = button_element.reinterpret_as_html_button_element()
  button.set_value("save")
  browser_assert("HtmlButtonElement preserves value", button.value() == "save")
  browser_assert("HtmlButtonElement starts enabled", !button.disabled())
  button.set_disabled(true)
  browser_assert("HtmlButtonElement preserves disabled", button.disabled())
  button.set_disabled(false)
  form_element.append_child(button_element.reinterpret_as_node())
  let input_submitter = doc.create_element("input")
  input_submitter.set_attribute("type", "submit")
  input_submitter.set_attribute("name", "secondary-intent")
  input_submitter.set_attribute("value", "secondary")
  form_element.append_child(input_submitter.reinterpret_as_node())
  body.append_child(form_element.reinterpret_as_node())
  let form_data = @dom_ffi.FormData::new_from_form(form)
  browser_assert(
    "FormData from a form preserves input value",
    match form_data.get("title") {
      Some(Text("MoonBit")) => true
      _ => false
    },
  )
  browser_assert(
    "FormData from a form preserves select value",
    match form_data.get("level") {
      Some(Text("advanced")) => true
      _ => false
    },
  )
  browser_assert(
    "FormData from a form excludes an unclicked submit button",
    form_data.get("intent") is None,
  )
  form.reset()
  browser_assert(
    "HtmlFormElement reset restores input default",
    input.value() == "default title",
  )
  browser_assert(
    "HtmlFormElement reset restores select default",
    select.value() == "basic",
  )
  browser_assert(
    "FormData from a form remains a snapshot after reset",
    match form_data.get("title") {
      Some(Text("MoonBit")) => true
      _ => false
    },
  )
  browser_assert(
    "SubmitEvent without an init submitter maps to None",
    @dom_ffi.SubmitEvent::new("submit").submitter() is None,
  )
  let submit_init = @dom_ffi.SubmitEventInit::new()
  submit_init.set_submitter(button_element)
  let synthetic_submit = @dom_ffi.SubmitEvent::new_with_init_dict(
    "submit", submit_init,
  )
  browser_assert(
    "SubmitEvent init preserves submitter identity",
    js_identity(
      @dom_ffi.v_to_js_obscure(synthetic_submit.submitter().unwrap()),
      @dom_ffi.v_to_js_obscure(button_element),
    ),
  )
  reset_submit_report()
  form_element
  .reinterpret_as_event_target()
  .add_event_listener("submit", record_submit)
  form.request_submit_with_submitter(button_element)
  browser_assert(
    "requestSubmit dispatches a submit event",
    submit_report_called(),
  )
  browser_assert(
    "requestSubmit reports its button submitter",
    submit_report_matches(button_element),
  )
  browser_assert(
    "SubmitEvent listener can prevent default",
    submit_report_prevented(),
  )
  reset_submit_report()
  form.request_submit()
  browser_assert(
    "requestSubmit without an argument dispatches a submit event",
    submit_report_called(),
  )
  browser_assert(
    "requestSubmit without an argument maps submitter to None",
    submit_report_has_no_submitter(),
  )
  reset_submit_report()
  form.request_submit_with_submitter(input_submitter)
  browser_assert(
    "requestSubmit accepts an input submitter",
    submit_report_called(),
  )
  browser_assert(
    "requestSubmit preserves input submitter identity",
    submit_report_matches(input_submitter),
  )
}
