//
//  NewsCell.swift
//  VK Client
//
//  Created by Rayen D on 06.09.2020.
//  Copyright © 2020 Rayen D. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var imageGroup: UIImageView! {
        didSet {
            imageGroup.layer.cornerRadius = imageGroup.frame.size.height / 2
            imageGroup.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var dateGroup: UILabel!
    @IBOutlet weak var textFromGroup: UILabel!
    @IBOutlet weak var imageFromGroup: UIImageView!
    @IBOutlet weak var commentsCountLabel: UILabel!
        @IBOutlet weak var likeControl: LikeControl!
    func configure(for model: NewsModel) {
        self.dateGroup.text = model.getStringDate()
                self.textFromGroup.text = model.text
                self.likeControl.setLike(count: model.likes.count)
                self.nameGroup.text = model.creatorName
                self.commentsCountLabel.text = "\(model.comments.count)"

                DispatchQueue.global().async {

                    guard let url = model.avatarUrl,
                          let imageURL = URL(string: url),
                          let imageData = try? Data(contentsOf: imageURL) else { return }

                    DispatchQueue.main.async { [weak self] in
                        self?.imageGroup.image = UIImage(data: imageData)
                    }
                }
        
//        nameGroup.text = model.nameSurnameFriend
//        imageGroup.image = UIImage(named: model.imageFriend.last!)
//        dateGroup.text = "\(Int.random(in: 1...31)).\(Int.random(in: 1...12)).\(Int.random(in: 2016...2020))"
//        imageFromGroup.image = UIImage(named: model.imageFriend.first!)
//        textFromGroup.text = "\(model.nameSurnameFriend) опубликовал новое фото!"
    }
}
