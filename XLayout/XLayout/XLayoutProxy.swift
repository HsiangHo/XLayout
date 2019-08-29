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
                        second == params.secondItem && con.secondAttribute == params.attribute
                        && params.multiplier == con.multiplier
                        && params.priority == con.priority
                        && params.relation == con.relation {
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

//internal methods
extension XLayoutProxy {
    func makeConstraintFromParam(by attr: XLayoutAttribute, with params: XLayoutConstraintParam) {
        handleParam4Constraint(by: attr, with: params)
    }

    func makeConstraintFromCGFloat(by attr: XLayoutAttribute, with value: CGFloat) {
        let params = XLayoutConstraintParam.init(isSmart: true)
        params.constant = value
        handleParam4Constraint(by: attr, with: params)
    }
}

//make methods chaining
extension XLayoutProxy: XLayoutMethodChainingProtocol {
    public var leading: XLayoutProxy {
        self.cashedAttributes.append(.leading)
        return self
    }

    public func leading(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        makeConstraintFromParam(by: .leading, with: params)
        return self
    }

    @discardableResult
    public func leading(_ value: CGFloat) -> XLayoutProxy {
        makeConstraintFromCGFloat(by: .leading, with: value)
        return self
    }

    public var trailing: XLayoutProxy {
        self.cashedAttributes.append(.trailing)
        return self
    }

    @discardableResult
    public func trailing(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        makeConstraintFromParam(by: .trailing, with: params)
        return self
    }

    @discardableResult
    public func trailing(_ value: CGFloat) -> XLayoutProxy {
        makeConstraintFromCGFloat(by: .trailing, with: value)
        return self
    }

    public var left: XLayoutProxy {
        self.cashedAttributes.append(.left)
        return self
    }

    @discardableResult
    public func left(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        makeConstraintFromParam(by: .left, with: params)
        return self
    }

    @discardableResult
    public func left(_ value: CGFloat) -> XLayoutProxy {
        makeConstraintFromCGFloat(by: .left, with: value)
        return self
    }

    public var right: XLayoutProxy {
        self.cashedAttributes.append(.right)
        return self
    }

    @discardableResult
    public func right(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        makeConstraintFromParam(by: .right, with: params)
        return self
    }

    @discardableResult
    public func right(_ value: CGFloat) -> XLayoutProxy {
        makeConstraintFromCGFloat(by: .right, with: value)
        return self
    }

    public var top: XLayoutProxy {
        self.cashedAttributes.append(.top)
        return self
    }

    @discardableResult
    public func top(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        makeConstraintFromParam(by: .top, with: params)
        return self
    }

    @discardableResult
    public func top(_ value: CGFloat) -> XLayoutProxy {
        makeConstraintFromCGFloat(by: .top, with: value)
        return self
    }

    public var bottom: XLayoutProxy {
        self.cashedAttributes.append(.bottom)
        return self
    }

    @discardableResult
    public func bottom(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        makeConstraintFromParam(by: .bottom, with: params)
        return self
    }

    @discardableResult
    public func bottom(_ value: CGFloat) -> XLayoutProxy {
        makeConstraintFromCGFloat(by: .bottom, with: value)
        return self
    }

    public var width: XLayoutProxy {
        self.cashedAttributes.append(.width)
        return self
    }

    @discardableResult
    public func width(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        makeConstraintFromParam(by: .width, with: params)
        return self
    }

    @discardableResult
    public func width(_ value: CGFloat) -> XLayoutProxy {
        makeConstraintFromCGFloat(by: .width, with: value)
        return self
    }

    public var height: XLayoutProxy {
        self.cashedAttributes.append(.height)
        return self
    }

    @discardableResult
    public func height(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        makeConstraintFromParam(by: .height, with: params)
        return self
    }

    @discardableResult
    public func height(_ value: CGFloat) -> XLayoutProxy {
        makeConstraintFromCGFloat(by: .height, with: value)
        return self
    }

    public var centerX: XLayoutProxy {
        self.cashedAttributes.append(.centerX)
        return self
    }

    @discardableResult
    public func centerX(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        makeConstraintFromParam(by: .centerX, with: params)
        return self
    }

    @discardableResult
    public func centerX(_ value: CGFloat) -> XLayoutProxy {
        makeConstraintFromCGFloat(by: .centerX, with: value)
        return self
    }

    public var centerY: XLayoutProxy {
        self.cashedAttributes.append(.centerY)
        return self
    }

    @discardableResult
    public func centerY(_ params: XLayoutConstraintParam) -> XLayoutProxy {
        makeConstraintFromParam(by: .centerY, with: params)
        return self
    }

    @discardableResult
    public func centerY(_ value: CGFloat) -> XLayoutProxy {
        makeConstraintFromCGFloat(by: .centerY, with: value)
        return self
    }
}

//visual layout methods
extension XLayoutProxy {
    @discardableResult
    func visualLayout(_ args: [(XLayoutVisualParam, XLayoutDirection)]) -> [NSLayoutConstraint] {
        for tuple in args {
            let params = tuple.0.constraintParamForView(firstItem: self.view, direction: tuple.1)
            for param in params {
                switch param.attribute {
                case .top:
                    makeConstraintFromParam(by: .bottom, with: param)
                case .left:
                    makeConstraintFromParam(by: .right, with: param)
                case .right:
                    makeConstraintFromParam(by: .left, with: param)
                case .bottom:
                    makeConstraintFromParam(by: .top, with: param)
                case .leading:
                    makeConstraintFromParam(by: .trailing, with: param)
                case .trailing:
                    makeConstraintFromParam(by: .leading, with: param)
                case .width, .height, .centerX, .centerY, .lastBaseline, .firstBaseline, .notAnAttribute:
                    break
                @unknown default:
                    break
                }
            }
        }
        return self.constraints
    }
}
