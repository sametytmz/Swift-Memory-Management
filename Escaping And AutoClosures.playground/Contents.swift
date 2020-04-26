import UIKit

/*
    @escape and @autoclosures
    Problem: What are those?
 */


//: Scenario 1
var closureBlocks: [() -> Void] = []
func funcWithClosure(closure: @escaping () -> Void ) {
    closureBlocks.append(closure)
    print("Function done")
}


// If the closure can be executed after the function finishes == @escaping

//: Scenario 2
func funcWithNetworkingClosure(closure: @escaping () -> Void) {
    DispatchQueue.global().async {
        closure() // Ex) downloading
    }
    print("Function done")
}


funcWithNetworkingClosure {
    for _ in 1...10 {
        print("downloading")
    }
}


//: Normal Function
class Normal {
    let name = "Samet"
    
    func normalFunctionwithClosure(closure: (String) -> Void) {
        closure(self.name)
    }
}

Normal().normalFunctionwithClosure { (myName) in
    print(myName)
}


// By default, normal functions/closures are non-escaping
/*
    Benefits of Non-Escaping
    1- There is no retention cycle for non-escaping
    2- You may use self keyword without worrying about memory leak
    3- Performance and the ability for the compiler to optimize
 */


// @Autoclosure
func checkIDCard(hasCard:() -> Bool) {
    if hasCard() {
        print("You've an ID")
    }
}

checkIDCard(hasCard: { return true })
checkIDCard(hasCard: { true })
checkIDCard { true }

func checkIDCard(hasCard: @autoclosure () -> Bool) {
    if hasCard() {
        print("You've an ID")
    }
}

checkIDCard(hasCard: true)

//: Lazy Init capture
class NewGreet {
    var name = "Samet the Developer"
    
    lazy var greeting: String = {
        return "Hello, \(self.name)"
    }()
    
    deinit {
        print("I'm gone bye..")
    }
}

var sametGreet: NewGreet? = NewGreet()
sametGreet?.greeting
sametGreet = nil

// Non-escaping by default


