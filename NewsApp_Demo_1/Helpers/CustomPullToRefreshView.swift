//
//  PullToRefreshView.swift
//  Agalia_Facility
//
//  Created by Nickelfox on 11/04/23.
//  Copyright © 2023 Nickelfox. All rights reserved.
//

import Foundation
import Lottie
import PaginationUIManager

class CustomPullToRefreshView: PullToRefreshContentView {
    
    var lottieView: LottieAnimationView = .init(name: "loader")
    
    static var newInstance: CustomPullToRefreshView {
        return Bundle.main.loadNibNamed("CustomPullToRefreshView", owner: nil, options: nil)![0] as! CustomPullToRefreshView
    }
    
    private func showAnimation(_ lottieName: String, _ state: PullToRefreshViewState) {
        
        self.lottieView.contentMode = .scaleAspectFit
        self.addSubview(self.lottieView)
        self.lottieView.loopMode = .loop
        self.lottieView.translatesAutoresizingMaskIntoConstraints = false
        self.lottieView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.lottieView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.lottieView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.lottieView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        switch state {
        case .normal:
            self.lottieView.stop()
            print("Normal")
        case .ready:
            self.lottieView.play()
            print("Ready")
        case .closing:
            self.lottieView.stop()
            print("Closing")
        case .loading:
            self.lottieView.play()
            self.lottieView.loopMode = .loop
            print("Loading")
        @unknown default:
            ()
        }
    }
 
    override func setState(_ state: PullToRefreshViewState, with view: PullToRefreshView!) {
        self.showAnimation("loader", state)
    }
    
    override func setPullProgress(_ pullProgress: CGFloat) {
        if pullProgress < 1 {
            self.lottieView.play(toFrame: pullProgress * 10, loopMode: .playOnce)
        } else { }
    }

    
}
