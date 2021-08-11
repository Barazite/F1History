//
//  DriversView.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 7/7/21.
//

import SwiftUI

struct DriversView: View {
    
    @ObservedObject var presenter = DriversPresenterImpl()
    
    var body: some View {
        
        if self.presenter.arrayDrivers.isEmpty{
            ProgressView(LocalizedKeys.General.progressText)
                .onAppear(perform: {
                    self.presenter.fetchDrivers()
                })
        }else{
            List{
                ForEach(self.presenter.arrayDrivers){ item in
                    DriverCard(item: item).buttonStyle(PlainButtonStyle())
                        .onAppear(perform: {
                            if self.presenter.arrayDrivers.last?.id == item.id {
                                if !self.presenter.finalList{
                                    self.presenter.fetchDrivers()
                                }
                            }
                        })
                }
            }
        }
    }
}

struct DriversView_Previews: PreviewProvider {
    static var previews: some View {
        DriversView()
    }
}

struct DriverCard: View {
    
    var driver : Drivers
    @ObservedObject var imageManager = ImageManager()
    @State var showWiki = false
    
    init(item: Drivers){
        self.driver = item
        self.imageManager.getFlagFromUrl(imageUrl: self.imageManager.getUrl(nation: item.nationality ?? ""))
        self.imageManager.getImageFromUrl()
    }
    
    var body: some View{
        VStack{
            HStack{
                Button(action: {
                    
                }, label: {
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: 40, height: 40)
                }).foregroundColor(.yellow)
                
                Spacer()
                VStack{
                    Text(driver.givenName ?? "").font(.title)
                    Text(driver.familyName ?? "").font(.title3)
                    Text(driver.dateOfBirth ?? "").font(.callout)
                }
                Spacer()
                
                Button(action: {
                    showWiki.toggle()
                }, label: {
                    Image("wikipedia")
                        .resizable()
                        .frame(width: 40, height: 40)
                })
                .foregroundColor(.yellow)
                .sheet(isPresented: $showWiki, onDismiss: {
                    
                }){
                    WebViewHome(showWiki: $showWiki, url: driver.url!)
                }
                
                
                
            }.padding(.all, 8)
            
            HStack{
                Image(uiImage: (self.imageManager.data.isEmpty ? UIImage(systemName: "person.fill") : UIImage(data: self.imageManager.data))!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                Spacer()
                if driver.permanentNumber != nil{
                    Text(driver.permanentNumber!)
                        .font(Font.system(size: 50))
                        .padding(.all, 8)
                        .overlay(
                            Circle().stroke(Color.black)
                        )
                }
                Spacer()
                
                Image(uiImage: (self.imageManager.flag.isEmpty ? UIImage(systemName: "photo") : UIImage(data: self.imageManager.flag))!)
                    .resizable()
                    .frame(width: 70, height: 60)
                    .scaledToFill()
                
            }.padding(.all, 8)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1).padding(.all, 5))
    }
}
