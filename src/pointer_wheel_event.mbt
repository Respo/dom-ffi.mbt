///|
/// | A pointer input event, covering mouse, pen, and touch input.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent)
#external
pub type PointerEvent

///|
/// | Creates a pointer event with the supplied initialization dictionary.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/PointerEvent)
pub extern "js" fn PointerEvent::new_with_init_dict(
  type_ : String,
  init : PointerEventInit,
) -> PointerEvent =
  #| (type_, init) => new PointerEvent(type_, init)

///|
/// | Returns the button whose state changed, or `-1` for a move event.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/button)
pub extern "js" fn PointerEvent::button(self : PointerEvent) -> Int =
  #| (self) => self.button

///|
/// | Returns the bitmask of currently pressed buttons.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/buttons)
pub extern "js" fn PointerEvent::buttons(self : PointerEvent) -> Int =
  #| (self) => self.buttons

///|
/// | Returns the pointer identifier that remains stable for its active input.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pointerId)
pub extern "js" fn PointerEvent::pointer_id(self : PointerEvent) -> Int =
  #| (self) => self.pointerId

///|
/// | Returns the normalized pressure, from `0.0` to `1.0`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pressure)
pub extern "js" fn PointerEvent::pressure(self : PointerEvent) -> Float =
  #| (self) => self.pressure

///|
/// | Returns the horizontal pointer position within the viewport.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientX)
pub extern "js" fn PointerEvent::client_x(self : PointerEvent) -> Float =
  #| (self) => self.clientX

///|
/// | Returns the vertical pointer position within the viewport.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientY)
pub extern "js" fn PointerEvent::client_y(self : PointerEvent) -> Float =
  #| (self) => self.clientY

///|
/// | Reinterprets this pointer event as the generic `Event` used by
/// | `EventTarget` APIs.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent)
pub fn PointerEvent::reinterpret_as_event(self : PointerEvent) -> Event = "%identity"

///|
/// | Initialization values for a `PointerEvent`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/PointerEvent#options)
#external
pub type PointerEventInit

///|
/// | Creates an empty pointer-event initialization dictionary.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/PointerEvent#options)
pub extern "js" fn PointerEventInit::new() -> PointerEventInit =
  #| () => ({})

///|
/// | Sets the changed button value.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/button)
pub extern "js" fn PointerEventInit::set_button(
  self : PointerEventInit,
  button : Int,
) -> Unit =
  #| (self, button) => { self.button = button }

///|
/// | Sets the bitmask of pressed buttons.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/buttons)
pub extern "js" fn PointerEventInit::set_buttons(
  self : PointerEventInit,
  buttons : Int,
) -> Unit =
  #| (self, buttons) => { self.buttons = buttons }

///|
/// | Sets the stable pointer identifier.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pointerId)
pub extern "js" fn PointerEventInit::set_pointer_id(
  self : PointerEventInit,
  pointer_id : Int,
) -> Unit =
  #| (self, pointer_id) => { self.pointerId = pointer_id }

///|
/// | Sets normalized pointer pressure.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pressure)
pub extern "js" fn PointerEventInit::set_pressure(
  self : PointerEventInit,
  pressure : Float,
) -> Unit =
  #| (self, pressure) => { self.pressure = pressure }

///|
/// | Sets the horizontal pointer position in viewport coordinates.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientX)
pub extern "js" fn PointerEventInit::set_client_x(
  self : PointerEventInit,
  client_x : Float,
) -> Unit =
  #| (self, client_x) => { self.clientX = client_x }

///|
/// | Sets the vertical pointer position in viewport coordinates.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientY)
pub extern "js" fn PointerEventInit::set_client_y(
  self : PointerEventInit,
  client_y : Float,
) -> Unit =
  #| (self, client_y) => { self.clientY = client_y }

///|
/// | A wheel event with normalized scroll deltas.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent)
#external
pub type WheelEvent

///|
/// | Creates a wheel event with the supplied initialization dictionary.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/WheelEvent)
pub extern "js" fn WheelEvent::new_with_init_dict(
  type_ : String,
  init : WheelEventInit,
) -> WheelEvent =
  #| (type_, init) => new WheelEvent(type_, init)

///|
/// | Returns the horizontal scroll amount.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaX)
pub extern "js" fn WheelEvent::delta_x(self : WheelEvent) -> Float =
  #| (self) => self.deltaX

///|
/// | Returns the vertical scroll amount.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaY)
pub extern "js" fn WheelEvent::delta_y(self : WheelEvent) -> Float =
  #| (self) => self.deltaY

///|
/// | Returns the unit used by `delta_x` and `delta_y`: pixel (`0`), line
/// | (`1`), or page (`2`).
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaMode)
pub extern "js" fn WheelEvent::delta_mode(self : WheelEvent) -> Int =
  #| (self) => self.deltaMode

///|
/// | Reinterprets this wheel event as the generic `Event` used by
/// | `EventTarget` APIs.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent)
pub fn WheelEvent::reinterpret_as_event(self : WheelEvent) -> Event = "%identity"

///|
/// | Initialization values for a `WheelEvent`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/WheelEvent#options)
#external
pub type WheelEventInit

///|
/// | Creates an empty wheel-event initialization dictionary.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/WheelEvent#options)
pub extern "js" fn WheelEventInit::new() -> WheelEventInit =
  #| () => ({})

///|
/// | Sets the horizontal scroll amount.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaX)
pub extern "js" fn WheelEventInit::set_delta_x(
  self : WheelEventInit,
  delta_x : Float,
) -> Unit =
  #| (self, delta_x) => { self.deltaX = delta_x }

///|
/// | Sets the vertical scroll amount.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaY)
pub extern "js" fn WheelEventInit::set_delta_y(
  self : WheelEventInit,
  delta_y : Float,
) -> Unit =
  #| (self, delta_y) => { self.deltaY = delta_y }

///|
/// | Sets the delta unit: pixel (`0`), line (`1`), or page (`2`).
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaMode)
pub extern "js" fn WheelEventInit::set_delta_mode(
  self : WheelEventInit,
  delta_mode : Int,
) -> Unit =
  #| (self, delta_mode) => { self.deltaMode = delta_mode }
