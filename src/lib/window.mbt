///| window
pub(all) extern type Window

///|
pub extern "js" fn window() -> Window =
  #| () => window

// add_event_listener_with_callback
///|
pub extern "js" fn Window::add_event_listener_with_callback(
  self : Window,
  type_ : String,
  f : (KeyboardEvent) -> Bool // TODO
) -> Unit =
  #| (self, type, f) => { self.addEventListener(type, f) }

// remove_event_listener_with_callback
///|
pub extern "js" fn Window::remove_event_listener_with_callback(
  self : Window,
  type_ : String,
  f : () -> Bool // TODO
) -> Unit =
  #| (self, type, f) => { self.removeEventListener(type, f) }

///|
pub extern "js" fn Window::set_timeout(
  self : Window,
  f : () -> Unit,
  ms : UInt
) -> Unit =
  #| (self, f, ms) => { self.setTimeout(f, ms) }

///|
pub extern "js" fn Window::request_animation_frame(
  self : Window,
  f : (Float) -> Unit
) -> Unit =
  #| (self, f) => { self.requestAnimationFrame(f) }

///|
pub(all) extern type BeforeUnloadEvent

///|
pub extern "js" fn before_unload_event() -> BeforeUnloadEvent =
  #| () => new BeforeUnloadEvent()

///|
pub extern "js" fn set_onbeforeunload(
  self : Window,
  f : (BeforeUnloadEvent) -> Unit
) -> Unit =
  #| (self, f) => { self.onbeforeunload = f }
