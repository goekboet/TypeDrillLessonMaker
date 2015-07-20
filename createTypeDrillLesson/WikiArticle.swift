//
//  WikiArticle.swift
//  Create TypeDrill Lesson
//
//  Created by Erik on 2015-06-10 v: 24.
//  Copyright (c) 2015 Gookboet. All rights reserved.
//

import Foundation

public class WikiArticle {
    
    static let fileLink = "\\[\\[File?:([\\s\\S]*?)\\.\\]\\]"
    static let htmlStyleTag = "<([a-z0-9= ]*)\\b[^>]*>([\\s\\S]*?)<\\/\\1>"
    static let shortHtmlTag = "<[\\S\\s]*?\\/>"
    static let wikiLinksAlternativeText = "(\\[{2}).[^\\]\\|]*\\|"
    static let categoryClassification = "\\[\\[[K|C]ategor[i|y]:([\\S\\s]*?)\\]\\]"
    static let wikiLink = "\\[\\[|\\]\\]"
    static let sectionHeader = "(={2,})[\\S\\s]*?\\1"
    static let wikiTable = "\\{\\|[\\S\\s]*?\\|\\}"
    static let wikiList = "^[*|:]([\\S\\s]*?)$"
    static let metaLink = "\\{\\{([\\s\\S]*?)\\}\\}"
    static let formatting = "'+"
    static let nonLineBreakingSpace = "&nbsp;"
    
    var plainText:String
    var markup: String
    
    public init(markup: String) {
        self.markup = markup
        plainText = ""
    }
    
    public func getplainText() -> String {
        if plainText.isEmpty {
            plainText = markup
            cleanMarkup()
            makeParagraphs()
        }
        return plainText
    }
    
    func cleanMarkup() {
        removeMarkupThatMatches(WikiArticle.fileLink)
        removeMarkupThatMatches(WikiArticle.htmlStyleTag)
        removeMarkupThatMatches(WikiArticle.shortHtmlTag)
        removeMarkupThatMatches(WikiArticle.wikiLinksAlternativeText)
        removeMarkupThatMatches(WikiArticle.categoryClassification)
        removeMarkupThatMatches(WikiArticle.wikiLink)
        removeMarkupThatMatches(WikiArticle.sectionHeader)
        removeMarkupThatMatches(WikiArticle.wikiTable)
        removeMarkupThatMatches(WikiArticle.wikiList)
        removeMarkupThatMatches(WikiArticle.metaLink)
        removeMarkupThatMatches(WikiArticle.formatting)
        removeMarkupThatMatches(WikiArticle.nonLineBreakingSpace)
    }
    
    func removeMarkupThatMatches(regexString: String) {
        let entire = NSMakeRange(0, count(plainText))
        if let regex = NSRegularExpression(pattern: regexString, options: NSRegularExpressionOptions.AnchorsMatchLines, error: nil) {
            plainText = regex.stringByReplacingMatchesInString(plainText, options: NSMatchingOptions.allZeros, range: entire, withTemplate: "")
        }
    }
    
    func makeParagraphs() {
        let entire = NSMakeRange(0, count(plainText))
        if let regex = NSRegularExpression(pattern: " *?\\n+[ |\\n]*?", options: NSRegularExpressionOptions.allZeros, error: nil) {
            plainText = regex.stringByReplacingMatchesInString(plainText, options: NSMatchingOptions.allZeros, range: entire, withTemplate: "\n")
        }
        plainText = plainText.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
        
    }
}
