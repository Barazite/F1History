//
//  HomeTabView.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 9/7/21.
//

import SwiftUI

struct HomeTabView: View {
    
    @State private var selected = "Seasons"
    @State private var xAxis: CGFloat = 45
    @State private var showSlide = false
    
    //SlideMenu UIImage
    @State private var imagen = UIImage()
    
    //Navigation
    @State private var showImagePicker = false
    @State private var showFavorites = false
    @State private var showProfile = false
    
    init() {
        UITabBar.appearance().isHidden = true
        UINavigationBar.appearance().barTintColor = UIColor(Color.barColor)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                ZStack(alignment: .leading) {
                    VStack(){
                        TabView(selection: $selected){
                            SeasonsCoordinator.buildView()
                                .tag("Seasons")
                            
                            DriversCoordinator.buildView()
                                .tag("Drivers")
                            
                            ConstructorsCoordinator.buildView()
                                .tag("Constructors")
                            
                            CircuitsCoordinator.buildView()
                                .tag("Circuits")
                            
                        }
                        //.tabViewStyle(PageTabViewStyle())
                        //.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                        
                        CustomTabBar(selectedTab: $selected, xAxis: $xAxis)
                            .padding(.bottom, 15)
                        
                        
                    }
                    
                    SliderMenuView(image: $imagen, optionSelected: { option in
                        getDestination(itemSelected: option)
                    })
                        .frame(width: geometry.size.width * 3/4)
                        .offset(x: self.showSlide ? 0 : -geometry.size.width)
                        .animation(.default)
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $imagen)
                }
                .fullScreenCover(isPresented: $showFavorites, content: {
                    Text("Favorites")
                })
                .fullScreenCover(isPresented: $showProfile, content: {
                    Text("Profile")
                })
                .gesture(DragGesture().onEnded({ (drag) in
                    if drag.translation.width < geometry.size.width/3{
                        withAnimation(.spring()){
                            self.showSlide = false
                        }
                    }else{
                        withAnimation(.spring()){
                            self.showSlide = true
                        }
                    }
                }))
                .ignoresSafeArea(.all, edges: .bottom)
                .navigationBarTitle("F1 History", displayMode: .inline)
                .navigationBarItems(leading:
                                        Button(action: {
                                            self.showSlide.toggle()
                                        }, label: {
                                            Image(systemName: "slider.horizontal.3")
                                                .resizable()
                                                .foregroundColor(.white)
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 30, height: 30)
                                            
                                        })
                )
            }
        }
    }
    
    private func getDestination(itemSelected: String){
        switch MenuOption(rawValue: itemSelected){
        case .ImagePicker:
            showImagePicker = true
        case .Favorites:
            showFavorites = true
        case .Profile:
            showProfile = true
        case .none:
            print("nada")
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: String
    @Binding var xAxis: CGFloat
    @Namespace var animation
    
    
    let tabs = ["Seasons", "Drivers", "Constructors", "Circuits"]
    
    var body: some View{
        
        HStack(spacing: 0){
            ForEach(tabs, id: \.self){image in
                GeometryReader{ reader in
                    Button(action: {
                        withAnimation(.spring()){
                            selectedTab = image
                            xAxis = reader.frame(in: .global).minX
                        }
                    }, label: {
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .padding(selectedTab == image ? 15 : 0)
                            .background(Color.barColor.opacity(selectedTab == image ? 1 : 0).clipShape(Circle()))
                            .matchedGeometryEffect(id: image, in: animation)
                            .offset(x: selectedTab == image ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0, y: selectedTab == image ? -45 : 0)
                    })
                }
                .frame(width: 25, height: 30)
                
                if image != tabs.last{Spacer(minLength: 0)}
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical)
        .background(Color.barColor.clipShape(CustomShape(xAxis: xAxis)).cornerRadius(12))
        .padding(.horizontal)
    }
}

struct CustomShape: Shape {
    
    var xAxis: CGFloat
    
    var animatableData: CGFloat {
        get { xAxis }
        set { xAxis = newValue }
    }
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            
            path.move(to: CGPoint(x: center - 50, y: 0))
            
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

extension Color{
    static let barColor = Color(red: 250/255, green: 128/255, blue: 114/255)
}
