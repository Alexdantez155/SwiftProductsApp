import Foundation

@MainActor
protocol DeleteProductUseCaseProtocol {
    func deleteProduct(product: Product) throws
}

struct DeleteProductUseCase: DeleteProductUseCaseProtocol {
    let dataBase: ConfigurationBaseProtocol
    
    init(dataBase: ConfigurationBaseProtocol) {
        self.dataBase = dataBase
    }
    
    func deleteProduct(product: Product) throws{
        try dataBase.deleteProduct(product: product)
    }
}
