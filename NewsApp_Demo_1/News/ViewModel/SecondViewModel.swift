//
//  SecondViewModel.swift
//  NewsApp_Demo_1
//
//  Created by Nickelfox on 20/04/23.
//

import Foundation

protocol SecondViewModelDelegate: AnyObject {
    
}

class SecondViewModel {
    
    weak var view : SecondViewModelDelegate?
    
    init(view: SecondViewModelDelegate?) {
        self.view = view
    }

    
    
    
}

extension SecondViewModel: SecondViewControllerDelegate {
    
}
