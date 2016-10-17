//
//  Lenses.swift
//  Example
//
//  Created by László Teveli on 2016. 10. 17..
//  Copyright © 2016. László Teveli. All rights reserved.
//

import Foundation

struct Lens<Whole, Part> {
    let get: (Whole) -> Part
    let set: (Whole, Part) -> Whole
}

func createIdentityLens<Whole>() -> Lens<Whole, Whole> {
    return Lens<Whole, Whole>(
        get: { $0 },
        set: { (whole, _) in return whole }
    )
}

func compose <A, B, C> (lhs: Lens<A, B>, rhs: Lens<B, C>) -> Lens<A, C> {
    return Lens<A, C>(
        get: { rhs.get(lhs.get($0)) },
        set: { a, c in lhs.set(a, rhs.set(lhs.get(a), c)) }
    )
}

func compose <A, B, C> (lhs: Lens<A, B?>, rhs: Lens<B, C>, factory: @escaping (C) -> B) -> Lens<A, C?> {
    return Lens<A, C?>(
        get: {
            if let part = lhs.get($0) {
                return rhs.get(part)
            } else {
                return nil
            }
        },
        set: { outerProperty, newPropertyValue in
            if let propertyValue = newPropertyValue {
                let innerProperty = lhs.get(outerProperty) ?? factory(propertyValue)
                let editedInnerProperty = rhs.set(innerProperty, propertyValue)
                return lhs.set(outerProperty, editedInnerProperty)
            } else {
                return lhs.set(outerProperty, nil)
            }
        }
    )
}

func compose <A, B, C> (lhs: Lens<A, B?>, rhs: Lens<B, C?>, factory: @escaping (C) -> B) -> Lens<A, C?> {
    return Lens<A, C?>(
        get: {
            if let part = lhs.get($0) {
                return rhs.get(part)
            } else {
                return nil
            }
        },
        set: { outerProperty, newPropertyValue in
            if let propertyValue = newPropertyValue {
                let innerProperty = lhs.get(outerProperty) ?? factory(propertyValue)
                let editedInnerProperty = rhs.set(innerProperty, propertyValue)
                return lhs.set(outerProperty, editedInnerProperty)
            } else {
                if let innerProperty = lhs.get(outerProperty) {
                    let editedInnerProperty = rhs.set(innerProperty, nil)
                    return lhs.set(outerProperty, editedInnerProperty)
                } else {
                    return outerProperty
                }
            }
        }
    )
}

precedencegroup CompositionPredicate {
    associativity: left
    higherThan: ComparisonPrecedence
}
infix operator => : CompositionPredicate

precedencegroup LensSetterPredicate {
    associativity: left
    higherThan: CompositionPredicate
}
infix operator ~= : LensSetterPredicate

precedencegroup ApplicationPredicate {
    associativity: left
    higherThan: LensSetterPredicate
}
infix operator |> : ApplicationPredicate

func => <A, B, C> (lhs: Lens<A, B>, rhs: Lens<B, C>) -> Lens<A, C> {
    return compose(lhs: lhs, rhs: rhs)
}

func ~= <A, B> (lens: Lens<A, B>, part: B) -> (A) -> A {
    return { lens.set($0, part) }
}

func ~= <A, B> (lens: BoundLens<A, B>, part: B) -> (A) -> A {
    return lens.storage.lens ~= part
}

func |> <A, B> (x: A, f: (A) -> B) -> B {
    return f(x)
}

func |> <A, B, C> (f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { g(f($0)) }
}

struct BoundLensStorage<Whole, Part> {
    let instance: Whole
    let lens: Lens<Whole, Part>
}


protocol BoundLensType {
    associatedtype Whole
    associatedtype Part
    
    init(storage: BoundLensStorage<Whole, Part>)
    
    var storage: BoundLensStorage<Whole, Part> { get }
    
    func get() -> Part
    func set(newPart: Part) -> Whole
}

extension BoundLensType {
    init(instance: Whole, lens: Lens<Whole, Part>) {
        self.init(storage: BoundLensStorage(instance: instance, lens: lens))
    }
    
    init<Parent: BoundLensType>(parent: Parent, sublens: Lens<Parent.Part, Part>) where Parent.Whole == Whole {
        let storage = parent.storage
        self.init(instance: storage.instance, lens: storage.lens => sublens)
    }
    
    func get() -> Part {
        return storage.lens.get(storage.instance)
    }
    
    func set(newPart: Part) -> Whole {
        return storage.lens.set(storage.instance, newPart)
    }
}

struct BoundLens<Whole, Part>: BoundLensType {
    let storage: BoundLensStorage<Whole, Part>
}
