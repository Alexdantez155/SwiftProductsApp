import SwiftUI

struct AddProductView: View {
    @State private var name: String = ""
    @State private var urlTexto: String = ""
    @State private var price: Double?
    @State private var quantity: Int = 1
    let viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            Form {
                TextField("Nombre", text: $name)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                TextField("URL: https://ejemplo.com", text: $urlTexto)
                    .keyboardType(.URL)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                TextField("Precio Ej: 15.50 ", value: $price , format: .number)
                    .keyboardType(.decimalPad)
                Stepper(value: $quantity, in: 1...10) {
                    Text("Cantidad:  \(quantity)")
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(red: 145/255, green: 160/255, blue: 57/255), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar{
                ToolbarItem(placement: .principal) {
                            Text("Nuevo Producto")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.primary)
                                
                                
                    }
                
                ToolbarItem(placement: .status) {
                    Button(action: {
                        //add Product
                        let newProduct = Product(name: name, price: price!,url: URL(string: urlTexto)!, activeProduct: .init(isActive: true, quantity: quantity))
                        viewModel.insertProduct(product: newProduct)
                        dismiss()
                        viewModel.getProducts()
                    }, label: {
                        Label("Añadir", systemImage: "arrow.up.circle")
                            .labelStyle(.titleAndIcon)
                    })
                    .buttonStyle(.bordered)
                    .tint(.blue)
                }
            }
        }
    }
}

