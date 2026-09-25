import Foundation
import SwiftData

@MainActor
protocol ConfigurationBaseProtocol {
    func fetchAll() throws -> [Product]
    func fetchProducto(text: String) throws -> [Product]
    func addProduct( product: Product) throws
    func deleteProduct(product: Product) throws
    func updateProduct(product: Product) throws
}

enum ConfigurationError: Error {
    case ErrorFetch
    case ErrorAdd
    case ErrorDelete
    case ErrorUpdate
}

final class  ConfigurationBase: ConfigurationBaseProtocol {

    static let shared = ConfigurationBase()
    var modelContainer: ModelContainer
    
     init() {
        modelContainer =  ConfigurationBase.configuration(memory: false)
    }
    
    static func configuration(memory: Bool) -> ModelContainer {
        do {
            let container = try ModelContainer(for: Product.self, configurations: ModelConfiguration(isStoredInMemoryOnly: memory))
            container.mainContext.autosaveEnabled = true
            return container
        } catch {
            print(error.localizedDescription)
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchProducto(text: String) throws -> [Product]  {
        do{
        let fetchDescription = FetchDescriptor<Product>(
                predicate: #Predicate<Product> { item in
                    if text.isEmpty {
                        return true
                    } else {
                        return item.name.localizedStandardContains(text)
                    }
                },
                sortBy: [SortDescriptor<Product>(\.name)]
            )
            return try modelContainer.mainContext.fetch(fetchDescription)
        } catch {
            throw ConfigurationError.ErrorFetch
        }
    }
    
    func fetchAll() throws -> [Product]  {
        do{
            let fetchDescription = FetchDescriptor<Product>(predicate: nil, sortBy: [SortDescriptor<Product>(\.name)] )
            return try modelContainer.mainContext.fetch(fetchDescription)
        } catch {
           throw ConfigurationError.ErrorFetch
        }
    }
    
    func addProduct( product: Product) throws {
        do{
            modelContainer.mainContext.insert(product)
            try modelContainer.mainContext.save()
        } catch {
            throw ConfigurationError.ErrorAdd
        }
    }
    
    func deleteProduct(product: Product) throws {
        do{
            modelContainer.mainContext.delete(product)
            try modelContainer.mainContext.save()
        } catch {
            throw ConfigurationError.ErrorDelete
        }
    }
    
    func updateProduct(product: Product) throws {
        
        do {
            let identifier = product.identifier

            let descriptor = FetchDescriptor<Product>(
                predicate: #Predicate<Product> { productDB in
                    productDB.identifier == identifier
                }
            )

            if let productToUpdate = try modelContainer.mainContext.fetch(descriptor).first {

                productToUpdate.name = product.name
                productToUpdate.price = product.price
                productToUpdate.activeProduct = product.activeProduct

                try modelContainer.mainContext.save()
            }

        } catch {
            throw ConfigurationError.ErrorUpdate
        }
    }

}
