import UIKit

/*
    Closure Retain Cycle
    1- Problem: How to use capture lists to prevent retain cycle in closures
    2- When to use unowned
 */


//: Design Class
class FirstClass {
    var firstClosure: (()-> ())?
    var name: String = "Samet"
    
    init() {
        firstClosure = { [weak self] in
            guard let self = self else { return }
            print("\(self.name) the Developer")
        }
    }
    deinit {
        print("FirstClass has gone")
    }
}

// Or

/*
 class FirstClass {
     var firstClosure: (()-> ())?
     var name: String = "Samet"
     
     init() {
         firstClosure = { [unowned self] in
             print("\(self.name) the Developer")
         }
     }
     deinit {
         print("FirstClass has gone")
     }
 }
 */

var firstInstance: FirstClass? = FirstClass()
firstInstance?.firstClosure?()

firstInstance = nil


//: Design Independent Class
class Owner {
    var creditCard: CreditCard?
    deinit {
        print("Owner gone")
    }
}


//: Design Dependent Class
class CreditCard {
    unowned let owner: Owner
    init(enterOwner: Owner) {
        owner = enterOwner
    }
    deinit {
        print("Card gone")
    }
}


//: Create Instances
var samet: Owner? = Owner()

var myCard: CreditCard = CreditCard(enterOwner: samet!)
samet?.creditCard = myCard

samet = nil
myCard.owner // crash

// You should not use unowned like that. But you can use unowned like that is '[unowned self]'
