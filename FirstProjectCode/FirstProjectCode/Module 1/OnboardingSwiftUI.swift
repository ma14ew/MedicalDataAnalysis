//
//  OnboardingSwiftUI.swift
//  FirstProjectCode
//
//  Created by Матвей Матюшко on 26.03.2023.
//

import Foundation
import SwiftUI

struct LoginVC: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: LoginViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> LoginViewController {
        return LoginViewController()
    }
}

struct ContentView: View {
    @State var tabSelection = 0
    @State var firstAlpha = 0.0
    @State var secAlpha = 0.0
    @State private var selectedIndex = 0
    let vc = OnboradingViewController()
    var body: some View {
        NavigationView {
            TabView {
                VStack(alignment: .center, spacing: 30) {
                    Image("first")
                    Text("Все ваши данные о здоровье в одном месте")
                    NavigationLink("Начать!"){
                        LoginVC()
                    }
                }
                .opacity(firstAlpha)
                .onAppear {
                    let animation = Animation.easeInOut(duration: 1)
                    withAnimation(animation) {
                        firstAlpha = 1
                    }
                }
                .onDisappear {
                    let animation = Animation.easeInOut(duration: 1)
                    withAnimation(animation) {
                        firstAlpha = 0
                    }
                }
                
                VStack(alignment: .center, spacing: 30) {
                    Image("second")
                    Text("Следите за своим здоровьем")
                        .lineLimit(3)
                    NavigationLink("Начать!"){
                        LoginVC()
                    }
                }
                .opacity(secAlpha)
                .onAppear {
                    let animation = Animation.easeInOut(duration: 1)
                    withAnimation(animation) {
                        secAlpha = 1
                    }
                }
                .onDisappear {
                    let animation = Animation.easeInOut(duration: 1)
                    withAnimation(animation) {
                        secAlpha = 0
                    }
                }
                
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .animation(.easeOut(duration: 0.2), value: tabSelection)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
