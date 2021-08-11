//
//  ImageManager.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 11/8/21.
//

import Foundation

class ImageManager: ObservableObject {
    
    @Published var flag =  Data()
    @Published var data =  Data()
    
    internal func getFlagFromUrl(imageUrl : String){
        guard let url = URL(string: imageUrl) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.flag = data
            }
        }
        task.resume()
    }
    
    internal func getImageFromUrl(){
        guard let url = URL(string: "https://loremflickr.com/100/100/people") else {return}
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
    
    internal func getUrl(nation : String) -> String{
        var url = ""
        
        switch nation {
        case "Italian", "Italy": url = "https://image.flaticon.com/icons/png/512/555/555668.png"
        case "British", "UK": url = "https://image.flaticon.com/icons/png/512/555/555417.png"
        case "Belgian", "Belgium": url = "https://image.flaticon.com/icons/png/512/555/555625.png"
        case "American", "American-Italian", "USA": url = "https://image.flaticon.com/icons/png/512/206/206626.png"
        case "German", "Germany", "East German": url = "https://image.flaticon.com/icons/png/512/555/555613.png"
        case "Dutch", "Netherlands": url = "https://image.flaticon.com/icons/png/512/555/555484.png"
        case "Spanish", "Spain": url = "https://image.flaticon.com/icons/png/512/206/206724.png"
        case "French", "France": url = "https://image.flaticon.com/icons/png/512/555/555602.png"
        case "Swedish", "Sweden": url = "https://image.flaticon.com/icons/png/512/555/555606.png"
        case "Brazilian", "Brazil": url = "https://image.flaticon.com/icons/png/512/206/206597.png"
        case "Hungarian", "Hungary": url = "https://image.flaticon.com/icons/png/512/555/555626.png"
        case "Danish": url = "https://image.flaticon.com/icons/png/512/555/555607.png"
        case "Monegasque", "Monaco": url = "https://image.flaticon.com/icons/png/512/555/555636.png"
        case "Austrian", "Austria": url = "https://image.flaticon.com/icons/png/512/555/555490.png"
        case "Canadian", "Canada": url = "https://image.flaticon.com/icons/png/512/555/555473.png"
        case "South African", "South Africa": url = "https://image.flaticon.com/icons/png/512/555/555604.png"
        case "Argentine", "Argentine-Italian", "Argentina": url = "https://image.flaticon.com/icons/png/512/555/555615.png"
        case "Finnish": url = "https://image.flaticon.com/icons/png/512/555/555627.png"
        case "Australian", "Australia": url = "https://image.flaticon.com/icons/png/512/555/555549.png"
        case "Swiss", "Switzerland": url = "https://image.flaticon.com/icons/png/512/555/555582.png"
        case "Irish": url = "https://image.flaticon.com/icons/png/512/555/555609.png"
        case "Portuguese", "Portugal": url = "https://image.flaticon.com/icons/png/512/206/206628.png"
        case "Uruguayan": url = "https://image.flaticon.com/icons/png/512/206/206764.png"
        case "Venezuelan": url = "https://image.flaticon.com/icons/png/512/555/555622.png"
        case "Indian", "India": url = "https://image.flaticon.com/icons/png/512/206/206606.png"
        case "Czech": url = "https://image.flaticon.com/icons/png/512/555/555618.png"
        case "Japanese", "Japan": url = "https://image.flaticon.com/icons/png/512/555/555646.png"
        case "New Zealander", "New Zealand": url = "https://image.flaticon.com/icons/png/512/206/206731.png"
        case "Colombian": url = "https://image.flaticon.com/icons/png/512/555/555617.png"
        case "Mexican", "Mexico": url = "https://image.flaticon.com/icons/png/512/206/206600.png"
        case "Indonesian": url = "https://image.flaticon.com/icons/png/512/2151/2151329.png"
        case "Polish": url = "https://image.flaticon.com/icons/png/512/555/555571.png"
        case "Russian", "Russia": url = "https://image.flaticon.com/icons/png/512/555/555451.png"
        case "Rhodesian": url = "https://image.flaticon.com/icons/png/512/206/206841.png"
        case "Chilean": url = "https://image.flaticon.com/icons/png/512/555/555628.png"
        case "Liechtensteiner": url = "https://image.flaticon.com/icons/png/512/206/206718.png"
        case "Malaysian", "Malaysia": url = "https://image.flaticon.com/icons/png/512/555/555623.png"
        case "Hong Kong": url = "https://image.flaticon.com/icons/png/512/206/206669.png"
        case "Morocco": url = "https://image.flaticon.com/icons/png/512/2151/2151353.png"
        case "Bahrain": url = "https://image.flaticon.com/icons/png/512/555/555563.png"
        case "Azerbaijan": url = "https://image.flaticon.com/icons/png/512/206/206711.png"
        case "Vietnam": url = "https://image.flaticon.com/icons/png/512/555/555515.png"
        case "Turkey": url = "https://image.flaticon.com/icons/png/512/555/555560.png"
        case "Saudi Arabia": url = "https://image.flaticon.com/icons/png/512/206/206719.png"
        case "Singapore": url = "https://image.flaticon.com/icons/png/512/555/555538.png"
        case "China": url = "https://image.flaticon.com/icons/png/512/206/206818.png"
        case "UAE": url = "https://image.flaticon.com/icons/png/512/206/206701.png"
        case "Korea": url = "https://image.flaticon.com/icons/png/512/206/206758.png"
        case "Thai": url = "https://image.flaticon.com/icons/png/512/555/555495.png"
        default:
            url = "https://image.flaticon.com/icons/png/512/190/190284.png"
        }
        
        
        return url
    }
    
}
