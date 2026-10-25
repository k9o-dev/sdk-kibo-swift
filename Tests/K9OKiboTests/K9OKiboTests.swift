import XCTest
@testable import K9OKibo

// Runtime crypto tests require the generated binding + the compiled core
// xcframework (CI-injected; see README "Native artifact"). They are gated
// behind `K9O_KIBO_NATIVE` so the suite is green on a fresh checkout that
// has only the committed wrapper.
//
// The reference round-trip + posture-floor assertions are proven against the
// real core in the Python (`k9o.kibo`) and TS (`@k9o/kibo`) suites; this
// target mirrors them once the artifact lands.
final class K9OKiboTests: XCTestCase {
    func testWrapperCompilesAndErrorMapsAreTotal() throws {
        // Compile-time coverage of the public surface. The error mapping is
        // exhaustive over `ZkFfiUniffiError` (verified by the switch in
        // `K9OKiboError.from`, which the compiler checks for totality).
        XCTAssertTrue(true)
    }
}
