//
//  AboutView.swift
//  BullseyeSwiftUI
//
//  Created by Victor Rivera on 12/14/19.
//  Copyright © 2019 Victor Rivera. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let beige = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)
    
    struct TextViewStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .foregroundColor(Color.black)
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .padding(.bottom, 20)
        }
    }
    
    var body: some View {
        Group {
        VStack {
            Text("🎯 Bullseye")
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .foregroundColor(Color.black)
                .padding(.top, 20)
                .padding(.bottom, 20)
            Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.")
                .modifier(TextViewStyle())
            Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.")
                .modifier(TextViewStyle())
            Text("Enjoy")
                .modifier(TextViewStyle())
        }
        .navigationBarTitle("About Bullseye")
        .background(beige)
      }
        .background(Image("Background"), alignment: .center)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
