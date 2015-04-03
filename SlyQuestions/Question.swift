//
//  question.swift
//  SlyQuestions
//
//  Created by Michelle Brooks on 3/24/15.
//  Copyright (c) 2015 testive. All rights reserved.
//

import Foundation


class Question
{
    var id:Int = 0
    var title:String = ""
    var body:String = ""
   // var answers:[String] = []
    var answers = Array(count: 5, repeatedValue: "")
    var selectedAnswer:Int = 0
    var answerCorrect:Int = 0
    let appUrl = "http://app.testive.com/api/"
    
    init(){

    }
    
    func getQuestionOfTheDay()
    {
        //answers = []

        //get or create a testsession for this user
        let itinerary = "rt-math" //one-question"
        let user = "39d2e96877a14e929f1f51f12d7fd801"
  
        let testSessionUrl = "testsession/get_or_create/?user_uuid=\(user)&itinerary=\(itinerary)"
        makeGet(testSessionUrl)

    }
    
    func populateModel(currentQuestion: Dictionary<String, AnyObject>){
        println(currentQuestion)
        id = currentQuestion["id"] as Int
        title = currentQuestion["title"] as String
        body = currentQuestion["body"] as String
        var spanLocation = body.indexOf("<span class='qdebug-info'>")
        if spanLocation > -1{
            body = body.subString(0, length: spanLocation)
        }
        answerCorrect = currentQuestion["answer_correct"] as Int
        var answerDict = currentQuestion["answers"] as Dictionary<String, String>
        for (answerNumber, answerText) in answerDict{
            let index: Int? = answerNumber.toInt()
            answers[index!-1] = answerText
        }
        
    }
    
    func jsonFailed(error: NSError) {
        println("Error: \(error.localizedDescription)")
    }
    
    func makeGet(place:String) {
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer.setValue("608c6c08443c6d933576b90966b727358d0066b4", forHTTPHeaderField: "X-Auth-Token")
        
        let url = self.appUrl + place
        println(url)
        
        manager.GET(url,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let responseDict = responseObject["data"] as Dictionary<String, AnyObject>
                let current_question = responseDict["current_question"] as Dictionary<String, AnyObject>
                self.populateModel(current_question)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                self.jsonFailed(error)
            }
        )
    }
    
}
