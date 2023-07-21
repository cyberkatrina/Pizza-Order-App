//
//  PizzaCreationVC.swift
//  Pizza-Order-App
//
//  Created by Katrina Aliashkevich on 10/13/22.
//

import UIKit

class PizzaCreationVC: UIViewController {
    
    // outlet connection for the SegmentedController variable
    @IBOutlet weak var segCtrl: UISegmentedControl!
    // outlet connection for the textField variable
    @IBOutlet weak var textField: UITextView!
    
    // assign the delegate variable to the UpdateTable protocol
    var updateTableDelegate: UpdateTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // function runs when the segmented view controller is selected
    @IBAction func onSegmentChanged(_ sender: Any) {
        switch segCtrl.selectedSegmentIndex{
        // if first segment is pressed, pizza size set to small
        case 0:
            Pizza.pizza!.pSize = "small"
        // if second segment is pressed, pizza size set to medium
        case 1:
            Pizza.pizza!.pSize = "medium"
        // if third segment is pressed, pizza size set to large
        case 2:
            Pizza.pizza!.pSize = "large"
        // default state to small
        default:
            Pizza.pizza!.pSize = "small"
        }
    }
    
    // function runs when selectCrust button is pressed
    @IBAction func selectCrust(_ sender: Any) {
        // brings up an Alert where user chooses crust type from 2 buttons
        let controller = UIAlertController(
            title: "Select crust",
            message: "Choose a crust type:",
            preferredStyle: .alert)
        // if thin crust button is selected, make that the crust type of the pizza object
        controller.addAction(UIAlertAction(
            title: "Thin crust",
            style: .default,
            handler: {
                (action) in Pizza.pizza!.crust = "thin crust"
            }))
        // if thick crust button is selected, make that the crust type of the pizza object
        controller.addAction(UIAlertAction(
            title: "Thick crust",
            style: .default,
            handler: {
                (action) in Pizza.pizza!.crust = "thick crust"
            }))
        present(controller, animated: true)
    }
    
    // function runs when selectCheese button is pressed
    @IBAction func selectCheese(_ sender: Any) {
        // brings up an Action Sheet where user chooses cheese type from 3 options
        let controller = UIAlertController(
            title: "Select cheese",
            message: "Choose a cheese type:",
            preferredStyle: .actionSheet)
        // if regular cheese option is selected, make that the cheese type of the pizza object
        let regCheese = UIAlertAction(
            title: "Regular cheese",
            style: .default,
            handler: {
                (action) in Pizza.pizza!.cheese = "regular cheese"
            })
        controller.addAction(regCheese)
        // if no cheese option is selected, make that the cheese type of the pizza object
        let noCheese = UIAlertAction(
            title: "No cheese",
            style: .default,
            handler: {
                (action) in Pizza.pizza!.cheese = "no cheese"
            })
        controller.addAction(noCheese)
        // if double cheese option is selected, make that the cheese type of the pizza object
        let doubCheese = UIAlertAction(
            title: "Double cheese",
            style: .default,
            handler: {
                (action) in Pizza.pizza!.cheese = "double cheese"
            })
        controller.addAction(doubCheese)
        present(controller, animated: true)
    }
    
    // function runs when selectMeat button is pressed
    @IBAction func selectMeat(_ sender: Any) {
        // brings up an Action Sheet where user chooses meat type from 3 options
        let controller = UIAlertController(
            title: "Select meat",
            message: "Choose one meat:",
            preferredStyle: .actionSheet)
        // if pepperoni option is selected, make that the meat type of the pizza object
        let addPep = UIAlertAction(
            title: "Pepperoni",
            style: .default,
            handler: {
                (action) in Pizza.pizza!.meat = "pepperoni"
            })
        controller.addAction(addPep)
        // if sausage option is selected, make that the meat type of the pizza object
        let addSaus = UIAlertAction(
            title: "Sausage",
            style: .default,
            handler: {
                (action) in Pizza.pizza!.meat = "sausage"
            })
        controller.addAction(addSaus)
        // if canadian bacon option is selected, make that the meat type of the pizza object
        let addCanBac = UIAlertAction(
            title: "Canadian Bacon",
            style: .default,
            handler: {
                (action) in Pizza.pizza!.meat = "canadian bacon"
            })
        controller.addAction(addCanBac)
        present(controller, animated: true)
    }
    
    // function runs when selectVeggies button is pressed
    @IBAction func selectVeggies(_ sender: Any) {
        // brings up an Action Sheet where user chooses veggies type from 5 options
        let controller = UIAlertController(
            title: "Select veggies",
            message: "Choose your veggies:",
            preferredStyle: .actionSheet)
        // if mushroom option is selected, make that the veggies type of the pizza object
        let addMush = UIAlertAction(
            title: "Mushroom",
            style: .default,
            handler: {
                (action) in Pizza.pizza!.veggies = "mushroom"
            })
        controller.addAction(addMush)
        // if onion option is selected, make that the veggies type of the pizza object
        let addOn = UIAlertAction(
            title: "Onion",
            style: .default,
            handler: {
                (action) in Pizza.pizza!.veggies = "onion"
            })
        controller.addAction(addOn)
        // if green olive option is selected, make that the veggies type of the pizza object
        let addGreen = UIAlertAction(
            title: "Green Olive",
            style: .default,
            handler: {
                (action) in Pizza.pizza!.veggies = "green olive"
            })
        controller.addAction(addGreen)
        // if black olive option is selected, make that the veggies type of the pizza object
        let addBlack = UIAlertAction(
            title: "Black Olive",
            style: .default,
            handler: {
                (action) in Pizza.pizza!.veggies = "black olive"
            })
        controller.addAction(addBlack)
        // if none option is selected, make that the veggies type of the pizza object
        let addNone = UIAlertAction(
            title: "None",
            style: .default,
            handler: {
                (action) in Pizza.pizza!.veggies = "none"
            })
        controller.addAction(addNone)
        present(controller, animated: true)
    }
    
    // function runs when Done button is pressed
    @IBAction func donePressed(_ sender: Any) {
        // initialize message to be an empty string
        var message = ""
        // if the veggies of the pizza object is empty
        if Pizza.pizza!.veggies == "" {
            message = "Please select veggies type."
        }
        // if the meat of the pizza object is empty
        if Pizza.pizza!.meat == "" {
            message = "Please select a meat type."
        }
        // if the cheese of the pizza object is empty
        if Pizza.pizza!.cheese == "" {
            message = "Please select a cheese type."
        }
        // if the crust of the pizza object is empty
        if Pizza.pizza!.crust == "" {
            message = "Please select a crust type."
        }
        // if the message isn't an empty string anymore
        if message != "" {
            // bring up an alert for the proper missing ingredient with a single 'OK' button
            let controller = UIAlertController(
                title: "Missing ingredient",
                message: message,
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: {_ in
                }))
            present(controller, animated: true)
            return
        }
        // if all ingredients have been selected, append the pizza object to pizzaList
        Pizza.pizzaList.append(Pizza.pizza!)
        // run the UpdateTable function on the delegate
        updateTableDelegate?.updateTable()
        // assign pizza variable to the current pizza object unwrapped
        let pizza = Pizza.pizza!
        // textField contains the ingredients for this one specific pizza
        textField.text = "One \(pizza.pSize) pizza with:\n    \(pizza.crust)\n    \(pizza.cheese)    \n    \(pizza.meat)\n    \(pizza.veggies)"
        // run the storePizza function on the delegate to store the list of pizza objects
        updateTableDelegate?.storePizza(pizzaList: Pizza.pizzaList)
    }
}
