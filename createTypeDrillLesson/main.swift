import Cocoa


let title = "Första_världskriget"

let lessonComposer = LessonComposer(title: title)
let typingLessonFromWiki = lessonComposer.compose()

println("hello!")

typingLessonFromWiki.publish()
