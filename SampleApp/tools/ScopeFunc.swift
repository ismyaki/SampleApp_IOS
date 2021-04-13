//
//  ScopeFunc.swift
//  Stock
//
//  Created by Aki Wang on 2020/10/29.
//

import Foundation

protocol ScopeFunc {}

extension ScopeFunc {
    @discardableResult
    func also(block: (Self) -> ()) -> Self {
        block(self)
        return self
    }
    
    @discardableResult
    func apply(block: (Self) -> ()) -> Self {
        block(self)
        return self
    }
    
    @discardableResult
    func `let`<R>(block: (Self) -> R) -> R? {
        return block(self)
    }
    
    @discardableResult
    func run<R>(block: (Self) -> R) -> R? {
        return block(self)
    }
}

extension Optional where Wrapped: ScopeFunc { }

extension NSObject: ScopeFunc {}
extension Array: ScopeFunc {}
extension String: ScopeFunc {}
extension String.SubSequence: ScopeFunc {}
extension Int: ScopeFunc {}
extension Float: ScopeFunc {}
extension Double: ScopeFunc {}
extension Bool: ScopeFunc {}
