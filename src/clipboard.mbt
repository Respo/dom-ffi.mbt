///|
/// A clipboard event, distinct from the asynchronous system Clipboard API.
/// https://developer.mozilla.org/en-US/docs/Web/API/ClipboardEvent
#external
pub type ClipboardEvent

///|
/// Creates an untrusted event with null clipboardData by default.
/// Dispatching it does not read or modify the system clipboard.
/// https://developer.mozilla.org/en-US/docs/Web/API/ClipboardEvent/ClipboardEvent
pub extern "js" fn ClipboardEvent::new(type_ : String) -> ClipboardEvent =
  #| (type_) => new ClipboardEvent(type_)

///|
/// Creates an untrusted clipboard event with the supplied initialization values.
/// https://developer.mozilla.org/en-US/docs/Web/API/ClipboardEvent/ClipboardEvent
pub extern "js" fn ClipboardEvent::new_with_init_dict(
  type_ : String,
  init : ClipboardEventInit,
) -> ClipboardEvent =
  #| (type_, init) => new ClipboardEvent(type_, init)

///|
extern "js" fn ClipboardEvent::data_raw(self : ClipboardEvent) -> JsObscure =
  #| (self) => self.clipboardData

///|
/// Returns the original data store, or None for a constructed event without one.
/// Read paste data synchronously in the handler; this does not grant clipboard permission.
/// https://developer.mozilla.org/en-US/docs/Web/API/ClipboardEvent/clipboardData
pub fn ClipboardEvent::clipboard_data(self : ClipboardEvent) -> DataTransfer? {
  let data = self.data_raw()
  if data.is_nullish() {
    None
  } else {
    Some(js_obscure_to_v(data))
  }
}

///|
/// Views this clipboard event as Event for dispatch and cancellation.
/// https://developer.mozilla.org/en-US/docs/Web/API/ClipboardEvent
pub fn ClipboardEvent::reinterpret_as_event(self : ClipboardEvent) -> Event = "%identity"

///|
/// Unchecked view: the caller must know this is a ClipboardEvent, not merely
/// a generic Event named paste/copy/cut. React should check the native event first.
/// https://developer.mozilla.org/en-US/docs/Web/API/ClipboardEvent
pub fn Event::reinterpret_as_clipboard_event(self : Event) -> ClipboardEvent = "%identity"

///|
/// Initialization dictionary for constructed clipboard events.
/// https://developer.mozilla.org/en-US/docs/Web/API/ClipboardEvent/ClipboardEvent
#external
pub type ClipboardEventInit

///|
/// Creates default initialization values (no data, non-bubbling, non-cancelable).
/// https://developer.mozilla.org/en-US/docs/Web/API/ClipboardEvent/ClipboardEvent
pub extern "js" fn ClipboardEventInit::new() -> ClipboardEventInit =
  #| () => ({})

///|
/// Sets the data store by reference, without copying its items.
/// https://developer.mozilla.org/en-US/docs/Web/API/ClipboardEvent/ClipboardEvent
pub extern "js" fn ClipboardEventInit::set_clipboard_data(
  self : ClipboardEventInit,
  data : DataTransfer,
) -> Unit =
  #| (self, data) => { self.clipboardData = data; }

///|
/// Controls propagation to ancestor event targets.
/// https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
pub extern "js" fn ClipboardEventInit::set_bubbles(
  self : ClipboardEventInit,
  value : Bool,
) -> Unit =
  #| (self, value) => { self.bubbles = value; }

///|
/// Controls whether preventDefault can cancel this event.
/// https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
pub extern "js" fn ClipboardEventInit::set_cancelable(
  self : ClipboardEventInit,
  value : Bool,
) -> Unit =
  #| (self, value) => { self.cancelable = value; }

///|
/// Creates an empty writable data store for constructed drag/clipboard events.
/// https://developer.mozilla.org/en-US/docs/Web/API/DataTransfer/DataTransfer
pub extern "js" fn DataTransfer::new() -> DataTransfer =
  #| () => new DataTransfer()

///|
/// Returns a copied array of format names; includes Files when files are present.
/// Later store changes do not update this array.
/// https://developer.mozilla.org/en-US/docs/Web/API/DataTransfer/types
pub extern "js" fn DataTransfer::types(self : DataTransfer) -> Array[String] =
  #| (self) => Array.from(self.types)

///|
/// Returns the live item list. Browser protected-mode restrictions still apply.
/// https://developer.mozilla.org/en-US/docs/Web/API/DataTransfer/items
pub extern "js" fn DataTransfer::items(
  self : DataTransfer,
) -> DataTransferItemList =
  #| (self) => self.items

///|
/// A live list of string and file items in a drag/clipboard data store.
/// https://developer.mozilla.org/en-US/docs/Web/API/DataTransferItemList
#external
pub type DataTransferItemList

///|
/// Returns the current number of items (possibly zero in protected mode).
/// https://developer.mozilla.org/en-US/docs/Web/API/DataTransferItemList/length
pub extern "js" fn DataTransferItemList::length(
  self : DataTransferItemList,
) -> Int =
  #| (self) => self.length

///|
extern "js" fn DataTransferItemList::item_raw(
  self : DataTransferItemList,
  index : Int,
) -> JsObscure =
  #| (self, index) => index >= 0 && index < self.length ? self[index] : null

///|
/// Returns None for negative or out-of-range indexes.
/// https://developer.mozilla.org/en-US/docs/Web/API/DataTransferItemList
pub fn DataTransferItemList::item(
  self : DataTransferItemList,
  index : Int,
) -> DataTransferItem? {
  let value = self.item_raw(index)
  if value.is_nullish() {
    None
  } else {
    Some(js_obscure_to_v(value))
  }
}

///|
/// Copies item references into an array; this is not a deep copy of item contents.
/// Removing/clearing items can invalidate those references; retain File or String
/// values during the handler when needed beyond the data store's lifetime.
/// https://developer.mozilla.org/en-US/docs/Web/API/DataTransferItemList
pub extern "js" fn DataTransferItemList::to_array(
  self : DataTransferItemList,
) -> Array[DataTransferItem] =
  #| (self) => Array.from(self)

///|
/// A string or file item whose accessibility follows the underlying data store.
/// https://developer.mozilla.org/en-US/docs/Web/API/DataTransferItem
#external
pub type DataTransferItem

///|
/// Returns string or file for an accessible item; may be empty after removal.
/// https://developer.mozilla.org/en-US/docs/Web/API/DataTransferItem/kind
pub extern "js" fn DataTransferItem::kind(self : DataTransferItem) -> String =
  #| (self) => self.kind

///|
/// Returns the item's MIME type, or an empty string when unavailable.
/// https://developer.mozilla.org/en-US/docs/Web/API/DataTransferItem/type
pub extern "js" fn DataTransferItem::type_(self : DataTransferItem) -> String =
  #| (self) => self.type

///|
extern "js" fn DataTransferItem::file_raw(self : DataTransferItem) -> JsObscure =
  #| (self) => self.getAsFile()

///|
/// Returns a File for an accessible file item, otherwise None (including strings).
/// https://developer.mozilla.org/en-US/docs/Web/API/DataTransferItem/getAsFile
pub fn DataTransferItem::get_as_file(self : DataTransferItem) -> File? {
  let value = self.file_raw()
  if value.is_nullish() {
    None
  } else {
    Some(js_obscure_to_v(value))
  }
}
