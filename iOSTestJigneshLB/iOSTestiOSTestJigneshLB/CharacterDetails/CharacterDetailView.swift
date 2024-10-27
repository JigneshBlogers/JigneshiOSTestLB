//
//  CharacterDetails.swift
//  iOSTestJigneshLB
//
//  Created by jignesh kalantri on 27/10/24.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: 200, height: 200)
                     .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            Text(character.name)
                .font(.largeTitle)
                .padding(.top)
            Text("Status: \(character.status)")
            Text("Species: \(character.species)")
            Text("Gender: \(character.gender)")
        }
        .padding()
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
