// TODO: Implement Promise

///|
#external
pub(all) type JsValue

///|
pub(all) struct Promise[T] {
  val : T
}

///|
pub extern "js" fn JsValue::then_ffi(
  self : JsValue,
  f : (JsValue) -> JsValue,
) -> Promise[JsValue] =
  #| (self, f) => { self.then(f) }
