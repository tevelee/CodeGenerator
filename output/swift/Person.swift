import Foundation

struct Person  {
    let firstName: String
    let lastName: String
    let nickName: String
    let age: Int
    let address: Address

    init(firstName: String, lastName: String, nickName: String, age: Int, address: Address) {
		self.firstName = firstName
		self.lastName = lastName
		self.nickName = nickName
		self.age = age
		self.address = address
    }
}


func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.nickName == rhs.nickName && lhs.age == rhs.age && lhs.address == rhs.address}

extension Person : Equatable {
}

extension Person : CustomStringConvertible {
    var description: String {
        return "Person(firstName: \(firstName) lastName: \(lastName) nickName: \(nickName) age: \(age) address: \(address)"
    }
}

