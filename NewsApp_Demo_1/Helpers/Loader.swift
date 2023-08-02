//
//  Loader.swift
//  NewsApp_Demo_1
//
//  Created by Nickelfox on 19/04/23.
//

import Foundation
import MBProgressHUD
import ReactiveSwift
import Lottie

class Loader {
    
    static func showAdded(to view: UIView, animated: Bool) {
//        MBProgressHUD.showAdded(to: view, animated: animated)
        let width: CGFloat = 150
        let center = view.center
        
        let loaderView = UIView(frame: CGRect(x: center.x - width * 0.5,
                                              y: center.y - width * 0.5,
                                              width: width,
                                              height: width))
        
        loaderView.accessibilityIdentifier = "Loader Identifier"
        loaderView.backgroundColor = .clear
        view.addSubview(loaderView)
        let loader = LottieAnimationView(name: "loader")
        loaderView.addSubview(loader)
        loader.contentMode = .scaleAspectFit
        loader.frame = loaderView.bounds
        loader.loopMode = .loop
        loader.play()
    }
    
    static func hide(for view: UIView, animated: Bool) {
//        MBProgressHUD.hide(for: view, animated: animated)
        for subview in view.subviews where subview.accessibilityIdentifier == "Loader Identifier" {
            subview.removeFromSuperview()
        }
    }
}

extension UIViewController {
    
    func showLoader(animated: Bool = false) {
        Loader.showAdded(to: self.view, animated: animated)
    }
    
    func hideLoader(animated: Bool = false) {
        Loader.hide(for: self.view, animated: animated)
    }
    
}

extension Reactive where Base: UIViewController {
    public var showLoader: BindingTarget<Bool> {
        return makeBindingTarget({ (view, showLoader) in
            if showLoader {
                view.showLoader()
            } else {
                view.hideLoader()
            }
        })
    }
    
    internal func makeBindingTarget<U>(_ key: StaticString = #function, action: @escaping (Base, U) -> Void) -> BindingTarget<U> {
        return BindingTarget(on: UIScheduler(), lifetime: lifetime) { [weak base = self.base] value in
            if let base = base {
                action(base, value)
            }
        }
    }
}

