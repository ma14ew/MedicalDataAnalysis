//
//  RootViewController.swift
//  FirstProjectCode
//
//  Created by Матвей Матюшко on 12.04.2023.
//

import Foundation
import UIKit

class RootViewController: UIViewController {
    private var current: UIViewController
    init() {
        self.current = OnboradingViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        logIn()
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    func showOnboardLoginScreen() {
        let onBoardingViewController = OnboradingViewController()
        let new = UINavigationController(rootViewController:onBoardingViewController )
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
    }
    func showMainScreen() {
        let mainViewController = MainViewController()
        let new = UINavigationController(rootViewController: mainViewController)
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
    }
    private func logIn() {
        if UserDefaults.standard.bool(forKey: Keys.accesToken) {
            showMainScreen()
        } else {
            showOnboardLoginScreen()
        }
    }
}
