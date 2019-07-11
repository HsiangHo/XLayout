//
//  NSView+XLayout.swift
//  XLayout
//
//  Created by Jovi on 7/2/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import Foundation

extension NSView {
    public var xLayout: XLayoutProxy {
        self.translatesAutoresizingMaskIntoConstraints = false
        return XLayoutProxy.init(view: self)
    }

    public func remakeLayout() {
        let proxy = XLayoutProxy.init(view: self)
        _ = proxy.remake
    }

    @discardableResult
    public func visualLayout(_ params: XLayoutVisualParamsWithDirection...) -> [NSLayoutConstraint] {
        let proxy = XLayoutProxy.init(view: self)
        var args: [(XLayoutVisualParam, XLayoutDirection)] = []
        for param in params {
            args.append(contentsOf: param.params)
        }
        return proxy.visualLayout(args)
    }
}

extension NSView: XLayoutConstraintParamMakerProtocol {
    public var leading: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .leading, context: self)
    }

    public var trailing: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .trailing, context: self)
    }

    public var left: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .left, context: self)
    }

    public var right: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .right, context: self)
    }

    public var top: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .top, context: self)
    }

    public var bottom: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .bottom, context: self)
    }

    public var width: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .width, context: self)
    }

    public var height: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .height, context: self)
    }

    public var centerX: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .centerX, context: self)
    }

    public var centerY: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .centerY, context: self)
    }
}
