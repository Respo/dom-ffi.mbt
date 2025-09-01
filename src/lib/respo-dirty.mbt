///|
/// this file contains dirty functions that Respo requires to call js

// window
pub extern "js" fn load_my_window() -> Window =
  #| () => window

// dirty_get_fn

///|
pub extern "js" fn dirty_get_fn(self : Window, name : String) -> () -> Unit =
  #| (self, name) => self[name]

// dirty_set_fn

///|
pub extern "js" fn dirty_set_fn(self : Window, name : String, f : () -> Unit) =
  #| (self, name, f) => { self[name] = f }

// dirty_call_fn

///|
pub extern "js" fn dirty_call_fn(self : Window, name : String) -> Unit =
  #| (self, name) => self[name]?.()

// dirty_remove_fn

///|
pub extern "js" fn dirty_remove_fn(self : Window, name : String) -> Unit =
  #| (self, name) => delete self[name]

// dirty_get_fn_1

///|
pub extern "js" fn dirty_get_fn_1(
  self : Window,
  name : String,
) -> (String) -> Unit =
  #| (self, name) => self[name]

// dirty_set_fn_1

///|
pub extern "js" fn dirty_set_fn_1(
  self : Window,
  name : String,
  f : (String) -> Unit,
) =
  #| (self, name, f) => { self[name] = f }

// dirty_call_fn_1

///|
pub extern "js" fn dirty_call_fn_1(
  self : Window,
  name : String,
  v1 : String,
) -> Unit =
  #| (self, name, v1) => self[name]?.(v1)

///|
/// a temporary solution for generating random id
pub extern "js" fn random_id() -> String =
  #| () => Math.random().toString(36).slice(2)

// dirty_get_attribute_fn

///|
pub extern "js" fn dirty_get_attribute_fn(
  self : Element,
  name : String,
) -> () -> Bool =
  #| (self, name) => self[name]

// dirty_set_attribute_fn

///|
pub extern "js" fn dirty_set_attribute_fn(
  self : Element,
  name : String,
  f : (KeyboardEvent) -> Bool,
) =
  #| (self, name, f) => self[name] = f

// dirty_remove_attribute_fn

///|
pub extern "js" fn dirty_remove_attribute_fn(self : Element, name : String) =
  #| (self, name) => delete self[name]
