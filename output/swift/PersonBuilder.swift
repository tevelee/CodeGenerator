import Foundation

struct PersonBuilder {
	var firstName: String
	var lastName: String
	var nickName: String
	var age: Int
	var address: Address
    
    func build () -> Person {
        return Person(firstName: firstName, lastName: lastName, nickName: nickName, age: age, address: address)
    }
    
    //MARK: Initializers
    
    init(existingPerson: Person) {
        firstName = existingPerson.firstName
        lastName = existingPerson.lastName
        nickName = existingPerson.nickName
        age = existingPerson.age
        address = existingPerson.address
    }
    
    //MARK: Property setters
    
    mutating func withFirstName(_ firstName: String) -> PersonBuilder {
        self.firstName = firstName
        return self
    }

    mutating func withLastName(_ lastName: String) -> PersonBuilder {
        self.lastName = lastName
        return self
    }

    mutating func withNickName(_ nickName: String) -> PersonBuilder {
        self.nickName = nickName
        return self
    }

    mutating func withAge(_ age: Int) -> PersonBuilder {
        self.age = age
        return self
    }

    mutating func withAddress(_ address: Address) -> PersonBuilder {
        self.address = address
        return self
    }
}
