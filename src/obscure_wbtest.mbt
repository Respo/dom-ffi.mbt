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
extern "js" fn test_method_object() -> JsObjectObscure =
  #| () => ({
  #|   first: 1,
  #|   second: 2,
  #|   sum(...values) { return values.reduce((total, value) => total + value, 0); },
  #| })

///|
extern "js" fn test_same_reference(left : JsObscure, right : JsObscure) -> Bool =
  #| (left, right) => left === right

///|
test "from_array copies its container and preserves object references" {
  let object = test_plain_object()
  let source = [object]
  let snapshot = JsObscure::from_array(source)
  source.push(JsObscure::from_number(7))
  let length : Int = js_obscure_to_v(snapshot.get("length"))
  inspect(length, content="1")
  inspect(test_same_reference(snapshot.get("0"), object), content="true")
  snapshot.set("0", JsObscure::from_number(9))
  inspect(test_same_reference(source[0], object), content="true")
  snapshot.set("length", JsObscure::from_number(0))
  inspect(source.length(), content="2")
}

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

///|
test "object collection and method wrappers preserve MoonBit Array contracts" {
  let object = test_method_object()
  inspect(object.keys().length(), content="3")
  inspect(object.values().length(), content="3")
  inspect(object.entries().length(), content="3")
  let total : Int = js_obscure_to_v(
    object.call_method_args("sum", [
      JsObscure::from_number(2),
      JsObscure::from_number(3),
    ]),
  )
  inspect(total, content="5")
}
