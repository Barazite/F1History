//
//  WebView.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 8/8/21.
//

import SwiftUI
import WebKit



struct WebViewHome: View {
    @Binding var showWiki: Bool
    var url = ""
    
    var body: some View{
        NavigationView{
            WebView(request: URLRequest(url: URL(string: url)!))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button(action: {
                    self.showWiki = false
                }) {
                    Text(LocalizedKeys.General.webViewText).bold().foregroundColor(.white)
                })
        }
    }
}

struct WebView: UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
            return WKWebView()
        }
        
        func updateUIView(_ uiView: WKWebView, context: Context) {
            uiView.load(request)
        }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(request: URLRequest(url: URL(string: "https://www.apple.com")!))
    }
}
