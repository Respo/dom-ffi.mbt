///|
/// | The `Document` interface represents any web page loaded in the browser and serves as an entry point into the web page's content, which is the DOM tree.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Document)
#external
pub(all) type Document

///|
/// | Returns the `document` object of a `window`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Window/document)
pub extern "js" fn Window::document(self : Window) -> Document =
  #| (self) => self.document

// body

///|
/// | Returns the `<body>` or `<frameset>` element, or `None` while the
/// | document has no body.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Document/body)
extern "js" fn Document::js_body(self : Document) -> JsObscure =
  #| (self) => self.body

///|
/// | Returns the `<body>` or `<frameset>` element, or `None` while the
/// | document has no body.
pub fn Document::body(self : Document) -> Element? {
  let body = self.js_body()
  if body.is_nil() {
    None
  } else {
    Some(js_obscure_to_v(body))
  }
}

// head

///|
/// | Returns the `<head>` element, or `None` when the document has no head.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Document/head)
extern "js" fn Document::js_head(self : Document) -> JsObscure =
  #| (self) => self.head

///|
/// | Returns the `<head>` element, or `None` when the document has no head.
pub fn Document::head(self : Document) -> Element? {
  let head = self.js_head()
  if head.is_nil() {
    None
  } else {
    Some(js_obscure_to_v(head))
  }
}

///|
/// | An internal helper function for `getElementById`.
extern "js" fn js_get_element_by_id(doc : Document, id : String) -> JsObscure =
  #| (doc, id) => doc.getElementById(id)

///|
/// | Returns a reference to the element by its ID.
/// | Returns `None` if no element with the specified ID is found.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementById)
pub fn Document::get_element_by_id(self : Document, id : String) -> Element? {
  let e = js_get_element_by_id(self, id)
  if e.is_nil() {
    None
  } else {
    Some(js_obscure_to_v(e))
  }
}

///|
/// | An internal helper function for `querySelector`.
extern "js" fn js_query_selector(
  doc : Document,
  selector : String,
) -> JsObscure =
  #| (doc, selector) => doc.querySelector(selector)

///|
/// | An internal helper function for `querySelectorAll`.
extern "js" fn js_query_selector_all(
  doc : Document,
  selector : String,
) -> Array[JsObscure] =
  #| (doc, selector) => Array.from(doc.querySelectorAll(selector))

///|
/// | Returns the first `Element` within the document that matches the specified selector, or group of selectors.
/// | If no matches are found, `None` is returned.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector)
pub fn Document::query_selector(self : Document, selector : String) -> Element? {
  let e = js_query_selector(self, selector)
  if e.is_nil() {
    None
  } else {
    Some(js_obscure_to_v(e))
  }
}

///|
/// | Returns a static (not live) `NodeList` representing a list of the document's elements that match the specified group of selectors.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelectorAll)
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
/// | Creates the HTML element specified by tagName.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Document/createElement)
pub extern "js" fn Document::create_element(
  self : Document,
  name : String,
) -> Element =
  #| (self, name) => self.createElement(name)

// Convenience functions for document queries (global scope)

///|
/// | Returns the first `Element` within the document that matches the specified selector, or `None` if no matches are found.
/// | Convenience function that uses the global document object.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector)
pub fn document_query_selector(selector : String) -> Element? {
  window().document().query_selector(selector)
}

///|
/// | Returns a static (not live) `NodeList` representing a list of the document's elements that match the specified group of selectors.
/// | Convenience function that uses the global document object.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelectorAll)
pub fn document_query_selector_all(selector : String) -> Array[Element] {
  window().document().query_selector_all(selector)
}

///|
/// | Returns a reference to the element by its ID.
/// | Convenience function that uses the global document object.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementById)
pub fn document_get_element_by_id(id : String) -> Element? {
  window().document().get_element_by_id(id)
}
