///|
#external
pub(all) type JsPromise

///|
extern "js" fn js_to_string(v : JsObscure) -> String =
  #| (v) => { return v.toString()}

///|
pub impl Show for JsPromise with output(self : JsPromise, logger : &Logger) -> Unit {
  logger.write_string(js_to_string(v_to_js_obscure(self)))
}

///|
/// Creates a new JavaScript Promise with the given executor function.
///
/// # Parameters
/// - `f`: A function that takes two parameters (resolve, reject) both of type `(JsObscure) -> Unit`
///
/// # Returns
/// `JsPromise` - A new Promise object
///
/// # Example
/// ```moonbit_no_check
/// let _promise = JsPromise::new(fn(resolve, reject) {
///   // Async operation logic here
///   resolve(v_to_js_obscure("success"))
/// })
/// ```
pub extern "js" fn JsPromise::new(
  f : ((JsObscure) -> Unit, (JsObscure) -> Unit),
) -> JsPromise =
  #| (f) => new Promise(f)

///|
/// Creates a Promise that is rejected with the given reason.
///
/// # Parameters
/// - `val`: The reason for rejection as `JsObscure`
///
/// # Returns
/// `JsPromise` - A Promise that is rejected with the given value
///
/// # Example
/// ```
/// let _rejected_promise = JsPromise::reject(v_to_js_obscure("Error occurred"))
/// let _ = _rejected_promise.catch_(fn(_error) { v_to_js_obscure("handled reject") })
/// ```
pub extern "js" fn JsPromise::reject(val : JsObscure) -> JsPromise =
  #| (val) => Promise.reject(val)

///|
/// Creates a Promise that is resolved with the given value.
///
/// # Parameters
/// - `val`: The value to resolve the Promise with as `JsObscure`
///
/// # Returns
/// `JsPromise` - A Promise that is resolved with the given value
///
/// # Example
/// ```
/// let resolved_promise = JsPromise::resolve(v_to_js_obscure("success"))
/// inspect(resolved_promise, content="[object Promise]")
/// ```
pub extern "js" fn JsPromise::resolve(val : JsObscure) -> JsPromise =
  #| (val) => Promise.resolve(val)

///|
/// Attaches a callback for the resolution of the Promise.
///
/// # Parameters
/// - `self`: The Promise to attach the callback to
/// - `f`: A function that handles the resolved value, taking `JsObscure` and returning `JsObscure`
///
/// # Returns
/// `JsPromise` - A new Promise for the return value of the callback
///
/// # Example
/// ```moonbit_no_check
/// let promise = JsPromise::resolve(v_to_js_obscure("initial"))
/// let chained = promise.then(fn(value) { v_to_js_obscure("processed") })
/// ```
pub extern "js" fn JsPromise::then(
  self : JsPromise,
  f : (JsObscure) -> JsObscure,
) -> JsPromise =
  #| (self, f) => { self.then(f) }

///|
/// Attaches a callback for the rejection of the Promise.
///
/// # Parameters
/// - `self`: The Promise to attach the error handler to
/// - `f`: A function that handles the rejection reason, taking `JsObscure` and returning `JsObscure`
///
/// # Returns
/// `JsPromise` - A new Promise for the return value of the callback
///
/// # Example
/// ```
/// let promise = JsPromise::reject(v_to_js_obscure("error"))
/// let _handled = promise.catch_(fn(_error) { v_to_js_obscure("handled") })
/// ```
pub extern "js" fn JsPromise::catch_(
  self : JsPromise,
  f : (JsObscure) -> JsObscure,
) -> JsPromise =
  #| (self, f) => { self.catch(f) }
