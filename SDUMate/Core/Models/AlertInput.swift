//
//  AlertInput.swift
//  BePRO
//
//  Created by Yessenali Zhanaidar on 20.07.2023.
//
import Foundation
import UIKit


public struct AlertInput {
    public var title: String? = CoreL10n.error
    public var message: String?
    
    public var cancelTitle: String? = CoreL10n.cancel
    public var cancelActionCallBack: (() -> Void)?
    
    public var actionTitle: String?
    public var actionCallBack: (() -> Void)?
    
    public init(
        title: String?,
        message: String?,
        cancelTitle: String? = nil,
        cancelActionCallBack: (() -> Void)? = nil,
        actionTitle: String? = "",
        actionCallBack: (() -> Void)? = nil)
    {
        self.title = title
        self.message = message
        self.cancelTitle = cancelTitle ?? CoreL10n.cancel
        self.cancelActionCallBack = cancelActionCallBack
        self.actionTitle = actionTitle
        self.actionCallBack = actionCallBack
    }
}
