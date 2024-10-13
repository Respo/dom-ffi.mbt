// performance
pub type Performance

pub extern "js" fn performance(self : Window) -> Performance =
  #| (self) => self.performance

// performance.now
pub extern "js" fn now(self : Performance) -> Float =
  #| (self) => self.now()
