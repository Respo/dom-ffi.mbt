///|
/// https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams
#external
type URLSearchParams

///|
pub impl Show for URLSearchParams with output(
  self : URLSearchParams,
  logger : &Logger,
) -> Unit {
  logger.write_string(js_to_string(v_to_js_obscure(self)))
}

///|
/// Creates a new URLSearchParams object from a query string.
///
/// # Parameters
/// - `s`: A query string (with or without leading '?')
///
/// # Returns
/// `URLSearchParams` - A new URLSearchParams object
///
/// # Example
/// ```
/// let params = new_url_search_params("name=john&age=25")
/// inspect(params, content="name=john&age=25")
///
/// let params2 = new_url_search_params("?foo=bar&baz=qux")
/// inspect(params2, content="foo=bar&baz=qux")
/// ```
pub extern "js" fn new_url_search_params(s : String) -> URLSearchParams =
  #| (s) => new URLSearchParams(s)

///|
/// Checks if a parameter with the given name exists.
///
/// # Parameters
/// - `self`: The URLSearchParams instance
/// - `name`: The name of the parameter to check
///
/// # Returns
/// `Bool` - true if the parameter exists, false otherwise
///
/// # Example
/// ```
/// let params = new_url_search_params("name=john&age=25")
/// let has_name = params.has("name")
/// inspect(has_name, content="true")
///
/// let has_email = params.has("email")
/// inspect(has_email, content="false")
/// ```
pub extern "js" fn URLSearchParams::has(
  self : URLSearchParams,
  name : String,
) -> Bool =
  #| (self, name) => self.has(name)

///|
/// Gets the first value associated with the given parameter name.
///
/// # Parameters
/// - `self`: The URLSearchParams instance
/// - `name`: The name of the parameter to get
///
/// # Returns
/// `String` - The first value associated with the parameter, or empty string if not found
///
/// # Example
/// ```moonbit_no_check
/// let params = new_url_search_params("name=john&age=25&name=jane")
/// let name = params.get("name")
/// inspect(name, content="john")
///
/// let missing = params.get("email")
/// inspect(missing, content="")
/// ```
pub extern "js" fn URLSearchParams::get(
  self : URLSearchParams,
  name : String,
) -> String =
  #| (self, name) => self.get(name)

///|
/// Gets all values associated with the given parameter name.
///
/// # Parameters
/// - `self`: The URLSearchParams instance
/// - `name`: The name of the parameter to get all values for
///
/// # Returns
/// `Array[String]` - An array of all values associated with the parameter
///
/// # Example
/// ```
/// let params = new_url_search_params("name=john&age=25&name=jane")
/// let names = params.get_all("name")
/// inspect(names, content="[\"john\", \"jane\"]")
///
/// let ages = params.get_all("age")
/// inspect(ages, content="[\"25\"]")
/// ```
pub extern "js" fn URLSearchParams::get_all(
  self : URLSearchParams,
  name : String,
) -> Array[String] =
  #| (self, name) => self.getAll(name)

///|
/// Sets the value associated with a parameter name, replacing any existing values.
///
/// # Parameters
/// - `self`: The URLSearchParams instance
/// - `name`: The name of the parameter to set
/// - `value`: The value to set for the parameter
///
/// # Returns
/// `Unit` - No return value
///
/// # Example
/// ```
/// let params = new_url_search_params("name=john&age=25")
/// params.set("name", "alice")
/// params.set("email", "alice@example.com")
/// inspect(params.to_string(), content="name=alice&age=25&email=alice%40example.com")
/// ```
pub extern "js" fn URLSearchParams::set(
  self : URLSearchParams,
  name : String,
  value : String,
) -> Unit =
  #| (self, name, value) => self.set(name, value)

///|
/// Appends a new value to an existing parameter name, or creates it if it doesn't exist.
///
/// # Parameters
/// - `self`: The URLSearchParams instance
/// - `name`: The name of the parameter to append to
/// - `value`: The value to append
///
/// # Returns
/// `Unit` - No return value
///
/// # Example
/// ```
/// let params = new_url_search_params("name=john")
/// params.append("name", "jane")
/// params.append("age", "25")
/// inspect(params.to_string(), content="name=john&name=jane&age=25")
/// ```
pub extern "js" fn URLSearchParams::append(
  self : URLSearchParams,
  name : String,
  value : String,
) -> Unit =
  #| (self, name, value) => self.append(name, value)

///|
/// Deletes all parameters with the given name.
///
/// # Parameters
/// - `self`: The URLSearchParams instance
/// - `name`: The name of the parameter(s) to delete
///
/// # Returns
/// `Unit` - No return value
///
/// # Example
/// ```
/// let params = new_url_search_params("name=john&age=25&name=jane")
/// params.delete("name")
/// inspect(params.to_string(), content="age=25")
/// ```
pub extern "js" fn URLSearchParams::delete(
  self : URLSearchParams,
  name : String,
) -> Unit =
  #| (self, name) => self.delete(name)

///|
/// Returns a string representation of the URLSearchParams in query string format.
///
/// # Parameters
/// - `self`: The URLSearchParams instance
///
/// # Returns
/// `String` - A query string representation (without leading '?')
///
/// # Example
/// ```
/// let params = new_url_search_params("name=john&age=25")
/// let query_string = params.to_string()
/// inspect(query_string, content="name=john&age=25")
/// ```
pub extern "js" fn URLSearchParams::to_string(self : URLSearchParams) -> String =
  #| (self) => self.toString()
