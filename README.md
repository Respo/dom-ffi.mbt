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
