import Foundation

public class WikiFetcher {
    let basePart = "http://sv.wikipedia.org/w/index.php?action=raw&title="
    let title: String
    
    public init(title: String) {
        self.title = title
    }
    
    public func fetch() -> WikiArticle? {
        let urlString = basePart + title
        let fetchedArticle: WikiArticle
        var error: NSError?
        if let escapedString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding),
            url = NSURL(string: escapedString),
            responseString = NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding, error: &error) {
                fetchedArticle = WikiArticle(markup: responseString as String)
                return fetchedArticle
        } else {
            if(error != nil) {
                println("Error fetching wikitext: \(error?.localizedDescription)")
            }
            return nil
        }
    }
}



