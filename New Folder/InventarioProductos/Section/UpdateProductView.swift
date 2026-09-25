//
//  UpdateProductView.swift
//  InventarioProductos
//
//  Created by GOBTI on 22/09/26.
//

import SwiftUI

struct UpdateProductView: View {
    @Bindable var item : Product
    let viewModel : ViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            Form {
                TextField("Nombre", text: $item.name)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                TextField("URL de la imagen", text: Binding(
                    get: { item.url.absoluteString },
                    set: { nuevoTexto in
                        if let nuevaURL = URL(string: nuevoTexto) {
                            item.url = nuevaURL
                        }
                    }
                ))
                    .keyboardType(.URL)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                TextField("Precio Ej: 15.50 ", value: $item.price , format: .number)
                    .keyboardType(.decimalPad)
                Stepper(value: $item.activeProduct.quantity, in: 1...10) {
                    Text("Cantidad:  \(item.activeProduct.quantity)")
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(red: 145/255, green: 160/255, blue: 57/255), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar{
                ToolbarItem(placement: .principal) {
                            Text("Modificar Producto")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.primary)
                                
                                
                    }
                
                ToolbarItem(placement: .status) {
                    Button(action: {
                        //Update Product
                        viewModel.updateProduct(product: item)
                        dismiss()
                        viewModel.getProducts()
                    }, label: {
                        Label("Modificar", systemImage: "square.and.arrow.up")
                            .labelStyle(.titleAndIcon)
                    })
                    .buttonStyle(.bordered)
                    .tint(.orange)
                }
            }
        }
    
    }
}


