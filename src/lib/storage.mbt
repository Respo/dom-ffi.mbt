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
