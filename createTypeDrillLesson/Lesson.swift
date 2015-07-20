import Foundation

public struct Lesson {
    var lessonDict = [String: AnyObject]()
    
    public init(title: String, lessonText: String) {
        let timeStamp = NSDate()
        lessonDict = [
            "body" : lessonText,
            "date" : timeStamp,
            "misc1" : "",
            "misc2" : "",
            "misc3" : "",
            "misc4" : "",
            "misc5" : "",
            "title" : title]
    }
    
    public func getLessonDict() -> NSDictionary {
        return lessonDict as NSDictionary
    }
}



