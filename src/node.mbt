///|
/// | An interface from which a number of DOM API object types inherit.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Node)
#external
pub(all) type Node

///|
/// | Returns a live `NodeList` of child nodes of the given `Node`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Node/childNodes)
pub extern "js" fn Node::child_nodes(self : Node) -> Array[Node] =
  #| (self) => self.childNodes

// children

///|
/// | Returns a live `HTMLCollection` containing all of the `Element` children of the node upon which it was called.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/children)
pub extern "js" fn Node::children(self : Node) -> Array[Node] =
  #| (self) => self.children

///|
/// | Reinterprets a `Node` as an `Element`. This is a type cast and does not change the underlying object.
pub extern "js" fn Node::reinterpret_as_element(self : Node) -> Element =
  #| (self) => self

// reinterpret_as_node

///|
/// | Reinterprets an `Element` as a `Node`. This is a type cast and does not change the underlying object.
pub extern "js" fn Element::reinterpret_as_node(self : Element) -> Node =
  #| (self) => self

// first_child

///|
/// | Internal helper to get the first child as `JsObscure`.
extern "js" fn Node::js_get_first_child(self : Node) -> JsObscure =
  #| (self) => self.firstChild

///|
/// | Returns the node's first child in the tree, or `None` if the node has no children.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Node/firstChild)
pub fn Node::first_child(self : Node) -> Node? {
  let first_child = self.js_get_first_child()
  if first_child.is_nil() {
    None
  } else {
    Some(js_obscure_to_v(first_child))
  }
}

///|
/// | The most general base class from which all objects in a `Document` inherit.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element)
#external
pub(all) type Element

///|
/// | Sets the HTML markup contained within the element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/innerHTML)
pub extern "js" fn Element::set_inner_html(
  self : Element,
  html : String,
) -> Unit =
  #| (self, html) => { self.innerHTML = html }

///|
/// | Sets the text content of a node and its descendants.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Node/textContent)
pub extern "js" fn Element::set_inner_text(
  self : Element,
  text : String,
) -> Unit =
  #| (self, text) => { self.innerText = text }

///|
/// | Sets the `for` attribute of a label element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLLabelElement/htmlFor)
pub extern "js" fn Element::set_html_for(self : Element, html : String) -> Unit =
  #| (self, html) => { self.htmlFor = html }

///|
/// | Returns the tag name of the element in upper case.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/tagName)
pub extern "js" fn Element::tag_name(self : Element) -> String =
  #| (self) => self.tagName

///|
/// | Sets the value of an attribute on the specified element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute)
pub extern "js" fn Element::set_attribute(
  self : Element,
  name : String,
  value : String,
) -> Unit =
  #| (self, name, value) => { self.setAttribute(name, value) }

// remove_attribute

///|
/// | Removes an attribute from the specified element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/removeAttribute)
pub extern "js" fn Element::remove_attribute(
  self : Element,
  name : String,
) -> Unit =
  #| (self, name) => { self.removeAttribute(name) }

///|
/// | Sets a custom data attribute (`data-*`).
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dataset)
pub extern "js" fn Element::set_data_attribute(
  self : Element,
  name : String,
  value : String,
) -> Unit =
  #| (self, name, value) => { self.dataset[name] = value }

///|
/// | Gets the value of a custom data attribute (`data-*`).
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dataset)
pub extern "js" fn Element::data_attribute(
  self : Element,
  name : String,
) -> String =
  #| (self, name) => self.dataset[name]

///|
/// | Removes a custom data attribute (`data-*`).
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dataset)
pub extern "js" fn Element::remove_data_attribute(
  self : Element,
  name : String,
) -> Unit =
  #| (self, name) => { delete self.dataset[name] }

///|
/// | Adds a node to the end of the list of children of a specified parent node.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Node/appendChild)
pub extern "js" fn Element::append_child(self : Element, child : Node) -> Unit =
  #| (self, child) => { self.appendChild(child) }

// set_onkeypress on input

