//
//  ToolCellView.swift
//  SevenWondersGuide
//
//  Created by Johnnan Monzon on 10/21/20.
//

import SwiftUI

struct ToolCellView: View {
    
    var destinationView : AnyView
    var label : String
    var imagePath : String
    var geometry : GeometryProxy
    var fill : LinearGradient
    
    var body: some View {
        
        NavigationLink(
            destination: destinationView,
            label: {
                Image(imagePath)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width / 2.5, height: geometry.size
                            .height / 2.5)
                    .cornerRadius(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(fill)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.clear)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.clear,Color.clear, Color.black]), startPoint: .top, endPoint: .bottom))
                    )
                    .overlay(
                        VStack{
                            Spacer()
                            HStack{
                                Text(label)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.leading, 5)
                                    .padding(.bottom, 10)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.1)
                                    .allowsTightening(true)

                                Spacer()
                            }
                        }
                    )
                    .shadow(radius: 10)
                    .padding()
                

            })
        }
}

struct ToolCellView_Previews: PreviewProvider {
    
    static var view : Text = Text("Destination")
    
    static var previews: some View {
        GeometryReader { geometry in
            NavigationView{
                VStack{
                    Spacer()
                    ScrollView(.vertical){
                        HStack{
                            ToolCellView(destinationView: AnyView(view), label: "AR Science Calculator", imagePath: "tablet", geometry: geometry, fill: LinearGradient(gradient: Gradient(colors: [Color.green, Color.black, Color.green]), startPoint: .topTrailing, endPoint: .bottomLeading))
                            Spacer()
                        }
                    }
                    
                }
            }
        }
        
    }
}
