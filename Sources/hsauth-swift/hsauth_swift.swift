// The Swift Programming Language
// https://docs.swift.org/swift-book

import LibCrypto
import Foundation

/// `KeyV1` is a object definition for operations on handshake authentication
public class KeyV1 {
    private var key: String = ""
    /// Gets hex-encoded key
    /// - Returns: `String`
    public func getKey() -> String {
        return self.key
    }
    
    /// Initializes new `KeyV1` instance from hex-encoded key
    ///
    /// - Parameter rawKeyPresentation: raw key as a `Data` object
    /// - Returns: `KeyV1` instance
    public init(hexKey: String) {
        self.key = hexKey
    }
    
    /// Initializes new `KeyV1` instance by computing shared secret (HSAuth key) from a (user's) private key and a (server's) public key
    ///
    /// - Parameters:
    ///   - ourPrivateKey: hex-encoded private key
    ///   - theirPublicKey: hex-encoded public key
    /// - Returns: `KeyV1` instance
    public required init(ourPrivateKey: String, theirPublicKey: String) throws {
        self.key = Hex.toHexString(
            Data(
                symmetricKey: try X25519.computeSharedSecret(ourPrivate: ourPrivateKey, theirPublic: theirPublicKey)
            )
        )
    }
    
    /// Checks if the key given by the user matches the one created from (server's) private and a (user's) public key
    ///
    /// - Parameters:
    ///   - ourPrivateKey: hex-encoded private key
    ///   - theirPublicKey: hex-encoded public key
    /// - Returns: `Bool` (`false` means it doesn't match, `true` means it matches)
    public func validate(ourPrivateKey: String, theirPublicKey: String) -> Bool {
        guard let key = try? Self(ourPrivateKey: ourPrivateKey, theirPublicKey: theirPublicKey) else {
            return false
        }
        
        return key.key == self.key
    }
}
