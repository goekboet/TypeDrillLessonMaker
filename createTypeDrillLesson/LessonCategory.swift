import Foundation

public struct LessonCategory {
    
    let fileExtension = ".tdcat"
    let pathToDesktop = "~/Desktop".stringByExpandingTildeInPath
    
    var categoryDict = [String: AnyObject]()
    var lessonsArray = [[String: AnyObject]]()
    
    public init(title: String) {
        let timestamp = NSDate()
        categoryDict = [
            "date": timestamp,
            "lessons": lessonsArray,
            "misc1": "",
            "misc2": "",
            "misc3": "",
            "misc4": "",
            "title": title]
    }
    
    public mutating func addLessons(lessons: [Lesson]) {
        for lesson in lessons {
            lessonsArray.append(lesson.getLessonDict() as! [String : AnyObject])
        }
        categoryDict["lessons"] = lessonsArray
    }
    
    public func publish() {
        let writeableDict = categoryDict as NSDictionary
        let title = categoryDict["title"] as! String
        println("\(pathToDesktop)/\(title)\(fileExtension)")
        writeableDict.writeToFile("\(pathToDesktop)/\(title)\(fileExtension)", atomically: true)
    }
}
