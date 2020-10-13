//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sofia Rodriguez Morales on 10/12/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy","Monaco"].shuffled()
    @State private var correctAnswer = Int.random(in: 0..<3)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.white,.blue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing:30){
                Text("Your score is \(score)")
                    .font(.title)
                VStack{
                    Text("Tap the flag of")
                        .foregroundColor(.black)
                    Text("\(countries[correctAnswer])")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                }
                
                ForEach(0..<3) {number in
                Button(action:{
                    //flag tapped
                    flagTapped(answer: number)
                }){
                    Image(self.countries[number])
                        .renderingMode(.original)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.black))
                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                }}
            }
            .alert(isPresented: $showingScore){
                Alert(title: Text("\(scoreTitle)"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Next")){
                    askQuestion()
                })
            }
           
        }
        
        
    }
    
    func flagTapped(answer: Int){
        if (answer == correctAnswer){
            scoreTitle = "Correct"
            score+=1
        }else{
            scoreTitle = "Incorrect"
            if (score > 0) {
                score-=1
            }
            
        }
        showingScore = true
    }
    func askQuestion(){
        print("Ask question")
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
