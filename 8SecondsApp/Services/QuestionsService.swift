//
//  QuestionsService.swift
//  8SecondsApp
//
//  Created by Ataberk Canıtez on 11.07.2020.
//  Copyright © 2020 Ataberk Canıtez. All rights reserved.
//

import Foundation

struct Questions: Codable {
    var questionSize: Int
    var questions: [QuestionData]
    
    private enum CodingKeys: String, CodingKey{
        case questionSize = "question size:"
        case questions = "questions"
    }
}

struct QuestionData: Codable {
    var question: String
    var answer: String
}



class QuestionsService{
    static func getQuestions(completion: @escaping(_ questions: Questions)->Void){
        let urlString = "https://us-central1-sec-bee11.cloudfunctions.net/randomQuestions?questionSize=15"
        
        let urlUnwrapped = URL(string: urlString)
        
        guard let url = urlUnwrapped else { return }
        
        var request = URLRequest(url: url)
        //request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request){(data, response, error) in
            if let error = error{
                print("Error : ", error)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                print("Question http status error!, ", httpStatus.statusCode)
                return
            }
            
            do{
                guard let data = data else { return }
                let jsonData = try JSONDecoder().decode(Questions.self, from: data)
                
                
                completion(jsonData)
            }catch let error{
                print("json error!!!", error)
                return
            }
        }
        task.resume()
        
        
    }
}
