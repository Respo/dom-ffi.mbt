// style
///|
pub(all) type CSSStyleDeclaration

///|
pub extern "js" fn Node::style(self : Node) -> CSSStyleDeclaration =
  #| (self) => self.style

// set_property
///|
pub extern "js" fn CSSStyleDeclaration::set_property(
  self : CSSStyleDeclaration,
  name : String,
  value : String
) -> Unit =
  #| (self, name, value) => { self[name] = value }

// remove_property
///|
pub extern "js" fn CSSStyleDeclaration::remove_property(
  self : CSSStyleDeclaration,
  name : String
) -> Unit =
  #| (self, name) => { delete self[name] }
