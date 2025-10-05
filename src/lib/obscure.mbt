///|
/// JavaScript obscure type. Unknown structure. need to detect before use
#external
pub type JsObscure

///|
/// Convert any value to JsObscure. This is a dangerous function. Use it with caution.
pub fn[T] v_to_js_obscure(v : T) -> JsObscure = "%identity"

///|
/// Convert JsObscure to any value. This is a dangerous function. Use it with caution.
pub fn[T] js_obscure_to_v(v : JsObscure) -> T = "%identity"

///|
/// use `Object.prototype.toString.call` to get type of JsObscure. e.g. "string", "object", "function"
/// returns type of JsObscure. e.g. "string", "object", "function"
pub extern "js" fn type_of(v : JsObscure) -> String =
  #| (v) => Object.prototype.toString.call(v).slice(8, -1).toLowerCase()

///|
/// is undefined or null
pub extern "js" fn JsObscure::is_nil(self : JsObscure) -> Bool =
  #| (self) => self === null

///|
pub extern "js" fn JsObscure::is_undefined(self : JsObscure) -> Bool =
  #| (self) => self === undefined

///|
pub extern "js" fn JsObscure::is_function(self : JsObscure) -> Bool =
  #| (self) => typeof self === 'function'

///|
pub extern "js" fn JsObscure::is_object(self : JsObscure) -> Bool =
  #| (self) => typeof self === 'object'

///|
pub extern "js" fn JsObscure::is_string(self : JsObscure) -> Bool =
  #| (self) => typeof self === 'string'

///|
pub extern "js" fn JsObscure::is_number(self : JsObscure) -> Bool =
  #| (self) => typeof self === 'number'

///|
pub extern "js" fn JsObscure::is_boolean(self : JsObscure) -> Bool =
  #| (self) => typeof self === 'boolean'

///|
pub extern "js" fn JsObscure::is_symbol(self : JsObscure) -> Bool =
  #| (self) => typeof self === 'symbol'

///|
pub extern "js" fn JsObscure::is_array(self : JsObscure) -> Bool =
  #| (self) => Array.isArray(self)

///|
pub extern "js" fn JsObscure::is_date(self : JsObscure) -> Bool =
  #| (self) => self instanceof Date

///|
pub extern "js" fn JsObscure::is_regexp(self : JsObscure) -> Bool =
  #| (self) => self instanceof RegExp

///|
pub extern "js" fn JsObscure::is_error(self : JsObscure) -> Bool =
  #| (self) => self instanceof Error

///|
pub extern "js" fn JsObscure::is_weakmap(self : JsObscure) -> Bool =
  #| (self) => self instanceof WeakMap

///|
pub extern "js" fn JsObscure::is_weakset(self : JsObscure) -> Bool =
  #| (self) => self instanceof WeakSet

///|
pub extern "js" fn JsObscure::is_map(self : JsObscure) -> Bool =
  #| (self) => self instanceof Map

///|
pub extern "js" fn JsObscure::is_set(self : JsObscure) -> Bool =
  #| (self) => self instanceof Set

///|
pub extern "js" fn JsObscure::is_typed_array(self : JsObscure) -> Bool =
  #| (self) => self instanceof Int8Array || self instanceof Uint8Array || self instanceof Uint8ClampedArray || self instanceof Int16Array || self instanceof Uint16Array || self instanceof Int32Array || self instanceof Uint32Array || self instanceof Float32Array || self instanceof Float64Array

///|
pub extern "js" fn JsObscure::is_arguments(self : JsObscure) -> Bool =
  #| (self) => self instanceof Arguments

// get and set object

///|
pub extern "js" fn JsObscure::get(self : JsObscure, prop : String) -> JsObscure =
  #| (self, prop) => self[prop]

///|
pub extern "js" fn JsObscure::set(
  self : JsObscure,
  prop : String,
  value : JsObscure,
) -> Unit =
  #| (self, prop, value) => self[prop] = value

///|
pub fn JsObscure::from_string(s : String) -> JsObscure = "%identity"

///|
pub fn JsObscure::from_number(n : Int) -> JsObscure = "%identity"

///|
pub fn JsObscure::from_float(n : Float) -> JsObscure = "%identity"

///|
pub fn JsObscure::from_bool(b : Bool) -> JsObscure = "%identity"

///|
pub fn JsObscure::from_array(a : Array[JsObscure]) -> JsObscure = "%identity"

// JsObject

///|
#external
pub type JsObjectObscure

///|
pub extern "js" fn JsObjectObscure::new() -> JsObjectObscure =
  #| () => ({})

///|
pub extern "js" fn JsObjectObscure::keys(
  self : JsObjectObscure,
) -> Array[JsObscure] =
  #| (self) => Object.keys(self)

///|
pub extern "js" fn JsObjectObscure::values(
  self : JsObjectObscure,
) -> Array[JsObscure] =
  #| (self) => Object.values(self)

///|
pub extern "js" fn JsObjectObscure::entries(
  self : JsObjectObscure,
) -> Array[JsObscure] =
  #| (self) => Object.entries(self)

// get/set

///|
pub extern "js" fn JsObjectObscure::get(
  self : JsObjectObscure,
  prop : String,
) -> JsObscure =
  #| (self, prop) => self[prop]

///|
pub extern "js" fn JsObjectObscure::set(
  self : JsObjectObscure,
  prop : String,
  value : JsObscure,
) -> Unit =
  #| (self, prop, value) => self[prop] = value

///|
pub extern "js" fn JsObjectObscure::has(
  self : JsObjectObscure,
  prop : String,
) -> Bool =
  #| (self, prop) => prop in self

///|
pub extern "js" fn JsObjectObscure::delete(
  self : JsObjectObscure,
  prop : String,
) -> Bool =
  #| (self, prop) => delete self[prop]

///|
pub extern "js" fn JsObjectObscure::size(self : JsObjectObscure) -> Int =
  #| (self) => Object.keys(self).length

///|
pub fn JsObjectObscure::to_js_obscure(self : JsObjectObscure) -> JsObscure = "%identity"

///|
/// eval js code
pub extern "js" fn eval_js_code(code : String) -> JsObscure =
  #| (code) => eval(code)

///|
/// created JavaScript `null`
pub extern "js" fn JsObscure::null() -> JsObscure =
  #| () => null

///|
/// creates JavaScript `undefined`
pub extern "js" fn JsObscure::undefined() -> JsObscure =
  #| () => null
