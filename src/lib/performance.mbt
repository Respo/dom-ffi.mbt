// performance
///|
pub(all) extern type Performance

///|
pub extern "js" fn Window::performance(self : Window) -> Performance =
  #| (self) => self.performance

// performance.now
///|
pub extern "js" fn Performance::now(self : Performance) -> Float =
  #| (self) => self.now()
