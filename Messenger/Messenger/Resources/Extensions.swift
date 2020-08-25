//
//  Extensions.swift
//  Messenger
//
//  Created by Vũ Tựu on 8/22/20.
//  Copyright © 2020 Vũ Tựu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    public var width: CGFloat{
        return self.frame.size.width
    }
    public var height: CGFloat{
        return self.frame.size.height
    }
    public var top: CGFloat{
        return self.frame.origin.y
    }
    public var bottom: CGFloat{
        return self.frame.size.height + self.frame.origin.y
    }
    public var left: CGFloat{
        return self.frame.origin.x
    }
    public var right: CGFloat{
        return self.frame.size.width + self.frame.origin.x
    }
}
extension Notification.Name{
    static let didLogInNotification = Notification.Name("didLogInNotification")
}
