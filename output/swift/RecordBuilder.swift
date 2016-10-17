import Foundation

struct RecordBuilder {
	var name: String
	var creator: Person
	var date: Date
    
    func build () -> Record {
        return Record(name: name, creator: creator, date: date)
    }
    
    //MARK: Initializers
    
    init(existingRecord: Record) {
        name = existingRecord.name
        creator = existingRecord.creator
        date = existingRecord.date
    }
    
    //MARK: Property setters
    
    mutating func withName(_ name: String) -> RecordBuilder {
        self.name = name
        return self
    }

    mutating func withCreator(_ creator: Person) -> RecordBuilder {
        self.creator = creator
        return self
    }

    mutating func withDate(_ date: Date) -> RecordBuilder {
        self.date = date
        return self
    }
}
