//
//  Modal.swift
//  CarQuiz
//
//  Created by apple on 2/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class Question: Equatable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.correctAns == rhs.correctAns
    }
    
    var text: String
    var imageRef: String
    var ansOptions: [String]
    var correctAns: String
    
    // initializer for providing values at instance(object) creation time
    init(qText: String, qImageRef: String, aOptions: [String], cAns: String){
        text = qText
        imageRef = qImageRef
        ansOptions = aOptions
        correctAns = cAns
    }

}
