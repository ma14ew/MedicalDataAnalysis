//
//  ContentView.swift
//  FirstProject+SwiftUi
//
//  Created by Матвей Матюшко on 20.03.2023.
//

import SwiftUI


struct ContentView: View {
    @State var buttonTitle: String = "Button Not Clicked"
    let health = Health()
    func healthLoad() {
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
    var body: some View {
        VStack {
           Text(buttonTitle)
            Button("Обновить данные"){
                healthLoad()
                let profile = health.readProfile().age
                let newDate = DateFormatter()
                newDate.dateFormat = "dd-MM-yyyy"
                buttonTitle = newDate.string(from: profile ?? Date.now)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
