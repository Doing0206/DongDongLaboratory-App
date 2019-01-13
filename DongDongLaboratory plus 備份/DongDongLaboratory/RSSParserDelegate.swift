//
//  RSSParserDelegate.swift
//  DongDongLaboratory
//
//  Created by Doing on 2018/11/28.
//  Copyright © 2018年 Doing. All rights reserved.
//

import Foundation
class RSSParserDelegate:NSObject, XMLParserDelegate{
    var currentItem: NewItem?
    var currentElementValue: String?
    var resultsArray = [NewItem]()
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item"{
            //START A NEW ITEM
            currentItem = NewItem()
        }else if elementName == "title"{
            currentElementValue = nil
        }else if elementName == "link"{
            currentElementValue = nil
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item"{
            if currentItem != nil{
                resultsArray.append(currentItem!)
                currentItem = nil
            }
        }else if elementName == "title"{
            currentItem?.title = currentElementValue
        }else if elementName == "link"{
            currentItem?.link = currentElementValue
        }
        currentElementValue = nil
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentElementValue == nil{
            currentElementValue = string
        }else{
            currentElementValue = currentElementValue! + string
        }
    }
    func getResult() -> [NewItem]{
        return resultsArray
    }
}
