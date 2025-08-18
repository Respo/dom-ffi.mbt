///| https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams
#external
type URLSearchParams

///|
pub extern "js" fn new_url_search_params(s : String) -> URLSearchParams =
  #| (s) => new URLSearchParams(s)

///|
pub extern "js" fn URLSearchParams::has(
  self : URLSearchParams,
  name : String,
) -> Bool =
  #| (self, name) => self.has(name)

///|
pub extern "js" fn URLSearchParams::get(
  self : URLSearchParams,
  name : String,
) -> String =
  #| (self, name) => self.get(name)

///|
pub extern "js" fn URLSearchParams::get_all(
  self : URLSearchParams,
  name : String,
) -> Array[String] =
  #| (self, name) => self.getAll(name)

///|
pub extern "js" fn URLSearchParams::set(
  self : URLSearchParams,
  name : String,
  value : String,
) -> Unit =
  #| (self, name, value) => self.set(name, value)

///|
pub extern "js" fn URLSearchParams::append(
  self : URLSearchParams,
  name : String,
  value : String,
) -> Unit =
  #| (self, name, value) => self.append(name, value)

///|
pub extern "js" fn URLSearchParams::delete(
  self : URLSearchParams,
  name : String,
) -> Unit =
  #| (self, name) => self.delete(name)

///|
pub extern "js" fn URLSearchParams::to_string(self : URLSearchParams) -> String =
  #| (self) => self.toString()
