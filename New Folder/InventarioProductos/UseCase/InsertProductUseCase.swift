import Foundation

@MainActor
protocol InsertProductUseCaseProtocol {
    func insertProduct(product: Product) throws
}


struct InsertProductUseCase: InsertProductUseCaseProtocol {
    
    let  dataBase : ConfigurationBaseProtocol
    
    init(dataBase: ConfigurationBaseProtocol) {
        self.dataBase = dataBase
    }
    
    func insertProduct(product: Product) throws {
        try dataBase.addProduct(product: product)
    }

}
