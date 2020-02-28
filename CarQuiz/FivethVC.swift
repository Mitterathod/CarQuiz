//
//  FivethVC.swift
//  CarQuiz
//
//  Created by cs on 2020/2/10.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class FivethVC: UIViewController {

    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        question.text = "Vad kallas motortypen?"
        answer1.setTitle("Wankelmotor", for: .normal)
        answer2.setTitle("V motor", for: .normal)
        answer3.setTitle("Boxermotor", for: .normal)
    }
    
    @IBAction func onClickAnswer(_ sender: UIButton) {
        
        if (sender.tag == 2) {
            correctNum += 1
        }else {}
        
        let toVC = self.storyboard?.instantiateViewController(withIdentifier: "EndVC") as! EndVC
        toVC.modalPresentationStyle = .fullScreen
        self.present(toVC, animated: true, completion: nil)
    }
    
 

}
