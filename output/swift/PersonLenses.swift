import Foundation

extension Person {
    struct Lenses {
        static let firstName: Lens<Person, String> = Lens(
            get: { $0.firstName },
            set: { (person, firstName) in
                var builder = PersonBuilder(existingPerson: person)
                return builder.withFirstName(firstName).build()
            }
        )
        static let lastName: Lens<Person, String> = Lens(
            get: { $0.lastName },
            set: { (person, lastName) in
                var builder = PersonBuilder(existingPerson: person)
                return builder.withLastName(lastName).build()
            }
        )
        static let nickName: Lens<Person, String> = Lens(
            get: { $0.nickName },
            set: { (person, nickName) in
                var builder = PersonBuilder(existingPerson: person)
                return builder.withNickName(nickName).build()
            }
        )
        static let age: Lens<Person, Int> = Lens(
            get: { $0.age },
            set: { (person, age) in
                var builder = PersonBuilder(existingPerson: person)
                return builder.withAge(age).build()
            }
        )
        static let address: Lens<Person, Address> = Lens(
            get: { $0.address },
            set: { (person, address) in
                var builder = PersonBuilder(existingPerson: person)
                return builder.withAddress(address).build()
            }
        )
    }
}

struct BoundLensToPerson<Whole>: BoundLensType {
    typealias Part = Person
    let storage: BoundLensStorage<Whole, Part>
    
    var firstName: BoundLens<Whole, String> {
        return BoundLens<Whole, String>(parent: self, sublens: Person.Lenses.firstName)
    }

    var lastName: BoundLens<Whole, String> {
        return BoundLens<Whole, String>(parent: self, sublens: Person.Lenses.lastName)
    }

    var nickName: BoundLens<Whole, String> {
        return BoundLens<Whole, String>(parent: self, sublens: Person.Lenses.nickName)
    }

    var age: BoundLens<Whole, Int> {
        return BoundLens<Whole, Int>(parent: self, sublens: Person.Lenses.age)
    }

    var address: BoundLensToAddress<Whole> {
        return BoundLensToAddress<Whole>(parent: self, sublens: Person.Lenses.address)
    }
}

extension Person {
    var lens: BoundLensToPerson<Person> {
        return BoundLensToPerson<Person>(instance: self, lens: createIdentityLens())
    }
}
