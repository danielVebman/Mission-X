//
//  OverviewViewController.swift
//  Mission X
//
//  Created by Daniel Vebman on 10/28/18.
//  Copyright © 2018 Daniel Vebman. All rights reserved.
//

import Foundation
import UIKit
import NightView

class OverviewViewController: UIViewController {
    var planet: String
    var detail: String
    var flightTime: Int
    var temperature: String
    var planetColor: UIColor
    var seatsBooked: Int
    
    init(planet: String, detail: String, flightTime: Int, temperature: String, planetColor: UIColor, seatsBooked: Int) {
        self.planet = planet
        self.detail = detail
        self.flightTime = flightTime
        self.temperature = temperature
        self.planetColor = planetColor
        self.seatsBooked = seatsBooked
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.clipsToBounds = true
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(rgb: 0x341B60).cgColor, UIColor(rgb: 0x1A0D30).cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
        
        let nightView = NightView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: view.frame.width, height: view.frame.height / 2))
        nightView.numberOfPointsForStar = 9000
        view.addSubview(nightView)
        
        let welcomeLabel = UILabel(frame: CGRect(x: 20, y: navigationController!.navigationBar.frame.maxY + 20, width: view.frame.width - 40, height: 20))
        welcomeLabel.text = "WELCOME TO"
        welcomeLabel.font = UIFont(name: "Bangla Sangam MN", size: 15)
        welcomeLabel.textColor = planetColor
        view.addSubview(welcomeLabel)
        
        let nameLabel = UILabel(frame: CGRect(x: 20, y: welcomeLabel.frame.maxY, width: view.frame.width - 40, height: 60))
        nameLabel.text = planet
        nameLabel.font = UIFont(name: "DIN Alternate", size: 50)
        nameLabel.textColor = .white
        view.addSubview(nameLabel)
        
        let descLabel = UILabel(frame: CGRect(x: 20, y: nameLabel.frame.maxY + 30, width: view.frame.width - 40, height: 0))
        descLabel.numberOfLines = 0
        descLabel.font = UIFont(name: "Bangla Sangam MN", size: 12)
        descLabel.text = detail
        descLabel.frame.size.height = descLabel.text!.height(withConstrainedWidth: descLabel.frame.width, font: descLabel.font)
        descLabel.textColor = UIColor(rgb: 0xDEDFE0)
        view.addSubview(descLabel)
        
        let separatorBar = UIView(frame: CGRect(x: 20, y: descLabel.frame.maxY + 50, width: view.frame.width - 40, height: 0.5))
        separatorBar.alpha = 0.2
        separatorBar.backgroundColor = .white
        view.addSubview(separatorBar)
        
        let lengthLabel = UILabel(frame: CGRect(x: 20, y: separatorBar.frame.maxY + 50, width: view.frame.width / 2 - 20, height: 15))
        lengthLabel.attributedText = labelText(icon: "\u{f197}", text: "\(flightTime)H FLIGHT")
        lengthLabel.textColor = .white
        view.addSubview(lengthLabel)
        
        let wifiLabel = UILabel(frame: CGRect(x: view.frame.midX, y: separatorBar.frame.maxY + 50, width: view.frame.width / 2 - 20, height: 15))
        wifiLabel.attributedText = labelText(icon: "\u{f1eb}", text: "FREE WiFi")
        wifiLabel.textAlignment = .right
        wifiLabel.textColor = .white
        view.addSubview(wifiLabel)
        
        let kidLabel = UILabel(frame: CGRect(x: 20, y: lengthLabel.frame.maxY + 20, width: view.frame.width / 2 - 20, height: 15))
        kidLabel.attributedText = labelText(icon: "\u{f1ae}", text: "KID FRIENDLY")
        kidLabel.textColor = .white
        view.addSubview(kidLabel)
        
        let tempLabel = UILabel(frame: CGRect(x: view.frame.midX, y: wifiLabel.frame.maxY + 20, width: view.frame.width / 2 - 20, height: 15))
        tempLabel.attributedText = labelText(icon: "\u{f2cb}", text: temperature)
        tempLabel.textAlignment = .right
        tempLabel.textColor = .white
        view.addSubview(tempLabel)
        
        let moonView = UIView()
        moonView.frame.size = CGSize(width: view.frame.width + 70, height: view.frame.width + 70)
        moonView.transform = CGAffineTransform(scaleX: 1.5, y: 1)
        moonView.layer.cornerRadius = 0.5 * moonView.frame.height
        moonView.center = CGPoint(x: view.frame.midX, y: view.frame.height + 40)
        moonView.backgroundColor = planetColor
        view.addSubview(moonView)
        
        let bookSeatsButton = UIButton(type: .system)
        bookSeatsButton.setTitle("BOOK SEATS", for: .normal)
        bookSeatsButton.setTitleColor(.black, for: .normal)
        bookSeatsButton.titleLabel?.font = UIFont(name: "Bangla Sangam MN", size: 20)
        bookSeatsButton.frame.size = CGSize(width: view.frame.width * 2 / 3 - 40 - 10, height: 50)
        bookSeatsButton.center.y = (moonView.frame.minY + tempLabel.frame.maxY) / 2
        bookSeatsButton.frame.origin.x = view.frame.width / 6
        bookSeatsButton.backgroundColor = UIColor(rgb: 0xDEDFE0)
        bookSeatsButton.layer.cornerRadius = 10
        view.addSubview(bookSeatsButton)
        
        let currentSeatsButton = UIButton(type: .system)
        currentSeatsButton.setTitle("\(seatsBooked)", for: .normal)
        currentSeatsButton.setTitleColor(.black, for: .normal)
        currentSeatsButton.titleLabel?.font = UIFont(name: "Bangla Sangam MN", size: 20)
        currentSeatsButton.frame = CGRect(x: bookSeatsButton.frame.maxX + 10, y: bookSeatsButton.frame.origin.y, width: 40, height: 50)
        currentSeatsButton.backgroundColor = UIColor(rgb: 0xDEDFE0)
        currentSeatsButton.layer.cornerRadius = 10
        view.addSubview(currentSeatsButton)
    }
    
    func labelText(icon: String, text: String) -> NSAttributedString {
        let attrStr = NSMutableAttributedString()
        attrStr.append(NSAttributedString(string: icon, attributes: [.font: UIFont(name: "Font Awesome 5 Free", size: 15)!]))
        attrStr.append(NSAttributedString(string: "  "))
        attrStr.append(NSAttributedString(string: text, attributes: [.font: UIFont(name: "Bangla Sangam MN", size: 15)!]))
        return attrStr
    }
}
