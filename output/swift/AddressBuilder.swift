import Foundation

struct AddressBuilder {
	var postalCode: Int
	var streetAddress: String
	var number: Int
    
    func build () -> Address {
        return Address(postalCode: postalCode, streetAddress: streetAddress, number: number)
    }
    
    //MARK: Initializers
    
    init(existingAddress: Address) {
        postalCode = existingAddress.postalCode
        streetAddress = existingAddress.streetAddress
        number = existingAddress.number
    }
    
    //MARK: Property setters
    
    mutating func withPostalCode(_ postalCode: Int) -> AddressBuilder {
        self.postalCode = postalCode
        return self
    }

    mutating func withStreetAddress(_ streetAddress: String) -> AddressBuilder {
        self.streetAddress = streetAddress
        return self
    }

    mutating func withNumber(_ number: Int) -> AddressBuilder {
        self.number = number
        return self
    }
}
