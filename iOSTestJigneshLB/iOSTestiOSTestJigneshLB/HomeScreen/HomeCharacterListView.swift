import SwiftUI

struct HomeCharacterListView: View {
    @ObservedObject var viewModel: CharactersViewModel
    @State private var showAlert = false

    init(viewModel: CharactersViewModel = CharactersViewModel()) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.characters) { character in
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        CharacterRow(character: character)
                    }
                }
                
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView(UIConstants.loadingMessage)
                        Spacer()
                    }
                }
            }
            .navigationTitle(UIConstants.navigationTitle)
            .font(.title)
            .onAppear {
                viewModel.fetchCharacters()
            }
            .onChange(of: viewModel.errorMessage) { errorMessage in
                showAlert = errorMessage != nil
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(UIConstants.errorTitle),
                    message: Text(viewModel.errorMessage ?? UIConstants.errorUnknownMessage),
                    dismissButton: .default(Text("OK")) {
                        viewModel.setErrorMessageNil()
                    }
                )
            }
            .refreshable {
                viewModel.fetchCharacters()
            }
        }
    }
}
