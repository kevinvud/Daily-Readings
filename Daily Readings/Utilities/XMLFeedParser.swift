//
//  XMLFeedParser.swift
//  Daily Readings
//
//  Created by PoGo on 11/7/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class XMLFeedParser: NSObject, XMLParserDelegate {
    
    var rssItems = [RSSItem]()
    var currentElement = ""
    var currentTitle = "" {
        didSet{
            currentTitle = currentTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    var currentDescription = "" {
        didSet{
            currentDescription = currentDescription.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    var currentPubDate = "" {
        didSet{
            
            currentPubDate = currentPubDate.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    var currentLink = "" {
        didSet{
            
            currentLink = currentLink.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    var parserCompletionHandler: (([RSSItem]) -> ())?
    
    func parseFeed(url: String, completionHandler: (([RSSItem]) -> ())?) {
        self.parserCompletionHandler = completionHandler
        guard let url = URL(string: url) else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                
                return
            }
            guard let data = data else {return}
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
            }.resume()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
            currentLink = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "link" : currentLink += string
        case "title" : currentTitle += string
        case "description" : currentDescription += string
        case "pubDate" : currentPubDate += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item"{
            let rssItem = RSSItem(title: currentTitle, description: currentDescription, pubDate: currentPubDate, link: currentLink)
            self.rssItems.append(rssItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems)
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}

