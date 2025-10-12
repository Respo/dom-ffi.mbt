///|
/// | A type representing an obscure JavaScript value.
/// | Its internal structure is unknown and should be inspected before use.
#external
pub type JsObscure

///|
/// | Converts any Moonbit value to `JsObscure`.
/// | This is a low-level operation and should be used with caution.
pub fn[T] v_to_js_obscure(v : T) -> JsObscure = "%identity"

///|
/// | Converts `JsObscure` to any Moonbit value.
/// | This is a low-level operation and should be used with caution.
pub fn[T] js_obscure_to_v(v : JsObscure) -> T = "%identity"

///|
/// | Returns the lowercased type string of a JavaScript value.
/// | It uses `Object.prototype.toString.call` internally.
/// | For example, it returns "string", "object", "function".
pub extern "js" fn type_of(v : JsObscure) -> String =
  #| (v) => Object.prototype.toString.call(v).slice(8, -1).toLowerCase()

///|
/// | Checks if the value is `null`.
pub extern "js" fn JsObscure::is_nil(self : JsObscure) -> Bool =
  #| (self) => self == null

///|
/// | Checks if the value is `undefined`.
pub extern "js" fn JsObscure::is_undefined(self : JsObscure) -> Bool =
  #| (self) => self === undefined

///|
/// | Checks if the value is a function.
pub extern "js" fn JsObscure::is_function(self : JsObscure) -> Bool =
  #| (self) => typeof self === 'function'

///|
/// | Checks if the value is an object.
pub extern "js" fn JsObscure::is_object(self : JsObscure) -> Bool =
  #| (self) => typeof self === 'object'

///|
/// | Checks if the value is a string.
pub extern "js" fn JsObscure::is_string(self : JsObscure) -> Bool =
  #| (self) => typeof self === 'string'

///|
/// | Checks if the value is a number.
pub extern "js" fn JsObscure::is_number(self : JsObscure) -> Bool =
  #| (self) => typeof self === 'number'

///|
/// | Checks if the value is a boolean.
pub extern "js" fn JsObscure::is_boolean(self : JsObscure) -> Bool =
  #| (self) => typeof self === 'boolean'

///|
/// | Checks if the value is a symbol.
pub extern "js" fn JsObscure::is_symbol(self : JsObscure) -> Bool =
  #| (self) => typeof self === 'symbol'

///|
/// | Checks if the value is an array.
pub extern "js" fn JsObscure::is_array(self : JsObscure) -> Bool =
  #| (self) => Array.isArray(self)

///|
/// | Checks if the value is a Date object.
pub extern "js" fn JsObscure::is_date(self : JsObscure) -> Bool =
  #| (self) => self instanceof Date

///|
/// | Checks if the value is a RegExp object.
pub extern "js" fn JsObscure::is_regexp(self : JsObscure) -> Bool =
  #| (self) => self instanceof RegExp

///|
/// | Checks if the value is an Error object.
pub extern "js" fn JsObscure::is_error(self : JsObscure) -> Bool =
  #| (self) => self instanceof Error

///|
/// | Checks if the value is a WeakMap object.
pub extern "js" fn JsObscure::is_weakmap(self : JsObscure) -> Bool =
  #| (self) => self instanceof WeakMap

///|
/// | Checks if the value is a WeakSet object.
pub extern "js" fn JsObscure::is_weakset(self : JsObscure) -> Bool =
  #| (self) => self instanceof WeakSet

///|
/// | Checks if the value is a Map object.
pub extern "js" fn JsObscure::is_map(self : JsObscure) -> Bool =
  #| (self) => self instanceof Map

///|
/// | Checks if the value is a Set object.
pub extern "js" fn JsObscure::is_set(self : JsObscure) -> Bool =
  #| (self) => self instanceof Set

///|
/// | Checks if the value is a TypedArray.
pub extern "js" fn JsObscure::is_typed_array(self : JsObscure) -> Bool =
  #| (self) => self instanceof Int8Array || self instanceof Uint8Array || self instanceof Uint8ClampedArray || self instanceof Int16Array || self instanceof Uint16Array || self instanceof Int32Array || self instanceof Uint32Array || self instanceof Float32Array || self instanceof Float64Array

///|
/// | Checks if the value is an `arguments` object.
pub extern "js" fn JsObscure::is_arguments(self : JsObscure) -> Bool =
  #| (self) => self instanceof Arguments

// get and set object

///|
/// | Gets a property from a JavaScript object.
pub extern "js" fn JsObscure::get(self : JsObscure, prop : String) -> JsObscure =
  #| (self, prop) => self[prop]

