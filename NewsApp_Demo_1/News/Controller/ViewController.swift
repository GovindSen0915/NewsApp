//
//  ViewController.swift
//  NewsApp_Demo_1
//
//  Created by Nickelfox on 19/04/23.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import PaginationUIManager
import Lottie
import SafariServices


protocol StaticReuseIdentifierProvider{
    static var reuseIdentifier: String { get }
}

protocol ViewControllerDelegate : AnyObject {
    var numberOfSections : Int { get }
    func numberOfItems(at section: Int) -> Int
    func item(at indexPath: IndexPath) -> Any
    func getNews()
    
    var loading: MutableProperty<Bool> { get }
    var disposable: CompositeDisposable { get}
    func fetchNewsData()
    
}


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBarButton: UIButton!
    var viewModel:ViewControllerDelegate!
    var articles : [Article]?
    var disposable = CompositeDisposable([])
    
    private var paginationManager: PaginationUIManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.registerNewsCell()
        self.setupPagination()
        self.setupViewModel()
        viewModel.getNews()
    }
    
    private func setupViewModel() {
        self.viewModel = ViewModel(view: self)
        self.viewModel.disposable += self.reactive.showLoader <~ self.viewModel!.loading
    }
    
    func registerNewsCell() {
        self.tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let identifier = self.reuseIdentifier(at: indexPath),
              let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.item = self.viewModel?.item(at: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    private func reuseIdentifier(at indexPath: IndexPath) -> String? {
        let item = self.viewModel?.item(at: indexPath)
        switch item {
        case _ as NewsCellModel:
            return NewsTableViewCell.reuseIdentifier
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return UITableView.automaticDimension
        return 135
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        let item = self.viewModel?.item(at: indexPath)
        if let newsArticle = item as? NewsCellModel {
            vc.article = newsArticle.article
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

// MARK: ViewModelDelegate

extension ViewController : ViewModelDelegate {
    func reload() {
        self.tableView.reloadData()
    }
}

extension UIView: StaticReuseIdentifierProvider {
    static var reuseIdentifier: String { return String(describing: self).components(separatedBy: ".").last! }
}

// MARK: PaginationUIManagerDelegate
extension ViewController: PaginationUIManagerDelegate {
    private func setupPagination() {
        self.paginationManager = PaginationUIManager(scrollView: self.tableView,
                                                     pullToRefreshType: .custom(CustomPullToRefreshView.newInstance))
        self.paginationManager?.delegate = self
    }
    
    func refreshAll(completion: @escaping (Bool) -> Void) {
        self.viewModel.fetchNewsData()
        completion(true)
    }
    
    func loadMore(completion: @escaping (Bool) -> Void) {
        completion(false)
    }
}


