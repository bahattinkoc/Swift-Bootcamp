//
//  ViewController.swift
//  YerliAngryBirds
//
//  Created by Bahattin Koç on 27.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtNickname: UITextField!
    @IBOutlet weak var sliderBottleLocation: UISlider!
    @IBOutlet weak var sliderBottleDelta: UISlider!
    @IBOutlet weak var sliderMortarAngle: UISlider!
    @IBOutlet weak var sliderMortarSpeed: UISlider!
    @IBOutlet weak var lblDeadLocation: UILabel!
    @IBOutlet weak var lblDeadDelta: UILabel!
    @IBOutlet weak var lblImposterAngle: UILabel!
    @IBOutlet weak var lblImposterSpeed: UILabel!
    @IBOutlet weak var txtLeaderboard: UITextView!
    @IBOutlet weak var imgImposter: UIImageView!
    @IBOutlet weak var imgDead: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblDeadLocation.text = "Dead Location = " + sliderBottleLocation.value.description
        lblDeadDelta.text = "Dead Delta = " + sliderBottleDelta.value.description
        lblImposterAngle.text = "Imposter Angle = " + sliderMortarAngle.value.description
        lblImposterSpeed.text = "Imposter Speed = " + sliderMortarSpeed.value.description
        
        print(imgImposter.frame.origin.x) // 8
        print(imgDead.frame.origin.x) // 326
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        if txtNickname.text != ""{
            createNewGame(nickname: txtNickname.text ?? "Default", bottleLocation: Double(sliderBottleLocation.value), bottleDelta: Double(sliderBottleDelta.value), mortarAngle: Double(sliderMortarAngle.value), mortarSpeed: Double(sliderMortarSpeed.value))
            
            print("Imposter: \(CGFloat((Mortar(location: 0.0, angle: Double(sliderMortarAngle.value), speed: Double(sliderMortarSpeed.value)).range() / 1500) * 318 + 8)) and Dead: \(CGFloat((sliderBottleLocation.value/1500) * 318 + 8))")
            
            txtLeaderboard.text = ""
            for item in leaderboard{
                print("\(item.player.nickname): \(item.player.score)")
                txtLeaderboard.text += "\(item.player.nickname): \(item.player.score)\n"
            }
            
            // Animasyonlu imposter hareketi
            UIView.animate(withDuration: 1.0, animations: {
                self.imgImposter.frame.origin.x = CGFloat((Mortar(location: 0.0, angle: Double(self.sliderMortarAngle.value), speed: Double(self.sliderMortarSpeed.value)).range() / 1500) * 318 + 8)
            })
        }
    }
    
    @IBAction func sliderDeadLocationAction(_ sender: UISlider) {
        lblDeadLocation.text = "Dead Location = " + sliderBottleLocation.value.description
        
        // oyunun kurallarındaki mesafe ile resimin konumunun koordinatlarını normalize ettik
        self.imgDead.frame.origin.x = CGFloat((sliderBottleLocation.value/1500) * 318 + 8)
    }
    
    @IBAction func sliderDeadDeltaAction(_ sender: UISlider) {
        lblDeadDelta.text = "Dead Delta = " + sender.value.description
    }
    
    @IBAction func sliderImposterAngleAction(_ sender: UISlider) {
        lblImposterAngle.text = "Imposter Angle = " + sender.value.description
    }
    
    @IBAction func sliderImposterSpeed(_ sender: UISlider) {
        lblImposterSpeed.text = "Imposter Speed = " + sender.value.description
    }
    
    
    struct Mortar {
        var location: Double = 0.0
        var angle: Double = 0.0 // teta 0-90
        var speed: Double = 0.0 // V 0-100 m/s
        
        func range() -> Double{
            return self.speed * self.speed * sin(2 * self.angle) / 10
        }
    }
    
    var leaderboard: [Game] = []
    
    struct Bottle {
        var location: Double = 0.0 // d. Sıfıra olan uzaklığı. 0-1500
        var delta: Double = 0.1 // Şişenin kapladığı alan. Genişliği. 0.1-1
        var isFall: Bool = false
    }

    struct Player {
        var nickname: String = ""
        var score: Int = 0
    }
    
    struct Game {
        var player: Player
        var mortar: Mortar
        var bottle: Bottle
        
        mutating func setPlayer(nickname: String){
            player.nickname = nickname
        }
        
        mutating func setBottle(location: Double, delta: Double){
            if location < 0{
                bottle.location = 0
            } else if location > 1500{
                bottle.location = 1500
            } else {
                bottle.location = location
            }
            
            if delta < 0.1{
                bottle.delta = 0.1
            } else if delta > 1{
                bottle.delta = 1
            } else {
                bottle.delta = delta
            }
        }
        
        mutating func setMortar(angle: Double, speed: Double){
            if angle < 0{
                mortar.angle = 0
            } else if angle > 90{
                mortar.angle = 90
            } else{
                mortar.angle = angle
            }
            
            if speed < 0{
                mortar.speed = 0
            } else if speed > 100{
                mortar.speed = 100
            } else {
                mortar.speed = speed
            }
        }
        
        mutating func shot(){
            let R = mortar.range()
            print("\(bottle.location - bottle.delta) <= \(R) <= \(bottle.location + bottle.delta)")
            if R >= (bottle.location - bottle.delta) && R <= (bottle.location + bottle.delta){
                bottle.isFall = true
                player.score += 1
                // print("Bottle overturned")
            } else {
                bottle.isFall = false
                // print("Bottle didn't overturn")
            }
        }
    }
    
    func createNewGame(nickname: String, bottleLocation: Double, bottleDelta: Double, mortarAngle: Double, mortarSpeed: Double){
        
        var game = Game(player: Player(), mortar: Mortar(), bottle: Bottle())
        game.setPlayer(nickname: nickname)
        game.setBottle(location: bottleLocation, delta: bottleDelta)
        game.setMortar(angle: mortarAngle, speed: mortarSpeed)
        game.shot()
        
        var isExist = false
        for (index,item) in leaderboard.enumerated(){
            if item.player.nickname == nickname{
                leaderboard[index].player.score += game.player.score
                isExist = true
                break
            }
        }
        
        if !isExist{
            leaderboard.append(game)
        }
    }
}

