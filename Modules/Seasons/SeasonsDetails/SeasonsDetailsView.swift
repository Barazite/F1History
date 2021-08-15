//
//  SeasonsDetailsView.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/8/21.
//

import SwiftUI

struct SeasonsDetailsView: View {
    
    @SwiftUI.Environment(\.presentationMode) var presentMode
    @ObservedObject var presenter = SeasonsDetailsPresenterImpl()
    private var tabs = ["calendar", "standingsdriver", "standingsteam"]
    @State private var selected = "calendar"
    @State var favorite = false
    
    init() {
        UITabBar.appearance().isHidden = true
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        GeometryReader{ reader in
            VStack{
                HStack(){
                    ForEach(tabs, id: \.self){ image in
                        TabButton(title: image, selectedTab: $selected)
                        if image != tabs.last{
                            Spacer(minLength: 0)
                        }
                    }
                }
                .padding(.horizontal, 30)
                .background(Color.barColor)
                
                TabView(selection: $selected){
                    ScheduleList(presenter: self.presenter)
                        .tag("calendar")
                    
                    DriversList(presenter: self.presenter)
                        .tag("standingsdriver")
                    
                    ConstructorsList(presenter: self.presenter)
                        .tag("standingsteam")
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .onAppear(perform: {
                self.presenter.fetchSchedules()
                self.presenter.fetchDrivers()
                self.presenter.fetchConstructors()
            })
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                                        self.presentMode.wrappedValue.dismiss()
                                    }, label: {
                                        Image(systemName: "chevron.left").foregroundColor(.white)
                                    })
                                , trailing:
                                    Button(action: {
                                        if favorite{
                                            FavoritesManager.shared.deleteSeason(season: presenter.season!)
                                            favorite = false
                                        }else{
                                            FavoritesManager.shared.saveSeason(season: presenter.season!)
                                            favorite = true
                                        }
                                    }, label: {
                                        Image(systemName: favorite ? "star.fill" : "star")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                    })
                                    .onAppear(perform: {
                                        self.favorite = FavoritesManager.shared.findSeason(season: presenter.season!)
                                    })
                                    .foregroundColor(.yellow))
        }
    }
}

struct SeasonsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonsDetailsView()
    }
}



struct TabButton: View {
    var title: String
    @Binding var selectedTab: String
    
    var body: some View{
        Button(action: {
            withAnimation(.spring()){
                selectedTab = title
            }
        }, label: {
            VStack(spacing: 6){
                Image(title)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                Text(title.localized)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                CustomSelectionShape()
                    .fill(selectedTab == title ? Color.white : Color.clear)
                    .frame(width: 70, height: 6)
            }
            .padding(.top, 5)
        })
    }
}

struct CustomSelectionShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 10, height: 10))
        return Path(path.cgPath)
    }
}

struct ScheduleList: View{
    
    @ObservedObject var presenter : SeasonsDetailsPresenterImpl
    
    var body: some View{
        VStack{
            if presenter.arraySchedule.isEmpty{
                ProgressView(LocalizedKeys.General.progressText)
            }else{
                List{
                    ForEach(presenter.arraySchedule){ race in
                        DateRace(race: race)
                            .onAppear(perform: {
                                if self.presenter.arraySchedule.last?.id == race.id{
                                    if !self.presenter.finalScheduleList{
                                        self.presenter.fetchSchedules()
                                    }
                                }
                            })
                            .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}

struct DriversList: View{
    
    @ObservedObject var presenter : SeasonsDetailsPresenterImpl
    
    var body: some View{
        VStack{
            if presenter.arrayDrivers.isEmpty{
                ProgressView(LocalizedKeys.General.progressText)
            }else{
                List{
                    ForEach(presenter.arrayDrivers){ driver in
                        DriverPosition(driver: driver)
                            .onAppear(perform: {
                                if self.presenter.arrayDrivers.last?.id == driver.id{
                                    if !self.presenter.finalDriverList{
                                        self.presenter.fetchDrivers()
                                    }
                                }
                            })
                            .buttonStyle(PlainButtonStyle())
                    }
                }
                
            }
        }
    }
}

struct ConstructorsList: View{
    
    @ObservedObject var presenter : SeasonsDetailsPresenterImpl
    
    var body: some View{
        VStack{
            if presenter.arrayConstructors.isEmpty{
                ProgressView(LocalizedKeys.General.progressText)
            }else{
                List{
                    ForEach(presenter.arrayConstructors){ constructor in
                        ConstructorPosition(constructor: constructor)
                            .onAppear(perform: {
                                if self.presenter.arrayConstructors.last?.id == constructor.id{
                                    if !self.presenter.finalConstructorList{
                                        self.presenter.fetchConstructors()
                                    }
                                }
                            })
                            .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}

struct DateRace: View {
    
    var race: SchedulesModel
    
    var body: some View{
        VStack{
            HStack{
                Text(race.round!+".").font(.title).bold()
                Spacer()
                Text(race.raceName!).font(.title3).bold().multilineTextAlignment(.center)
            }.padding()
            HStack{
                Text(race.circuitName!).font(.callout).multilineTextAlignment(.center).padding()
                Spacer()
                Text(race.date!).font(.callout)
            }.padding()
        }
    }
}

struct DriverPosition: View {
    
    var driver: DriverStandingModel
    @State private var info = false
    
    var body: some View{
        VStack{
            HStack{
                Text(driver.position!+".").font(.title2).bold().foregroundColor(driver.position == "1" ? .yellow : .black)
                Spacer()
                Text(driver.name!).font(.title3).bold()
                Spacer()
                Text(driver.points!).font(.title3).bold()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)){
                        info.toggle()
                    }
                }, label: {
                    Image(systemName: "info.circle")
                }).padding()
            }
            if info{
                HStack{
                    Text(LocalizedKeys.F1Text.standingsWinsText + ": " + driver.wins!).padding()
                    Spacer()
                    Text(LocalizedKeys.F1Text.standingsTeamText + ": "+driver.constructor!).padding()
                }
            }
        }
    }
}

struct ConstructorPosition: View {
    
    var constructor: ConstructorsStandingsModel
    @State private var info = false
    
    var body: some View{
        VStack{
            HStack{
                Text(constructor.position!+".").font(.title2).bold().foregroundColor(constructor.position == "1" ? .yellow : .black)
                Spacer()
                Text(constructor.constructor!).font(.title3).bold()
                Spacer()
                Text(constructor.points!).font(.title3).bold()
                Button(action: {
                    withAnimation(.spring()){
                        info.toggle()
                    }
                }, label: {
                    Image(systemName: "info.circle")
                }).padding()
            }
            if info{
                HStack{
                    Spacer()
                    Text(LocalizedKeys.F1Text.standingsWinsText + ": " + constructor.wins!).padding()
                    Spacer()
                }
            }
        }
    }
}
