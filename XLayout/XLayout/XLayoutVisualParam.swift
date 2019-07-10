//
//  XLayoutVisualParam.swift
//  XLayout
//
//  Created by Jovi on 7/8/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import Foundation

enum XLayoutVisualElement {
    case superView
    case padding
}

public enum XLayoutDirection {
    case vertical
    case horizontal
}

public class XLayoutVisualParam {
    public var elementOrder: [Any] = []
    public func constraintParamForView(firstItem: XLayoutView,
                                       direction: XLayoutDirection = .horizontal) -> [XLayoutConstraintParam] {
        var params: [XLayoutConstraintParam] = []
        let firstItemIndex: Int? = elementOrder.firstIndex {
            if let view = $0 as? XLayoutView {
                return view === firstItem
            }
            return false
        }

        if let index = firstItemIndex {
            if index >= 2 {
                let paddingL = elementOrder[index - 1]
                let secondItemL = elementOrder[index - 2]
                if let param: XLayoutConstraintParam = handleParam(padding: paddingL, secondItem: secondItemL) {
                    param.attribute = (direction == .horizontal ? .trailing : .bottom)
                    params.append(param)
                }

            }

            let paddingR = elementOrder[index + 1]
            let secondItemR = elementOrder[index + 2]
            if let param: XLayoutConstraintParam = handleParam(padding: paddingR, secondItem: secondItemR) {
                param.attribute = (direction == .horizontal ? .leading : .top)
                params.append(param)
            }
        }
        return params
    }

    public func handleParam(padding: Any, secondItem: Any) -> XLayoutConstraintParam? {
        var param: XLayoutConstraintParam?
        if let value = padding as? XLayoutConstraintParam {
            param = value.copy()
        } else if let value = padding as? XLayoutVisualElement, value == .padding {
            param = XLayoutConstraintParam.init()
            param!.constant = 8
        } else if let value = padding as? CGFloat {
            param = XLayoutConstraintParam.init()
            param!.constant = value
        }

        guard let constraintParam = param else {
            return param
        }

        if let item = secondItem as? XLayoutVisualElement, item == .superView {
            constraintParam.isSmart = true
        } else if let item = secondItem as? XLayoutView {
            constraintParam.secondItem = item
        } else {
            param = nil
        }
        return param
    }
}
