import Foundation

// ZK encrypt/decrypt — the thin Swift wrapper over the bound crypto core
// (`kibo-kms-rest-ffi`, piece C) compiled to a native lib via uniffi.
//
// ZERO crypto here: every wrap/unwrap, envelope framing, posture-floor
// enforcement, and KMS round-trip lives in the audited Rust core. This layer
// only forwards the typed input to the generated binding (`zkEncrypt` /
// `zkDecrypt`, both `async throws`) and maps the core's `ZkFfiUniffiError`
// → the SDK's `K9OKiboError` (Swift-idiomatic `throws` shape).
//
// The generated input/output types (`EncryptInput`, `DecryptInput`,
// `EncryptOutput`, `DecryptOutput`, `Ffi*`, `KmsProvider`, …) are re-exported
// implicitly: they compile into this same module from the generated
// `Generated/kibo_kms_rest_ffi.swift`, so callers `import K9OKibo` only.
//
// The F.5 ZK-DEK store/fetch surface (envelope persistence over the gateway)
// is separate + decoupled — the core never sees the store.

/// Encrypt `input.plaintext` via the customer KMS, client-side. Returns the
/// opaque ZKFE envelope — store it via the gateway ZK-DEK surface (F.5) or keep
/// it yourself; it is meaningless to the platform.
public func encrypt(_ input: EncryptInput) async throws -> EncryptOutput {
    do {
        return try await zkEncrypt(input: input)
    } catch let error as ZkFfiUniffiError {
        throw K9OKiboError.from(error)
    }
}

/// Decrypt a ZKFE `input.envelope`. `strategy`, `attestationTier`, and
/// `encryptionContext` MUST match the values used at encrypt — they are
/// AAD-bound and never recovered from the envelope (anti-substitution
/// discipline; the KMS verifies they match at decrypt).
public func decrypt(_ input: DecryptInput) async throws -> DecryptOutput {
    do {
        return try await zkDecrypt(input: input)
    } catch let error as ZkFfiUniffiError {
        throw K9OKiboError.from(error)
    }
}
