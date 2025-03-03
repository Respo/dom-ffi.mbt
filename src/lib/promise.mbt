// TODO: Implement Promise

///|
pub(all) extern type JsValue

///|
pub(all) struct Promise[T] {
  val : T
}

///|
pub extern "js" fn JsValue::then_ffi(
  self : JsValue,
  f : (JsValue) -> JsValue
) -> Promise[JsValue] =
  #| (self, f) => { self.then(f) }
