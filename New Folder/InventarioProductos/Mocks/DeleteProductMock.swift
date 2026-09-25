import Foundation

struct DeleteProductMock: DeleteProductUseCaseProtocol{
    func deleteProduct(product: Product) throws{
        if let index = mockproducts.firstIndex(where: { $0.identifier == product.identifier }){
            mockproducts.remove(at: index)
        }
    }
}
