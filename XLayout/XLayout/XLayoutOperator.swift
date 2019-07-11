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
prefix operator |-
postfix operator -|

// chaining methods operator
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
public prefix func * (right: CGFloat) -> XLayoutConstraintParam {
    let params = XLayoutConstraintParam.init(isSmart: true)
    params.multiplier = right
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

// equation-based operator
public func == (left: XLayoutConstraintParam, right: XLayoutConstraintParam) {
    right.relation = .equal
    if let view: NSView = left.context as? NSView {
        view.xLayout.makeConstraintFromParam(by: left.attribute, with: right)
    }
}

public func == (left: XLayoutConstraintParam, right: CGFloat) {
    let params = XLayoutConstraintParam.init(isSmart: true)
    params.relation = .equal
    params.constant = right
    if let view: NSView = left.context as? NSView {
        view.xLayout.makeConstraintFromParam(by: left.attribute, with: params)
    }
}

public func >= (left: XLayoutConstraintParam, right: XLayoutConstraintParam) {
    right.relation = .greaterThanOrEqual
    if let view: NSView = left.context as? NSView {
        view.xLayout.makeConstraintFromParam(by: left.attribute, with: right)
    }
}

public func >= (left: XLayoutConstraintParam, right: CGFloat) {
    let params = XLayoutConstraintParam.init(isSmart: true)
    params.relation = .greaterThanOrEqual
    params.constant = right
    if let view: NSView = left.context as? NSView {
        view.xLayout.makeConstraintFromParam(by: left.attribute, with: params)
    }
}

public func <= (left: XLayoutConstraintParam, right: XLayoutConstraintParam) {
    right.relation = .lessThanOrEqual
    if let view: NSView = left.context as? NSView {
        view.xLayout.makeConstraintFromParam(by: left.attribute, with: right)
    }
}

public func <= (left: XLayoutConstraintParam, right: CGFloat) {
    let params = XLayoutConstraintParam.init(isSmart: true)
    params.relation = .lessThanOrEqual
    params.constant = right
    if let view: NSView = left.context as? NSView {
        view.xLayout.makeConstraintFromParam(by: left.attribute, with: params)
    }
}

// visual layout operator
@discardableResult
public prefix func |- (right: CGFloat) -> XLayoutVisualParam {
    let visualParam = XLayoutVisualParam.init()
    visualParam.elementOrder.append(XLayoutVisualElement.superView)
    visualParam.elementOrder.append(right)
    return visualParam
}

public prefix func |- (right: XLayoutView) -> XLayoutVisualParam {
    let visualParam = XLayoutVisualParam.init()
    visualParam.elementOrder.append(XLayoutVisualElement.superView)
    visualParam.elementOrder.append(XLayoutVisualElement.padding)
    visualParam.elementOrder.append(right)
    return visualParam
}

public prefix func |- (right: XLayoutVisualParam) -> XLayoutVisualParam {
    if right.elementOrder.first is XLayoutView {
        right.elementOrder.insert(XLayoutVisualElement.padding, at: 0)
    }
    right.elementOrder.insert(XLayoutVisualElement.superView, at: 0)
    return right
}

public prefix func |- (right: XLayoutConstraintParam) -> XLayoutVisualParam {
    let visualParam = XLayoutVisualParam.init()
    visualParam.elementOrder.append(XLayoutVisualElement.superView)
    visualParam.elementOrder.append(right)
    return visualParam
}

public func - (left: XLayoutView, right: CGFloat) -> XLayoutVisualParam {
    let visualParam = XLayoutVisualParam.init()
    visualParam.elementOrder.append(left)
    visualParam.elementOrder.append(right)
    return visualParam
}

public func - (left: XLayoutView, right: XLayoutView) -> XLayoutVisualParam {
    let visualParam = XLayoutVisualParam.init()
    visualParam.elementOrder.append(left)
    visualParam.elementOrder.append(XLayoutVisualElement.padding)
    visualParam.elementOrder.append(right)
    return visualParam
}

public func - (left: XLayoutVisualParam, right: CGFloat) -> XLayoutVisualParam {
    left.elementOrder.append(right)
    return left
}

public func - (left: CGFloat, right: XLayoutVisualParam) -> XLayoutVisualParam {
    right.elementOrder.insert(right, at: 0)
    return right
}

public func - (left: XLayoutVisualParam, right: XLayoutView) -> XLayoutVisualParam {
    if left.elementOrder.last is XLayoutView {
        left.elementOrder.append(XLayoutVisualElement.padding)
    }
    left.elementOrder.append(right)
    return left
}

public func - (left: XLayoutView, right: XLayoutVisualParam) -> XLayoutVisualParam {
    if right.elementOrder.first is XLayoutView {
        right.elementOrder.insert(XLayoutVisualElement.padding, at: 0)
    }
    right.elementOrder.insert(left, at: 0)
    return right
}

public func - (left: XLayoutVisualParam, right: XLayoutConstraintParam) -> XLayoutVisualParam {
    left.elementOrder.append(right)
    return left
}

public func - (left: XLayoutVisualParam, right: XLayoutVisualParam) -> XLayoutVisualParam {
    if left.elementOrder.last is XLayoutView && right.elementOrder.first is XLayoutView {
        left.elementOrder.append(XLayoutVisualElement.padding)
    }
    left.elementOrder.append(contentsOf: right.elementOrder)
    return left
}

public postfix func -| (left: CGFloat) -> XLayoutVisualParam {
    let visualParam = XLayoutVisualParam.init()
    visualParam.elementOrder.append(left)
    visualParam.elementOrder.append(XLayoutVisualElement.superView)
    return visualParam
}

public postfix func -| (left: XLayoutView) -> XLayoutVisualParam {
    let visualParam = XLayoutVisualParam.init()
    visualParam.elementOrder.append(left)
    visualParam.elementOrder.append(XLayoutVisualElement.padding)
    visualParam.elementOrder.append(XLayoutVisualElement.superView)
    return visualParam
}

public postfix func -| (left: XLayoutConstraintParam) -> XLayoutVisualParam {
    let visualParam = XLayoutVisualParam.init()
    visualParam.elementOrder.append(left)
    visualParam.elementOrder.append(XLayoutVisualElement.superView)
    return visualParam
}
