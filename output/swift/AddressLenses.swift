import Foundation

extension Address {
    struct Lenses {
        static let postalCode: Lens<Address, Int> = Lens(
            get: { $0.postalCode },
            set: { (address, postalCode) in
                var builder = AddressBuilder(existingAddress: address)
                return builder.withPostalCode(postalCode).build()
            }
        )
        static let streetAddress: Lens<Address, String> = Lens(
            get: { $0.streetAddress },
            set: { (address, streetAddress) in
                var builder = AddressBuilder(existingAddress: address)
                return builder.withStreetAddress(streetAddress).build()
            }
        )
        static let number: Lens<Address, Int> = Lens(
            get: { $0.number },
            set: { (address, number) in
                var builder = AddressBuilder(existingAddress: address)
                return builder.withNumber(number).build()
            }
        )
    }
}

struct BoundLensToAddress<Whole>: BoundLensType {
    typealias Part = Address
    let storage: BoundLensStorage<Whole, Part>
    
    var postalCode: BoundLens<Whole, Int> {
        return BoundLens<Whole, Int>(parent: self, sublens: Address.Lenses.postalCode)
    }

    var streetAddress: BoundLens<Whole, String> {
        return BoundLens<Whole, String>(parent: self, sublens: Address.Lenses.streetAddress)
    }

    var number: BoundLens<Whole, Int> {
        return BoundLens<Whole, Int>(parent: self, sublens: Address.Lenses.number)
    }
}

extension Address {
    var lens: BoundLensToAddress<Address> {
        return BoundLensToAddress<Address>(instance: self, lens: createIdentityLens())
    }
}
