//
//  PickDestinationViewController.swift
//  Mission X
//
//  Created by Daniel Vebman on 10/28/18.
//  Copyright © 2018 Daniel Vebman. All rights reserved.
//

import Foundation
import UIKit


class PickDestinationViewController: UIViewController {
    let planets = [
        OverviewViewController(planet: "THE MOON", detail: "Glide across the beautiful surface of the moon in a comfortable HypTech space suit and explore the massive Aitken Basin with an accredited guide. Also get a unique chance to take a photo with the original USA flag planted by Buzz Aldrin and Neil Armstrong.", flightTime: 1, temperature: "BRING HATS", planetColor: UIColor(rgb: 0xDEDFE0), seatsBooked: 2),
        OverviewViewController(planet: "MARS", detail: "Visit our gorgeous red neighbor. Experience the Gully landforms in the Gasa Crater with professionally guided tours, or explore alone with our app. Don't forget to have one of our gourmet martian meals at the HUB.", flightTime: 4, temperature: "DRESS LIGHT", planetColor: UIColor(rgb: 0xF47D42), seatsBooked: 5),
        OverviewViewController(planet: "PHOBOS", detail: "", flightTime: 4, temperature: "DRESS LIGHT", planetColor: UIColor(rgb: 0xD0A7E8), seatsBooked: 0),
        OverviewViewController(planet: "DEIMOS", detail: "", flightTime: 4, temperature: "DRESS LIGHT", planetColor: UIColor(rgb: 0xE8E3A7), seatsBooked: 0),
        OverviewViewController(planet: "JUPITER", detail: "", flightTime: 7, temperature: "BRING HATS", planetColor: UIColor(rgb: 0xF9AB84), seatsBooked: 0),
        OverviewViewController(planet: "SATURN", detail: "", flightTime: 12, temperature: "DRESS CASUAL", planetColor: UIColor(rgb: 0xF4D4C3), seatsBooked: 0),
        OverviewViewController(planet: "URANUS", detail: "", flightTime: 14, temperature: "DRESS CASUAL", planetColor: UIColor(rgb: 0x7697F2), seatsBooked: 0)
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(rgb: 0x341B60).cgColor, UIColor(rgb: 0x1A0D30).cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        
        let nameLabel = UILabel(frame: CGRect(x: 20, y: navigationController!.navigationBar.frame.maxY, width: view.frame.width - 40, height: 60))
        nameLabel.text = "DESTINATIONS"
        nameLabel.font = UIFont(name: "DIN Alternate", size: 50)
        nameLabel.textColor = .white
        view.addSubview(nameLabel)
        
        let tableView = UITableView(frame: CGRect(x: 0, y: nameLabel.frame.maxY, width: view.frame.width, height: view.frame.height - nameLabel.frame.maxY))
        tableView.backgroundColor = .clear
        tableView.register(PlanetTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
}

extension PickDestinationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlanetTableViewCell
        let planet = planets[indexPath.row]
        
        cell.planetName = planet.planet.capitalized
        cell.flightDuration = planet.flightTime
        cell.planetColor = planet.planetColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension PickDestinationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(planets[indexPath.row], animated: true)
    }
}

class PlanetTableViewCell: UITableViewCell {
    var planetName: String? {
        didSet {
            nameLabel.text = planetName
        }
    }
    
    var flightDuration: Int? {
        didSet {
            guard let duration = flightDuration else {
                durationLabel.attributedText = nil
                return
            }
            
            let attrStr = NSMutableAttributedString()
            attrStr.append(NSAttributedString(string: "\u{f197}", attributes: [.font: UIFont(name: "Font Awesome 5 Free", size: 15)!]))
            attrStr.append(NSAttributedString(string: "  "))
            attrStr.append(NSAttributedString(string: "\(duration)H", attributes: [.font: UIFont(name: "Bangla Sangam MN", size: 15)!]))
            durationLabel.attributedText = attrStr
        }
    }
    
    var planetColor: UIColor? {
        didSet {
            planetCircle.backgroundColor = planetColor
        }
    }
    
    private var nameLabel: UILabel!
    private var durationLabel: UILabel!
    private var planetCircle: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        planetCircle = UIView(frame: CGRect(x: 20, y: 15, width: 70, height: 70))
        planetCircle.layer.cornerRadius = 0.5 * planetCircle.frame.height
        planetCircle.clipsToBounds = true
        contentView.addSubview(planetCircle)
        
        let glossCircle = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        glossCircle.backgroundColor = .white
        glossCircle.layer.cornerRadius = 0.5 * glossCircle.frame.height
        glossCircle.alpha = 0.1
        planetCircle.addSubview(glossCircle)
        
        nameLabel = UILabel(frame: CGRect(x: 100, y: 20, width: frame.width, height: 30))
        nameLabel.font = UIFont(name: "DIN Alternate", size: 30)
        nameLabel.textColor = .white
        contentView.addSubview(nameLabel)
        
        durationLabel = UILabel(frame: CGRect(x: 100, y: nameLabel.frame.maxY, width: frame.width, height: 30))
        durationLabel.textColor = UIColor(rgb: 0xDEDFE0)
        contentView.addSubview(durationLabel)
        
        accessoryType = .disclosureIndicator
        accessoryView?.tintColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
