//
//  ScienceSymbolCountView.swift
//  SevenWondersGuide
//
//  Created by Johnnan Monzon on 10/20/20.
//

import SwiftUI

struct ScienceSymbolCountRowView: View {
    
    @Binding var symbolCount : [Symbol : Int]
    
    var symbol : Symbol
    
    var body: some View {
        return HStack{
            Image(symbol.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
            
            Text(String(symbolCount[symbol] ?? 0))
                .padding(.leading, 20)
        }
    }
    
}

struct ScienceSymbolCountView: View {
    
    @Binding var symbolCount : [Symbol : Int]
    
    var body: some View {
        
        return VStack{
            ScienceSymbolCountRowView(symbolCount: self.$symbolCount, symbol: Symbol.wheel)
            ScienceSymbolCountRowView(symbolCount: self.$symbolCount, symbol: Symbol.compass)
            ScienceSymbolCountRowView(symbolCount: self.$symbolCount, symbol: Symbol.tablet)
        }
                        
    }
}

struct ScienceSymbolCountView_Previews: PreviewProvider {
    
    @State static var symbolCount : [Symbol : Int] = [Symbol.wheel: 1, Symbol.compass: 2, Symbol.tablet: 0, Symbol.wild: 0]

    static var previews: some View {
        ScienceSymbolCountView(symbolCount: $symbolCount)
    }
    
}
