///|
/// | A browser object that can receive events and manage event listeners.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget)
#external
pub type EventTarget

///|
/// | Creates an isolated event target, which is useful for custom event channels
/// | and tests.
pub extern "js" fn EventTarget::new() -> EventTarget =
  #| () => new EventTarget()

///|
/// | Adds a listener for events with `type_`.
/// |
/// | Keep the same callback value to remove this listener later.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener)
pub extern "js" fn EventTarget::add_event_listener(
  self : EventTarget,
  type_ : String,
  listener : (Event) -> Unit,
) -> Unit =
  #| (self, type_, listener) => self.addEventListener(type_, listener)

///|
/// | Removes a listener previously added with the same event type and callback.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener)
pub extern "js" fn EventTarget::remove_event_listener(
  self : EventTarget,
  type_ : String,
  listener : (Event) -> Unit,
) -> Unit =
  #| (self, type_, listener) => self.removeEventListener(type_, listener)

///|
/// | Dispatches an event and returns `false` when a listener cancels a
/// | cancelable event.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent)
pub extern "js" fn EventTarget::dispatch_event(
  self : EventTarget,
  event : Event,
) -> Bool =
  #| (self, event) => self.dispatchEvent(event)

///|
/// | A generic browser event.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Event)
#external
pub type Event

///|
/// | Creates an event with the supplied type.
pub extern "js" fn Event::new(type_ : String) -> Event =
  #| (type_) => new Event(type_)

///|
/// | Creates an event and explicitly configures whether it bubbles or can be
/// | canceled.
pub extern "js" fn Event::new_with_options(
  type_ : String,
  bubbles? : Bool = false,
  cancelable? : Bool = false,
) -> Event =
  #| (type_, bubbles, cancelable) => new Event(type_, { bubbles, cancelable })

///|
/// | Returns the event type.
pub extern "js" fn Event::type_(self : Event) -> String =
  #| (self) => self.type

///|
/// | Returns whether this event bubbles.
pub extern "js" fn Event::bubbles(self : Event) -> Bool =
  #| (self) => self.bubbles

///|
/// | Returns whether listeners can cancel this event.
pub extern "js" fn Event::cancelable(self : Event) -> Bool =
  #| (self) => self.cancelable

///|
/// | Returns whether `prevent_default` has canceled this event.
pub extern "js" fn Event::default_prevented(self : Event) -> Bool =
  #| (self) => self.defaultPrevented

///|
/// | Cancels this event when it is cancelable.
pub extern "js" fn Event::prevent_default(self : Event) -> Unit =
  #| (self) => self.preventDefault()

///|
/// | Prevents the event from continuing to later propagation targets.
pub extern "js" fn Event::stop_propagation(self : Event) -> Unit =
  #| (self) => self.stopPropagation()

///|
extern "js" fn Event::js_target(self : Event) -> JsObscure =
  #| (self) => self.target

///|
/// | Returns the target that originally received the event, or `None` before
/// | the event is dispatched.
pub fn Event::target(self : Event) -> EventTarget? {
  let target = self.js_target()
  if target.is_nullish() {
    None
  } else {
    Some(js_obscure_to_v(target))
  }
}

///|
extern "js" fn Event::js_current_target(self : Event) -> JsObscure =
  #| (self) => self.currentTarget

///|
/// | Returns the event target whose listener is currently running, or `None`
/// | outside listener dispatch.
pub fn Event::current_target(self : Event) -> EventTarget? {
  let target = self.js_current_target()
  if target.is_nullish() {
    None
  } else {
    Some(js_obscure_to_v(target))
  }
}

///|
/// | Reinterprets a node as an `EventTarget` without changing the JavaScript
/// | value.
pub fn Node::reinterpret_as_event_target(self : Node) -> EventTarget = "%identity"

///|
/// | Reinterprets an element as an `EventTarget` without changing the
/// | JavaScript value.
pub fn Element::reinterpret_as_event_target(self : Element) -> EventTarget = "%identity"

///|
/// | Reinterprets a document as an `EventTarget` without changing the
/// | JavaScript value.
pub fn Document::reinterpret_as_event_target(self : Document) -> EventTarget = "%identity"

///|
/// | Reinterprets a window as an `EventTarget` without changing the JavaScript
/// | value.
pub fn Window::reinterpret_as_event_target(self : Window) -> EventTarget = "%identity"
