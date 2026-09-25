import Foundation

//Mocks
struct InsertProductMock: InsertProductUseCaseProtocol{
    func insertProduct(product: Product) throws {
        mockproducts.append(product)
    }
}
