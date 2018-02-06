//
//  News.swift
//  LeMonde
//
//  Created by Pradheep Rajendirane on 04/02/2018.
//  Copyright © 2018 Pradheep Rajendirane. All rights reserved.
//

import Foundation

struct News {
    
    var link:String = ""
    var title:String = ""
    var description:String = ""
    var pubDate:Date?
    var coverUrl: String?
    
    // API RSS endpoint for Latest News
    private static func endpointForGet() -> String {
        return Settings.RSSUrl
    }
    
    static func getNews(completionHandler: @escaping ([News]?, Error?) -> Void) {
        
        // set up URLRequest with URL
        let endpoint = News.endpointForGet()
        guard let url = URL(string: endpoint) else {
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        
        // set up the XML Parser for the RSS Feed
        guard let parser = XMLParser(contentsOf: url) else {
            let error = BackendError.objectParsing(reason: "XML Parser Init Error")
            completionHandler(nil, error)
            return
        }
        
        // parse and Generate [News] Object
        let newsProvider = NewsXMLProvider()
        parser.delegate = newsProvider
        parser.parse()
        
        // catch parsing error
        if let _ = parser.parserError {
            let error = BackendError.objectParsing(reason: "XML Parsing Error")
            completionHandler(nil, error)
            return
        }
        
        // final completion handling
        completionHandler(newsProvider.items, nil)
        
        
    }
    
    
}

enum BackendError: Error {
    case urlError(reason: String)
    case objectParsing(reason: String)
}
