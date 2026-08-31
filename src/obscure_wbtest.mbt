///|
extern "js" fn test_plain_object() -> JsObscure =
  #| () => ({ answer: 42 })

///|
extern "js" fn test_arguments_object() -> JsObscure =
  #| () => (function () { return arguments; })("moonbit")

///|
extern "js" fn test_uint8_array() -> JsObscure =
  #| () => new Uint8Array([1, 2, 3])

///|
extern "js" fn test_bigint_array() -> JsObscure =
  #| () => new BigInt64Array([1n, 2n])

///|
extern "js" fn test_data_view() -> JsObscure =
  #| () => new DataView(new ArrayBuffer(8))

///|
test "null, undefined, and object predicates stay distinct" {
  inspect(JsObscure::null().is_nil(), content="true")
  inspect(JsObscure::undefined().is_nil(), content="false")
  inspect(JsObscure::null().is_nullish(), content="true")
  inspect(JsObscure::undefined().is_nullish(), content="true")
  inspect(JsObscure::null().is_object(), content="false")
  inspect(test_plain_object().is_object(), content="true")
}

///|
test "arguments detection does not reference a nonexistent constructor" {
  inspect(test_arguments_object().is_arguments(), content="true")
  inspect(JsObscure::from_array([]).is_arguments(), content="false")
}

///|
test "typed-array detection covers numeric and BigInt views" {
  inspect(test_uint8_array().is_typed_array(), content="true")
  inspect(test_bigint_array().is_typed_array(), content="true")
}

///|
test "DataView is not reported as a typed array" {
  inspect(test_data_view().is_typed_array(), content="false")
}

///|
test "array and object predicates match JavaScript runtime categories" {
  let array = JsObscure::from_array([])
  inspect(array.is_array(), content="true")
  inspect(array.is_object(), content="true")
  inspect(test_plain_object().is_array(), content="false")
}
