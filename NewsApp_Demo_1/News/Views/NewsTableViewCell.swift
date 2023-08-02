//
//  NewsTableViewCell.swift
//  NewsApp_Demo_1
//
//  Created by Nickelfox on 19/04/23.
//

import UIKit

class NewsTableViewCell: TableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        self.newsImage.layer.cornerRadius = 15

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        newsImage.image = nil
    }
        
    override func configure(_ item: Any?) {
        if let item = item as? NewsCellModel {
            self.titleLabel.text = item.article.title
            self.descriptionLabel.text = item.article.description
             
            if let url = URL(string: item.article.urlToImage ?? "") {
                self.downloadImage(from: url)
            }
            
            
        }
    }
    
    func downloadImage(from url: URL) {
      
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.newsImage.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }


}
