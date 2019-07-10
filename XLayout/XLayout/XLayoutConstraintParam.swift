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
    var isSmart: Bool
    var context: Any?

    init(secItem: XLayoutView, attr: XLayoutAttribute, context: Any? = nil) {
        self.secondItem = secItem
        self.attribute = attr
        self.relation = .equal
        self.multiplier = 1.0
        self.constant = 0
        self.priority = XLayoutPriority.init(rawValue: 1000)
        self.isSmart = false
        self.context = context
    }

    init(isSmart: Bool = false) {
        self.secondItem = nil
        self.attribute = XLayoutAttribute.notAnAttribute
        self.relation = .equal
        self.multiplier = 1.0
        self.constant = 0
        self.priority = XLayoutPriority.init(rawValue: 1000)
        self.isSmart = isSmart
        self.context = nil
    }
}

extension XLayoutConstraintParam: Copyable {
    func copy() -> XLayoutConstraintParam {
        let instance = XLayoutConstraintParam.init(isSmart: self.isSmart)
        instance.secondItem = self.secondItem
        instance.attribute = self.attribute
        instance.relation = self.relation
        instance.multiplier = self.multiplier
        instance.constant = self.constant
        instance.priority = self.priority
        return instance
    }
}
