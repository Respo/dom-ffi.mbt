///| https://developer.mozilla.org/en-US/docs/Web/API/Location
pub(all) extern type Location

///|
pub extern "js" fn Window::location(self : Window) -> Location =
  #| (self) => self.location

///|
pub extern "js" fn Location::href(self : Location) -> String =
  #| (self) => self.href

///|
pub extern "js" fn Location::set_href(self : Location, href : String) -> Unit =
  #| (self, href) => { self.href = href }

///|
pub extern "js" fn Location::protocol(self : Location) -> String =
  #| (self) => self.protocol

///|
pub extern "js" fn Location::host(self : Location) -> String =
  #| (self) => self.host

///|
pub extern "js" fn Location::hostname(self : Location) -> String =
  #| (self) => self.hostname

///|
pub extern "js" fn Location::port(self : Location) -> String =
  #| (self) => self.port

///|
pub extern "js" fn Location::pathname(self : Location) -> String =
  #| (self) => self.pathname

///|
pub extern "js" fn Location::search(self : Location) -> String =
  #| (self) => self.search

///|
pub extern "js" fn Location::hash(self : Location) -> String =
  #| (self) => self.hash

///|
pub extern "js" fn Location::origin(self : Location) -> String =
  #| (self) => self.origin

///|
pub extern "js" fn Location::assign(self : Location, url : String) -> Unit =
  #| (self, url) => self.assign(url)

///|
pub extern "js" fn Location::reload(self : Location) -> Unit =
  #| (self) => self.reload()

///|
pub extern "js" fn Location::replace(self : Location, url : String) -> Unit =
  #| (self, url) => self.replace(url)

///|
pub extern "js" fn Location::to_string(self : Location) -> String =
  #| (self) => self.toString()
