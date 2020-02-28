//
//  ViewController1.swift
//  CarQuiz
//
//  Created by admin on 2020-01-17.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class QuizViewController : UIViewController {
    
    @IBOutlet weak var questionImageView: UIImageView!
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel1: UILabel!
    @IBOutlet weak var questionLabel2: UILabel!
    @IBOutlet weak var firstOptionButton: UIButton!
    @IBOutlet weak var secondOptionButton: UIButton!
    @IBOutlet weak var thirdOptionButton: UIButton!
    @IBOutlet weak var fourthOptionButton: UIButton!
    
    // for question numbers
    private var questionIndex = 0
    private var correctAns = 0
    var quizRestarted = false
    
    // Questions
    var question1 = Question(qText: "Vilket land tillverkas bilen i?", qImageRef: "car", aOptions: ["Tyskland", "Japan", "USA"], cAns: "Japan")
    
    var question2 = Question(qText: "Vilken är INTE en takt i en fyrtaktsmotor?", qImageRef: "", aOptions: ["Insugstakt", "Kompressionstakt", "Arbetstakt", "Spolningstakt"], cAns: "Spolningstakt")
    
    var question3 = Question(qText: "Vad heter motorracebanan?", qImageRef: "map", aOptions: ["Nürburgring", "Monza", "Mantorp"], cAns: "Nürburgring")
    
    var question4 = Question(qText: "Vilket stift används i dieselmotorn?", qImageRef: "", aOptions: ["Tändstift", "Glödstift", "Värmestift"], cAns: "Glödstift")
    
    var question5 = Question(qText: "Vad kallas motortypen?", qImageRef: "engine", aOptions: ["Wankelmotor", "V motor", "Boxermotor"], cAns: "Boxermotor")
    
    // array of questions
    lazy var allQuestions: [Question] = [question1, question2, question3, question4, question5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if quizRestarted {reshuffleQuestionsArray()}
        setQuestion(questionNo: questionIndex)
    }
    
    // randomize the questions
    // if previous first question comes again after shuffle, function is recursed to change value
    private func reshuffleQuestionsArray(){
        let prevFirstQuestion = UserDefaults.standard.string(forKey: "prevFirstQuestion") ?? question1.correctAns
        
        allQuestions.shuffle() // shuffling questions
        if allQuestions.first?.correctAns == prevFirstQuestion {
            print("recursive function called")
            reshuffleQuestionsArray()
        }
        allQuestions.forEach { (question) in
            question.ansOptions.shuffle() // shuffling answer options
        }
        UserDefaults.standard.set(allQuestions.first?.correctAns, forKey: "prevFirstQuestion")
    }
        
    // to set question according to question number
    private func setQuestion(questionNo index: Int){
        let question = allQuestions[index]
        let questionText = question.text
        let imgReference = question.imageRef
        let ansOptions = question.ansOptions
        
        // if there is no image then hide imageView and qLabel2
        if imgReference == "" {
            showHideViews(viewToHide: "imageView")
            questionLabel1.text = questionText
        }
        
        // if there is an image hide label1 and show imageView and label2
        if imgReference != "" {
            showHideViews(viewToHide: "qLabel1")
            questionImageView.image = UIImage(named: imgReference)
            questionLabel2.text = questionText
        }
        
        // if there are not 4 answer options hide the first button else show it
        if ansOptions.count != 4 {
            firstOptionButton.isHidden = true
            secondOptionButton.setTitle(ansOptions[0], for: .normal)
            thirdOptionButton.setTitle(ansOptions[1], for: .normal)
            fourthOptionButton.setTitle(ansOptions[2], for: .normal)
        }
        else {
            firstOptionButton.isHidden = false
            firstOptionButton.setTitle(ansOptions[0], for: .normal)
            secondOptionButton.setTitle(ansOptions[1], for: .normal)
            thirdOptionButton.setTitle(ansOptions[2], for: .normal)
            fourthOptionButton.setTitle(ansOptions[3], for: .normal)
        }
        
    }
    
    private func showHideViews(viewToHide name: String){
        if name == "imageView" {
            questionImageView.isHidden = true
            questionLabel2.isHidden = true
            questionLabel1.isHidden = false
        }
        if name == "qLabel1" {
            questionLabel1.isHidden = true
            questionImageView.isHidden = false
            questionLabel2.isHidden = false
        }
    }

    // increment the index of question number
    // pass sender button to function for answer check and question reset
    @IBAction func onClickAnswer(_ sender: UIButton) {
        questionIndex += 1
        
        switch sender.tag {
        case 1:
            checkAnswerSetQuestion(button: sender)
        case 2:
            checkAnswerSetQuestion(button: sender)
        case 3:
            checkAnswerSetQuestion(button: sender)
        case 4:
            checkAnswerSetQuestion(button: sender)
        default:
            print("Not desired Option")
        }
        
    }
    
    // set interface and check correct ans and increment its value if was correct,
    //if question was last, present modal EndVC
    private func checkAnswerSetQuestion(button sender: UIButton){
        let question = allQuestions[questionIndex - 1]
        
        if sender.titleLabel?.text == question.correctAns {
            correctAns += 1
            sender.setTitleColor(.green, for: .normal)
        } else{
            sender.setTitleColor(.red, for: .normal)
        }
        
        // for little delay to display red or green color of answer
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.questionIndex > 4 {
                let toVC = self.storyboard?.instantiateViewController(withIdentifier: "EndVC") as! EndVC
                toVC.correctAnswers = self.correctAns // setting value of optional variable of EndVC
                toVC.modalPresentationStyle = .fullScreen
                toVC.modalTransitionStyle = .crossDissolve // style for going from one screen to another
                self.present(toVC, animated: true, completion: nil)
                return
            }
            
            // change question number label
            self.questionNumberLabel.text = "\(self.questionIndex+1)/5"
            
            //reset color of option text
            sender.setTitleColor(.systemYellow, for: .normal)
            
            // set question and answer options for next question
            self.setQuestion(questionNo: self.questionIndex)
        }
    
    }

}


