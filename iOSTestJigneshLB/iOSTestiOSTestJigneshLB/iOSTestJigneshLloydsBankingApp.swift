//
//  iOSTestJigneshLBankingApp.swift
//  iOSTestJigneshLB
//
//  Created by jignesh kalantri on 26/10/24.
//

import SwiftUI

@main
struct iOSTestJigneshLBankingApp: App {
    // Instantiate the view model here to use it as a dependency
    let characterViewModel = CharactersViewModel()
    
    var body: some Scene {
        WindowGroup {
            // Pass the view model into HomeCharacterListView
            HomeCharacterListView(viewModel: characterViewModel)
        }
    }
}
