// performance

///|
#external
pub(all) type Performance

///|
pub impl Show for Performance with output(self : Performance, logger : &Logger) -> Unit {
  logger.write_string(js_to_string(v_to_js_obscure(self)))
}

///|
/// Gets the Performance object from the window, providing access to performance-related information.
///
/// # Parameters
/// - `self`: The Window instance
///
/// # Returns
/// `Performance` - The Performance object for measuring performance
///
/// # Example
/// ```moonbit_no_check
/// let perf = window().performance()
/// inspect(perf, content="[object Performance]")
/// ```
pub extern "js" fn Window::performance(self : Window) -> Performance =
  #| (self) => self.performance

// performance.now

///|
/// Returns a high-resolution timestamp in milliseconds since the time origin.
///
/// # Parameters
/// - `self`: The Performance instance
///
/// # Returns
/// `Float` - A timestamp in milliseconds with microsecond precision
///
/// # Example
/// ```moonbit_no_check
/// let perf = window().performance()
/// let start_time = perf.now()
/// // ... some operation ...
/// let end_time = perf.now()
/// let duration = end_time - start_time
/// inspect(start_time, content="1234.567890")
/// ```
pub extern "js" fn Performance::now(self : Performance) -> Float =
  #| (self) => self.now()
