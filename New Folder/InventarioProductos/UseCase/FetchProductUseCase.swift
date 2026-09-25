import Foundation

@MainActor
protocol FetchProductUseCaseProtocol {
    func  fetchAll() throws -> [Product]
}


struct FetchProductUseCase:  FetchProductUseCaseProtocol{
    
    let  dataBase :  ConfigurationBaseProtocol

    init(dataBase: ConfigurationBaseProtocol) {
        self.dataBase = dataBase
    }
    
    func  fetchAll() throws -> [Product] {
        try   dataBase.fetchAll()
    }
}
