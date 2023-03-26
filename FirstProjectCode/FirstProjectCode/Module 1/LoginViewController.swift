//
//  ViewController.swift
//  FirstProject+Code
//
//  Created by Матвей Матюшко on 20.03.2023.
//

import UIKit
import HealthKit
import SwiftUI

final class LoginViewController: UIViewController {
    
    let health = Health()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.addArrangedSubview(healthText)
        stackView.addArrangedSubview(healthButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var healthText: UILabel = {
        let text = UILabel(frame: CGRect(x: 220, y: 220, width: 100, height: 100))
        let profile = health.readProfile().age
        let newDate = DateFormatter()
        newDate.dateFormat = "dd-MM-yyyy"
        let stringDate = newDate.string(from: profile ?? Date.now)
        text.text = stringDate
        return text
    }()
    
    private lazy var healthButton: UIButton = {
        let button = UIButton(primaryAction: UIAction{ _ in
            let profile = self.health.readProfile().age
            let newDate = DateFormatter()
            newDate.dateFormat = "dd-MM-yyyy"
            let stringDate = newDate.string(from: profile ?? Date.now)
            self.healthText.text = stringDate
        })
        button.setTitle("reload data", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.cornerRadius = 19
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        healthAuth()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(verticalStackView)
    }
    private func setupConstraints() {
        verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func healthAuth() {
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



