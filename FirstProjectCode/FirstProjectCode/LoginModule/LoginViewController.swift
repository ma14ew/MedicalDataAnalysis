//
//  LoginViewController.swift
//  FirstProjectCode
//
//  Created by Матвей Матюшко on 12.04.2023.
//

import UIKit

enum Keys {
    static let accesToken = "accesToken"
}

class LoginViewController: UIViewController {
    let mainVC = MainViewController()
    let health = Health()
    private lazy var LoginButton: UIButton = {
        let button = UIButton(primaryAction: UIAction { _ in
            self.healthAuth()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Разрешить доступ к Health", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.cornerRadius = 19
        button.clipsToBounds = true
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(LoginButton)
    }
    private func setupConstraints() {
        LoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LoginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    private func healthAuth() {
        health.authorizeHealthKit { (authorized,  error) -> Void in
            if authorized {
                UserDefaults.standard.set(true, forKey: Keys.accesToken)
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(self.mainVC, animated: true)
                }
                print("HealthKit authorization received.")
            }
            else {
                print("HealthKit authorization denied!")
                if error != nil {
                    print("\(String(describing: error))")
                }
            }
        }
    }
}
