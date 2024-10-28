import SwiftUI

struct HomeCharacterListView: View {
    @StateObject private var viewModel = CharactersViewModel()
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.characters) { character in
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        CharacterRow(character: character)
                    }
                }
                // Show an activity indicator while loading
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView("Loading...")
                        Spacer()
                    }
                }
            }
            .navigationTitle("Rick and Morty Characters")
            .font(.title)
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
            .refreshable {
                viewModel.fetchCharacters() // Add refresh functionality
            }
        }
    }
}


