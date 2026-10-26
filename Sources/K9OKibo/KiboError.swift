import Foundation

/// Errors thrown by K9OKibo crypto methods.
///
/// One-to-one with the bound core's `ZkFfiUniffiError` variants. Codes are
/// passed through from the core (never hardcoded), per the KError discipline:
///   - `.platform` carries a `K9O_*` wire code.
///   - `.upstreamKms` is the customer's own KMS failing — no platform code is
///     assigned (upstream failures carry no `K9O_*` code).
///   - `.postureViolation` is `K9O_CRYPTO_POSTURE_FLOOR_VIOLATION` — the
///     requested posture/oracle mode is below the project-declared floor.
public enum K9OKiboError: Error, Sendable {
    /// A platform error carrying a `K9O_*` wire code.
    case platform(code: String, message: String)
    /// The customer's KMS returned an error (no `K9O_*` code is assigned).
    case upstreamKms(message: String)
    /// The requested posture or oracle mode is below the project-declared floor.
    case postureViolation(
        code: String,
        message: String,
        dimension: String,
        requested: String,
        declared: String
    )

    /// Map the bound core's uniffi error → `K9OKiboError`, preserving codes.
    static func from(_ error: ZkFfiUniffiError) -> K9OKiboError {
        switch error {
        case let .Platform(code, message):
            return .platform(code: code, message: message)
        case let .UpstreamKms(message):
            return .upstreamKms(message: message)
        case let .PostureViolation(code, message, dimension, requested, declared):
            return .postureViolation(
                code: code,
                message: message,
                dimension: dimension,
                requested: requested,
                declared: declared
            )
        }
    }
}

extension K9OKiboError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .platform(code, message):
            return "\(code): \(message)"
        case let .upstreamKms(message):
            return "Upstream KMS error: \(message)"
        case let .postureViolation(code, message, dimension, requested, declared):
            return "\(code): \(message) (dimension: \(dimension), requested: \(requested), declared: \(declared))"
        }
    }
}
