## dom-ffi

> Typed MoonBit bindings for browser DOM APIs, with runtime conformance tests.

Docs: https://mooncakes.io/docs/#/tiye/dom-ffi/lib/members

```bash
moon add tiye/dom-ffi
```

```js
"import": [{ "path": "tiye/dom-ffi", "alias": "dom_ffi" }]
```

Currently it contains:

- querying elements
- setting attributes
- setting styles
- adding event listeners
- location
- search params

The public surface targets JavaScript and follows the corresponding Web IDL
nullability. DOM `NodeList` and `HTMLCollection` values are copied into
MoonBit arrays; these arrays are snapshots rather than live collections.

### Clipboard and transfer payloads (0.5.0)

`ClipboardEvent::clipboard_data()` returns the original `DataTransfer`, or
`None` for a constructed event without data. Use `ClipboardEventInit` to supply
data and configure bubbling/cancellation. Constructing or dispatching these
events does **not** read/write the system clipboard or simulate trusted paste.

`DataTransfer::types()` copies format names (including `Files` for file data).
`items()` exposes the live list; `item(index)` returns `None` outside its bounds.
Items provide `kind()`, `type_()`, and nullable `get_as_file()`. `to_array()` copies
item references, not the underlying contents; capture strings/files inside the
event handler before browser data-store restrictions apply. Item mutation and
asynchronous `getAsString` are not included in this slice.

For React, check the SyntheticEvent's native event family before using
`Event::reinterpret_as_clipboard_event()` (an unchecked cast). Keep
preventDefault/propagation calls on the React event. React will adopt this API
after a separately reviewed GitHub Release → Actions publication.

### Quality checks

```bash
moon check --target js
moon test --target js
moon build --target js --debug
corepack yarn@1.22.22 install --frozen-lockfile
corepack yarn@1.22.22 test:browser
```

The browser suite runs the compiled MoonBit bindings against real Chromium.
Run `corepack yarn@1.22.22 playwright install chromium` once if Chromium is
not already installed.

### License

Apache License 2.0
