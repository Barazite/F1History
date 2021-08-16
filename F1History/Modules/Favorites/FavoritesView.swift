//
//  FavoritesView.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 14/8/21.
//

import SwiftUI

struct FavoritesView: View {
    
    @Binding var showFavorites: Bool
    
    var seasons : [Seasons]
    var drivers: [Drivers]
    var constructors: [Constructors]
    var circuits: [Circuits]
    
    init(showFavorites: Binding<Bool>){
        self._showFavorites = showFavorites
        self.seasons = FavoritesManager.shared.getSeasons() ?? []
        self.drivers = FavoritesManager.shared.getDrivers() ?? []
        self.constructors = FavoritesManager.shared.getConstructors() ?? []
        self.circuits = FavoritesManager.shared.getCircuits() ?? []
    }
        
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    DisclosureGroup{
                            ForEach(self.seasons){ season in
                                NavigationLink(
                                    destination: SeasonsDetailsCoordinator.buildView(season: season)){
                                    SeasonCard(item: season)
                                }
                                Divider()
                            }
                    
                    }label:{
                        HStack{
                            Image("Seasons")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(LocalizedKeys.F1Text.seasonsText)
                        }
                    }.padding()
                    
                    DisclosureGroup{
                            ForEach(self.drivers){ driver in
                                DriverCard(item: driver)
                                Divider()
                            }
                    
                    }label:{
                        HStack{
                            Image("Drivers")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(LocalizedKeys.F1Text.driversText)
                        }
                    }.padding()
                    //.background(Color.red)
                    
                    DisclosureGroup{
                            ForEach(self.constructors){ constructor in
                                ConstructorCard(item: constructor)
                                Divider()
                            }
                    
                    }label:{
                        HStack{
                            Image("Constructors")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(LocalizedKeys.F1Text.constructorsText)
                        }
                    }.padding()
                    
                    DisclosureGroup{
                        ForEach(self.circuits){ circuit in
                            NavigationLink(
                                destination: CircuitDetailsCoordinator.buildView(circuit: circuit)){
                                CircuitCard(item: circuit)
                            }
                            Divider()
                        }
                        
                    }label: {
                        HStack{
                            Image("Circuits")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(LocalizedKeys.F1Text.circuitsText)
                        }
                    }.padding()
                }
                .navigationBarTitle("Favorites", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading:
                                        Button(action: {
                                            self.showFavorites = false
                                        }, label: {
                                            Image(systemName: "chevron.left").foregroundColor(.white)
                                        })
                )
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    
    static var previews: some View {
        FavoritesView(showFavorites: .constant(true))
    }
}
