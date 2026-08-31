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
}
