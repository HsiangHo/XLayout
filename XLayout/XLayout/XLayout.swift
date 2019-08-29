//
//  XLayout.swift
//  XLayout
//
//  Created by Jovi on 7/2/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import Cocoa

public typealias XLayoutView = NSView
public typealias XLayoutAttribute = NSLayoutConstraint.Attribute
public typealias XLayoutPriority = NSLayoutConstraint.Priority
public typealias XLayoutRelation = NSLayoutConstraint.Relation

// swiftlint:disable type_name
protocol Copyable {
    associatedtype T
    func copy() -> T
}

public protocol XLayoutMethodChainingProtocol {
    func leading(_ param: XLayoutConstraintParam) -> XLayoutProxy
    func trailing(_ param: XLayoutConstraintParam) -> XLayoutProxy
    func left(_ param: XLayoutConstraintParam) -> XLayoutProxy
    func right(_ param: XLayoutConstraintParam) -> XLayoutProxy
    func top(_ param: XLayoutConstraintParam) -> XLayoutProxy
    func bottom(_ param: XLayoutConstraintParam) -> XLayoutProxy
    func width(_ param: XLayoutConstraintParam) -> XLayoutProxy
    func height(_ param: XLayoutConstraintParam) -> XLayoutProxy
    func centerX(_ param: XLayoutConstraintParam) -> XLayoutProxy
    func centerY(_ param: XLayoutConstraintParam) -> XLayoutProxy

    func leading(_ value: CGFloat) -> XLayoutProxy
    func trailing(_ value: CGFloat) -> XLayoutProxy
    func left(_ value: CGFloat) -> XLayoutProxy
    func right(_ value: CGFloat) -> XLayoutProxy
    func top(_ value: CGFloat) -> XLayoutProxy
    func bottom(_ value: CGFloat) -> XLayoutProxy
    func width(_ value: CGFloat) -> XLayoutProxy
    func height(_ value: CGFloat) -> XLayoutProxy
    func centerX(_ value: CGFloat) -> XLayoutProxy
    func centerY(_ value: CGFloat) -> XLayoutProxy

    var leading: XLayoutProxy { get }
    var trailing: XLayoutProxy { get }
    var left: XLayoutProxy { get }
    var right: XLayoutProxy { get }
    var top: XLayoutProxy { get }
    var bottom: XLayoutProxy { get }
    var width: XLayoutProxy { get }
    var height: XLayoutProxy { get }
    var centerX: XLayoutProxy { get }
    var centerY: XLayoutProxy { get }
}

public protocol XLayoutConstraintParamMakerProtocol {
    var leading: XLayoutConstraintParam { get }
    var trailing: XLayoutConstraintParam { get }
    var left: XLayoutConstraintParam { get }
    var right: XLayoutConstraintParam { get }
    var top: XLayoutConstraintParam { get }
    var bottom: XLayoutConstraintParam { get }
    var width: XLayoutConstraintParam { get }
    var height: XLayoutConstraintParam { get }
    var centerX: XLayoutConstraintParam { get }
    var centerY: XLayoutConstraintParam { get }
}
