///|
#external
pub(all) type LocalStorage

///|
pub extern "js" fn local_storage(self : Window) -> LocalStorage =
  #| (self) => self.localStorage

///|
/// TODO undefined is used to trick `String?` type, need more solid solution
pub extern "js" fn get_item(self : LocalStorage, key : String) -> String? =
  #| (self, key) => self.getItem(key) || undefined

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
