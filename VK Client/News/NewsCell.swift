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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(for model: User) {
        
        nameGroup.text = model.nameSurnameFriend
        imageGroup.image = UIImage(named: model.imageFriend.last!)
        dateGroup.text = "\(Int.random(in: 01...31)).\(Int.random(in: 01...12)).\(Int.random(in: 2018...2020))"
        imageFromGroup.image = UIImage(named: model.imageFriend.first!)
        textFromGroup.text = "\(model.nameSurnameFriend) обновил(а) фото"
    }
}
