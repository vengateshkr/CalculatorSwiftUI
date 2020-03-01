//
//  ContentView.swift
//  CalculatorSwiftUI
//
//  Created by Venkatesh on 2/29/20.
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var userIsTyping = false
    @State var userInput = "0"
    @State var calcBrain = CalcBrain()
    
    let buttons : [[ButtonModel]] = [
        [.init(title: "AC",color: Color.orange),
         .init(title: "±",color: Color.orange),
         .init(title: "%",color: Color.orange),
         .init(title: "÷",color: Color.orange)
        ],
        
        [.init(title: "7"),
         .init(title: "8"),
         .init(title: "9"),
         .init(title: "x",color: Color.orange)
        ],
        
        [.init(title: "4"),
         .init(title: "5"),
         .init(title: "6"),
         .init(title: "-",color: Color.orange)
        ],
        [.init(title: "3"),
         .init(title: "2"),
         .init(title: "1"),
         .init(title: "+",color: Color.orange),
        ],
        [.init(title: "0"),
         .init(title: "."),
         .init(title: "=",color: Color.orange),
        ]
    ]
    
    var body: some View {
        let margin : CGFloat = 20
        return VStack(alignment:.center) {
            HStack {
                Spacer()
                Button(action: {}) {
                    Text(userInput)
                        .font(.largeTitle)
                }.foregroundColor(.white)
                    .frame(height: 200, alignment: .trailing)
            }
            VStack(alignment: .center, spacing: margin) {
                ForEach(buttons, id: \.self) { buttons in
                    GeometryReader { geometry in
                        return self.calculateRow(screenWidth: geometry.size.width, spacing: 2, buttons: buttons)
                    }
                }
            }.padding(5)
        }.background(Color.black)
        
    }
    
    func calculateRow(screenWidth:CGFloat,spacing:CGFloat, buttons:[ButtonModel]) -> some View {
        return HStack(alignment: .center, spacing: spacing) {
            ForEach(buttons) { button in
                Text(button.title)
                    .frame(width:
                        button.title != "0" ? (screenWidth - spacing * 5) / 4 : (screenWidth - spacing) / 4 * 2 + spacing
                        , height: (screenWidth - spacing) / 4)
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                    .background(button.color)
                    .cornerRadius(100)
                    .onTapGesture {
                        self.touch(button.title)
                }
            }
        }
    }
    
    private func touch(_ symbol:String) {
        if Int(symbol) != nil || symbol == "." {
            touchDigit(symbol)
        } else {
            touchOperator(symbol)
        }
    }
    
    private func touchDigit(_ digit:String) {
        if userIsTyping {
            userInput += digit
        } else {
            userInput = digit
            userIsTyping = true
        }
    }
    
    private func touchOperator(_ digit:String) {
        if userIsTyping {
            calcBrain.setOper(Double(userInput)!)
            userIsTyping = false
        }
        
        
        calcBrain.performOper(digit)
        
        if let res = calcBrain.res {
            userInput = String(res)
        }
    }
}


struct CalculatorButton : View {
    var body: some View {
        Text("title")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ButtonModel : Identifiable,Hashable {
    let id = UUID()
    let title : String
    var color = Color(red: 0.2, green: 0.2, blue: 0.2)
}
