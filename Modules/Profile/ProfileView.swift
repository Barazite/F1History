//
//  ProfileView.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 14/8/21.
//

import SwiftUI

struct ProfileView: View {
    
    @Binding var showProfile: Bool
    
    var body: some View {
        NavigationView{
            Text("Profile")
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
