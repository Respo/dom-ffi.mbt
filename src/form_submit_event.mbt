///|
/// | An HTML form element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement)
#external
pub type HtmlFormElement

///|
/// | Reinterprets an element as a form element without validating its tag.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement)
pub fn Element::reinterpret_as_html_form_element(
  self : Element,
) -> HtmlFormElement = "%identity"

///|
/// | Returns the form submission method in normalized lowercase form.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement/method)
pub extern "js" fn HtmlFormElement::submission_method(
  self : HtmlFormElement,
) -> String =
  #| (self) => self.method

///|
/// | Sets the form submission method.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement/method)
pub extern "js" fn HtmlFormElement::set_submission_method(
  self : HtmlFormElement,
  submission_method : String,
) -> Unit =
  #| (self, submission_method) => { self.method = submission_method }

///|
/// | Returns whether all form controls pass constraint validation.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement/checkValidity)
pub extern "js" fn HtmlFormElement::check_validity(
  self : HtmlFormElement,
) -> Bool =
  #| (self) => self.checkValidity()

///|
/// | Resets form controls to their default values.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement/reset)
pub extern "js" fn HtmlFormElement::reset(self : HtmlFormElement) -> Unit =
  #| (self) => self.reset()

///|
/// | Requests form submission with the supplied submit button.
/// |
/// | The browser performs constraint validation and dispatches a `SubmitEvent`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement/requestSubmit)
pub extern "js" fn HtmlFormElement::request_submit(
  self : HtmlFormElement,
  submitter : HtmlButtonElement,
) -> Unit =
  #| (self, submitter) => self.requestSubmit(submitter)

///|
/// | Creates `FormData` from the current successful controls in a form.
/// |
/// | The result is a snapshot; later control changes do not alter it.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/FormData/FormData)
pub extern "js" fn FormData::new_from_form(form : HtmlFormElement) -> FormData =
  #| (form) => new FormData(form)

///|
/// | An HTML button element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLButtonElement)
#external
pub type HtmlButtonElement

///|
/// | Reinterprets an element as a button element without validating its tag.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLButtonElement)
pub fn Element::reinterpret_as_html_button_element(
  self : Element,
) -> HtmlButtonElement = "%identity"

///|
/// | Returns the button value submitted with a form.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLButtonElement/value)
pub extern "js" fn HtmlButtonElement::value(self : HtmlButtonElement) -> String =
  #| (self) => self.value

///|
/// | Sets the button value submitted with a form.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLButtonElement/value)
pub extern "js" fn HtmlButtonElement::set_value(
  self : HtmlButtonElement,
  value : String,
) -> Unit =
  #| (self, value) => { self.value = value }

///|
/// | Returns whether the button is disabled.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLButtonElement/disabled)
pub extern "js" fn HtmlButtonElement::disabled(
  self : HtmlButtonElement,
) -> Bool =
  #| (self) => self.disabled

///|
/// | Sets whether the button is disabled.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLButtonElement/disabled)
pub extern "js" fn HtmlButtonElement::set_disabled(
  self : HtmlButtonElement,
  disabled : Bool,
) -> Unit =
  #| (self, disabled) => { self.disabled = disabled }

///|
/// | An HTML select element.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLSelectElement)
#external
pub type HtmlSelectElement

///|
/// | Reinterprets an element as a select element without validating its tag.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLSelectElement)
pub fn Element::reinterpret_as_html_select_element(
  self : Element,
) -> HtmlSelectElement = "%identity"

///|
/// | Returns the value of the selected option.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLSelectElement/value)
pub extern "js" fn HtmlSelectElement::value(self : HtmlSelectElement) -> String =
  #| (self) => self.value

///|
/// | Selects the option matching `value`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/HTMLSelectElement/value)
pub extern "js" fn HtmlSelectElement::set_value(
  self : HtmlSelectElement,
  value : String,
) -> Unit =
  #| (self, value) => { self.value = value }

///|
/// | A form submission event.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/SubmitEvent)
#external
pub type SubmitEvent

///|
/// | Creates a submission event with default initialization values.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/SubmitEvent/SubmitEvent)
pub extern "js" fn SubmitEvent::new(type_ : String) -> SubmitEvent =
  #| (type_) => new SubmitEvent(type_)

///|
/// | Creates a submission event with the supplied initialization dictionary.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/SubmitEvent/SubmitEvent)
pub extern "js" fn SubmitEvent::new_with_init_dict(
  type_ : String,
  init : SubmitEventInit,
) -> SubmitEvent =
  #| (type_, init) => new SubmitEvent(type_, init)

///|
extern "js" fn SubmitEvent::js_submitter(self : SubmitEvent) -> JsObscure =
  #| (self) => self.submitter

///|
/// | Returns the submit button that triggered this event, or `None` when the
/// | event has no submitter.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/SubmitEvent/submitter)
pub fn SubmitEvent::submitter(self : SubmitEvent) -> Element? {
  let submitter = self.js_submitter()
  if submitter.is_nullish() {
    None
  } else {
    Some(js_obscure_to_v(submitter))
  }
}

///|
/// | Reinterprets this submission event as the generic `Event` used by
/// | `EventTarget` APIs.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent)
pub fn SubmitEvent::reinterpret_as_event(self : SubmitEvent) -> Event = "%identity"

///|
/// | Reinterprets a generic event as a submission event when the caller knows
/// | it originated from a `submit` listener.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/SubmitEvent)
pub fn Event::reinterpret_as_submit_event(self : Event) -> SubmitEvent = "%identity"

///|
/// | Initialization values for a `SubmitEvent`.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/SubmitEvent/SubmitEvent#options)
#external
pub type SubmitEventInit

///|
/// | Creates an empty submit-event initialization dictionary.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/SubmitEvent/SubmitEvent#options)
pub extern "js" fn SubmitEventInit::new() -> SubmitEventInit =
  #| () => ({})

///|
/// | Sets the button exposed as the event submitter.
/// |
/// | [MDN Reference](https://developer.mozilla.org/en-US/docs/Web/API/SubmitEvent/SubmitEvent#options)
pub extern "js" fn SubmitEventInit::set_submitter(
  self : SubmitEventInit,
  submitter : Element,
) -> Unit =
  #| (self, submitter) => { self.submitter = submitter }
