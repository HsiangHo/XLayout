//
//  XLayoutOperator.swift
//  XLayout
//
//  Created by Jovi on 7/3/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import Foundation

precedencegroup XLayoutPriorityPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
}

infix operator ~: XLayoutPriorityPrecedence
prefix operator ==
prefix operator >=
prefix operator <=

@discardableResult
public func ~ (left: XLayoutConstraintParam, right: Float) -> XLayoutConstraintParam {
    var priorityValue = right
    if 0 > priorityValue {
        priorityValue = 1
    } else if priorityValue > 1000 {
        priorityValue = 1000
    }
    left.priority = XLayoutPriority.init(rawValue: priorityValue)
    return left
}

@discardableResult
public func * (left: XLayoutConstraintParam, right: CGFloat) -> XLayoutConstraintParam {
    left.multiplier = right
    return left
}

@discardableResult
public func + (left: XLayoutConstraintParam, right: CGFloat) -> XLayoutConstraintParam {
    left.constant = right
    return left
}

@discardableResult
public func - (left: XLayoutConstraintParam, right: CGFloat) -> XLayoutConstraintParam {
    left.constant = -right
    return left
}

@discardableResult
public prefix func == (params: XLayoutConstraintParam) -> XLayoutConstraintParam {
    params.relation = .equal
    return params
}

@discardableResult
public prefix func >= (params: XLayoutConstraintParam) -> XLayoutConstraintParam {
    params.relation = .greaterThanOrEqual
    return params
}

@discardableResult
public prefix func <= (params: XLayoutConstraintParam) -> XLayoutConstraintParam {
    params.relation = .lessThanOrEqual
    return params
}
