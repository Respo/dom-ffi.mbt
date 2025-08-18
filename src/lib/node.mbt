///| DOM Node type
/// <https://developer.mozilla.org/en-US/docs/Web/API/Node>
#external
pub(all) type Node

///|
pub extern "js" fn Node::child_nodes(self : Node) -> Array[Node] =
  #| (self) => self.childNodes

// children

///|
pub extern "js" fn Node::children(self : Node) -> Array[Node] =
  #| (self) => self.children

///|
pub extern "js" fn Node::reinterpret_as_element(self : Node) -> Element =
  #| (self) => self

// reinterpret_as_node

///|
pub extern "js" fn Element::reinterpret_as_node(self : Element) -> Node =
  #| (self) => self

// first_child

///|
pub extern "js" fn Node::first_child(self : Node) -> Node =
  #| (self) => self.firstChild

///|
#external
pub(all) type Element

///|
pub extern "js" fn Element::set_inner_html(
  self : Element,
  html : String,
) -> Unit =
  #| (self, html) => { self.innerHTML = html }

///|
pub extern "js" fn Element::set_inner_text(
  self : Element,
  text : String,
) -> Unit =
  #| (self, text) => { self.innerText = text }

///|
pub extern "js" fn Element::set_html_for(self : Element, html : String) -> Unit =
  #| (self, html) => { self.htmlFor = html }

///|
pub extern "js" fn Element::tag_name(self : Element) -> String =
  #| (self) => self.tagName

///|
pub extern "js" fn Element::set_attribute(
  self : Element,
  name : String,
  value : String,
) -> Unit =
  #| (self, name, value) => { self.setAttribute(name, value) }

// remove_attribute

///|
pub extern "js" fn Element::remove_attribute(
  self : Element,
  name : String,
) -> Unit =
  #| (self, name) => { self.removeAttribute(name) }

///|
pub extern "js" fn Element::set_data_attribute(
  self : Element,
  name : String,
  value : String,
) -> Unit =
  #| (self, name, value) => { self.dataset[name] = value }

///|
pub extern "js" fn Element::data_attribute(
  self : Element,
  name : String,
) -> String =
  #| (self, name) => self.dataset[name]

///|
pub extern "js" fn Element::remove_data_attribute(
  self : Element,
  name : String,
) -> Unit =
  #| (self, name) => { delete self.dataset[name] }

///|
pub extern "js" fn Element::append_child(self : Element, child : Node) -> Unit =
  #| (self, child) => { self.appendChild(child) }

// set_onkeypress on input

