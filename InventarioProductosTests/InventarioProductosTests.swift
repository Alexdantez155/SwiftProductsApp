import XCTest
@testable import InventarioProductos

@MainActor
final class InventarioProductosTests: XCTestCase {
    
    var viewModel: ViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = ViewModel(fetchAllProductsUseCase: FetchProductMock(),
                                                    insertProductUseCase: InsertProductMock(),
                                                    deleteProductUseCase: DeleteProductMock(),
                                                    updateProductUseCase: UpdateProductMock())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockproducts = []
    }
    
    func testInsertProduct() {
        //GIVEN
        let name = "Jabon Foca"
        let price = 10.0
        let isActive = true
        let quantity = 2
        //WHEN
        let newProduct = Product(name: name, price: price, url: URL(string: "https://farmaciasanjorge.com/cdn/shop/files/planogram__1__20a0c70d-8c7c-4d0a-b1a2-838abc655d94.jpg?v=1734638784&width=1200")!,activeProduct: .init(isActive: isActive, quantity: quantity))
        viewModel.insertProduct(product: newProduct)
        viewModel.getProducts()
        //THEN
        XCTAssertEqual(viewModel.products.count, 1)
        XCTAssertEqual(viewModel.products[0].name , name)
    }
    
    func testUpdateProduct(){
        //GIVEN
        let name = "Jabon Foca"
        let price = 10.0
        let isActive = true
        let quantity = 2
        
        let nameUpdated = "Jabon Zote"
        let priceUpdated = 15.0
        let isActiveUpdated = true
        let quantityUpdated = 5
        
        let newProduct = Product(name: name, price: price,url: URL(string: "https://farmaciasanjorge.com/cdn/shop/files/planogram__1__20a0c70d-8c7c-4d0a-b1a2-838abc655d94.jpg?v=1734638784&width=1200")!,activeProduct: .init(isActive: isActive, quantity: quantity))
        viewModel.insertProduct(product: newProduct)
        viewModel.getProducts()
        //WHEN
        if let index = viewModel.products.first {
            let updateProduct = Product(identifier: index.identifier,name: nameUpdated, price: priceUpdated,url: index.url,activeProduct: .init(isActive: isActiveUpdated, quantity: quantityUpdated))
            viewModel.updateProduct(product: updateProduct)
            viewModel.getProducts()
        }
        // Then
        XCTAssertEqual(viewModel.products.count, 1)
        XCTAssertEqual(viewModel.products[0].name , nameUpdated)
        XCTAssertEqual(viewModel.products[0].price , priceUpdated)
        
    }
    
    func testDeleteProduct(){
        //GIVEN
        let name = "Jabon Foca"
        let price = 10.0
        let isActive = true
        let quantity = 2
        
        let newProduct = Product(name: name, price: price,url: URL(string: "https://farmaciasanjorge.com/cdn/shop/files/planogram__1__20a0c70d-8c7c-4d0a-b1a2-838abc655d94.jpg?v=1734638784&width=1200")!,activeProduct: .init(isActive: isActive, quantity: quantity))
        viewModel.insertProduct(product: newProduct)
        viewModel.getProducts()
        //WHEN
        if let index = viewModel.products.first {
            viewModel.deleteProduct(product: index)
            viewModel.getProducts()
        }
        //THEN
        XCTAssertEqual(viewModel.products.count, 0)
        XCTAssertEqual(viewModel.products.isEmpty, true)
        
    }

}
