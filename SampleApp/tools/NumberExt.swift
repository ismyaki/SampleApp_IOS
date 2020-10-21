//
//  Ext.swift
//  SmatQDemo
//
//  Created by Aki Wang on 2020/2/13.
//  Copyright © 2020 smartq. All rights reserved.
//

import Foundation

extension Array where Iterator.Element == Int {
    func sum() -> Int {
        return self.reduce(.zero, +)
    }
}

extension Array where Iterator.Element == Int? {
    func sum() -> Int {
        return self.map({ $0 ?? .zero }).sum()
    }
}

extension Array where Iterator.Element == Int64 {
    func sum() -> Int {
        return self.map({ $0.toInt() }).reduce(.zero, +)
    }
}

extension Array where Iterator.Element == Int64? {
    func sum() -> Int {
        return self.map({ $0 ?? .zero }).sum()
    }
}

extension Array where Iterator.Element == Double {
    func sum() -> Double {
        return self.reduce(.zero, +)
    }
}

extension Array where Iterator.Element == Double? {
    func sum() -> Double {
        return self.map({ $0 ?? .zero }).sum()
    }
}

extension Array where Iterator.Element == Float {
    func sum() -> Float {
        return self.reduce(.zero, +)
    }
}

extension Array where Iterator.Element == Float? {
    func sum() -> Float {
        return self.map({ $0 ?? .zero }).sum()
    }
}

extension String {
    func toDouble() -> Double? {
        if let d = Double(self) {
            return d
        } else if let i = Int(self) {
            return Double(i)
        }
        return nil
    }
    
    func toDoubleNonNil(_ def: Double = .zero) -> Double {
        return self.toDouble() ?? def
    }
    
    func toFloat() -> Float? {
        if let f = Float(self) {
            return f
        } else if let i = Int(self) {
            return Float(i)
        }
        return Float(self)
    }
    
    func toFloatNonNil(_ def: Float = .zero) -> Float {
        return self.toFloat() ?? .zero
    }
    
    func toInt() -> Int? {
        if let i = Int(self) {
            return i
        } else if let d = Double(self) {
            return Int(d)
        }
        return nil
    }
    
    func toIntNonNil(_ def: Int = .zero) -> Int {
        return self.toInt() ?? .zero
    }
    
    func toInt64() -> Int64? {
        return Int64(self)
    }
    
    func toInt64NonNil(_ def: Int64 = .zero) -> Int64 {
        return Int64(self) ?? .zero
    }
}

extension String.SubSequence {
    func toString() -> String {
        return String(self)
    }
    
    func toDouble() -> Double? {
        return toString().toDouble()
    }
    
    func toDoubleNonNil(_ def: Double = .zero) -> Double {
        return self.toDouble() ?? def
    }
    
    func toFloat() -> Float? {
        return toString().toFloat()
    }
    
    func toFloatNonNil(_ def: Float = .zero) -> Float {
        return self.toFloat() ?? .zero
    }
    
    func toInt() -> Int? {
        return toString().toInt()
    }
    
    func toIntNonNil(_ def: Int = .zero) -> Int {
        return self.toInt() ?? .zero
    }
    
    func toInt64() -> Int64? {
        return Int64(self)
    }
    
    func toInt64NonNil(_ def: Int64 = .zero) -> Int64 {
        return Int64(self) ?? .zero
    }
}

extension Int {
    func toString() -> String {
        return String(self)
    }
    
    func toInt64() -> Int64 {
        return Int64(self)
    }
    
    func toDouble() -> Double {
        return Double(self)
    }
    
    func toFloat() -> Float {
        return Float(self)
    }
}

extension Int64 {
    func toString() -> String {
        return String(self)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    func toDouble() -> Double {
        return Double(self)
    }
    
    func toFloat() -> Float {
        return Float(self)
    }
}

func %(lhs: Double, rhs: Double) -> Double {
    return lhs.remainder(dividingBy: rhs)
}

func %=( lhs: inout Double, rhs: Double) {
    lhs = lhs.remainder(dividingBy: rhs)
}

func %(lhs: Float, rhs: Float) -> Float {
    return lhs.remainder(dividingBy: rhs)
}

func %=( lhs: inout Float, rhs: Float) {
    lhs = lhs.remainder(dividingBy: rhs)
}

extension Double {
    func toString() -> String {
        return String(self)
    }
    
    func toInt64() -> Int64 {
        return Int64(self)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    func toFloat() -> Float {
        return Float(self)
    }
}

extension Float {
    func toString() -> String {
        return String(self)
    }
    
    func toInt64() -> Int64 {
        return Int64(self)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    func toDouble() -> Double {
        return Double(self)
    }
}
