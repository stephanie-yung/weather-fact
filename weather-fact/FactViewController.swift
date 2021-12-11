//
//  ViewController.swift
//  weather-fact
//
//  Created by Stephanie Yung on 11/7/21.
//

import UIKit
import Foundation

class FactViewController: UIViewController {
    
    @IBOutlet var getRandomFactButton: UIButton!
    @IBOutlet var colorView: UIView!
    @IBOutlet var MathTriviaButton: [UIButton]!
    
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var factLabel: UILabel!
    var receivedNum: Any!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getRandomFactButton.layer.cornerRadius = 0
        getRandomFactButton.layer.borderWidth = 1
        getRandomFactButton.layer.borderColor = UIColor.black.cgColor
        receivedNum = 0
        
//        fetchMathFactData{ (mathData) in
//            print(mathData.text)
//            DispatchQueue.main.async {
//                self.numberLabel.text = "\(mathData.number)"
//                self.factLabel.text = mathData.text
//            }
//        }
        
//        fetchTriviaFactData{ (triviaData) in
//            print(triviaData)
//            DispatchQueue.main.async {
//                self.numberLabel.text = "\(mathData.number)"
//                self.factLabel.text = mathData.text
//            }
//        }
        
    }
    
    func fetchTriviaFactData(completionHandler: @escaping (TriviaFact) -> Void){
        let number = Int.random(in: 0...2025)
        let headers = [
            "x-rapidapi-host": "numbersapi.p.rapidapi.com",
            "x-rapidapi-key": "31b15844femsh5871d44730f7f47p1d491djsn846fb4398848"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://numbersapi.p.rapidapi.com/\(number)/trivia?fragment=true&notfound=floor&json=true")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data else {return}
            print("JSONDECODER DATA: ",data)
            
            do{
                let triviaFactData = try JSONDecoder().decode(TriviaFact.self, from: data)
                
                completionHandler(triviaFactData)
            }
            catch{
                let error = error
                print("THIS IS THE ERROR",error)
            }
        })

        dataTask.resume()
    }
    
    func fetchMathFactData(completionHandler: @escaping (MathFact) -> Void){
        let number = Int.random(in: 0...2025)
        let headers = [
            "x-rapidapi-host": "numbersapi.p.rapidapi.com",
            "x-rapidapi-key": "31b15844femsh5871d44730f7f47p1d491djsn846fb4398848"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://numbersapi.p.rapidapi.com/\(number)/math?fragment=true&json=true")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            guard let data = data else {return}
            print("JSONDECODER DATA: ",type(of: data),data)
            
            do{
                let mathFactData = try JSONDecoder().decode(MathFact.self, from: data)
                
                completionHandler(mathFactData)
            }
            catch{
                let error = error
                print("THIS IS THE ERROR",error)
            }
        }
        dataTask.resume()
        
    }
    
 
    
    func showButtonVisibility(){
        MathTriviaButton.forEach{ button in
            UIView.animate(withDuration: 0.3) {
                button.isHidden = !button.isHidden
//                button.isHidden = false
                self.view.layoutIfNeeded()
//                self.numberLabel.isHidden = !self.numberLabel.isHidden
//                self.factLabel.isHidden = !self.factLabel.isHidden
            }
        }
    }
    
    
    @IBAction func selectRandomFact(_ sender: Any) {
        showButtonVisibility()
    }
    
    @IBAction func colorButtonAction(_ sender: UIButton){
        showButtonVisibility()
        switch sender.currentTitle {
        case "GET MATH FACT":
            getRandomFactButton.setTitle("MATH FACT:", for: .normal)
//            colorView.backgroundColor = .systemBlue
            numberLabel.textColor = .systemBlue
            factLabel.textColor = .systemBlue
            fetchMathFactData{ (mathData) in
                print(mathData.text)
                DispatchQueue.main.async {
                    self.numberLabel.text = "\(mathData.number)"
                    self.factLabel.text = mathData.text
                }
            }

        case "GET TRIVIA FACT":
            getRandomFactButton.setTitle("TRIVIA FACT:", for: .normal)
//            colorView.backgroundColor = .systemYellow
            numberLabel.textColor = .systemYellow
            factLabel.textColor = .systemYellow
            fetchTriviaFactData{ (triviaData) in
                print(triviaData)
                DispatchQueue.main.async {
                    self.numberLabel.text = "\(triviaData.number)"
                    self.factLabel.text = (triviaData).text
                }
            }
        
        default:
//            colorView.backgroundColor = .white
            numberLabel.textColor = .white
            factLabel.textColor = .white
            
        }
    }

}
