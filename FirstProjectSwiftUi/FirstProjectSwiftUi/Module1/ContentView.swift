//
//  ContentView.swift
//  FirstProject+SwiftUi
//
//  Created by Матвей Матюшко on 20.03.2023.
//

import SwiftUI


struct ContentView: View {
    @State var buttonTitle: String = "Button Not Clicked"
    var body: some View {
        
        VStack {
            Image("first")
            Text("Все данные о Вашем здоровье в одном месте")
            Button("Next") {
                
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
