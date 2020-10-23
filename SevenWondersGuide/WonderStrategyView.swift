//
//  WonderStrategyView.swift
//  SevenWondersGuide
//
//  Created by Johnnan Monzon on 10/22/20.
//

import SwiftUI

struct WonderStrategy {
    var name : String
    var tldrA : String
    var tldrB : String
    var strategyA : String
    var strategyB : String
}

struct WonderStrategyView: View {
    
    @State var isSideA : Bool = true
    
    var wonder : WonderStrategy
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                
                Image(wonder.name.lowercased())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: 250)
                    .clipped()
                    .edgesIgnoringSafeArea(.top)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.clear)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.black,Color.clear, Color.clear, Color.black]), startPoint: .top, endPoint: .bottom)))

                HStack {
                    
                    Text(wonder.name + (isSideA ? " A" : " B"))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    
                    Button(action: {
                        isSideA.toggle()
                    }, label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .resizable()
                            .frame(width: 40, height: 30)
                            .padding(.leading)
                    })
                    
                    Spacer()
                }
                .padding()
                
                (Text("TL;DR " ).fontWeight(.bold) + Text(isSideA ? wonder.tldrA : wonder.tldrB))
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text("Strategy")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal)
                
                Text(isSideA ? wonder.strategyA : wonder.strategyB)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
        
        
    }
}

struct WonderStrategyView_Previews: PreviewProvider {
    static var previews: some View {
        WonderStrategyView(wonder: WonderStrategy(name: "Alexandria", tldrA: "tldr", tldrB: "tldr", strategyA: "Get blues", strategyB: "b side"))
    }
}
