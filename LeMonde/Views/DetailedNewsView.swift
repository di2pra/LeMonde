//
//  DetailedNewsView.swift
//  LeMonde
//
//  Created by Pradheep Rajendirane on 06/02/2018.
//  Copyright © 2018 Pradheep Rajendirane. All rights reserved.
//

import UIKit

class DetailedNewsView: UIView {
    
    @IBOutlet weak var newsCover: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsDesc: UILabel!
    
    @IBOutlet weak var readNewsBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = Settings.mainColor
        self.newsDate.textColor = Settings.secondaryTextColor
        
    }
    
    func set(news : News) {
        
        self.newsTitle.text = news.title
        self.newsDesc.text = news.description
        
        if let date = news.pubDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            formatter.timeStyle = .medium
            self.newsDate.text = formatter.string(from: date)
        } else {
            self.newsDate.text = "Date non spécifiée"
        }
        
        self.newsCover.sd_setShowActivityIndicatorView(true)
        self.newsCover.sd_setIndicatorStyle(.gray)
        
        if let coverUrl = news.coverUrl {
            let url = URL(string: coverUrl)
            self.newsCover.sd_setImage(with: url!, completed: nil)
        }
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
