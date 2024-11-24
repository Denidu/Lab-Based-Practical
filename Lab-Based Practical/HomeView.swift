//
//  HomeView.swift
//  Lab-Based Practical
//
//  Created by Denidu Gamage on 2024-11-23.
//

import SwiftUI

enum MathOperator: String, CaseIterable{
    case addition = "+"
    case substraction = "-"
    case multiplication = "*"
    case devision = "/"
}

struct HomeView: View {
    
    @State private var mathOperator : MathOperator = MathOperator.allCases.randomElement()!
    @State private var num1 : Int = Int.random(in: 1..<10)
    @State private var num2 : Int = Int.random(in: 1..<10)
    @State private var userInput:String = ""
    @State private var points: Int = 0
    @State private var message : String = ""
    @AppStorage("selectedFontSize") private var selectedFontSize : Double = 0.0
    @AppStorage("selectedColor") private var selectedColor : String = "#000000"
    
    var body: some View {
        NavigationStack {
            VStack() {
                Text("Guess The Answer!").font(.largeTitle).bold().foregroundColor(Color(hex: selectedColor))
                
                Text("What is \(num1) \(mathOperator.rawValue) \(num2) ? ")
                    .font(.system(size: 30))
                    .bold()
                    .padding()
                    
                HStack{
                    TextField("Answer", text: $userInput).padding()
                    
                    Button("Submit") {
                        checkAnswer()
                    }.padding()
                        .buttonStyle(.bordered)
                        .tint(.blue)
                    
                }.frame(width: 340, height: 60)
                    .overlay {
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.black, lineWidth: 2)
                    }
                    .padding()
                
                Text("\(message)").padding()
                
                Text("\(points)")
                    .font(.system(size: 100))
                    .bold()
                Text("Intructions").padding().font(.system(size: selectedFontSize))
                
                Text("Submit the correct answer and gain 1 point. Submit a wrong answer or press on Next and you will lose 1 point").font(.system(size: selectedFontSize))
                
                Spacer()
                
                Button("Next"){
                    randomQuestion()
                    userInput = ""
                    message = ""
                }.padding()
                    .buttonStyle(.bordered)
                    .tint(.green)
                    .bold()
                
            }
            .padding()
            .onAppear{
                randomQuestion()
            }
        }
    }
    func randomQuestion(){
        num1 = Int.random(in: 1..<10)
        num2 = Int.random(in: 1..<10)
        mathOperator = MathOperator.allCases.randomElement()!
    }
    
    func checkAnswer(){
        guard let answer = Int(userInput) else{return}
        
        let correctAnswer : Int
        switch mathOperator{
        case.addition:
            correctAnswer = num1+num2
        case.substraction:
            correctAnswer = num1 - num2
        case.multiplication:
            correctAnswer = num1 * num2
        case.devision:
            if num2 == 0 {
                randomQuestion()
            }
                correctAnswer = num1/num2
        }
        
        if answer == correctAnswer {
            points += 1
            message = "Correct Answer! Well Done"
        }else{
            points -= 1
            message = "Incorrect Answer! The correct answer is \(correctAnswer)"
        }
        
    }
}

#Preview {
    HomeView()
}
