///|
/// https://developer.mozilla.org/en-US/docs/Web/API/Location
#external
pub(all) type Location

///|
pub impl Show for Location with output(self : Location, logger : &Logger) -> Unit {
  logger.write_string(js_to_string(v_to_js_obscure(self)))
}

///|
/// Gets the Location object from the window, representing the current URL.
///
/// # Parameters
/// - `self`: The Window instance
///
/// # Returns
/// `Location` - The Location object for the current page
///
/// # Example
/// ```moonbit_no_check
/// let _loc = window().location()
/// ```
pub extern "js" fn Window::location(self : Window) -> Location =
  #| (self) => self.location

///|
/// Gets the complete URL of the current page.
///
/// # Parameters
/// - `self`: The Location instance
///
/// # Returns
/// `String` - The complete URL including protocol, host, path, and query string
///
/// # Example
/// ```moonbit_no_check
/// let loc = window().location()
/// let url = loc.href()
/// inspect(url, content="https://example.com/path?query=value#hash")
/// ```
pub extern "js" fn Location::href(self : Location) -> String =
  #| (self) => self.href

///|
/// Sets the complete URL, causing the browser to navigate to the new location.
///
/// # Parameters
/// - `self`: The Location instance
/// - `href`: The new URL to navigate to
///
/// # Returns
/// `Unit` - No return value
///
/// # Example
/// ```moonbit_no_check
/// let loc = window().location()
/// loc.set_href("https://example.com/new-page")
/// ```
pub extern "js" fn Location::set_href(self : Location, href : String) -> Unit =
  #| (self, href) => { self.href = href }

///|
/// Gets the protocol scheme of the URL (including the trailing colon).
///
/// # Parameters
/// - `self`: The Location instance
///
/// # Returns
/// `String` - The protocol (e.g., "https:", "http:", "file:")
///
/// # Example
/// ```moonbit_no_check
/// let loc = window().location()
/// let protocol = loc.protocol()
/// inspect(protocol, content="https:")
/// ```
pub extern "js" fn Location::protocol(self : Location) -> String =
  #| (self) => self.protocol

///|
/// Gets the host (hostname and port) of the URL.
///
/// # Parameters
/// - `self`: The Location instance
///
/// # Returns
/// `String` - The host including port if non-standard (e.g., "example.com:8080")
///
/// # Example
/// ```moonbit_no_check
/// let loc = window().location()
/// let host = loc.host()
/// inspect(host, content="example.com:8080")
/// ```
pub extern "js" fn Location::host(self : Location) -> String =
  #| (self) => self.host

///|
/// Gets the hostname of the URL (without port).
///
/// # Parameters
/// - `self`: The Location instance
///
/// # Returns
/// `String` - The hostname only (e.g., "example.com")
///
/// # Example
/// ```moonbit_no_check
/// let loc = window().location()
/// let hostname = loc.hostname()
/// inspect(hostname, content="example.com")
/// ```
pub extern "js" fn Location::hostname(self : Location) -> String =
  #| (self) => self.hostname

///|
/// Gets the port number of the URL.
///
/// # Parameters
/// - `self`: The Location instance
///
/// # Returns
/// `String` - The port number as a string, or empty string for default ports
///
/// # Example
/// ```moonbit_no_check
/// let loc = window().location()
/// let port = loc.port()
/// inspect(port, content="8080")
/// ```
pub extern "js" fn Location::port(self : Location) -> String =
  #| (self) => self.port

///|
/// Gets the path portion of the URL.
///
/// # Parameters
/// - `self`: The Location instance
///
/// # Returns
/// `String` - The path starting with "/" (e.g., "/path/to/page")
///
/// # Example
/// ```moonbit_no_check
/// let loc = window().location()
/// let path = loc.pathname()
/// inspect(path, content="/path/to/page")
/// ```
pub extern "js" fn Location::pathname(self : Location) -> String =
  #| (self) => self.pathname

///|
/// Gets the query string portion of the URL (including the leading "?").
///
/// # Parameters
/// - `self`: The Location instance
///
/// # Returns
/// `String` - The query string starting with "?" or empty string if none
///
/// # Example
/// ```moonbit_no_check
/// let loc = window().location()
/// let search = loc.search()
/// inspect(search, content="?name=john&age=25")
/// ```
pub extern "js" fn Location::search(self : Location) -> String =
  #| (self) => self.search

///|
/// Gets the fragment identifier portion of the URL (including the leading "#").
///
/// # Parameters
/// - `self`: The Location instance
///
/// # Returns
/// `String` - The hash fragment starting with "#" or empty string if none
///
/// # Example
/// ```moonbit_no_check
/// let loc = window().location()
/// let hash = loc.hash()
/// inspect(hash, content="#section1")
/// ```
pub extern "js" fn Location::hash(self : Location) -> String =
  #| (self) => self.hash

///|
/// Gets the origin of the URL (protocol + hostname + port).
///
/// # Parameters
/// - `self`: The Location instance
///
/// # Returns
/// `String` - The origin (e.g., "https://example.com:8080")
///
/// # Example
/// ```moonbit_no_check
/// let loc = window().location()
/// let origin = loc.origin()
/// inspect(origin, content="https://example.com:8080")
/// ```
pub extern "js" fn Location::origin(self : Location) -> String =
  #| (self) => self.origin

///|
/// Navigates to the specified URL, adding the current page to the browser history.
///
/// # Parameters
/// - `self`: The Location instance
/// - `url`: The URL to navigate to
///
/// # Returns
/// `Unit` - No return value
///
/// # Example
/// ```moonbit_no_check
/// let loc = window().location()
/// loc.assign("https://example.com/new-page")
/// inspect((), content="()")
/// ```
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
