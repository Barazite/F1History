//
//  ProfileView.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 14/8/21.
//

import SwiftUI

struct ProfileView: View {
    
    @Binding var showProfile: Bool
    @State var image : UIImage = UIImage(named: "f1")!
    @AppStorage("name") var name : String = ""
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Image(uiImage: self.image)
                    .resizable()
                    .frame(height: 300)
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
                    .padding(.bottom)
                    .onAppear(perform: {
                        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                        let documentsDirectory = paths[0]
                        self.image = UIImage(contentsOfFile: documentsDirectory.appendingPathComponent("profile.jpg").path) ?? UIImage(named: "f1")!
                    })
                
                    Section(header: Text(LocalizedKeys.ProfileText.nameText).foregroundColor(.barColor)){
                        TextField(LocalizedKeys.ProfileText.enterNameText, text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(5)
                
                    Spacer()
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                self.showProfile = false
            }) {
                Text(LocalizedKeys.General.webViewText).bold().foregroundColor(.white)
            })
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    
    @State static var value = true

    static var previews: some View {
        ProfileView(showProfile: $value)
    }
}
