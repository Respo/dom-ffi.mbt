///|
/// | A set-like collection of CSS class tokens.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList)
#external
pub type DomTokenList

///|
/// | Returns the class-token collection for this element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/classList)
pub extern "js" fn Element::class_list(self : Element) -> DomTokenList =
  #| (self) => self.classList

///|
/// | Adds a class token when it is not already present.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/add)
pub extern "js" fn DomTokenList::add(
  self : DomTokenList,
  token : String,
) -> Unit =
  #| (self, token) => self.add(token)

///|
/// | Removes a class token when it is present.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/remove)
pub extern "js" fn DomTokenList::remove(
  self : DomTokenList,
  token : String,
) -> Unit =
  #| (self, token) => self.remove(token)

///|
/// | Returns whether this collection contains `token`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/contains)
pub extern "js" fn DomTokenList::contains(
  self : DomTokenList,
  token : String,
) -> Bool =
  #| (self, token) => self.contains(token)

///|
/// | Toggles a class token and returns whether it is present afterwards.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/toggle)
pub extern "js" fn DomTokenList::toggle(
  self : DomTokenList,
  token : String,
) -> Bool =
  #| (self, token) => self.toggle(token)

///|
extern "js" fn DomTokenList::js_to_array(
  self : DomTokenList,
) -> FixedArray[String] =
  #| (self) => Array.from(self)

///|
/// | Returns a snapshot MoonBit array of the tokens in their current order.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList)
pub fn DomTokenList::to_array(self : DomTokenList) -> Array[String] {
  Array::from_fixed_array(self.js_to_array())
}

///|
extern "js" fn Element::js_get_attribute(
  self : Element,
  name : String,
) -> JsObscure =
  #| (self, name) => self.getAttribute(name)

///|
/// | Returns an attribute value, or `None` when the attribute is absent.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttribute)
pub fn Element::get_attribute(self : Element, name : String) -> String? {
  let value = self.js_get_attribute(name)
  if value.is_nullish() {
    None
  } else {
    Some(js_obscure_to_v(value))
  }
}

///|
/// | Returns whether this element has an attribute with `name`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/hasAttribute)
pub extern "js" fn Element::has_attribute(
  self : Element,
  name : String,
) -> Bool =
  #| (self, name) => self.hasAttribute(name)

///|
/// | Toggles an attribute and returns whether it is present afterwards.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/toggleAttribute)
pub extern "js" fn Element::toggle_attribute(
  self : Element,
  name : String,
) -> Bool =
  #| (self, name) => self.toggleAttribute(name)

///|
/// | Forces an attribute present or absent and returns its resulting presence.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/toggleAttribute)
pub extern "js" fn Element::toggle_attribute_with_force(
  self : Element,
  name : String,
  force : Bool,
) -> Bool =
  #| (self, name, force) => self.toggleAttribute(name, force)

///|
/// | Returns whether this element matches a CSS selector.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/matches)
pub extern "js" fn Element::matches(self : Element, selectors : String) -> Bool =
  #| (self, selectors) => self.matches(selectors)

///|
extern "js" fn Element::js_closest(
  self : Element,
  selectors : String,
) -> JsObscure =
  #| (self, selectors) => self.closest(selectors)

///|
/// | Returns the nearest ancestor (including this element) that matches, or
/// | `None` when no such ancestor exists.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/closest)
pub fn Element::closest(self : Element, selectors : String) -> Element? {
  let element = self.js_closest(selectors)
  if element.is_nullish() {
    None
  } else {
    Some(js_obscure_to_v(element))
  }
}

///|
extern "js" fn Element::js_query_selector_all(
  self : Element,
  selectors : String,
) -> FixedArray[Element] =
  #| (self, selectors) => Array.from(self.querySelectorAll(selectors))

///|
/// | Returns a snapshot MoonBit array of descendants matching `selectors`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/querySelectorAll)
pub fn Element::query_selector_all(
  self : Element,
  selectors : String,
) -> Array[Element] {
  Array::from_fixed_array(self.js_query_selector_all(selectors))
}

///|
extern "js" fn Element::js_first_element_child(self : Element) -> JsObscure =
  #| (self) => self.firstElementChild

///|
/// | Returns the first child element, or `None` when no child element exists.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/firstElementChild)
pub fn Element::first_element_child(self : Element) -> Element? {
  let child = self.js_first_element_child()
  if child.is_nullish() {
    None
  } else {
    Some(js_obscure_to_v(child))
  }
}

///|
extern "js" fn Element::js_last_element_child(self : Element) -> JsObscure =
  #| (self) => self.lastElementChild

///|
/// | Returns the last child element, or `None` when no child element exists.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/lastElementChild)
pub fn Element::last_element_child(self : Element) -> Element? {
  let child = self.js_last_element_child()
  if child.is_nullish() {
    None
  } else {
    Some(js_obscure_to_v(child))
  }
}

///|
extern "js" fn Element::js_previous_element_sibling(
  self : Element,
) -> JsObscure =
  #| (self) => self.previousElementSibling

///|
/// | Returns the preceding element sibling, or `None` at the beginning.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/previousElementSibling)
pub fn Element::previous_element_sibling(self : Element) -> Element? {
  let sibling = self.js_previous_element_sibling()
  if sibling.is_nullish() {
    None
  } else {
    Some(js_obscure_to_v(sibling))
  }
}

///|
extern "js" fn Element::js_next_element_sibling(self : Element) -> JsObscure =
  #| (self) => self.nextElementSibling

///|
/// | Returns the following element sibling, or `None` at the end.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/nextElementSibling)
pub fn Element::next_element_sibling(self : Element) -> Element? {
  let sibling = self.js_next_element_sibling()
  if sibling.is_nullish() {
    None
  } else {
    Some(js_obscure_to_v(sibling))
  }
}

///|
/// | Returns whether this element contains `other`, including itself.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Node/contains)
pub extern "js" fn Element::contains(self : Element, other : Node) -> Bool =
  #| (self, other) => self.contains(other)

///|
extern "js" fn Node::js_text_content(self : Node) -> JsObscure =
  #| (self) => self.textContent

///|
/// | Returns node text content, or `None` for node kinds such as `Document`
/// | whose DOM `textContent` is `null`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Node/textContent)
pub fn Node::text_content(self : Node) -> String? {
  let content = self.js_text_content()
  if content.is_nullish() {
    None
  } else {
    Some(js_obscure_to_v(content))
  }
}

///|
/// | Returns this element's text content.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Node/textContent)
pub extern "js" fn Element::text_content(self : Element) -> String =
  #| (self) => self.textContent

///|
/// | Returns the serialized HTML markup contained by this element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/innerHTML)
pub extern "js" fn Element::inner_html(self : Element) -> String =
  #| (self) => self.innerHTML
