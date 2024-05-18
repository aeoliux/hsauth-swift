import XCTest
@testable import LibCrypto
@testable import hsauth_swift

final class hsauth_swiftTests: XCTestCase {
    func testValidation() throws {
        let firstKeyPair = X25519.generateKeyPair()
        let secondKeyPair = X25519.generateKeyPair()
        
        let key1 = try KeyV1(ourPrivateKey: firstKeyPair.privateKey, theirPublicKey: secondKeyPair.publicKey)
        
        XCTAssert(key1.validate(ourPrivateKey: secondKeyPair.privateKey, theirPublicKey: firstKeyPair.publicKey))
    }
}
