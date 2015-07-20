import Foundation

public class LessonComposer {
    let maxCharacterCount = 400
    let title: String
    var content = ""
    var lessonCategory: LessonCategory
    var lessonNumber = 1
    
    public init(title: String) {
        self.title = title
        self.lessonCategory = LessonCategory(title: title)
        
    }
    
    public func compose() -> (LessonCategory) {
        
        getContent()
        let lessons = prepareLessons(content)
        lessonCategory.addLessons(lessons)
        
        return lessonCategory
    }
    
    func getContent() {
        let fetcher = WikiFetcher(title: title)
        var content = ""
        if let wikiArticle = fetcher.fetch() {
            content = wikiArticle.getplainText()
        }
        self.content = content
    }
    
    func prepareLessons(content: String) -> ([Lesson]) {
        
        let lessonTexts = getLessonTexts()
        var lessons: [Lesson] = []
        
        for lessonText in lessonTexts {
            let lessonTitle = "\(title) \(lessonNumber)"
            let trimmedLessonText = lessonText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let lesson = Lesson(title: lessonTitle, lessonText: trimmedLessonText as String)
            lessons.append(lesson)
            lessonNumber++
        }
        
        return lessons
    }
    
    func getLessonTexts() -> ([NSString]) {
        let text = content as NSString
        var lessonTexts: [NSString] = []
        
        let paragraphs = text.getParagraphArray()
        
        for paragraph in paragraphs {
            
            var lessonText: NSString = ""
            var charCount = 0
            
            let sentences = paragraph.getSentenceArray()
            for sentence in sentences {
                
                var sentenceWithSeparator = "\(sentence) " as NSString
                charCount += sentenceWithSeparator.length
                if (charCount > maxCharacterCount) {
                    lessonTexts.append(lessonText)
                    charCount = sentenceWithSeparator.length
                    lessonText = sentenceWithSeparator
                } else {
                    lessonText = lessonText.stringByAppendingString(sentenceWithSeparator as String)
                }
            }
            if let lastSentence = sentences.last {
                lessonTexts.append(lastSentence)
            }
        }
        return lessonTexts
    }
}



