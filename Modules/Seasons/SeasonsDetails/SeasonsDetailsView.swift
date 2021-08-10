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
    private var tabs = ["calendar", "rectangle.stack.person.crop", "person.2.square.stack"]
    @State private var selected = "calendar"
    
    init() {
        UITabBar.appearance().isHidden = true
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        GeometryReader{ reader in
            VStack{
                HStack(){
                    ForEach(tabs, id: \.self){ image in
                        VStack(spacing: 5){
                            Button(action: {
                                withAnimation(.spring()){
                                    selected = image
                                }
                            }, label: {
                                Image(systemName: image)
                                    .resizable()
                                    .frame(width: reader.size.height/15, height: reader.size.height/15, alignment: .center)
                                    .foregroundColor(.white)
                            })
                        
                            Rectangle().fill(selected == image ? Color.white : Color.clear).frame(height: 5)
                            
                        }
                        .padding(.top, 15)
                        .frame(height: reader.size.height/10)
                        //.padding(.horizontal)
                    }
                }
                .frame(height: reader.size.height/10)
                .frame(maxWidth: .infinity)
                .background(Color.barColor)
                .padding(0)
                
                TabView(selection: $selected){
                    ScheduleList(presenter: self.presenter)
                        .tag("calendar")
                    
                    DriversList(presenter: self.presenter)
                        .tag("rectangle.stack.person.crop")
                    
                    ConstructorsList(presenter: self.presenter)
                        .tag("person.2.square.stack")
                                        
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
            )
        }
    }
}

struct SeasonsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonsDetailsView()
    }
}

struct ScheduleList: View{
    
    @ObservedObject var presenter : SeasonsDetailsPresenterImpl
    
    var body: some View{
        VStack{
            if presenter.arraySchedule.isEmpty{
                ProgressView("Loading")
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
                ProgressView("Loading")
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
                ProgressView("Loading")
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
                    withAnimation(){
                        info.toggle()
                    }
                }, label: {
                    Image(systemName: "info.circle")
                }).padding()
            }
            if info{
                HStack{
                    Text("Wins: "+driver.wins!).padding()
                    Spacer()
                    Text("Team: "+driver.constructor!).padding()
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
                    withAnimation(){
                        info.toggle()
                    }
                }, label: {
                    Image(systemName: "info.circle")
                }).padding()
            }
            if info{
                HStack{
                    Spacer()
                    Text("Wins: "+constructor.wins!).padding()
                    Spacer()
                }
            }
        }
    }
}
