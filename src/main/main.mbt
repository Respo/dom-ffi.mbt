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
fn main {
  begin_conformance_report()
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
}
