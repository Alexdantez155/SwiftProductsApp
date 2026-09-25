import SwiftUI

struct TextSearch: View {
    @State var searchText: String = ""
    let viewModel: ViewModel
    var body: some View {
        VStack {
            TextField(
                "",
                text: $searchText,
                prompt: Text("🔎 Buscar producto").foregroundStyle(Color.gray) // Color del placeholder
            )
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .foregroundStyle(.black) // Color del texto que escribe el usuario
            .tint(.black) // Color del cursor
            .padding(5)
            .background(.white, in: RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            .onChange(of: searchText) {
                viewModel.searchProduct(text: searchText)
            }
        }
    }
}
