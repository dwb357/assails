//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// An add-on protocol to describe a type that must be opened before and closed after usage.
public protocol HasOpenAndClose: HasClose, HasOpen {}

public extension HasOpenAndClose {
    /// Execute a block of code, guaranteeing that is `open`ed before usage and `close`d afterwards.
    /// - parameter body: block to be safely executed
    /// - returns value returned by `body` if any.
    /// - throws rethrows any exception generated by `open` or `body`.
    func use<T>(_ body: (Self) throws -> T) throws -> T {
        try open()
        defer { try? close() }
        return try body(self)
    }
}

extension InputStream: HasOpenAndClose {}
extension OutputStream: HasOpenAndClose {}
