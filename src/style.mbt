// style

///|
#external
pub(all) type CSSStyleDeclaration

///|
pub extern "js" fn Node::style(self : Node) -> CSSStyleDeclaration =
  #| (self) => self.style

// set_property

///|
pub extern "js" fn CSSStyleDeclaration::set_property(
  self : CSSStyleDeclaration,
  name : String,
  value : String,
) -> Unit =
  #| (self, name, value) => { self[name] = value }

// remove_property

///|
pub extern "js" fn CSSStyleDeclaration::remove_property(
  self : CSSStyleDeclaration,
  name : String,
) -> Unit =
  #| (self, name) => { delete self[name] }

// inject_style

///|
/// | Injects or updates a style element with the given id and CSS content.
/// | If a style element with the given id already exists, its content will be replaced.
/// |
/// | This is useful for dynamically adding CSS for animations, themes, or other runtime styling needs.
pub extern "js" fn inject_style(id : String, css : String) -> Unit =
  #| (id, css) => {
  #|   let el = document.getElementById(id);
  #|   if (el) {
  #|     el.textContent = css;
  #|   } else {
  #|     const style = document.createElement('style');
  #|     style.id = id;
  #|     style.textContent = css;
  #|     document.head.appendChild(style);
  #|   }
  #| }

// remove_style

///|
/// | Removes a style element with the given id from the document.
pub extern "js" fn remove_style(id : String) -> Unit =
  #| (id) => {
  #|   const el = document.getElementById(id);
  #|   if (el) { el.remove(); }
  #| }