///|
pub extern "js" fn HtmlInputElement::set_onkeypress(
  self : HtmlInputElement,
  f : ((KeyboardEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onkeypress = f }

// set_onkeypress on textarea

///|
pub extern "js" fn HtmlTextAreaElement::set_onkeypress(
  self : HtmlTextAreaElement,
  f : ((KeyboardEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onkeypress = f }

// set_onkeydown on input

///|
pub extern "js" fn HtmlInputElement::set_onkeydown(
  self : HtmlInputElement,
  f : ((KeyboardEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onkeydown = f }

// set_onkeydown on textarea

///|
pub extern "js" fn HtmlTextAreaElement::set_onkeydown(
  self : HtmlTextAreaElement,
  f : ((KeyboardEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onkeydown = f }

// set_onkeyup on input

///|
pub extern "js" fn HtmlInputElement::set_onkeyup(
  self : HtmlInputElement,
  f : ((KeyboardEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onkeyup = f }

// set_onkeyup on textarea

///|
pub extern "js" fn HtmlTextAreaElement::set_onkeyup(
  self : HtmlTextAreaElement,
  f : ((KeyboardEvent) -> Unit)?,
) -> Unit =
  #| (self, f) =>  { self.onkeyup = f }

///|
pub extern "js" fn Node::clone_node(self : Node, deep~ : Bool = false) -> Node =
  #| (self, deep) => self.cloneNode(deep)

///|
pub extern "js" fn Node::owner_document(self : Node) -> Document =
  #| (self) => self.ownerDocument

///|
#external
pub(all) type HtmlInputElement

///|
pub extern "js" fn Element::reinterpret_as_html_input_element(
  self : Element,
) -> HtmlInputElement =
  #| (self) => self

///|
#external
pub(all) type HtmlTextAreaElement

// set_onblur

///|
pub extern "js" fn HtmlInputElement::set_onblur(
  self : HtmlInputElement,
  f : ((BlurEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onblur = f }

// set_onfocus on input

///|
pub extern "js" fn HtmlInputElement::set_onfocus(
  self : HtmlInputElement,
  f : ((FocusEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onfocus = f }

// set_onblur on textarea

///|
pub extern "js" fn HtmlTextAreaElement::set_onblur(
  self : HtmlTextAreaElement,
  f : ((BlurEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onblur = f }

// set_onfocus on textarea

///|
pub extern "js" fn HtmlTextAreaElement::set_onfocus(
  self : HtmlTextAreaElement,
  f : ((FocusEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onfocus = f }

// set_onchange on input

///|
pub extern "js" fn HtmlInputElement::set_onchange(
  self : HtmlInputElement,
  f : ((InputEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onchange = f }

// set_onchange on textarea

///|
pub extern "js" fn HtmlTextAreaElement::set_onchange(
  self : HtmlTextAreaElement,
  f : ((InputEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onchange = f }

// set_oninput on input

///|
pub extern "js" fn HtmlInputElement::set_oninput(
  self : HtmlInputElement,
  f : (InputEvent) -> Unit,
) -> Unit =
  #| (self, f) => { self.oninput = f }

///|
pub extern "js" fn HtmlInputElement::unset_oninput(
  self : HtmlInputElement,
) -> Unit =
  #| (self) => { self.oninput = null }

// set_oninput on textarea

///|
pub extern "js" fn HtmlTextAreaElement::set_oninput(
  self : HtmlTextAreaElement,
  f : ((InputEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.oninput = f }

///|
pub extern "js" fn HtmlInputElement::value(self : HtmlInputElement) -> String =
  #| (self) => self.value

///|
pub extern "js" fn HtmlInputElement::set_value(
  self : HtmlInputElement,
  value : String,
) -> Unit =
  #| (self, value) => { self.value = value }

///|
pub extern "js" fn HtmlTextAreaElement::value(
  self : HtmlTextAreaElement,
) -> String =
  #| (self) => self.value

///|
pub extern "js" fn HtmlTextAreaElement::set_value(
  self : HtmlTextAreaElement,
  value : String,
) -> Unit =
  #| (self, value) => { self.value = value }

// parent_element

///|
pub extern "js" fn Node::parent_element(self : Node) -> Element =
  #| (self) => self.parentElement

///|
pub extern "js" fn Element::reinterpret_as_html_textarea_element(
  self : Element,
) -> HtmlTextAreaElement =
  #| (self) => self

// remove

///|
pub extern "js" fn Node::remove(self : Node) -> Unit =
  #| (self) => { self.remove() }

// remove_child from Node

///|
pub extern "js" fn Node::remove_child(self : Node, child : Node) -> Unit =
  #| (self, child) => { self.removeChild(child) }

// set_onclick

///|
pub extern "js" fn Element::set_onclick(
  self : Element,
  f : (MouseEvent) -> Unit,
) -> Unit =
  #| (self, f) => { self.onclick = f }

///|
pub extern "js" fn Element::unset_onclick(self : Element) -> Unit =
  #| (self) => { self.onclick = null }

// set_ondblclick

///|
pub extern "js" fn Element::set_ondblclick(
  self : Element,
  f : (MouseEvent) -> Unit,
) -> Unit =
  #| (self, f) => { self.ondblclick = f }

///|
pub extern "js" fn Element::unset_ondblclick(self : Element) -> Unit =
  #| (self) = > { self.ondbclick = null }

///|
pub extern "js" fn Element::query_selector(
  self : Element,
  selector : String,
) -> Element =
  #| (self, selector) => self.querySelector(selector)

// create_element

///|
pub extern "js" fn Document::create_element(
  self : Document,
  name : String,
) -> Element =
  #| (self, name) => self.createElement(name)

///|
pub extern "js" fn Node::append_child(self : Node, child : Node) -> Unit =
  #| (self, child) => self.appendChild(child)

///| insert_before on Node

///| notice that `Option[T]` is using `._0` to get the value, which may be unstable
pub extern "js" fn Node::insert_before(
  self : Node,
  new_child : Node,
  reference_child : Node?,
) -> Unit =
  #| (self, new_child, reference_child) => { self.insertBefore(new_child, reference_child?._0) }

// target on input event

///|
pub extern "js" fn InputEvent::target(self : InputEvent) -> Element =
  #| (self) => self.target

///|
pub extern "js" fn Element::focus(self : Element) -> Unit =
  #| (self) => self?.focus()
