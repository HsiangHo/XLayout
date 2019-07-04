//
//  NSView+XLayout.swift
//  XLayout
//
//  Created by Jovi on 7/2/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import Foundation

extension NSView {
    public var xlp: XLayoutProxy {
        self.translatesAutoresizingMaskIntoConstraints = false
        return XLayoutProxy.init(view: self)
    }
}

extension NSView: XLayoutConstraintParamMakerProtocol {
    public var leading: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .leading)
    }

    public var trailing: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .trailing)
    }

    public var left: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .left)
    }

    public var right: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .right)
    }

    public var top: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .top)
    }

    public var bottom: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .bottom)
    }

    public var width: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .width)
    }

    public var height: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .height)
    }

    public var centerX: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .centerX)
    }

    public var centerY: XLayoutConstraintParam {
        return XLayoutConstraintParam(secItem: self, attr: .centerY)
    }
}
