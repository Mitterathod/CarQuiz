//
//  EndVC.swift
//  CarQuiz
//
//  Created by cs on 2020/2/10.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class EndVC: UIViewController {

    var correctAnswers: Int? // optional variable which takes value from previous screen
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        result.text = "Du fick " + "\(correctAnswers ?? 0)" + " av 5 rätt!" // This sentence appear as a result.
    }
    
    @IBAction func onClickRestart(_ sender: Any) {
        
        let toVC = self.storyboard?.instantiateViewController(withIdentifier: "FirstVC") as! QuizViewController
        toVC.quizRestarted = true
        toVC.modalPresentationStyle = .fullScreen
        self.present(toVC, animated: true, completion: nil)
        // Clicks you back to first question
    }
    
    @IBAction func onClickExit(_ sender: Any) {
        
        let toVC = self.storyboard?.instantiateViewController(withIdentifier: "StartVC") as! StartVC
        toVC.modalPresentationStyle = .fullScreen
        self.present(toVC, animated: true, completion: nil)
        // Clicks you back to start screen

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        correctNum = 0
    } // when you return the game or exit this resets results
    
}
