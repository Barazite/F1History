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
            ProgressView("Loading")
                .onAppear(perform: {
                    self.presenter.fetchCircuits()
                })
        }else{
            List{
                ForEach(self.presenter.arrayCircuits){ item in
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


struct CircuitsView_Previews: PreviewProvider {
    static var previews: some View {
        CircuitsView()
    }
}

struct CircuitCard: View {
    
    var circuit: Circuits
    
    init(item: Circuits) {
        self.circuit = item
    }
    
    var body: some View{
            VStack{
                Text(circuit.circuitName ?? "").font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 70)
                    .padding()
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1).padding(.all, 5))
        }
    
}
