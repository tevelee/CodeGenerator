//
//  ViewController.swift
//  Swift
//
//  Created by László Teveli on 2016. 10. 17..
//  Copyright © 2016. László Teveli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let address = Address(postalCode: 1052, streetAddress: "Karoly korut", number: 6)
        let person = Person(firstName: "Laszlo", lastName: "Teveli", nickName: "Teve", age: 26, address: address)
        let record = Record(name: "Example", creator: person, date: Date())
        
        let r0 = record.lens.creator.firstName.set(newPart: "Test")
        print(r0.creator.firstName)
        
        let r1 = record
            |> (record.lens.name ~= "Name")
            |> (record.lens.creator.firstName ~= "L")
            |> (record.lens.creator.lastName ~= "T")
            |> (record.lens.creator.address.streetAddress ~= "Budapest")
            |> (record.lens.creator.address.postalCode ~= 1202)
        print(r1.creator.address.streetAddress)
        
        let r2 = record
            |> (Record.Lenses.name ~= "Name")
            |> (Record.Lenses.creator => Person.Lenses.firstName ~= "L")
        print(r2.creator.firstName)
    }
}

