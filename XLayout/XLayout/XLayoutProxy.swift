//
//  XLayoutProxy.swift
//  XLayout
//
//  Created by Jovi on 7/1/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import Foundation

public class XLayoutProxy {
    private let view: XLayoutView
    private var cashedLayoutConstraints: [NSLayoutConstraint]
    private var cashedAttributes: [XLayoutAttribute]

    public init(view: XLayoutView) {
        self.view = view
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.cashedLayoutConstraints = []
        self.cashedAttributes = []
    }
}

//public property
extension XLayoutProxy {
    public var remake: XLayoutProxy {
        removeAllConstraints()
        return self
    }

    public var constraint: NSLayoutConstraint? {
        return self.cashedLayoutConstraints.last
    }

    public var constraints: [NSLayoutConstraint] {
        return self.cashedLayoutConstraints
    }
}

//private methods
extension XLayoutProxy {
    private func handleParam4Constraint(by attr: XLayoutAttribute, with params: XLayoutConstraintParam) {
        if cashedAttributes.isEmpty {
            addConstraint(by: attr, with: params)
        } else {
            let paramArray: [XLayoutConstraintParam] = cashedAttributes.compactMap {
                let newParam = params.copy()
                newParam.attribute = $0
                return newParam
            }
            for par in paramArray {
                addConstraint(by: par.attribute, with: par)
            }
            cashedAttributes.removeAll()
            addConstraint(by: attr, with: params)
        }
    }

    private func reviseConstraintParam(attr: XLayoutAttribute,
                                       params: XLayoutConstraintParam) -> XLayoutConstraintParam {
        if params.isSmart {
            if attr == .width || attr == .height {
                params.secondItem = nil
                params.attribute = XLayoutAttribute.notAnAttribute
            } else {
                params.secondItem = self.view.superview!
                params.attribute = attr
            }
        }
        return params
    }

    private func addConstraint(by attr: XLayoutAttribute, with params: XLayoutConstraintParam) {
        let paramValue = reviseConstraintParam(attr: attr, params: params)
        removeSpecificConstraint(attr: attr, params: paramValue)
        let constraint = makeConstraint(by: attr, with: paramValue)
        if let secondItem = paramValue.secondItem {
            closestCommonSuperview(view: secondItem).addConstraint(constraint)
        } else {
            view.addConstraint(constraint)
        }
        self.cashedLayoutConstraints.append(constraint)
    }

    private func closestCommonSuperview(view: XLayoutView) -> XLayoutView {
        var closestCommonSuperview: XLayoutView?
        var secondViewSuperview: XLayoutView? = view
        while nil == closestCommonSuperview && nil != secondViewSuperview {
            var firstViewSuperview: XLayoutView? = self.view
            while nil == closestCommonSuperview && nil != firstViewSuperview {
                if secondViewSuperview == firstViewSuperview {
                    closestCommonSuperview = secondViewSuperview
                }
                firstViewSuperview = firstViewSuperview?.superview
            }
            secondViewSuperview = secondViewSuperview?.superview
        }
        return closestCommonSuperview!
    }

    private func removeSpecificConstraint(attr: XLayoutAttribute, params: XLayoutConstraintParam) {
        var view: XLayoutView? = self.view
        while nil != view {
            if let constraints = view?.constraints {
                for con in constraints {
                    if let first = con.firstItem as? NSObject,
                        first == self.view && con.firstAttribute == attr,
                        let second = con.secondItem as? NSObject,
                        second == params.secondItem && con.secondAttribute == params.attribute {
                        view?.removeConstraint(con)
                        break
                    }
                }
            }
            view = view?.superview
        }
    }

    private func makeConstraint(by attr: XLayoutAttribute, with params: XLayoutConstraintParam) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint.init(item: self.view,
                                                 attribute: attr,
                                                 relatedBy: params.relation,
                                                 toItem: params.secondItem,
                                                 attribute: params.attribute,
                                                 multiplier: params.multiplier,
                                                 constant: params.constant)
        constraint.priority = params.priority
        return constraint
    }

    private func removeAllConstraints() {
        var view: XLayoutView? = self.view
        while nil != view {
            if let constraints = view?.constraints {
                for con in constraints {
                    if let first = con.firstItem as? XLayoutView, first == self.view {
                        view?.removeConstraint(con)
                    }
                }
            }
            view = view?.superview
        }
    }
}

//make methods chaining
extension XLayoutProxy: XLayoutMethodChainingProtocol {
    public var leading: XLayoutProxy {
        self.cashedAttributes.append(.leading)
        return self
    }

