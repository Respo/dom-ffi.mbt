pub(all) type Document

pub extern "js" fn document(self : Window) -> Document =
  #| (self) => self.document

// body
pub extern "js" fn body(self : Document) -> Element =
  #| (self) => self.body

// head
pub extern "js" fn head(self : Document) -> Element =
  #| (self) => self.head

pub extern "js" fn query_selector(
  self : Document,
  selector : String
) -> Element =
  #| (self, selector) => self.querySelector(selector)
