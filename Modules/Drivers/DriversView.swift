//
//  DriversView.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 7/7/21.
//

import SwiftUI

struct DriversView: View {
    
    @ObservedObject var presenter = DriversPresenterImpl()
    
    /*init(){
        self.presenter.fetchDrivers()
    }*/
    
    var body: some View {
        List{
            if self.presenter.arrayDrivers.isEmpty{
                ProgressView()
            }else{
                ForEach(self.presenter.arrayDrivers){ item in
                    DriverCard(item: item)
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
        .onAppear(perform: {
            self.presenter.fetchDrivers()
        })
    }
}

struct DriversView_Previews: PreviewProvider {
    static var previews: some View {
        DriversView()
    }
}

struct DriverCard: View {
    
    var driver : Drivers
    @ObservedObject var presenter = DriversPresenterImpl()
    
    init(item: Drivers){
        self.driver = item
        self.presenter.getImageFromUrl()
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
                    
                }, label: {
                    Image("wikipedia")
                        .resizable()
                        .frame(width: 40, height: 40)
                }).foregroundColor(.yellow)
                
            }.padding(.all, 8)
            
            HStack{
                Image(uiImage: ((self.presenter.data.isEmpty) ? UIImage(systemName: "person.fill") : UIImage(data: self.presenter.data))!)
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
                
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 50)
                
            }.padding(.all, 8)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1).padding(.all, 5))
    }
}
