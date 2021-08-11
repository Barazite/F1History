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
            ProgressView(LocalizedKeys.General.progressText)
                .onAppear(perform: {
                    self.presenter.fetchSeasons()
                })
        }else{
            ScrollView{
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2)){
                    ForEach(self.presenter.arraySeasons){ season in
                        NavigationLink(
                            destination: SeasonsDetailsCoordinator.buildView(season: season.season ?? "")){
                            SeasonCard(item: season)
                                .padding()
                                .onAppear(perform: {
                                    if self.presenter.arraySeasons.last?.id == season.id {
                                        if !self.presenter.finalList{
                                            self.presenter.fetchSeasons()
                                        }
                                    }
                                })
                        }
                    }
                }
            }
        }
    }
}

struct SeasonsView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonsView()
    }
}

struct SeasonCard: View{
    
    var item: Seasons
    
    var body: some View{
        ZStack{
            Text(item.season!)
                .foregroundColor(Color(red: 239/255, green: 184/255, blue: 16/255))
                .font(.title)
            Image("y2")
                .resizable()
                .frame(width: 100, height: 100)
        }
    }
}
