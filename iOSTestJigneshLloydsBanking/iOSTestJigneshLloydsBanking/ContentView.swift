import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CharactersViewModel()
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    CharacterRow(character: character)
                }
            }
            .navigationTitle("Rick and Morty Characters")
            .onAppear {
                viewModel.fetchCharacters()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? "Unknown error"),
                    dismissButton: .default(Text("OK")) {
                        viewModel.errorMessage = nil
                    }
                )
            }
        }
    }
}

struct CharacterRow: View {
    let character: Character

    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
                    .frame(width: 50, height: 50)
            }
            
            Text(character.name)
                .font(.headline)
                .padding(.leading, 8)
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .padding(.vertical, 8)
    }
}
