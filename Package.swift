// swift-tools-version: 5.9
import PackageDescription

// Released package — the compiled core is fetched by SPM from a pinned,
// checksummed remote zip (built by kibo CI, core v2.13.1).
let package = Package(
    name: "K9OKibo",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [.library(name: "K9OKibo", targets: ["K9OKibo"])],
    targets: [
        .binaryTarget(
            name: "kibo_kms_rest_ffiFFI",
            url: "https://k9o.dev/sdk-kibo-swift/1.4.0/kibo_kms_rest_ffiFFI.xcframework.zip",
            checksum: "7e30a90f77aedc05b129113a5b6c5d00e5389784f797a0186d21e7d9adf4cec3"
        ),
        .target(
            name: "K9OKibo",
            dependencies: ["kibo_kms_rest_ffiFFI"],
            path: "Sources/K9OKibo"
        ),
        .testTarget(
            name: "K9OKiboTests",
            dependencies: ["K9OKibo"],
            path: "Tests/K9OKiboTests"
        ),
    ]
)
