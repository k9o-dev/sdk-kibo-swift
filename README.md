# K9OKibo

Zero-knowledge encryption for iOS and macOS: encrypt and decrypt on the device with your own key management service (KMS).

## Contents

- [Install](#install)
- [Requirements](#requirements)
- [Quick start](#quick-start)
- [Handle errors](#handle-errors)
- [Appendix](#appendix)

## Install

```swift
dependencies: [
    .package(url: "https://github.com/k9o-dev/sdk-kibo-swift.git", from: "1.1.0"),
],
targets: [
    .target(
        name: "MyApp",
        dependencies: [
            .product(name: "K9OKibo", package: "sdk-kibo-swift"),
        ]
    ),
]
```

## Requirements

- iOS 15 or later, or macOS 12 or later
- Swift 5.9 or later

## Quick start

Encryption and decryption run on the device, against your KMS. The platform never sees plaintext or unwrapped keys.

```swift
import K9OKibo

let output = try await encrypt(input)
```

`input` is an `EncryptInput`. `output` is an `EncryptOutput` holding an opaque envelope.

Keep the envelope yourself; it means nothing to the platform.

Decrypt it later with a `DecryptInput`:

```swift
let plaintext = try await decrypt(decryptInput)
```

The strategy, attestation tier and encryption context must match the values used to encrypt.
They are bound to the envelope and are not read back from it.

See the [functions](#functions).

## Handle errors

Both functions throw `K9OKiboError`.

```swift
do {
    _ = try await encrypt(input)
} catch K9OKiboError.upstreamKms(let message) {
    print("Your KMS reported: \(message)")
} catch {
    print("Encryption failed: \(error.localizedDescription)")
}
```

See all [error cases](#error-cases).

## Appendix

### Functions

| Function | Meaning |
|---|---|
| `encrypt(_:)` | Takes an `EncryptInput`; returns an `EncryptOutput` |
| `decrypt(_:)` | Takes a `DecryptInput`; returns a `DecryptOutput` |

Both are `async throws`. The input and output types come from the cryptographic core that this package wraps.

### Error cases

| Case | Meaning |
|---|---|
| `.platform(code:message:)` | A platform error with a `K9O_*` code |
| `.upstreamKms(message:)` | Your own KMS returned an error |
| `.postureViolation(code:message:dimension:requested:declared:)` | The requested security posture is below the project's declared floor |

The code of a `.postureViolation` is `K9O_CRYPTO_POSTURE_FLOOR_VIOLATION`.

### Related packages

| Package | What it does |
|---|---|
| `K9OGate` | Signs end users in; in the `sdk-swift` package |
| `K9OCore` | Project-plane client; in the `sdk-swift` package |

Documentation: https://kilimanjaro.dev

## License

Apache-2.0 © Formelo Inc. See `LICENSE` and `NOTICE`.
