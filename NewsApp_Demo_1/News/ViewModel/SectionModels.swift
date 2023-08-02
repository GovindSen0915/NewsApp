//
//  SectionModels.swift
//  NewsApp_Demo_1
//
//  Created by Nickelfox on 19/04/23.
//

import Foundation
class SectionModels {
    var headerModel:Any?
    var cellModels : [Any] = []
    var footerModels :Any?

    
    init( headerModel:Any? = nil, cellModels:[Any] = [], footerModels:Any? = nil){
        self.headerModel = headerModel
        self.cellModels = cellModels
        self.footerModels = footerModels
    }
}
