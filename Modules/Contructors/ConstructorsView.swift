//
//  ConstructorsView.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 8/7/21.
//

import SwiftUI

struct ConstructorsView: View {
    
    @ObservedObject var presenter = ConstructorsPresenterImpl()
    
    var body: some View {
        
        if self.presenter.arrayConstructors.isEmpty{
            ProgressView("Loading")
                .onAppear(perform: {
                    self.presenter.fetchConstructors()
                })
        }else{
            List{
                ForEach(self.presenter.arrayConstructors){ item in
                    ConstructorCard(item: item).buttonStyle(PlainButtonStyle())
                        .onAppear(perform: {
                            if self.presenter.arrayConstructors.last?.id == item.id {
                                if !self.presenter.finalList{
                                    self.presenter.fetchConstructors()
                                }
                            }
                        })
                }
            }
        }
    }
}

struct ConstructorsView_Previews: PreviewProvider {
    static var previews: some View {
        ConstructorsView()
    }
}

struct ConstructorCard: View {
    
    var constructor: Constructors
    @State var showWiki = false
    
    init(item: Constructors){
        self.constructor = item
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
                
                Button(action: {
                    showWiki.toggle()
                }, label: {
                    Image("wikipedia")
                        .resizable()
                        .frame(width: 40, height: 40)
                })
                .foregroundColor(.yellow)
                .sheet(isPresented: $showWiki, onDismiss: didDismiss){
                    WebViewHome(showWiki: $showWiki, url: constructor.url!)
                }
            }
            .padding(.all, 8)
            
            HStack{
                Spacer()
                Text(constructor.name ?? "").font(.title)
                Spacer()
            }
            
            HStack{
                Spacer()
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 70)
                Spacer()
            }
            .padding(.all, 8)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1).padding(.all, 5))
    }
    
    func didDismiss() {
        
    }
}
