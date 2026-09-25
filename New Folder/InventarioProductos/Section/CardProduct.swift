import SwiftUI

struct CardProduct: View {
    
    var item : Product
    let urlImagen = URL(string: "https://www.neumaticoscastellon.com/images/no-imagen.png")
    let viewModel : ViewModel
    @State var isActivo : Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(.white)
                .cornerRadius(5)
                .shadow(radius: 3)
            
            VStack(alignment: .center) {
                
                Text(item.name)
                    .font(.headline).foregroundStyle(.primary)
                Spacer()
                AsyncImage(url: item.url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80, height: 100)
                Spacer()
                HStack {
                    Text(item.price, format: .currency(code: "MXN").precision(.fractionLength(2)))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("Disponible: \(item.activeProduct.quantity)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Button(action: {
                        //Update
                        isActivo = true
                    }, label: {
                        Label("Editar", systemImage: "square.and.arrow.up")
                            .labelStyle(.titleOnly)
                            .font(.system(size: 10))
                    }).tint(.orange).buttonStyle(.bordered)
                    
                    Button(action: {
                        //Deleted
                        viewModel.deleteProduct(product: item)
                        viewModel.getProducts()
                    }, label: {
                        Label("Eliminar", systemImage: "trash.fill")
                            .labelStyle(.iconOnly)
                            .font(.system(size: 10))
                    }).tint(.red).buttonStyle(.bordered)
                    
                    Button(action: {
                        //Add
                    }, label: {
                        Label("Agregar", systemImage: "plus")
                            .labelStyle(.iconOnly)
                            .font(.system(size: 10))
                    }).tint(.blue).buttonStyle(.bordered)
                    
                }
                
            }
            .padding()
            .sheet(isPresented: $isActivo, content: {
                UpdateProductView(item: item , viewModel: viewModel)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            })
        }
    }
}

