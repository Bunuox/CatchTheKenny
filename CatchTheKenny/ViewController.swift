//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Bünyamin Kılıçer on 26.08.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var imageViewList = [UIImageView]()
    var countdown = 10
    var score = 0
    var highScore = 0
    var timer = Timer()
    var timerForImageChange = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score : \(score)"
        countDownLabel.text = "\(countdown)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil{
            highScore = 0
            highScoreLabel.text = "HighScore: \(highScore)"
            
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        
        prepareImageViewsForGesture()
        imageViewList = [imageView1,imageView2,imageView3,imageView4,imageView5,imageView6,imageView7,imageView8,imageView9]
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdownControl), userInfo: nil, repeats: true)
        changeImage()
        timerForImageChange = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        
    }

    @objc func countdownControl(){
        countDownLabel.text = "\(countdown)"
        countdown = countdown - 1
        
        if countdown == 0 {
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "HighScore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            showAlert(title: "Finish!", message: "Game finished - github push deneme")
            self.timer.invalidate()
            self.timerForImageChange.invalidate()
            self.score = 0
        }
    }
    
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let closeButtonForAlert = UIAlertAction(title: "Close", style: .cancel) { (UIAlertAction) in
            self.countdown = 10
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdownControl), userInfo: nil, repeats: true)
            self.timerForImageChange = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        alert.addAction(closeButtonForAlert)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func increaseScore(){
        self.score += 1
        self.scoreLabel.text = "Score: \(self.score)"
    }
    
    @objc func changeImage(){
        for image in imageViewList{
            image.isHidden = true
        }
        let randomInt = arc4random_uniform(UInt32(imageViewList.count-1))
        imageViewList[Int(randomInt)].isHidden = false
    }
    
    func prepareImageViewsForGesture(){
        
        imageView1.isUserInteractionEnabled = true
        imageView2.isUserInteractionEnabled = true
        imageView3.isUserInteractionEnabled = true
        imageView4.isUserInteractionEnabled = true
        imageView5.isUserInteractionEnabled = true
        imageView6.isUserInteractionEnabled = true
        imageView7.isUserInteractionEnabled = true
        imageView8.isUserInteractionEnabled = true
        imageView9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        imageView1.addGestureRecognizer(recognizer1)
        imageView2.addGestureRecognizer(recognizer2)
        imageView3.addGestureRecognizer(recognizer3)
        imageView4.addGestureRecognizer(recognizer4)
        imageView5.addGestureRecognizer(recognizer5)
        imageView6.addGestureRecognizer(recognizer6)
        imageView7.addGestureRecognizer(recognizer7)
        imageView8.addGestureRecognizer(recognizer8)
        imageView9.addGestureRecognizer(recognizer9)
    }
}

