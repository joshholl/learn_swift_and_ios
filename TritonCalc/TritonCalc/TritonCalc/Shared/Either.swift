//
//  Either.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/6/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation

public enum Either<T, U> {
    case left(T)
    case right(U)
}
extension Either: EitherProtocol {
    /// Constructs a `Left`.
    ///
    /// Suitable for partial application.
    public static func toLeft(_ value: T) -> Either {
        return .left(value)
    }
    
    /// Constructs a `Right`.
    ///
    /// Suitable for partial application.
    public static func toRight(_ value: U) -> Either {
        return .right(value)
    }
    
    /// Returns the result of applying `f` to the value of `Left`, or `g` to the value of `Right`.
    public func either<Result>(ifLeft: (T) throws -> Result, ifRight: (U) throws -> Result) rethrows -> Result {
        switch self {
        case let .left(x):
            return try ifLeft(x)
        case let .right(x):
            return try ifRight(x)
        }
    }
}

public protocol EitherProtocol {
    associatedtype Left
    associatedtype Right
    
    /// Constructs a `Left` instance.
    static func toLeft(_ value: Left) -> Self
    
    /// Constructs a `Right` instance.
    static func toRight(_ value: Right) -> Self
    
    /// Returns the result of applying `f` to `Left` values, or `g` to `Right` values.
    func either<Result>(ifLeft: (Left) throws -> Result, ifRight: (Right) throws -> Result) rethrows -> Result
}


