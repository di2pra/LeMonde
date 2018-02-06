//
//  MainNewsCell.swift
//  LeMonde
//
//  Created by Pradheep Rajendirane on 04/02/2018.
//  Copyright © 2018 Pradheep Rajendirane. All rights reserved.
//

import UIKit

class MainNewsCell: NewsCell {
    
    @IBOutlet weak var titleBgView: UIView!
    
    override func UISetup() {
        
        super.UISetup()
        
        self.contentView.backgroundColor = Settings.mainColor
        self.backgroundColor = Settings.mainColor
        
        self.container.backgroundColor = Settings.mainColor
        self.container.layer.cornerRadius = Settings.cornerRadius
        self.container.layer.shadowColor = UIColor.black.cgColor
        self.container.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.container.layer.shadowOpacity = 0.2
        self.container.layer.shadowRadius = 5
        
        
        self.newsCover.layer.cornerRadius = Settings.cornerRadius
        self.titleBgView.backgroundColor = Settings.mainColor
        //self.cover.backgroundColor = mainColor
        
    }
    
    private lazy var UILayout: Void = {
        
        let mask = CAGradientLayer()
        mask.startPoint = CGPoint(x: 0.5, y: 0.0)
        mask.endPoint = CGPoint(x:0.5, y:1.0)
        let whiteColor = UIColor.white
        mask.colors = [whiteColor.withAlphaComponent(0.0).cgColor,whiteColor.withAlphaComponent(0.5).cgColor, whiteColor.withAlphaComponent(1.0).cgColor]
        mask.locations = [NSNumber(value: 0.0), NSNumber(value: 0.5), NSNumber(value: 0.95)]
        mask.frame = gradView.bounds
        gradView.layer.mask = mask
        gradView.backgroundColor = Settings.mainColor
        
    }()
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        _ = UILayout
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
