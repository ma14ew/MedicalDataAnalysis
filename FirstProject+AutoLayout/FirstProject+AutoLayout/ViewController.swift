//
//  ViewController.swift
//  FirstProject+AutoLayout
//
//  Created by Матвей Матюшко on 17.03.2023.
//


import UIKit
import HealthKit


class ViewController: UIViewController {
    
    let health = Health()
    
//    private lazy var verticalStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.spacing = 16
//        stackView.addArrangedSubview(healthText)
//        stackView.addArrangedSubview(healthButton)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
//    
//    private lazy var healthText: UILabel = {
//        let text = UILabel(frame: CGRect(x: 220, y: 220, width: 100, height: 100))
//        let profile = health.readProfile().age
//        let newDate = DateFormatter()
//        newDate.dateFormat = "dd-MM-yyyy"
//        let stringDate = newDate.string(from: profile ?? Date.now)
//        text.text = stringDate
//        return text
//    }()
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var healthButton: UIButton!
    
    @IBAction func buttonAction(sender: UIButton!) {
        
        let profile = health.readProfile().age
        let newDate = DateFormatter()
        newDate.dateFormat = "dd-MM-yyyy"
        let stringDate = newDate.string(from: profile ?? Date.now)
        dateLabel.text = stringDate
        
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        health.authorizeHealthKit { (authorized,  error) -> Void in
            if authorized {
                print("HealthKit authorization received.")
            }
            else
            {
                print("HealthKit authorization denied!")
                if error != nil {
                    print("\(String(describing: error))")
                }
            }
            
            
        }
    }
}

