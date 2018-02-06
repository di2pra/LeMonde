//
//  HomeViewController.swift
//  LeMonde
//
//  Created by Pradheep Rajendirane on 04/02/2018.
//  Copyright © 2018 Pradheep Rajendirane. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    
    var isLoading:Bool = false
    var data:[News] = []
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = Settings.mainColor
        
        
        self.initLoadingView()
        self.initRefreshControl()
        self.initTableView()
        self.loadNews(refresh: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.initNavigationBar()
    }
    
    private func initNavigationBar() {
        
        let title = UILabel()
        title.text = Settings.mainTitle.uppercased()
        title.font = UIFont(name: "Futura", size: 15)
        title.textColor = .white
        self.navigationItem.titleView = title
        self.navigationController?.hidesBarsOnSwipe = true
        
    }
    
    private func initTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = Settings.mainColor
        
        self.tableView.register(UINib(nibName: "MainNewsCell", bundle: nil), forCellReuseIdentifier: "mainNewsCell")
        self.tableView.register(UINib(nibName: "SubNewsCell", bundle: nil), forCellReuseIdentifier: "subNewsCell")
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
        
        
        
    }
    
    private func initRefreshControl() {
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(self.refreshNews), for: .valueChanged)
        
        refreshControl.backgroundColor = Settings.mainColor
        refreshControl.tintColor = .white
        
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        refreshControl.attributedTitle = NSAttributedString(string: "Chargement...", attributes: attributes)
        
    }
    
    private func initLoadingView() {
        
        self.loadingView.color = .white
        self.loadingView.type = .lineScale
        
    }
    
    @objc func refreshNews() {
        loadNews(refresh: true)
    }
    
    func loadNews(refresh: Bool) {
        
        if !isLoading {
            
            self.isLoading = true
            
            if !refresh {
                self.tableView.isHidden = true
                self.loadingView.startAnimating()
            }
            
            
            News.getNews { (news, error) in
                
                self.isLoading = false
                
                DispatchQueue.main.async {
                    if refresh {
                        self.refreshControl.endRefreshing()
                    } else {
                        self.loadingView.stopAnimating()
                    }
                }
                
                if error == nil {
                    
                    self.data = news!
                    
                    DispatchQueue.main.async {
                        
                        if !refresh {
                            self.tableView.isHidden = false
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     }
     */
    
    
}

extension HomeViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let news:News = data[indexPath.row]
        
        if indexPath.row  == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainNewsCell", for: indexPath) as? MainNewsCell else {
                return UITableViewCell()
            }
            
            cell.set(news: news)
            
            return cell
            
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "subNewsCell", for: indexPath) as? SubNewsCell else {
                return UITableViewCell()
            }
            
            cell.set(news: news)
            
            return cell
            
        }
        
    }
    
    
    
    
}


extension HomeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detailedNewsVC") as? DetailedNewsViewController {
            vc.news = self.data[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

