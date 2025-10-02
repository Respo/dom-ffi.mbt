///|
#external
pub(all) type LocalStorage

///|
pub extern "js" fn local_storage(self : Window) -> LocalStorage =
  #| (self) => self.localStorage

///|
extern "js" fn LocalStorage::js_get_item(
  self : LocalStorage,
  key : String,
) -> JsObscure =
  #| (self, key) => self.getItem(key)

///|
/// Retrieves the value associated with the given key from localStorage.
///
/// # Parameters
/// - `self`: The LocalStorage instance
/// - `key`: The key to retrieve the value for
///
/// # Returns
/// `String?` - Some(value) if the key exists, None if the key doesn't exist or value is null
///
/// # Example
/// ```moonbit_no_check
/// let storage = window().local_storage()
/// storage.set_item("username", "alice")
/// let result = storage.get_item("username")
/// inspect(result, content="Some(\"alice\")")
///
/// let missing = storage.get_item("nonexistent")
/// inspect(missing, content="None")
/// ```
pub fn LocalStorage::get_item(self : LocalStorage, key : String) -> String? {
  let item = self.js_get_item(key)
  if item.is_nil() {
    None
  } else {
    Some(js_obscure_to_v(item))
  }
}

///|
pub extern "js" fn LocalStorage::set_item(
  self : LocalStorage,
  key : String,
  value : String,
) -> Unit =
  #| (self, key, value) => { self.setItem(key, value) }

///|
pub extern "js" fn LocalStorage::remove_item(
  self : LocalStorage,
  key : String,
) -> Unit =
  #| (self, key) => { self.removeItem(key) }
