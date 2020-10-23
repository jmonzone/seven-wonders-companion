//
//  ARScienceCalculatorView.swift
//  SevenWondersGuide
//
//  Created by Johnnan Monzon on 10/21/20.
//

import SwiftUI

struct ARScienceCalculatorView: View {
    
    @State private var points = 0
    @State private var reset : ResetState = ResetState.Null
    @State private var symbolCount : [Symbol : Int] = [Symbol.wheel: 0, Symbol.compass: 0, Symbol.tablet: 0]
    @State private var wildCount : Int = 0
    
    private var isPreview : Bool
    
    init(isPreview : Bool = false) {
        self.isPreview = isPreview
    }
    
    var body: some View {
        VStack {
            ZStack {
                
                if !isPreview {
                    ARScienceCalculator(points: self.$points, reset: self.$reset, symbolCount: self.$symbolCount, wildCount: self.$wildCount)
                }
                    
                VStack {
                    
                    Text(points == 0 ? "Scan Science Cards" : String(points))
                        .font(.largeTitle)
                        .padding(.top, 150)
                    
                    Spacer()
                    
                    HStack {
                                                
                        ScienceSymbolCountView(symbolCount: self.$symbolCount)
                            .padding(.leading, 20)

                        Spacer()
                        
                        Button(action: {
                            reset = ResetState.Start
                        }) {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                            
                        }
                        
                        
                        Spacer().frame(width: 50)
                    }
                    .padding(.bottom, 50)
                    
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ARScienceCalculatorView_Previews: PreviewProvider {
    
    static var previews: some View {
        ARScienceCalculatorView(isPreview: true)
    }
    
}
