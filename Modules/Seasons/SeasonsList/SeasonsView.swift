//
//  SeasonsView.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/7/21.
//

import SwiftUI

struct SeasonsView: View {
    
    @ObservedObject var presenter = SeasonsPresenterImpl()
    
    var body: some View {
        
        if self.presenter.arraySeasons.isEmpty{
            VStack(alignment: .center){
                ProgressView("Loading")
            }
            .onAppear(perform: {
                self.presenter.fetchSeasons()
            })
        }else{
            List{
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2)){
                    ForEach(self.presenter.arraySeasons){ item in
                        NavigationLink(
                            destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/){
                                ZStack{
                                    Text(item.season!)
                                        .foregroundColor(Color(red: 239/255, green: 184/255, blue: 16/255))
                                        .font(.title)
                                    Image("y2")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }
                                //background(Color.gray)
                                .padding()
                            }
                    }
                }
                if !self.presenter.finalList{
                    HStack{
                        Spacer()
                        ProgressView("Loading")
                        Spacer()
                    }
                    .onAppear(perform: {
                        self.presenter.fetchSeasons()
                    })
                }
            }
            .listStyle(InsetListStyle())
            .navigationTitle("Seasons")
        }
    }
}

struct SeasonsView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonsView()
    }
}
