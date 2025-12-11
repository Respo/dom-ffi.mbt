///|
/// window
#external
pub(all) type Window

///|
pub extern "js" fn window() -> Window =
  #| () => window

// add_event_listener_with_callback

///|
pub extern "js" fn Window::add_event_listener_with_callback(
  self : Window,
  type_ : String,
  f : JsFnObscure,
) -> Unit =
  #| (self, type, f) => { self.addEventListener(type, f) }

// remove_event_listener_with_callback

///|
pub extern "js" fn Window::remove_event_listener_with_callback(
  self : Window,
  type_ : String,
  f : JsFnObscure,
) -> Unit =
  #| (self, type, f) => { self.removeEventListener(type, f) }

///|
/// | Calls a function after a specified delay.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setTimeout)
pub extern "js" fn Window::set_timeout(
  self : Window,
  f : () -> Unit,
  ms : UInt,
) -> Int =
  #| (self, f, ms) => self.setTimeout(f, ms)

///|
/// | Cancels a timeout previously established by calling `set_timeout`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/clearTimeout)
pub extern "js" fn Window::clear_timeout(self : Window, id : Int) -> Unit =
  #| (self, id) => self.clearTimeout(id)

///|
/// | Repeatedly calls a function with a fixed time delay between each call.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setInterval)
pub extern "js" fn Window::set_interval(
  self : Window,
  f : () -> Unit,
  ms : UInt,
) -> Int =
  #| (self, f, ms) => self.setInterval(f, ms)

///|
/// | Cancels a timed, repeating action previously established by a call to `set_interval`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/clearInterval)
pub extern "js" fn Window::clear_interval(self : Window, id : Int) -> Unit =
  #| (self, id) => self.clearInterval(id)

///|
/// | Tells the browser that you wish to perform an animation and requests the browser to call a specified function to update an animation before the next repaint.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/window/requestAnimationFrame)
pub extern "js" fn Window::request_animation_frame(
  self : Window,
  f : (Float) -> Unit,
) -> Int =
  #| (self, f) => self.requestAnimationFrame(f)

///|
/// | Cancels an animation frame request previously scheduled through a call to `request_animation_frame`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Window/cancelAnimationFrame)
pub extern "js" fn Window::cancel_animation_frame(
  self : Window,
  id : Int,
) -> Unit =
  #| (self, id) => self.cancelAnimationFrame(id)

///|
#external
pub(all) type BeforeUnloadEvent

///|
pub extern "js" fn before_unload_event() -> BeforeUnloadEvent =
  #| () => new BeforeUnloadEvent()

///|
pub extern "js" fn Window::set_onbeforeunload(
  self : Window,
  f : (BeforeUnloadEvent) -> Unit,
) -> Unit =
  #| (self, f) => { self.onbeforeunload = f }

///|
/// Cast Window to JsObjectObscure
pub fn Window::to_js_object(self : Window) -> JsObjectObscure = "%identity"

// Convenience functions for timers and animation frames (global scope)

///|
/// | Calls a function after a specified delay.
/// | Convenience function that uses the global window object.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setTimeout)
pub extern "js" fn set_timeout(f : () -> Unit, ms : UInt) -> Int =
  #| (f, ms) => setTimeout(f, ms)

///|
/// | Cancels a timeout previously established by calling `set_timeout`.
/// | Convenience function that uses the global window object.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/clearTimeout)
pub extern "js" fn clear_timeout(id : Int) -> Unit =
  #| (id) => clearTimeout(id)

///|
/// | Repeatedly calls a function with a fixed time delay between each call.
/// | Convenience function that uses the global window object.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setInterval)
pub extern "js" fn set_interval(f : () -> Unit, ms : UInt) -> Int =
  #| (f, ms) => setInterval(f, ms)

///|
/// | Cancels a timed, repeating action previously established by a call to `set_interval`.
/// | Convenience function that uses the global window object.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/clearInterval)
pub extern "js" fn clear_interval(id : Int) -> Unit =
  #| (id) => clearInterval(id)

///|
/// | Tells the browser that you wish to perform an animation and requests the browser to call a specified function to update an animation before the next repaint.
/// | Convenience function that uses the global window object.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/window/requestAnimationFrame)
pub extern "js" fn request_animation_frame(f : (Float) -> Unit) -> Int =
  #| (f) => requestAnimationFrame(f)

///|
/// | Cancels an animation frame request previously scheduled through a call to `request_animation_frame`.
/// | Convenience function that uses the global window object.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Window/cancelAnimationFrame)
pub extern "js" fn cancel_animation_frame(id : Int) -> Unit =
  #| (id) => cancelAnimationFrame(id)
