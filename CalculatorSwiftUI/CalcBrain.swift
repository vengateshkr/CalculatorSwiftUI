//
//  CalcBrain.swift
//  CalculatorSwiftUI
//
//  Created by Venkatesh on 3/1/20.
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import Foundation
import SwiftUI

struct CalcBrain {
    private var accumulator :Double?
    
    private enum Operation {
        case equals
        case constant(Double)
        case binary((Double,Double) -> Double)
    }
    
    
    private var operation:Dictionary<String,Operation> = [
        
        "+" : Operation.binary({$0 + $1}),
        "÷" : Operation.binary({$0 / $1}),
        "x" : Operation.binary({$0 * $1}),
        "-" : Operation.binary({$0 - $1}),
        "%" : Operation.binary({0.truncatingRemainder(dividingBy:$1)}),
        "AC": Operation.constant(0),
        "=":Operation.equals
        
    ]
    
    
    
    mutating func performOper(_ symbol:String)
    {
        if let operation = operation[symbol] {
            switch operation {
            case .constant(let val):
                accumulator = val
            case .binary(let f):
                if accumulator != nil{
                    pendingBinaryOper = PendingBinaryOper(function:f,firstOper:accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOper()
                
            }
        }
        else{
            print("Wrong Operator")
        }
    }
    
    //mutating func PendingBinaryOper(function:)
    
    
    mutating func performPendingBinaryOper()
    {
        if pendingBinaryOper != nil && accumulator != nil{
            accumulator = pendingBinaryOper!.perform(with:accumulator!)
            pendingBinaryOper = nil
        }
    }
    
    private var pendingBinaryOper:PendingBinaryOper?
    
    private struct PendingBinaryOper {
        let function:(Double,Double) -> Double
        let firstOper:Double
        
        func perform(with secondOper:Double) -> Double{
            return function(firstOper,secondOper)
        }
    }
    
    mutating func setOper(_ operand:Double)
    {
        accumulator = operand
    }
    
    var res : Double? {
        get {
            return accumulator
        }
    }
}


