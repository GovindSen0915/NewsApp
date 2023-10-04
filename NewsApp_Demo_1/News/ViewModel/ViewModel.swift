//
//  ViewModel.swift
//  NewsApp_Demo_1
//
//  Created by Nickelfox on 19/04/23.
//

import Foundation
import ReactiveSwift

protocol ViewModelDelegate : AnyObject{
    func reload()
}

class ViewModel {
//    let apiKey = "e7855adfcfbb4dd69e3fd27172d1aa4e"
    
    var loading = MutableProperty<Bool>(false)
    var disposable = CompositeDisposable([])
    var sectionModels = MutableProperty<[SectionModels]>([])
    var cellModels = MutableProperty<[Any]>([])
    var articles:[Article] = []
    
    weak var view : ViewModelDelegate?
    var isFirstTimeLoaderEnabled: Bool = true
    
    init(view: ViewModelDelegate){
        self.view = view
        self.setupObservers()
    }
    // MARK: Action
    private let fetchNewsAction = Action {() -> SignalProducer<[Article], ModelError> in
        return Article.fetch()
    }
    
    // MARK: Observer
    private func setupObservers() {
        
        self.disposable += self.fetchNewsAction.values.observeValues({ [weak self] (articles) in
            self?.articles = articles
            self?.prepareCellModel()
            self?.loading.value = false
            print(articles.count, "Articles")
            
        })
        
        self.disposable += self.fetchNewsAction.errors.observeValues({ [weak self] (error) in
            print(error)
        })
    }
    
    // MARK: PrepareCellModel
    private func prepareCellModel(){
        self.sectionModels.value = []
        self.cellModels.value = []
        for article in self.articles {
            self.cellModels.value.append(NewsCellModel(article : article))
        }
        self.sectionModels.value = [SectionModels(headerModel: nil, cellModels: cellModels.value, footerModels: nil)]
        self.view?.reload()
    }
}

// MARK: ViewControllerDelegate
extension ViewModel: ViewControllerDelegate {
    
    func fetchNewsData() {
        self.getNews()
    }
    
    
    var numberOfSections: Int {
        return self.sectionModels.value.count
    }

    func numberOfItems(at section: Int) -> Int {
        return self.sectionModels.value[section].cellModels.count
    }

    func item(at indexPath: IndexPath) -> Any {
        return self.sectionModels.value[indexPath.section].cellModels[indexPath.item]
    }

    func getNews() {
//        let params : [String:Any] = [
//            "apiKey": self.apiKey,
//            "q": "apple",
////            "from": "2023-07-30",
////            "to": "2023-07-30",
//            "sortBy": "popularity"
//        ]
        self.fetchNewsAction.apply().start()
        if self.isFirstTimeLoaderEnabled {
            self.loading.value = true
            self.isFirstTimeLoaderEnabled = false
        }
        
    }
}


