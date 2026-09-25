import Foundation

struct UpdateProductMock: UpdateProductUseCaseProtocol {
    func updateProduct(product: Product) throws {
        if let index = mockproducts.firstIndex(where: { $0.identifier == product.identifier }){
            mockproducts[index] = product
        }
    }
}
