///|
#external
pub(all) type Document

///|
pub extern "js" fn Window::document(self : Window) -> Document =
  #| (self) => self.document

// body

///|
pub extern "js" fn Document::body(self : Document) -> Element =
  #| (self) => self.body

// head

///|
pub extern "js" fn Document::head(self : Document) -> Element =
  #| (self) => self.head

///|
extern "js" fn js_query_selector(
  doc : Document,
  selector : String,
) -> JsObscure =
  #| (doc, selector) => doc.querySelector(selector)

///|
extern "js" fn js_query_selector_all(
  doc : Document,
  selector : String,
) -> Array[JsObscure] =
  #| (doc, selector) => doc.querySelectorAll(selector)

///|
/// Query a single element from the document.
pub fn Document::query_selector(self : Document, selector : String) -> Element? {
  let e = js_query_selector(self, selector)
  if e.is_nil() {
    None
  } else {
    Some(js_obscure_to_v(js_obscure_to_v(e)))
  }
}

///|
pub fn Document::query_selector_all(
  self : Document,
  selector : String,
) -> Array[Element] {
  let data = js_query_selector_all(self, selector)
  let len = data.length()
  let result : Array[Element] = []
  for i in 0..<len {
    let e = data.get(i).unwrap_or(JsObscure::undefined())
    result.push(js_obscure_to_v(e))
  }
  result
}

// create_element

///|
pub extern "js" fn Document::create_element(
  self : Document,
  name : String,
) -> Element =
  #| (self, name) => self.createElement(name)
