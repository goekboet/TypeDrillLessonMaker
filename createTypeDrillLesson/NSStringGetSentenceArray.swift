import Foundation

public extension NSString {
    
    public func getParagraphArray() -> ([NSString]) {
        var paragraphs: [NSString] = self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
        let nonEmptyParagraphs = paragraphs.filter({$0.length != 0})
        return nonEmptyParagraphs
    }
    
    public func getSentenceArray() -> ([NSString]) {
        let entireString = NSMakeRange(0, self.length)
        var sentences: [NSString] = []
        
        if let sentenceRegex = NSRegularExpression(pattern: "[A-Ö]([\\s\\S]*?)[\\.\\!\\?](?= [A-Z|Å|Ä|Ö]|$)", options: NSRegularExpressionOptions.allZeros, error: nil) {
            var stop = false
            sentenceRegex.enumerateMatchesInString(self as String, options: NSMatchingOptions.allZeros, range: entireString) { (result, flags, stop) -> Void in
                let sentenceRange = result.range
                let aSentence = self.substringWithRange(sentenceRange)
                sentences.append(aSentence)
            }
        }
        return sentences
    }
}

