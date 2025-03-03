///|
pub(all) extern type Document

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
pub extern "js" fn Document::query_selector(
  self : Document,
  selector : String
) -> Element =
  #| (self, selector) => self.querySelector(selector)
