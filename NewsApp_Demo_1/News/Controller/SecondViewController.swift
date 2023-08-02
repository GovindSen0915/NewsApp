//
//  SecondViewController.swift
//  NewsApp_Demo_1
//
//  Created by Nickelfox on 19/04/23.
//

//import Foundation
import UIKit

protocol SecondViewControllerDelegate: AnyObject {
    
}

class SecondViewController: UIViewController {
    
    var article: Article?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var viewModel: SecondViewControllerDelegate!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.layer.cornerRadius = 15
        
        self.titleLabel.text = article?.title
        self.descriptionLabel.text = article?.description
        if article?.urlToImage != nil {
            let url = URL(string: article?.urlToImage ?? "")
            imageView.downloadImage(from: url!)
        }


    }
    
//    func setupViewModel() {
//        self.viewModel = SecondViewModel(view: self)
//        self.viewModel.disposable += self.reactive.showLoader <~ self.viewModel!.loading
//    }

}

extension UIImageView {
    func downloadImage(from url: URL) {
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data, error == nil,
                    let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        })
        dataTask.resume()

    }
}

extension SecondViewController: SecondViewModelDelegate {
    
}



