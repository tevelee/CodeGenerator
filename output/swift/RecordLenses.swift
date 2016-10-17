import Foundation

extension Record {
    struct Lenses {
        static let name: Lens<Record, String> = Lens(
            get: { $0.name },
            set: { (record, name) in
                var builder = RecordBuilder(existingRecord: record)
                return builder.withName(name).build()
            }
        )
        static let creator: Lens<Record, Person> = Lens(
            get: { $0.creator },
            set: { (record, creator) in
                var builder = RecordBuilder(existingRecord: record)
                return builder.withCreator(creator).build()
            }
        )
        static let date: Lens<Record, Date> = Lens(
            get: { $0.date },
            set: { (record, date) in
                var builder = RecordBuilder(existingRecord: record)
                return builder.withDate(date).build()
            }
        )
    }
}

struct BoundLensToRecord<Whole>: BoundLensType {
    typealias Part = Record
    let storage: BoundLensStorage<Whole, Part>
    
    var name: BoundLens<Whole, String> {
        return BoundLens<Whole, String>(parent: self, sublens: Record.Lenses.name)
    }

    var creator: BoundLensToPerson<Whole> {
        return BoundLensToPerson<Whole>(parent: self, sublens: Record.Lenses.creator)
    }

    var date: BoundLens<Whole, Date> {
        return BoundLens<Whole, Date>(parent: self, sublens: Record.Lenses.date)
    }
}

extension Record {
    var lens: BoundLensToRecord<Record> {
        return BoundLensToRecord<Record>(instance: self, lens: createIdentityLens())
    }
}
