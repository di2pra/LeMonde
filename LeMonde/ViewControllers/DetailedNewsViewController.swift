//
//  DetailedNewsViewController.swift
//  LeMonde
//
//  Created by Pradheep Rajendirane on 05/02/2018.
//  Copyright © 2018 Pradheep Rajendirane. All rights reserved.
//

import UIKit

class DetailedNewsViewController: UIViewController {
    
    var news:News?
    
    @IBOutlet weak var detailedNewsView: DetailedNewsView!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = Settings.mainColor
        
        self.detailedNewsView.readNewsBtn.addTarget(self, action: #selector(self.readNewsBtnPressed), for: .touchUpInside)
        
        // populate News Data into the View if News is defined
        if let newsData = news {
            self.detailedNewsView.set(news: newsData)
        } else {
            self.detailedNewsView.isHidden = true
            self.errorLabel.text = "Erreur pas d'article sélectionné"
        }
        
    }
    
    @objc func readNewsBtnPressed() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "newsVC") as? NewsViewController {
            vc.newsUrl = news?.link
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    private func initNavigationBar() {
        
        let title = UILabel()
        title.text = "\(Settings.mainTitle.uppercased()) - ARTICLE"
        title.font = UIFont(name: "Futura", size: 15)
        title.textColor = .white
        self.navigationItem.titleView = title
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.hidesBarsOnSwipe = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.initNavigationBar()
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
