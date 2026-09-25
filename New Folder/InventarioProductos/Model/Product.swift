import Foundation
import SwiftData


@Model
final class Card {
    @Attribute(.unique)
    var identifier: UUID
    @Relationship(deleteRule: .cascade)
    var items: [CartItem]
    var total: Double {
        items.reduce(0) {
            $0 + ($1.product.price * Double($1.quantity))
        }
    }
    init(
        identifier: UUID = UUID(),
        items: [CartItem] = []
    ) {
        self.identifier = identifier
        self.items = items
    }
}

@Model
final class CartItem {
    var quantity: Int
    var product: Product
    init(product: Product, quantity: Int) {
        self.product = product
        self.quantity = quantity
    }
}

@Model
final class Product {
    
    @Attribute(.unique) var identifier: UUID
    var name: String
    var price: Double
    var url: URL
    @Relationship(deleteRule: .cascade)
    var activeProduct : ActiveProduct
    
    init(identifier:UUID = UUID(), name: String, price: Double, url: URL,activeProduct: ActiveProduct) {
        self.identifier = identifier
        self.name = name
        self.price = price
        self.url = url
        self.activeProduct = activeProduct
    }
    
}

@Model
final class ActiveProduct {
    var isActive: Bool
    var quantity: Int
    
    init(isActive: Bool, quantity: Int) {
        self.isActive = isActive
        self.quantity = quantity
    }
}
