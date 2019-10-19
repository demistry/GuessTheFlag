//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by David Ilenwabor on 18/10/2019.
//  Copyright © 2019 Davidemi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedFlag = 0
    @State private var isAlertShowing = false
    @State private var scoreTitle = ""
    @State private var correctAnswer = Int.random(in: 0...5)
    @State private var currentScore : Int = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing : 30){
                VStack{
                    Text("Tap the flag of").foregroundColor(.white)
                    Text("\(countries[correctAnswer])").foregroundColor(.white)
                        .font(.largeTitle).fontWeight(.black)
                }
                
                ForEach(0..<5){number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number]).renderingMode(.original)
                            .clipShape(Capsule()).overlay(Capsule().stroke(Color.white,lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                
                Text("Current score is \(currentScore)").foregroundColor(.white)
                    .bold()
                Spacer()
                }
            
            .alert(isPresented: $isAlertShowing) {
                Alert(title: Text(scoreTitle), message: Text("Your score is \(currentScore)"), dismissButton: .default(Text("Continue"), action: {
                    self.askQuestion()
                }))
            }
        }
    }
    
    func flagTapped(_ number : Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            currentScore += 1
        } else{
            scoreTitle = "Wrong thats the flag of \(countries[number])"
        }
        isAlertShowing = true
    }
    
    func askQuestion(){
        correctAnswer = Int.random(in: 0...2)
        countries = countries.shuffled()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
