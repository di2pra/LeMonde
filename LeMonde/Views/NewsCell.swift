//
//  NewsCell.swift
//  LeMonde
//
//  Created by Pradheep Rajendirane on 04/02/2018.
//  Copyright © 2018 Pradheep Rajendirane. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
   
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var gradView: UIView!
    
    @IBOutlet weak var newsCover: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        UISetup()
    }
    
    func UISetup() {
        self.newsTitle.textColor = Settings.mainTextColor
        self.newsDate.textColor = Settings.secondaryTextColor
    }
    
    func set(news: News) {
        self.newsTitle.text = news.title
        
        if let date = news.pubDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            self.newsDate.text = formatter.string(from: date)
        } else {
            self.newsDate.text = "Date non spécifiée"
        }
        
        self.newsCover.sd_setShowActivityIndicatorView(true)
        self.newsCover.sd_setIndicatorStyle(.gray)
        
        if let coverUrl = news.coverUrl {
            if let url = URL(string: coverUrl) {
                self.newsCover.sd_setImage(with: url, completed: nil)
            }
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

