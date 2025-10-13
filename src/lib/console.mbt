///|
/// Outputs a message to the browser console at the info level.
///
/// # Parameters
/// - `msg`: The message string to log
///
/// # Returns
/// `Unit` - No return value
///
/// # Example
/// ```
/// log("Hello, world!")
/// log("Debug information: value = 42")
/// ```
pub extern "js" fn log(msg : String) -> Unit =
  #| (msg) => { console.log(msg) }

///|
/// Outputs a warning message to the browser console at the warning level.
///
/// # Parameters
/// - `msg`: The warning message string to log
///
/// # Returns
/// `Unit` - No return value
///
/// # Example
/// ```
/// warn_log("This is a warning message")
/// warn_log("Deprecated function used")
/// ```
pub extern "js" fn warn_log(msg : String) -> Unit =
  #| (msg) => { console.warn(msg) }

///|
/// Outputs an error message to the browser console at the error level.
///
/// # Parameters
/// - `msg`: The error message string to log
///
/// # Returns
/// `Unit` - No return value
///
/// # Example
/// ```
/// error_log("An error occurred!")
/// error_log("Failed to load resource")
/// ```
pub extern "js" fn error_log(msg : String) -> Unit =
  #| (msg) => { console.error(msg) }
