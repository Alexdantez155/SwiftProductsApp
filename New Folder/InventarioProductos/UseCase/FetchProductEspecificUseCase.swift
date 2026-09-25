import Foundation

@MainActor
protocol FetchProductEspecificUseCaseProtocol {
    func searhEspecific(text: String) throws -> [Product]
}

struct FetchProductEspecificUseCaseTests: FetchProductEspecificUseCaseProtocol {
    let dataBase: ConfigurationBaseProtocol
    
    init(dataBase: ConfigurationBaseProtocol) {
        self.dataBase = dataBase
    }
    
    func searhEspecific(text: String) throws -> [Product] {
        try dataBase.fetchProducto(text: text)
    }
}
