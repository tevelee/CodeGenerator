import Foundation

struct Record  {
    let name: String
    let creator: Person
    let date: Date

    init(name: String, creator: Person, date: Date) {
		self.name = name
		self.creator = creator
		self.date = date
    }
}


func ==(lhs: Record, rhs: Record) -> Bool {
    return lhs.name == rhs.name && lhs.creator == rhs.creator && lhs.date == rhs.date}

extension Record : Equatable {
}

extension Record : CustomStringConvertible {
    var description: String {
        return "Record(name: \(name) creator: \(creator) date: \(date)"
    }
}

