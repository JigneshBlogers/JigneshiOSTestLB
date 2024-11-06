//
//  CharacterRow.swift
//  iOSTestJigneshLB
//
//  Created by jignesh kalantri on 28/10/24.
//

import SwiftUI

struct CharacterRow: View {
    let character: Character

    var body: some View {
        HStack(alignment: .center) {
            CachedAsyncImage(
                url: URL(string: character.image),
                placeholder: { AnyView(ProgressView().frame(width: 50, height: 50)) },
                content: { image in
                    AnyView(
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                    )
                }
            )
            Text(character.name)
                .font(.headline)
                .padding(.leading, 8)
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .padding(.vertical, 8)
    }
}

