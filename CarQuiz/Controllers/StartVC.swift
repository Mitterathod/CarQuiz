//
//  ViewController.swift
//  CarQuiz
//
//  Created by admin on 2020-02-9.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit


var correctNum = 0 // Define public var and format

class StartVC : UIViewController {
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func onClickContinue(_ sender: Any) {
        let toVC = self.storyboard?.instantiateViewController(withIdentifier: "FirstVC") as! QuizViewController
        toVC.modalPresentationStyle = .fullScreen // Full screen mode
        self.present(toVC, animated: true, completion: nil)
    }   // Click to get to the first screen
}