///|
/// | Sets a property on a JavaScript object.
pub extern "js" fn JsObscure::set(
  self : JsObscure,
  prop : String,
  value : JsObscure,
) -> Unit =
  #| (self, prop, value) => self[prop] = value

///|
/// | Converts a `String` to `JsObscure`.
pub fn JsObscure::from_string(s : String) -> JsObscure = "%identity"

///|
/// | Converts an `Int` to `JsObscure`.
pub fn JsObscure::from_number(n : Int) -> JsObscure = "%identity"

///|
/// | Converts a `Float` to `JsObscure`.
pub fn JsObscure::from_float(n : Float) -> JsObscure = "%identity"

///|
/// | Converts a `Bool` to `JsObscure`.
pub fn JsObscure::from_bool(b : Bool) -> JsObscure = "%identity"

///|
/// | Converts an `Array[JsObscure]` to `JsObscure`.
pub fn JsObscure::from_array(a : Array[JsObscure]) -> JsObscure = "%identity"

// JsObject

///|
/// | A type representing an obscure JavaScript object.
#external
pub type JsObjectObscure

///|
/// | Creates a new empty JavaScript object.
pub extern "js" fn JsObjectObscure::new() -> JsObjectObscure =
  #| () => ({})

///|
/// | Returns an array of a given object's own enumerable property names.
pub extern "js" fn JsObjectObscure::keys(
  self : JsObjectObscure,
) -> Array[JsObscure] =
  #| (self) => Object.keys(self)

///|
/// | Returns an array of a given object's own enumerable property values.
pub extern "js" fn JsObjectObscure::values(
  self : JsObjectObscure,
) -> Array[JsObscure] =
  #| (self) => Object.values(self)

///|
/// | Returns an array of a given object's own enumerable string-keyed property `[key, value]` pairs.
pub extern "js" fn JsObjectObscure::entries(
  self : JsObjectObscure,
) -> Array[JsObscure] =
  #| (self) => Object.entries(self)

// get/set

///|
/// | Gets a property from a JavaScript object.
pub extern "js" fn JsObjectObscure::get(
  self : JsObjectObscure,
  prop : String,
) -> JsObscure =
  #| (self, prop) => self[prop]

///|
/// | Sets a property on a JavaScript object.
pub extern "js" fn JsObjectObscure::set(
  self : JsObjectObscure,
  prop : String,
  value : JsObscure,
) -> Unit =
  #| (self, prop, value) => self[prop] = value

///|
/// | Checks if a property is in an object.
pub extern "js" fn JsObjectObscure::has(
  self : JsObjectObscure,
  prop : String,
) -> Bool =
  #| (self, prop) => prop in self

///|
/// | Deletes a property from an object.
pub extern "js" fn JsObjectObscure::delete(
  self : JsObjectObscure,
  prop : String,
) -> Bool =
  #| (self, prop) => delete self[prop]

///|
/// | Returns the number of enumerable properties in an object.
pub extern "js" fn JsObjectObscure::size(self : JsObjectObscure) -> Int =
  #| (self) => Object.keys(self).length

///|
/// | Converts `JsObjectObscure` to `JsObscure`.
pub fn JsObjectObscure::to_js_obscure(self : JsObjectObscure) -> JsObscure = "%identity"

///|
/// Call method with arguments
pub extern "js" fn JsObjectObscure::call_method_args(
  self : Self,
  method_ : String,
  args : Array[JsObscure],
) -> JsObscure =
  #| (self, method_, args) => self[method_](...args)

///|
/// | Evaluates JavaScript code and returns the result.
pub extern "js" fn eval_js_code(code : String) -> JsObscure =
  #| (code) => eval(code)

///|
/// | Creates a JavaScript `null` value.
pub extern "js" fn JsObscure::null() -> JsObscure =
  #| () => null

///|
/// | Creates a JavaScript `undefined` value.
pub extern "js" fn JsObscure::undefined() -> JsObscure =
  #| () => undefined

///|
#external
pub type JsFnObscure

///|
pub fn JsFnObscure::to_obscure(self : JsFnObscure) -> JsObscure = "%identity"

///|
/// Perform detection and conversion
pub fn[T] JsFnObscure::from(t : T) -> JsFnObscure {
  let js_t = v_to_js_obscure(t)
  if !js_t.is_function() {
    js_obscure_to_v(js_t)
    warn_log("JsFnObscure::from: not a function")
  }
  js_obscure_to_v(js_t)
}
