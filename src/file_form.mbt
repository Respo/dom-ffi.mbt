///|
/// | Immutable raw binary data.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Blob)
#external
pub type Blob

///|
/// | Creates a text-backed blob with an optional MIME type.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Blob/Blob)
pub extern "js" fn Blob::new_from_text(
  text : String,
  type_? : String = "",
) -> Blob =
  #| (text, type_) => new Blob([text], { type: type_ })

///|
/// | Returns the number of bytes in this blob.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Blob/size)
pub extern "js" fn Blob::size(self : Blob) -> Int =
  #| (self) => self.size

///|
/// | Returns the MIME type, or an empty string when unspecified.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Blob/type)
pub extern "js" fn Blob::type_(self : Blob) -> String =
  #| (self) => self.type

///|
/// | A named file, which is also a `Blob`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/File)
#external
pub type File

///|
/// | Creates a text-backed file with an optional MIME type.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/File/File)
pub extern "js" fn File::new_from_text(
  name : String,
  text : String,
  type_? : String = "",
) -> File =
  #| (name, text, type_) => new File([text], name, { type: type_ })

///|
/// | Returns the file name without its path.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/File/name)
pub extern "js" fn File::name(self : File) -> String =
  #| (self) => self.name

///|
/// | Returns the number of bytes in this file.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Blob/size)
pub extern "js" fn File::size(self : File) -> Int =
  #| (self) => self.size

///|
/// | Returns the file MIME type, or an empty string when unspecified.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/Blob/type)
pub extern "js" fn File::type_(self : File) -> String =
  #| (self) => self.type

///|
/// | Returns the millisecond timestamp at which this file was last modified.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/File/lastModified)
pub extern "js" fn File::last_modified(self : File) -> Int =
  #| (self) => self.lastModified

///|
/// | A browser-owned collection of files.
/// |
/// | `to_array` returns a snapshot, not a live view of the browser collection.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/FileList)
#external
pub type FileList

///|
/// | Returns the number of files in this list.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/FileList/length)
pub extern "js" fn FileList::length(self : FileList) -> Int =
  #| (self) => self.length

///|
extern "js" fn FileList::js_item(self : FileList, index : Int) -> JsObscure =
  #| (self, index) => self.item(index)

///|
/// | Returns the file at `index`, or `None` when the index is out of range.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/FileList/item)
pub fn FileList::item(self : FileList, index : Int) -> File? {
  let file = self.js_item(index)
  if file.is_nullish() {
    None
  } else {
    Some(js_obscure_to_v(file))
  }
}

///|
extern "js" fn FileList::js_to_array(self : FileList) -> FixedArray[File] =
  #| (self) => Array.from(self)

///|
/// | Returns a snapshot MoonBit array of the files currently in this list.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/FileList)
pub fn FileList::to_array(self : FileList) -> Array[File] {
  Array::from_fixed_array(self.js_to_array())
}

///|
/// | A value stored in `FormData`: either text or a `File`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/FormData/get)
pub enum FormDataValue {
  Text(String)
  File(File)
}

///|
/// | A collection of form fields and files for form submission.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/FormData)
#external
pub type FormData

///|
/// | Creates empty form data.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/FormData/FormData)
pub extern "js" fn FormData::new() -> FormData =
  #| () => new FormData()

///|
/// | Appends a text value without removing existing values for the same name.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/FormData/append)
pub extern "js" fn FormData::append_text(
  self : FormData,
  name : String,
  value : String,
) -> Unit =
  #| (self, name, value) => self.append(name, value)

///|
/// | Appends a file without removing existing values for the same name.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/FormData/append)
pub extern "js" fn FormData::append_file(
  self : FormData,
  name : String,
  value : File,
) -> Unit =
  #| (self, name, value) => self.append(name, value)

///|
/// | Replaces all values for `name` with a text value.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/FormData/set)
pub extern "js" fn FormData::set_text(
  self : FormData,
  name : String,
  value : String,
) -> Unit =
  #| (self, name, value) => self.set(name, value)

///|
/// | Replaces all values for `name` with a file.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/FormData/set)
pub extern "js" fn FormData::set_file(
  self : FormData,
  name : String,
  value : File,
) -> Unit =
  #| (self, name, value) => self.set(name, value)

///|
extern "js" fn FormData::js_get(self : FormData, name : String) -> JsObscure =
  #| (self, name) => self.get(name)

///|
fn form_data_value_from_js(value : JsObscure) -> FormDataValue {
  if value.is_string() {
    Text(js_obscure_to_v(value))
  } else {
    File(js_obscure_to_v(value))
  }
}

///|
/// | Returns the first value for `name`, or `None` when no value is present.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/FormData/get)
pub fn FormData::get(self : FormData, name : String) -> FormDataValue? {
  let value = self.js_get(name)
  if value.is_nullish() {
    None
  } else {
    Some(form_data_value_from_js(value))
  }
}

///|
extern "js" fn FormData::js_get_all(
  self : FormData,
  name : String,
) -> FixedArray[JsObscure] =
  #| (self, name) => self.getAll(name)

///|
/// | Returns a snapshot MoonBit array of all values for `name` in insertion
/// | order.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/FormData/getAll)
pub fn FormData::get_all(
  self : FormData,
  name : String,
) -> Array[FormDataValue] {
  Array::from_fixed_array(self.js_get_all(name)).map(form_data_value_from_js)
}

///|
/// | Returns whether at least one value exists for `name`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/FormData/has)
pub extern "js" fn FormData::has(self : FormData, name : String) -> Bool =
  #| (self, name) => self.has(name)

///|
/// | Deletes every value for `name`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/FormData/delete)
pub extern "js" fn FormData::delete(self : FormData, name : String) -> Unit =
  #| (self, name) => self.delete(name)

///|
/// | Returns whether an input is checked.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLInputElement/checked)
pub extern "js" fn HtmlInputElement::checked(self : HtmlInputElement) -> Bool =
  #| (self) => self.checked

///|
/// | Sets whether an input is checked.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLInputElement/checked)
pub extern "js" fn HtmlInputElement::set_checked(
  self : HtmlInputElement,
  checked : Bool,
) -> Unit =
  #| (self, checked) => { self.checked = checked }

///|
extern "js" fn HtmlInputElement::js_files(self : HtmlInputElement) -> JsObscure =
  #| (self) => self.files

///|
/// | Returns the selected files, or `None` for input types without a file
/// | selection list.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLInputElement/files)
pub fn HtmlInputElement::files(self : HtmlInputElement) -> FileList? {
  let files = self.js_files()
  if files.is_nullish() {
    None
  } else {
    Some(js_obscure_to_v(files))
  }
}

///|
/// | Returns the files held by a drag data store.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/DataTransfer/files)
pub extern "js" fn DataTransfer::files(self : DataTransfer) -> FileList =
  #| (self) => self.files
