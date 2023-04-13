//
//  ViewController.swift
//  FirstProject+Code
//
//  Created by Матвей Матюшко on 20.03.2023.
//

import UIKit
import HealthKit
import SwiftUI

class MainViewController: UIViewController {
    let root = RootViewController()
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
        text.text = configureData()
        return text
    }()
    
    private lazy var healthButton: UIButton = {
        let button = UIButton(primaryAction: UIAction{ _ in
            self.healthText.text = self.configureData()
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
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
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
                print(authorized)
            }
            else {
                print("HealthKit authorization denied!")
                if error != nil {
                    print("\(String(describing: error))")
                }
            }
        }
    }
    
    private func createAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: "Ошибка",
            message: "Нет доступа к данным, нужно дать доступ в настройках",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { (action:UIAlertAction!) in

        }))
        return alert
    }
    
    private func configureData() -> String {
        guard let profile = health.readProfile().age else {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let alert = self.createAlert()
                self.present(
                    alert,
                    animated: true,
                    completion: nil
                )
            }
            return "error"
        }
        let newDate = DateFormatter()
        newDate.dateFormat = "dd-MM-yyyy"
        let stringDate = newDate.string(from: profile)
        return stringDate
    }

}



