import Foundation

var mockproducts: [Product] = []
//Mocks
struct FetchProductMock: FetchProductUseCaseProtocol{
    func fetchAll() throws -> [Product] {
        return mockproducts
    }
}
