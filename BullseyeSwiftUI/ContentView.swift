//
//  ContentView.swift
//  BullseyeSwiftUI
//
//  Created by Victor Rivera on 12/14/19.
//  Copyright © 2019 Victor Rivera. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var target = Int.random(in: 1...100)
    @State var sliderValue: Double = 50.0
    @State var score = 0
    @State var round = 1
    
    let midnightBlue = Color(red: 0.0/255.0, green: 51.0/255.0, blue: 102.0/255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.white)
            .modifier(Shadow())
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
                .modifier(Shadow())
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    var body: some View {
        VStack {
            // Target row
            Spacer()
            HStack {
                Text("Put the bullseye as close as you can to: ")
                    .modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            Spacer()
            
            // Slider row
            HStack {
                Text("1")
                .modifier(LabelStyle())
                Slider(value: self.$sliderValue, in: 1...100)
                    .accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }

            Spacer()

            // Button Rows
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text("Hit Me!")
                .modifier(ButtonLargeTextStyle())
            }
            .alert(isPresented: self.$alertIsVisible) {
                () -> Alert in
                return Alert(title: Text(alertTitle()), message: Text("The slider's value is \(getSliderValueRounded()).\n"
                    + "You scored \(pointsForCurrentRound()) points this round."), dismissButton: .default(Text("Dismiss")) {
                        self.score += self.pointsForCurrentRound()
                        self.target = Int.random(in: 1...100)
                        self.round += 1
                    })
            }
            .background(Image("Button"))
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
            Spacer()

            // Score row
            HStack {
                Button(action: {
                    self.startNewGame()
                }){
                    HStack {
                        Image("StartOverIcon")
                        Text("Start Over")
                        .modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button"))
                .modifier(Shadow())
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()){
                    HStack {
                        Image("InfoIcon")
                        Text("Info")
                        .modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button"))
                .modifier(Shadow())
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
        .navigationBarTitle("Bullseye")
    }
    
    func getSliderValueRounded() -> Int {
        Int(self.sliderValue.rounded())
    }
    
    func amountOff() -> Int {
        abs(self.target - getSliderValueRounded())
    }
    
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let diff = amountOff()
        let bonus: Int
        if diff == 0 {
            bonus = 100
        } else if diff == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        return maximumScore - diff + bonus
    }
    
    func alertTitle() -> String {
        let diff = amountOff()
        let title: String
        if diff == 0 {
            title = "Perfect!"
        } else if diff < 5 {
            title = "You almost had it!"
        } else if diff <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
    
    func startNewGame() {
        score = 0
        round = 1
        sliderValue = 50.0
        target = Int.random(in: 1...100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
