//
//  OnboradingViewController.swift
//  FirstProjectCode
//
//  Created by Матвей Матюшко on 26.03.2023.
//

import SwiftUI

class OnboradingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftUIView = ContentView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        
        setupViews(hostingController.view)
        setupConstraints(hostingController.view)
        
        hostingController.didMove(toParent: self)
        hostingController.willMove(toParent: self)
    }
    
    private func setupViews(_ newView: UIView) {
        view.addSubview(newView)
    }
    
    private func setupConstraints(_ newView: UIView) {
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        newView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func pushVC() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}


