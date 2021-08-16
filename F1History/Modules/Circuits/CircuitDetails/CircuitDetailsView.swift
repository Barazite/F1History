//
//  CircuitDetailsView.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 9/8/21.
//

import SwiftUI
import MapKit

struct CircuitDetailsView: View {
    
    @SwiftUI.Environment(\.presentationMode) var presentMode
    @ObservedObject var presenter = CircuitDetailsPresenterImpl()
    @ObservedObject var imageManager = ImageManager()
    @State var showWiki = false
    @State var favorite = false
    
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    if favorite{
                        FavoritesManager.shared.deleteCircuit(circuit: presenter.circuit!)
                        favorite = false
                    }else{
                        FavoritesManager.shared.saveCircuit(circuit: presenter.circuit!)
                        favorite = true
                    }
                }, label: {
                    Image(systemName: favorite ? "star.fill" : "star")
                        .resizable()
                        .frame(width: 40, height: 40)
                })
                .onAppear(perform: {
                    self.favorite = FavoritesManager.shared.findCircuit(circuit: presenter.circuit!)
                })
                .foregroundColor(.yellow)
                
                Spacer()
                
                Button(action: {
                    showWiki.toggle()
                }, label: {
                    Image("wikipedia")
                        .resizable()
                        .frame(width: 40, height: 40)
                })
                .foregroundColor(.yellow)
                .sheet(isPresented: $showWiki, onDismiss: {}){
                    WebViewHome(showWiki: $showWiki, url: self.presenter.circuit?.url ?? "https://www.wikipedia.com")
                }
            }
            .padding()
            
            HStack(alignment: .center){
                Text(self.presenter.circuit?.circuitName ?? "").font(.title2).bold()
            }.padding()
            
            HStack(){
                Text(self.presenter.circuit?.locality ?? "").font(.title3)
                Spacer()
                Image(uiImage: (self.imageManager.flag.isEmpty ? UIImage(systemName: "photo") : UIImage(data: self.imageManager.flag))!)
                    .resizable()
                    .frame(width: 100, height: 80)
                    .scaledToFill()
            }.padding()
            
            MapCircuit(circuit: self.presenter.circuit!)
                .frame(maxWidth: .infinity)
                .ignoresSafeArea(edges: .horizontal)
        }
        .onAppear(perform: {
            self.imageManager.getFlagFromUrl(imageUrl: self.imageManager.getUrl(nation: self.presenter.circuit?.country ?? ""))
        })
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
                                    self.presentMode.wrappedValue.dismiss()
                                }, label: {
                                    Image(systemName: "chevron.left").foregroundColor(.white)
                                })
        )
    }
}

struct CircuitDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CircuitDetailsView()
    }
}

struct MapCircuit: View{
    
    var circuit : Circuits
    @State private var region : MKCoordinateRegion
    
    init(circuit : Circuits){
        self.circuit = circuit
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.circuit.lat!, longitude: self.circuit.long!), latitudinalMeters: 1500, longitudinalMeters: 1500)
    }
    
    var body: some View{
        
        /*Map(coordinateRegion: self.$region,annotationItems: [circuit]){ place in
            MapPin(coordinate: CLLocationCoordinate2D(latitude: (place.lat! as NSString).doubleValue, longitude: (place.long! as NSString).doubleValue), tint: .red)
        }*/
        Map(coordinateRegion: self.$region, interactionModes: .all, annotationItems: [circuit]){ place in
            MapPin(coordinate: CLLocationCoordinate2D(latitude: place.lat! , longitude: place.long!), tint: .red)
        }
        
    }
}
