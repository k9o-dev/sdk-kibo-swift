// swift-tools-version: 5.9
import PackageDescription

// Released package — the compiled core is fetched by SPM from a pinned,
// checksummed remote zip (built by kibo CI, core v2.12.0).
let package = Package(
    name: "K9OKibo",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [.library(name: "K9OKibo", targets: ["K9OKibo"])],
    targets: [
        .binaryTarget(
            name: "kibo_kms_rest_ffiFFI",
            url: "https://k9o.dev/sdk-kibo-swift/1.1.1/kibo_kms_rest_ffiFFI.xcframework.zip",
            checksum: "c011d7d2505adea187b06b6300dc99f5d7016754a904063a297528d9c4498589"
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