///|
/// | Sets the `onkeypress` event handler for an `<input>` element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onkeypress)
pub extern "js" fn HtmlInputElement::set_onkeypress(
  self : HtmlInputElement,
  f : ((KeyboardEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onkeypress = f }

// set_onkeypress on textarea

///|
/// | Sets the `onkeypress` event handler for a `<textarea>` element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onkeypress)
pub extern "js" fn HtmlTextAreaElement::set_onkeypress(
  self : HtmlTextAreaElement,
  f : ((KeyboardEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onkeypress = f }

// set_onkeydown on input

///|
/// | Sets the `onkeydown` event handler for an `<input>` element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onkeydown)
pub extern "js" fn HtmlInputElement::set_onkeydown(
  self : HtmlInputElement,
  f : ((KeyboardEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onkeydown = f }

// set_onkeydown on textarea

///|
/// | Sets the `onkeydown` event handler for a `<textarea>` element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onkeydown)
pub extern "js" fn HtmlTextAreaElement::set_onkeydown(
  self : HtmlTextAreaElement,
  f : ((KeyboardEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onkeydown = f }

// set_onkeyup on input

///|
/// | Sets the `onkeyup` event handler for an `<input>` element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onkeyup)
pub extern "js" fn HtmlInputElement::set_onkeyup(
  self : HtmlInputElement,
  f : ((KeyboardEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onkeyup = f }

// set_onkeyup on textarea

///|
/// | Sets the `onkeyup` event handler for a `<textarea>` element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onkeyup)
pub extern "js" fn HtmlTextAreaElement::set_onkeyup(
  self : HtmlTextAreaElement,
  f : ((KeyboardEvent) -> Unit)?,
) -> Unit =
  #| (self, f) =>  { self.onkeyup = f }

///|
/// | Returns a duplicate of the node on which this method was called.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Node/cloneNode)
pub extern "js" fn Node::clone_node(self : Node, deep? : Bool = false) -> Node =
  #| (self, deep) => self.cloneNode(deep)

///|
/// | Returns the `Document` object associated with the node.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Node/ownerDocument)
pub extern "js" fn Node::owner_document(self : Node) -> Document =
  #| (self) => self.ownerDocument

///|
/// | Provides an interface for the HTML `<input>` element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLInputElement)
#external
pub(all) type HtmlInputElement

///|
/// | Reinterprets an `Element` as an `HtmlInputElement`.
pub extern "js" fn Element::reinterpret_as_html_input_element(
  self : Element,
) -> HtmlInputElement =
  #| (self) => self

///|
/// | Provides an interface for the HTML `<textarea>` element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLTextAreaElement)
#external
pub(all) type HtmlTextAreaElement

// set_onblur

///|
/// | Sets the `onblur` event handler for an `<input>` element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onblur)
pub extern "js" fn HtmlInputElement::set_onblur(
  self : HtmlInputElement,
  f : ((BlurEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onblur = f }

// set_onfocus on input

///|
/// | Sets the `onfocus` event handler for an `<input>` element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onfocus)
pub extern "js" fn HtmlInputElement::set_onfocus(
  self : HtmlInputElement,
  f : ((FocusEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onfocus = f }

// set_onblur on textarea

///|
/// | Sets the `onblur` event handler for a `<textarea>` element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onblur)
pub extern "js" fn HtmlTextAreaElement::set_onblur(
  self : HtmlTextAreaElement,
  f : ((BlurEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onblur = f }

// set_onfocus on textarea

///|
/// | Sets the `onfocus` event handler for a `<textarea>` element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onfocus)
pub extern "js" fn HtmlTextAreaElement::set_onfocus(
  self : HtmlTextAreaElement,
  f : ((FocusEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onfocus = f }

// set_onchange on input

///|
/// | Sets the `onchange` event handler for an `<input>` element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onchange)
pub extern "js" fn HtmlInputElement::set_onchange(
  self : HtmlInputElement,
  f : ((InputEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onchange = f }

// set_onchange on textarea

///|
/// | Sets the `onchange` event handler for a `<textarea>` element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onchange)
pub extern "js" fn HtmlTextAreaElement::set_onchange(
  self : HtmlTextAreaElement,
  f : ((InputEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.onchange = f }

// set_oninput on input

///|
/// | Sets the `oninput` event handler for an `<input>` element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/oninput)
pub extern "js" fn HtmlInputElement::set_oninput(
  self : HtmlInputElement,
  f : (InputEvent) -> Unit,
) -> Unit =
  #| (self, f) => { self.oninput = f }

///|
/// | Removes the `oninput` event handler from an `<input>` element.
pub extern "js" fn HtmlInputElement::unset_oninput(
  self : HtmlInputElement,
) -> Unit =
  #| (self) => { self.oninput = null }

// set_oninput on textarea

///|
/// | Sets the `oninput` event handler for a `<textarea>` element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/oninput)
pub extern "js" fn HtmlTextAreaElement::set_oninput(
  self : HtmlTextAreaElement,
  f : ((InputEvent) -> Unit)?,
) -> Unit =
  #| (self, f) => { self.oninput = f }

///|
/// | Gets the current value of the input element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLInputElement/value)
pub extern "js" fn HtmlInputElement::value(self : HtmlInputElement) -> String =
  #| (self) => self.value

///|
/// | Sets the value of the input element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLInputElement/value)
pub extern "js" fn HtmlInputElement::set_value(
  self : HtmlInputElement,
  value : String,
) -> Unit =
  #| (self, value) => { self.value = value }

///|
/// | Gets the current value of the textarea element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLTextAreaElement/value)
pub extern "js" fn HtmlTextAreaElement::value(
  self : HtmlTextAreaElement,
) -> String =
  #| (self) => self.value

///|
/// | Sets the value of the textarea element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLTextAreaElement/value)
pub extern "js" fn HtmlTextAreaElement::set_value(
  self : HtmlTextAreaElement,
  value : String,
) -> Unit =
  #| (self, value) => { self.value = value }

// parent_element

///|
/// | Returns the parent `Element` of the specified node in the DOM tree.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Node/parentElement)
pub extern "js" fn Node::parent_element(self : Node) -> Element =
  #| (self) => self.parentElement

///|
/// | Reinterprets an `Element` as an `HtmlTextAreaElement`.
pub extern "js" fn Element::reinterpret_as_html_textarea_element(
  self : Element,
) -> HtmlTextAreaElement =
  #| (self) => self

// remove

///|
/// | Removes the object from the tree it belongs to.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove)
pub extern "js" fn Node::remove(self : Node) -> Unit =
  #| (self) => { self.remove() }

// remove_child from Node

///|
/// | Removes a child node from the DOM and returns the removed node.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Node/removeChild)
pub extern "js" fn Node::remove_child(self : Node, child : Node) -> Unit =
  #| (self, child) => { self.removeChild(child) }

// set_onclick

///|
/// | Sets the `onclick` event handler for an element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onclick)
pub extern "js" fn Element::set_onclick(
  self : Element,
  f : (MouseEvent) -> Unit,
) -> Unit =
  #| (self, f) => { self.onclick = f }

///|
/// | Removes the `onclick` event handler from an element.
pub extern "js" fn Element::unset_onclick(self : Element) -> Unit =
  #| (self) => { self.onclick = null }

// set_ondblclick

///|
/// | Sets the `ondblclick` event handler for an element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/ondblclick)
pub extern "js" fn Element::set_ondblclick(
  self : Element,
  f : (MouseEvent) -> Unit,
) -> Unit =
  #| (self, f) => { self.ondblclick = f }

///|
/// | Removes the `ondblclick` event handler from an element.
pub extern "js" fn Element::unset_ondblclick(self : Element) -> Unit =
  #| (self) = > { self.ondbclick = null }

///|
/// | Internal helper for `querySelector`.
pub extern "js" fn Element::js_query_selector(
  self : Element,
  selector : String,
) -> JsObscure =
  #| (self, selector) => self.querySelector(selector)

///|
/// | Returns the first `Element` within the element that matches the specified selector.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Element/querySelector)
pub fn Element::query_selector(self : Element, selector : String) -> Element? {
  let result = self.js_query_selector(selector)
  if result.is_nil() {
    None
  } else {
    Some(js_obscure_to_v(result))
  }
}

///|
/// | Adds a node to the end of the list of children of a specified parent node.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Node/appendChild)
pub extern "js" fn Node::append_child(self : Node, child : Node) -> Unit =
  #| (self, child) => self.appendChild(child)

///|
/// | Internal helper for `insertBefore`.
extern "js" fn Node::js_insert_before(
  self : Node,
  new_child : Node,
  reference_child : JsObscure,
) -> Unit =
  #| (self, new_child, reference_child) => { self.insertBefore(new_child, reference_child) }

///|
/// | Inserts a node before a reference node as a child of a specified parent node.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Node/insertBefore)
pub fn Node::insert_before(
  self : Node,
  new_child : Node,
  reference_child : Node?,
) -> Unit {
  match reference_child {
    None => self.js_insert_before(new_child, JsObscure::null())
    Some(ref_child) =>
      self.js_insert_before(new_child, v_to_js_obscure(ref_child))
  }
}
// target on input event

///|
/// | Returns the object to which a dispatched event is targeted.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Event/target)
pub extern "js" fn InputEvent::target(self : InputEvent) -> Element =
  #| (self) => self.target

///|
/// | Sets focus on the specified element, if it can be focused.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/focus)
pub extern "js" fn Element::focus(self : Element) -> Unit =
  #| (self) => { 
  #|   if (self) {
  #|     self.focus()
  #|   } else {
  #|     console.warn("Trying to focus on a null element");
  #|   }
  #| }

///|
/// cast Element to JsObjectObscure
pub fn Element::to_js_object(self : Element) -> JsObjectObscure = "%identity"

///|
/// cast Node to JsObjectObscure
pub fn Node::to_js_object(self : Node) -> JsObjectObscure = "%identity"

// Drag and Drop events

///|
/// | Sets the `ondragstart` event handler for an element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/ondragstart)
pub extern "js" fn Element::set_ondragstart(
  self : Element,
  f : (DragEvent) -> Unit,
) -> Unit =
  #| (self, f) => { self.ondragstart = f }

///|
/// | Removes the `ondragstart` event handler from an element.
pub extern "js" fn Element::unset_ondragstart(self : Element) -> Unit =
  #| (self) => { self.ondragstart = null }

///|
/// | Sets the `ondragend` event handler for an element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/ondragend)
pub extern "js" fn Element::set_ondragend(
  self : Element,
  f : (DragEvent) -> Unit,
) -> Unit =
  #| (self, f) => { self.ondragend = f }

///|
/// | Removes the `ondragend` event handler from an element.
pub extern "js" fn Element::unset_ondragend(self : Element) -> Unit =
  #| (self) => { self.ondragend = null }

///|
/// | Sets the `ondragover` event handler for an element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/ondragover)
pub extern "js" fn Element::set_ondragover(
  self : Element,
  f : (DragEvent) -> Unit,
) -> Unit =
  #| (self, f) => { self.ondragover = f }

///|
/// | Removes the `ondragover` event handler from an element.
pub extern "js" fn Element::unset_ondragover(self : Element) -> Unit =
  #| (self) => { self.ondragover = null }

///|
/// | Sets the `ondragenter` event handler for an element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/ondragenter)
pub extern "js" fn Element::set_ondragenter(
  self : Element,
  f : (DragEvent) -> Unit,
) -> Unit =
  #| (self, f) => { self.ondragenter = f }

///|
/// | Removes the `ondragenter` event handler from an element.
pub extern "js" fn Element::unset_ondragenter(self : Element) -> Unit =
  #| (self) => { self.ondragenter = null }

///|
/// | Sets the `ondragleave` event handler for an element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/ondragleave)
pub extern "js" fn Element::set_ondragleave(
  self : Element,
  f : (DragEvent) -> Unit,
) -> Unit =
  #| (self, f) => { self.ondragleave = f }

///|
/// | Removes the `ondragleave` event handler from an element.
pub extern "js" fn Element::unset_ondragleave(self : Element) -> Unit =
  #| (self) => { self.ondragleave = null }

///|
/// | Sets the `ondrop` event handler for an element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/ondrop)
pub extern "js" fn Element::set_ondrop(
  self : Element,
  f : (DragEvent) -> Unit,
) -> Unit =
  #| (self, f) => { self.ondrop = f }

///|
/// | Removes the `ondrop` event handler from an element.
pub extern "js" fn Element::unset_ondrop(self : Element) -> Unit =
  #| (self) => { self.ondrop = null }

///|
/// | Sets the `ondrag` event handler for an element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/ondrag)
pub extern "js" fn Element::set_ondrag(
  self : Element,
  f : (DragEvent) -> Unit,
) -> Unit =
  #| (self, f) => { self.ondrag = f }

///|
/// | Removes the `ondrag` event handler from an element.
pub extern "js" fn Element::unset_ondrag(self : Element) -> Unit =
  #| (self) => { self.ondrag = null }
