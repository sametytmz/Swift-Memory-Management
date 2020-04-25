import UIKit

/*
    Delegate Retain Cycle
    Problem: Why delegate should be weak var
 */


//: Design Protocol
protocol SendDataDelegate: class {}

//: Design Sender.Delegator
class SendingVC {
    weak var delegate: SendDataDelegate?
    //var delegate: SendDataDelegate?
    
    deinit {
        print("Delegator gone")
    }
}


//: Design Receiver/Delegate
class ReceivingVC: SendDataDelegate {
    lazy var sendingVC: SendingVC = {
        let vc = SendingVC()
        vc.delegate = self
        return vc
    }()
    
    deinit {
        print("Delegate gone")
    }
}

var receivingVC: ReceivingVC? = ReceivingVC()
receivingVC?.sendingVC

receivingVC = nil

/*
    Note:
        Memory Management also retain cycle only occurs when you are working with such as classes and closures.
        So weak, you were working with struct or one of the value types, you don't have to worry about beating cycle.
        
      Rules
      -- A 'weak' reference allows the referencing object to becoming 'nil'
        (this happens automatically when the referenced object is deallocated).
      -- Base on the rule above, the referencing object/variable must be optional.
 */
