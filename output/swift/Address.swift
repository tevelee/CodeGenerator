import Foundation

struct Address  {
    let postalCode: Int
    let streetAddress: String
    let number: Int

    init(postalCode: Int, streetAddress: String, number: Int) {
		self.postalCode = postalCode
		self.streetAddress = streetAddress
		self.number = number
    }
}


func ==(lhs: Address, rhs: Address) -> Bool {
    return lhs.postalCode == rhs.postalCode && lhs.streetAddress == rhs.streetAddress && lhs.number == rhs.number}

extension Address : Equatable {
}

extension Address : CustomStringConvertible {
    var description: String {
        return "Address(postalCode: \(postalCode) streetAddress: \(streetAddress) number: \(number)"
    }
}

