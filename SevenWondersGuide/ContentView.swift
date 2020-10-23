//
//  ContentView.swift
//  SevenWondersGuide
//
//  Created by Johnnan Monzon on 10/20/20.
//

import SwiftUI

struct ContentView: View {
    
    var isPreview : Bool
    
    init(isPreview: Bool = false) {
        UINavigationBar.appearance().backgroundColor = .clear
        self.isPreview = isPreview
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView{
                VStack{
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            
                            ToolCellView(destinationView:AnyView(WonderSelectionView()), label: "Wonder Strategy", imagePath: "wheel", geometry: geometry, fill: LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .topTrailing, endPoint: .bottomLeading))
                            
                            ToolCellView(destinationView:AnyView(ARScienceCalculatorView(isPreview: isPreview)), label: "Science Calculator", imagePath: "tablet", geometry: geometry, fill: LinearGradient(gradient: Gradient(colors: [Color.green, Color.black, Color.green]), startPoint: .topTrailing, endPoint: .bottomLeading))
                        
                            ToolCellView(destinationView:AnyView(Text("Point Calculator TBD")), label: "Point Calculator", imagePath: "compass", geometry: geometry, fill: LinearGradient(gradient: Gradient(colors: [Color.purple, Color.black]), startPoint: .topTrailing, endPoint: .bottomLeading))
                        }
                    }
                    
                    .navigationBarTitle("7 Wonders Guide")
                    .navigationBarItems(
                        trailing: NavigationLink(
                            destination: AboutView(),
                            label: {
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            })
                    )
                    
                    Spacer()
                    
                    
                }
            }
            .accentColor(.white)

        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isPreview: true)
    }
}
