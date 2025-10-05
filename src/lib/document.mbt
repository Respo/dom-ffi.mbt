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
/// | Returns the `<body>` or `<frameset>` node of the current document.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Document/body)
pub extern "js" fn Document::body(self : Document) -> Element =
  #| (self) => self.body

// head

///|
/// | Returns the `<head>` element of the current document.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Document/head)
pub extern "js" fn Document::head(self : Document) -> Element =
  #| (self) => self.head

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
  #| (doc, selector) => doc.querySelectorAll(selector)

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
    Some(js_obscure_to_v(js_obscure_to_v(e)))
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
