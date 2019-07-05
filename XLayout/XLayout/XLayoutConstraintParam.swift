//
//  XLayoutConstraintParam.swift
//  XLayout
//
//  Created by Jovi on 7/3/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import Foundation

public class XLayoutConstraintParam {
    public var relation: XLayoutRelation
    public var secondItem: XLayoutView?
    public var attribute: XLayoutAttribute
    public var multiplier: CGFloat
    public var constant: CGFloat
    public var priority: XLayoutPriority
    public let isSmart: Bool

    public init(secItem: XLayoutView, attr: XLayoutAttribute) {
        self.secondItem = secItem
        self.attribute = attr
        self.relation = .equal
        self.multiplier = 1.0
        self.constant = 0
        self.priority = XLayoutPriority.init(rawValue: 1000)
        self.isSmart = false
    }

    public init(isSmart: Bool = false) {
        self.secondItem = nil
        self.attribute = XLayoutAttribute.notAnAttribute
        self.relation = .equal
        self.multiplier = 1.0
        self.constant = 0
        self.priority = XLayoutPriority.init(rawValue: 1000)
        self.isSmart = isSmart
    }
}
