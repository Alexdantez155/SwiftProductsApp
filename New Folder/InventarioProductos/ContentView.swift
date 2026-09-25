import SwiftUI

struct ContentView: View {
    
    @State var viewModel = ViewModel()
    @State var isPresented: Bool = false

    let columnsVS: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: 2)

    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columnsVS) {
                                ForEach(viewModel.products) { product in
                                    CardProduct(item: product, viewModel: viewModel)
                                }
                }
                .padding(.horizontal, 16)
            }.padding(.top,10)
            .sheet(isPresented: $isPresented, content: {
                AddProductView( viewModel: viewModel)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            })
            .navigationTitle(Text("Super Neto"))
            .toolbarBackground(Color(red: 145/255, green: 160/255, blue: 57/255), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar{
                ToolbarItem{
                    Button(action: {
                    //add product
                    isPresented = true
                    }, label: {
                        Label("Add", systemImage: "plus")
                    }).tint(.white)
                }
                ToolbarItem(placement: .topBarLeading, content: {
                    Button(action: {
                        
                    }, label: {
                        Label("Shopping", systemImage: "cart.fill.badge.plus")
                    }).tint(.white)
                })
                //Search
                ToolbarItem(placement: .principal) {
                    TextSearch(viewModel: viewModel)
                }
            }
        }
        .onAppear{
            viewModel.getProducts()
        }
    }
}

#Preview {
    ContentView()
}