    public func leading(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        handleParam4Constraint(by: .leading, with: params)
        return self
    }

    @discardableResult
    public func leading(_ value: CGFloat) -> XLayoutProxy {
        let params = XLayoutConstraintParam.init(isSmart: true)
        params.constant = value
        handleParam4Constraint(by: .leading, with: params)
        return self
    }

    public var trailing: XLayoutProxy {
        self.cashedAttributes.append(.trailing)
        return self
    }

    @discardableResult
    public func trailing(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        handleParam4Constraint(by: .trailing, with: params)
        return self
    }

    @discardableResult
    public func trailing(_ value: CGFloat) -> XLayoutProxy {
        let params = XLayoutConstraintParam.init(isSmart: true)
        params.constant = value
        handleParam4Constraint(by: .trailing, with: params)
        return self
    }

    public var left: XLayoutProxy {
        self.cashedAttributes.append(.left)
        return self
    }

    @discardableResult
    public func left(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        handleParam4Constraint(by: .left, with: params)
        return self
    }

    @discardableResult
    public func left(_ value: CGFloat) -> XLayoutProxy {
        let params = XLayoutConstraintParam.init(isSmart: true)
        params.constant = value
        handleParam4Constraint(by: .left, with: params)
        return self
    }

    public var right: XLayoutProxy {
        self.cashedAttributes.append(.right)
        return self
    }

    @discardableResult
    public func right(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        handleParam4Constraint(by: .right, with: params)
        return self
    }

    @discardableResult
    public func right(_ value: CGFloat) -> XLayoutProxy {
        let params = XLayoutConstraintParam.init(isSmart: true)
        params.constant = value
        handleParam4Constraint(by: .right, with: params)
        return self
    }

    public var top: XLayoutProxy {
        self.cashedAttributes.append(.top)
        return self
    }

    @discardableResult
    public func top(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        handleParam4Constraint(by: .top, with: params)
        return self
    }

    @discardableResult
    public func top(_ value: CGFloat) -> XLayoutProxy {
        let params = XLayoutConstraintParam.init(isSmart: true)
        params.constant = value
        handleParam4Constraint(by: .top, with: params)
        return self
    }

    public var bottom: XLayoutProxy {
        self.cashedAttributes.append(.bottom)
        return self
    }

    @discardableResult
    public func bottom(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        handleParam4Constraint(by: .bottom, with: params)
        return self
    }

    @discardableResult
    public func bottom(_ value: CGFloat) -> XLayoutProxy {
        let params = XLayoutConstraintParam.init(isSmart: true)
        params.constant = value
        handleParam4Constraint(by: .bottom, with: params)
        return self
    }

    public var width: XLayoutProxy {
        self.cashedAttributes.append(.width)
        return self
    }

    @discardableResult
    public func width(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        handleParam4Constraint(by: .width, with: params)
        return self
    }

    @discardableResult
    public func width(_ value: CGFloat) -> XLayoutProxy {
        let params = XLayoutConstraintParam.init(isSmart: true)
        params.constant = value
        handleParam4Constraint(by: .width, with: params)
        return self
    }

    public var height: XLayoutProxy {
        self.cashedAttributes.append(.height)
        return self
    }

    @discardableResult
    public func height(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        handleParam4Constraint(by: .height, with: params)
        return self
    }

    @discardableResult
    public func height(_ value: CGFloat) -> XLayoutProxy {
        let params = XLayoutConstraintParam.init(isSmart: true)
        params.constant = value
        handleParam4Constraint(by: .height, with: params)
        return self
    }

    public var centerX: XLayoutProxy {
        self.cashedAttributes.append(.centerX)
        return self
    }

    @discardableResult
    public func centerX(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        handleParam4Constraint(by: .centerX, with: params)
        return self
    }

    @discardableResult
    public func centerX(_ value: CGFloat) -> XLayoutProxy {
        let params = XLayoutConstraintParam.init(isSmart: true)
        params.constant = value
        handleParam4Constraint(by: .centerX, with: params)
        return self
    }

    public var centerY: XLayoutProxy {
        self.cashedAttributes.append(.centerY)
        return self
    }

    @discardableResult
    public func centerY(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        handleParam4Constraint(by: .centerY, with: params)
        return self
    }

    @discardableResult
    public func centerY(_ value: CGFloat) -> XLayoutProxy {
        let params = XLayoutConstraintParam.init(isSmart: true)
        params.constant = value
        handleParam4Constraint(by: .centerY, with: params)
        return self
    }
}
