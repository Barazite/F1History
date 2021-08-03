//
//  SliderMenuView.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 2/8/21.
//

import SwiftUI

struct SliderMenuView: View {
    var body: some View {
        VStack(){
            HStack(alignment: .bottom){
                Spacer()
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(25)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.black, lineWidth: 3))
                Button(action: {
                    
                }, label: {
                    Image(systemName: "pencil.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                        .offset(x: -25, y: 0)
                })
                Spacer()
            }
            .padding()
            
            Divider()
                .background(Color.black)
            VStack{
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.black)
                        .imageScale(.large)
                    Text("Profile")
                        .foregroundColor(.black)
                        .font(.headline)
                    Spacer()
                }
                .padding(.top, 50)
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                        .imageScale(.large)
                    Text("Messages")
                        .foregroundColor(.black)
                        .font(.headline)
                    Spacer()
                }
                .padding(.top, 30)
                HStack {
                    Image(systemName: "gear")
                        .foregroundColor(.black)
                        .imageScale(.large)
                    Text("Settings")
                        .foregroundColor(.black)
                        .font(.headline)
                    Spacer()
                }
                .padding(.top, 30)
                Spacer()
            }
            .padding(.horizontal)
            
        }
        .background(Color.barColor)
        
    }
}

struct SliderMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SliderMenuView()
    }
}

