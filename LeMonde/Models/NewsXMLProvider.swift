//
//  NewsXMLProvider.swift
//  LeMonde
//
//  Created by Pradheep Rajendirane on 04/02/2018.
//  Copyright © 2018 Pradheep Rajendirane. All rights reserved.
//

import Foundation

class NewsXMLProvider: NSObject, XMLParserDelegate {
    
    var items = [News]()
    var item = News()
    var foundCharacters = ""
    
    func parserDidStartDocument(_ parser: XMLParser) {
        self.items = []
        self.item = News()
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        switch elementName {
        case "link":
            self.item.link = self.foundCharacters
        case "title":
            self.item.title = self.foundCharacters
        case "description":
            self.item.description = self.foundCharacters
        case "pubDate":
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
            if let date = dateFormatter.date(from: self.foundCharacters) {
                self.item.pubDate = date
            }
            
        case "item":
            self.items.append(self.item)
            self.item = News()
        default: break
        }
        
        self.foundCharacters = ""
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "enclosure" {
            if let url = attributeDict["url"] {
                self.item.coverUrl = url
            }
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.foundCharacters += String(utf8String: string.trimmingCharacters(in: .whitespacesAndNewlines).cString(using: .utf8)!)!
    }
    
}
