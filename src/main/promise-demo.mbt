///|
extern "js" fn callback_failure(
  _value : @dom_ffi.JsObscure,
) -> @dom_ffi.JsObscure =
  #| () => { throw new Error("callback failure"); }

///|
fn run_promise_conformance() -> Unit {
  let executor_called = Ref(false)
  let callbacks_run = Ref(0)
  let fulfilled = @dom_ffi.JsPromise::new(fn(resolve, reject) {
    executor_called.val = true
    resolve(@dom_ffi.JsObscure::from_number(41))
    reject(@dom_ffi.JsObscure::from_string("ignored rejection"))
  })
  browser_assert("Promise executor runs synchronously", executor_called.val)
  browser_assert(
    "Promise Show preserves native display",
    fulfilled.to_string() == "[object Promise]",
  )
  let chained = fulfilled.then(fn(value) {
    callbacks_run.val = callbacks_run.val + 1
    let number : Int = @dom_ffi.js_obscure_to_v(value)
    browser_assert("Promise executor resolves its supplied value", number == 41)
    @dom_ffi.JsObscure::from_number(number + 1)
  })
  browser_assert("Promise callbacks run asynchronously", callbacks_run.val == 0)
  browser_assert(
    "Promise then returns a distinct native Promise",
    !js_identity(
      @dom_ffi.v_to_js_obscure(fulfilled),
      @dom_ffi.v_to_js_obscure(chained),
    ) &&
    @dom_ffi.type_of(@dom_ffi.v_to_js_obscure(chained)) == "promise",
  )
  ignore(
    chained.then(fn(value) {
      let number : Int = @dom_ffi.js_obscure_to_v(value)
      browser_assert(
        "Promise then propagates the transformed result",
        number == 42,
      )
      value
    }),
  )
  let rejected = @dom_ffi.JsPromise::new(fn(_resolve, reject) {
    reject(@dom_ffi.JsObscure::from_string("executor rejection"))
  })
  let recovered = rejected.catch_(fn(reason) {
    let message : String = @dom_ffi.js_obscure_to_v(reason)
    browser_assert(
      "Promise executor rejects its supplied reason",
      message == "executor rejection",
    )
    @dom_ffi.JsObscure::from_string("recovered")
  })
  browser_assert(
    "Promise catch returns a distinct native Promise",
    !js_identity(
      @dom_ffi.v_to_js_obscure(rejected),
      @dom_ffi.v_to_js_obscure(recovered),
    ) &&
    @dom_ffi.type_of(@dom_ffi.v_to_js_obscure(recovered)) == "promise",
  )
  ignore(
    recovered.then(fn(value) {
      let message : String = @dom_ffi.js_obscure_to_v(value)
      browser_assert(
        "Promise catch result can be chained",
        message == "recovered",
      )
      value
    }),
  )
  let adopted = @dom_ffi.JsPromise::resolve(@dom_ffi.JsObscure::from_number(1)).then(fn(
      _value,
    ) {
      @dom_ffi.v_to_js_obscure(
        @dom_ffi.JsPromise::resolve(@dom_ffi.JsObscure::from_number(99)),
      )
    },
  )
  ignore(
    adopted.then(fn(value) {
      let number : Int = @dom_ffi.js_obscure_to_v(value)
      browser_assert("Promise then adopts a returned Promise", number == 99)
      value
    }),
  )
  ignore(
    @dom_ffi.JsPromise::resolve(@dom_ffi.JsObscure::null())
    .then(callback_failure)
    .catch_(fn(reason) {
      let message : String = @dom_ffi.js_obscure_to_v(reason.get("message"))
      browser_assert(
        "Promise then turns a callback exception into rejection",
        message == "callback failure",
      )
      @dom_ffi.JsObscure::undefined()
    }),
  )
}
