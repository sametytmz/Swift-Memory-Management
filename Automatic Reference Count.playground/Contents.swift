import UIKit

/*
  Intro To Memory Management
  Problem: Deallocate and allocate objects with ARC
 */

/*
    What is Memory?
    -- RAM: Firdge
    -- Disk: Storage
 */

class Passport {
    weak var human: Human?
    //var human: Human?
    var citizenship: String
    init(citizenship: String) {
        self.citizenship = citizenship
        print("\(citizenship) passport generated")
    }
    
    deinit {
        print("I, paper, am gone")
    }
}

//: Design Human
class Human {
    //weak var passport: Passport?
    var passport: Passport?
    let name: String
    
    init(name: String) {
        self.name = name
        print("\(name) generated")
    }
    
    deinit {
        print("I, \(name), gone")
    }
}

// Passport(citizenship: "Republic of Turkey")
//var myPassport = Passport(citizenship: "The Mars")


//: Introducing Automatic Reference Counting
 
//: Create Instances
//var samet: Human? = Human(name: "Samet Yatmaz")
//var passport: Passport? = Passport(citizenship: "Republic of Turkey")

//: Deallocate
//samet = nil
//passport = nil

/*
    Note
    The Only Rule: If the reference count is zero/no relationship, the object gets purged out of the memory.
 */


var nisha: Human? = Human(name: "Nisha")
var passportOfNisha: Passport? = Passport(citizenship: "Republic of Turkey")

nisha?.passport = passportOfNisha
passportOfNisha?.human = nisha

//nisha = nil
//passportOfNisha = nil

// Ooops! What is hapening?

// Option 1
//nisha = nil
//passportOfNisha = nil


// Option 2
passportOfNisha = nil
nisha = nil
