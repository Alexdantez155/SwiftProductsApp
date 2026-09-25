import Foundation
import Observation

@Observable
@MainActor

final class ViewModel {
    
    var products: [Product] = []
    
    let fetchAllProductsUseCase: FetchProductUseCaseProtocol
    let insertProductUseCase: InsertProductUseCaseProtocol
    let deleteProductUseCase: DeleteProductUseCaseProtocol
    let updateProductUseCase: UpdateProductUseCaseProtocol
    let fetchProductEspecificUseCaseTests : FetchProductEspecificUseCaseProtocol
    
    //Views
    init(){
        self.fetchAllProductsUseCase = FetchProductUseCase(dataBase: ConfigurationBase.shared)
        self.insertProductUseCase = InsertProductUseCase(dataBase: ConfigurationBase.shared)
        self.deleteProductUseCase = DeleteProductUseCase(dataBase: ConfigurationBase.shared)
        self.updateProductUseCase = UpdateProductUseCase(dataBase: ConfigurationBase.shared)
        self.fetchProductEspecificUseCaseTests = FetchProductEspecificUseCaseTests(dataBase: ConfigurationBase.shared)
    }
    
    // Test/Inyeccion
    init(   fetchAllProductsUseCase : FetchProductUseCaseProtocol ,
                insertProductUseCase : InsertProductUseCaseProtocol ,
                deleteProductUseCase : DeleteProductUseCaseProtocol ,
                updateProductUseCase :  UpdateProductUseCaseProtocol,
            fetchProductEspecificUseCaseTests : FetchProductEspecificUseCaseProtocol
    ) {
        self.fetchAllProductsUseCase = fetchAllProductsUseCase
        self.insertProductUseCase = insertProductUseCase
        self.deleteProductUseCase = deleteProductUseCase
        self.updateProductUseCase = updateProductUseCase
        self.fetchProductEspecificUseCaseTests = fetchProductEspecificUseCaseTests
    }
    
    func getProducts(){
        do{
            products = try fetchAllProductsUseCase.fetchAll()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func searchProduct(text: String){
        do{
        products = try fetchProductEspecificUseCaseTests.searhEspecific(text: text)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func insertProduct(product: Product){
        do{
            try insertProductUseCase.insertProduct(product: product)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func deleteProduct(product: Product){
        do{
            try deleteProductUseCase.deleteProduct(product: product)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func updateProduct(product: Product){
        do{
            try updateProductUseCase.updateProduct(product: product)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
}
