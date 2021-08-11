//
//  CircuitsView.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 20/7/21.
//

import SwiftUI

struct CircuitsView: View {
    
    @ObservedObject var presenter = CircuitsPresenterImpl()
    
    var body: some View {
        
        if self.presenter.arrayCircuits.isEmpty{
            ProgressView(LocalizedKeys.General.progressText)
                .onAppear(perform: {
                    self.presenter.fetchCircuits()
                })
        }else{
            List{
                ForEach(self.presenter.arrayCircuits){ item in
                    NavigationLink(
                        destination: CircuitDetailsCoordinator.buildView(circuit: item)){
                        CircuitCard(item: item)
                            .onAppear(perform: {
                                if self.presenter.arrayCircuits.last?.id == item.id {
                                    if !self.presenter.finalList{
                                        self.presenter.fetchCircuits()
                                    }
                                }
                            })
                    }
                }
            }
        }
    }
}


struct CircuitsView_Previews: PreviewProvider {
    static var previews: some View {
        CircuitsView()
    }
}

struct CircuitCard: View {
    
    var circuit: Circuits
    @ObservedObject var imageManager = ImageManager()
    
    init(item: Circuits) {
        self.circuit = item
        self.imageManager.getFlagFromUrl(imageUrl: self.imageManager.getUrl(nation: item.country ?? ""))
    }
    
    var body: some View{
            VStack{
                Text(circuit.circuitName ?? "").font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Image(uiImage: (self.imageManager.flag.isEmpty ? UIImage(systemName: "photo") : UIImage(data: self.imageManager.flag))!)
                    .resizable()
                    .frame(width: 100, height: 80)
                    .scaledToFill()
                    .padding()
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1).padding(.all, 5))
        }
    
}
