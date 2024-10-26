/// https://developer.mozilla.org/en-US/docs/Web/API/Location
pub type Location

pub extern "js" fn get_location(self : Window) -> Location =
  #| (self) => self.location

pub extern "js" fn get_href(self : Location) -> String =
  #| (self) => self.href

pub extern "js" fn set_href(self : Location, href : String) -> Unit =
  #| (self, href) => { self.href = href }

pub extern "js" fn get_protocol(self : Location) -> String =
  #| (self) => self.protocol

pub extern "js" fn get_host(self : Location) -> String =
  #| (self) => self.host

pub extern "js" fn get_hostname(self : Location) -> String =
  #| (self) => self.hostname

pub extern "js" fn get_port(self : Location) -> String =
  #| (self) => self.port

pub extern "js" fn get_pathname(self : Location) -> String =
  #| (self) => self.pathname

pub extern "js" fn get_search(self : Location) -> String =
  #| (self) => self.search

pub extern "js" fn get_hash(self : Location) -> String =
  #| (self) => self.hash

pub extern "js" fn get_origin(self : Location) -> String =
  #| (self) => self.origin

pub extern "js" fn assign(self : Location, url : String) -> Unit =
  #| (self, url) => self.assign(url)

pub extern "js" fn reload(self : Location) -> Unit =
  #| (self) => self.reload()

pub extern "js" fn replace(self : Location, url : String) -> Unit =
  #| (self, url) => self.replace(url)

pub extern "js" fn to_string(self : Location) -> String =
  #| (self) => self.toString()
