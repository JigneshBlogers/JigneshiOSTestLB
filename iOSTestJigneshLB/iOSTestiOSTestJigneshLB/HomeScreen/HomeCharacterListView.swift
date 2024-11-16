import SwiftUI

struct HomeCharacterListView: View {
    @ObservedObject var viewModel: CharactersViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.characters) { character in
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        CharacterRow(character: character)
                    }
                }
                
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .navigationTitle(UIConstants.navigationTitle)
            .font(.title)
            .onAppear {
                // Avoid redundant fetch calls if data already exists
                if viewModel.characters.isEmpty {
                    viewModel.fetchCharacters()
                }
            }
            .alert(item: $viewModel.errorMessage) { errorMessage in
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage.message),
                    dismissButton: .default(Text("OK")) {
                        viewModel.setErrorMessageNil()
                    }
                )
            }
            .refreshable {
                // Refresh only if not already loading
                if !viewModel.isLoading {
                    viewModel.fetchCharacters()
                }
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView(UIConstants.loadingMessage)
            Spacer()
        }
    }
}
