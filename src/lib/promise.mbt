///|
#external
pub(all) type JsPromise

///|
/// new Promise
pub extern "js" fn JsPromise::new(
  f : ((JsObscure) -> Unit, (JsObscure) -> Unit),
) -> JsPromise =
  #| (f) => new Promise(f)

///|
pub extern "js" fn JsPromise::reject(val : JsObscure) -> JsPromise =
  #| (val) => Promise.reject(val)

///|
pub extern "js" fn JsPromise::resolve(val : JsObscure) -> JsPromise =
  #| (val) => Promise.resolve(val)

///|
pub extern "js" fn JsPromise::then(
  self : JsPromise,
  f : (JsObscure) -> JsObscure,
) -> JsPromise =
  #| (self, f) => { self.then(f) }

///|
pub extern "js" fn JsPromise::catch_(
  self : JsPromise,
  f : (JsObscure) -> JsObscure,
) -> JsPromise =
  #| (self, f) => { self.catch(f) }
