//
//  SliderMenuView.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 2/8/21.
//

import SwiftUI

struct SliderMenuView: View {
    
    @Binding var image : UIImage
    var optionSelected: (String) -> Void
            
    var body: some View {
        VStack(){
            HStack(alignment: .bottom){
                Spacer()
                Image(uiImage: self.image)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaledToFit()
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.barColor, lineWidth: 1))
                    .onAppear(perform: {
                        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                        let documentsDirectory = paths[0]
                        self.image = UIImage(contentsOfFile: documentsDirectory.appendingPathComponent("profile.jpg").path) ?? UIImage(named: "f1")!
                    })
                Button(action: {
                    self.optionSelected(MenuOption.ImagePicker.rawValue)
                }, label: {
                    Image(systemName: "pencil.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .offset(x: -30, y: 0)
                })
                
                Spacer()
            }
            .padding()
            
            Divider()
                .background(Color.white)
            
            VStack{
                Button(action: {
                    self.optionSelected(MenuOption.Profile.rawValue)
                }, label: {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.white)
                            .imageScale(.large)
                        Text(LocalizedKeys.SliderMenuText.profileText)
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.top, 50)
                })
                Button(action: {
                    self.optionSelected(MenuOption.Favorites.rawValue)
                }, label: {
                    HStack {
                        Image(systemName: "star")
                            .foregroundColor(.white)
                            .imageScale(.large)
                        Text(LocalizedKeys.SliderMenuText.favoritesText)
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.top, 30)
                })
        
                Spacer()
            }
            .padding(.horizontal)
            
        }
        .background(Color.barColor)
    }
}




enum MenuOption: String {
    case ImagePicker
    case Profile
    case Favorites
}
