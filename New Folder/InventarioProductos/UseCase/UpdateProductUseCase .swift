import Foundation

@MainActor
protocol UpdateProductUseCaseProtocol {
    func updateProduct(product: Product) throws
}


struct UpdateProductUseCase: UpdateProductUseCaseProtocol {
    
    let dataBase : ConfigurationBaseProtocol
    
    init(dataBase: ConfigurationBaseProtocol) {
        self.dataBase = dataBase
    }
    
    func updateProduct(product: Product) throws {
        try dataBase.updateProduct(product: product)
    }
}
