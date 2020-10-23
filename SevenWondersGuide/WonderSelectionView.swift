//
//  WonderStrategy.swift
//  SevenWondersGuide
//
//  Created by Johnnan Monzon on 10/22/20.
//

import SwiftUI


struct WonderSelectionView: View {
    
    let data = [
        WonderStrategy(name: "Alexandria", tldrA: "Get gold, war, and blue cards. The forum card is helpful.", tldrB: "Get brown, green, and blue cards.", strategyA: "Build the second stage of your wonder ASAP. Avoid getting another gray glass card for the last stage of your wonder because you won't need your second glass for anything else. Instead getting the forum will help you a lot.", strategyB: "Get one of the other gray cards and work towards science. Build the second stage of your wonder for the last gray card. Watch out for players to see if going all out on science is a good idea."),
        WonderStrategy(name: "Babylon", tldrA: "Get gray, green, and blue cards.", tldrB: "Get gray, war, and green cards.", strategyA: "Work towards science early on and try to grab each gray card. Recognize whether to go big or small on science. To build your wonder, utilize the resource cards in the second age.", strategyB: "Work towards grabbign each of the gray cards and work towards science. Adapt your strategy to whatever last card you manage to snatch."),
        WonderStrategy(name: "Ephesos", tldrA: "Get gold, war, and blue cards. The forum card is helpful", tldrB: "Get gray, gold, green, and blue cards.", strategyA: "Watch out to see if collecting tablets is an easy move, but try to get access to another paper. Use the second stage of your wonder to sustain you through gold cards.", strategyB: "Work towards grabbign each of the gray cards and work towards science. Work towards science and use the gold of your wonder to sustain your gold cards."),
        WonderStrategy(name: "Gizah", tldrA: "Get brown, war, and blue cards.", tldrB: "Get brown, war, and blue cards.", strategyA: "Your resources put you at an advantage for war and blue cards. Either don't get too many brown cards and get some grays, or get all the brown cards and use the money to pay for grays. ", strategyB: "This strategy isn't too different from side A, but you might need to get more resources, which means gray cards will be out of the picture for you."),
        WonderStrategy(name: "Halikarnassos", tldrA: "Get gold, war, and science cards.", tldrB: "Get gray, war, and science cards.", strategyA: "Work towards science early on. Avoid getting too many gray cards and lookout for the Forum card. You can always sell a card and retrieve it later through the second stage power.", strategyB: "Work towards science via all the gray cards, full out. You can always sell a card and retrieve it later through the second stage power."),
        WonderStrategy(name: "Olympia", tldrA: "Get gold, war, and blue cards.", tldrB: "Get gray, blue, and science cards.", strategyA: "Work towards science early on. Avoid getting too many gray cards and lookout for the Forum card. You can always sell a card and retrieve it later through the second stage power.", strategyB: "Work towards science via all the gray cards, full out. You can always sell a card and retrieve it later through the second stage power."),
        WonderStrategy(name: "Rhodos", tldrA: "Get brown, war, and blue cards.", tldrB: "Get brown, war, and blue cards.", strategyA: "There is no reason you should be losing war, as these are easy points. If opponents are not contesting, power up through the blue cards.", strategyB: "There is more flexibility with this side, and you can potentially get going on science alongside blue, if no one is contesting with war.")
    ]
    
    let layout = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout, spacing: 20) {
                ForEach(data, id: \.name) { item in
                    NavigationLink(
                        destination: WonderStrategyView(wonder: item),
                        label: {
                            VStack {
                                Image(item.name.lowercased())
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .clipped()
                                    .cornerRadius(20)
                                    .background(RoundedRectangle(cornerRadius: 20))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.clear)
                                            .background(
                                                LinearGradient(gradient: Gradient(colors: [Color.clear,Color.clear, Color.clear, Color.black]), startPoint: .top, endPoint: .bottom)))
//                                    .padding()
                                
                                Text(item.name)
                                    .foregroundColor(.white)
                            }
                        })
                    
                }
            }
            .padding()
        }
        .background(Color.black)
        .navigationTitle("Select a Wonder")
        
    }
}

struct WonderStrategy_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WonderSelectionView()
        }
    }
}
