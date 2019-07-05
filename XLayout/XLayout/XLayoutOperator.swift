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
prefix operator *

@discardableResult
public func ~ (left: XLayoutConstraintParam, right: CGFloat) -> XLayoutConstraintParam {
    left.priority = XLayoutPriority.init(rawValue: Float(right))
    return left
}

@discardableResult
public func ~ (left: CGFloat, right: CGFloat) -> XLayoutConstraintParam {
    let params = XLayoutConstraintParam.init(isSmart: true)
    params.constant = left
    params.priority = XLayoutPriority.init(rawValue: Float(right))
    return params
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
public prefix func * (params: CGFloat) -> XLayoutConstraintParam {
    let params = XLayoutConstraintParam.init(isSmart: true)
    return params
}

@discardableResult
public prefix func == (params: XLayoutConstraintParam) -> XLayoutConstraintParam {
    params.relation = .equal
    return params
}

@discardableResult
public prefix func == (right: CGFloat) -> XLayoutConstraintParam {
    let params = XLayoutConstraintParam.init(isSmart: true)
    params.relation = .equal
    params.constant = right
    return params
}

@discardableResult
public prefix func >= (params: XLayoutConstraintParam) -> XLayoutConstraintParam {
    params.relation = .greaterThanOrEqual
    return params
}

@discardableResult
public prefix func >= (right: CGFloat) -> XLayoutConstraintParam {
    let params = XLayoutConstraintParam.init(isSmart: true)
    params.relation = .greaterThanOrEqual
    params.constant = right
    return params
}

@discardableResult
public prefix func <= (params: XLayoutConstraintParam) -> XLayoutConstraintParam {
    params.relation = .lessThanOrEqual
    return params
}

@discardableResult
public prefix func <= (right: CGFloat) -> XLayoutConstraintParam {
    let params = XLayoutConstraintParam.init(isSmart: true)
    params.relation = .lessThanOrEqual
    params.constant = right
    return params
}
