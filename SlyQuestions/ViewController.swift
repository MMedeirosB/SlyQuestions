//
//  ViewController.swift
//  SlyQuestions
//
//  Created by Michelle Brooks on 3/24/15.
//  Copyright (c) 2015 testive. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionView: UIWebView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var successImage: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var slyButton: UIButton!
    @IBOutlet weak var answerOne: UIButton!
    @IBOutlet weak var answerTwo: UIButton!
    @IBOutlet weak var answerThree: UIButton!
    @IBOutlet weak var answerFour: UIButton!
    @IBOutlet weak var answerFive: UIButton!

    var answerButtons:[UIButton] = []
    var question:Question!
    var statusLabel: UILabel!
    
    @IBAction func answerTapped(sender: UIButton) {
        var selectedAnswer = 0
        
        switch sender {
        case answerOne:
            selectedAnswer = 1
        case answerTwo:
            selectedAnswer = 2
        case answerThree:
            selectedAnswer = 3
        case answerFour:
            selectedAnswer = 4
        case answerFive:
            selectedAnswer = 5
        default:
            selectedAnswer = 0
        }
       
        sender.layer.backgroundColor = UIColor.grayColor().CGColor
        self.checkAnswer(selectedAnswer)
   
    }
    
    func getAnswerButton(number:Int) -> UIButton {
        return answerButtons[number-1]
    }
    
    func checkAnswer(selectedAnswer:Int){
       
        println("checkAnswer")
        if selectedAnswer == question.answerCorrect{
            questionLabel.hidden = true
            
            for button in self.answerButtons {
                button.hidden = true;
            }
            
            backgroundImage.image = UIImage(named: "better_cloud_background")
            successImage.hidden = false
            
        }
        else{
            statusLabel.text = "Try Again Tomorrow"
            statusLabel.hidden = false
            
            //highlight the correct answer
            var correct = getAnswerButton(question.answerCorrect)
            correct.layer.borderColor = UIColor.orangeColor().CGColor
            correct.layer.backgroundColor = UIColor.whiteColor().CGColor
            correct.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            
            //lowlight the selectedAnswer if incorrect
            for button in self.answerButtons {
                button.enabled = false
            }
        }
    }
    
    func styleAnswerButton(button : UIButton) {
        button.backgroundColor = colorize(0xdfeff5) //UIColor.whiteColor()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.titleLabel!.font = UIFont.boldSystemFontOfSize(14) //UIFont(name: "Times New Roman", size: 25)
    
    }
    
    @IBAction func slyButtonTapped(sender : AnyObject) {
        if slyButton.enabled{
            println("sly")
            askQuestionOfTheDay()
        
            slyButton.enabled = false
            slyButton.hidden = true
        
            questionLabel.hidden = false
            for button in self.answerButtons {
                button.hidden = false
            }
        }
    }
    
    func colorize (hex: Int, alpha: Double = 1.0) -> UIColor {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        var color: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha:CGFloat(alpha) )
        return color
    }
    
    func askQuestionOfTheDay() {
        questionLabel.text = self.question.body
        answerOne.setTitle(self.question.answers[0], forState: UIControlState.Normal)
        answerTwo.setTitle(self.question.answers[1], forState: UIControlState.Normal)
        answerThree.setTitle(self.question.answers[2], forState: UIControlState.Normal)
        answerFour.setTitle(self.question.answers[3], forState: UIControlState.Normal)
        answerFive.setTitle(self.question.answers[4], forState: UIControlState.Normal)
        
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.successImage.hidden = true
        
        self.questionLabel.font = UIFont.boldSystemFontOfSize(20)
        self.questionLabel.frame = CGRect(x: 20, y: 100, width: 100, height: 70)
        self.questionLabel.numberOfLines = 4
        self.questionLabel.lineBreakMode = .ByWordWrapping
        
        self.answerButtons.append(answerOne)
        self.answerButtons.append(answerTwo)
        self.answerButtons.append(answerThree)
        self.answerButtons.append(answerFour)
        self.answerButtons.append(answerFive)
        
        statusLabel = UILabel()
        statusLabel.frame = CGRectMake(0, 0, 200, 21)
        statusLabel.center = CGPointMake(300, 250)
        statusLabel.textAlignment = NSTextAlignment.Center
        statusLabel.hidden = true
        self.view.addSubview(statusLabel)
        
        self.question = Question()
        self.question.getQuestionOfTheDay()
        for button in self.answerButtons {
            styleAnswerButton(button as UIButton)
            button.hidden = true
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

