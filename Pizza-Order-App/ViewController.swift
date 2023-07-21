//
//  ViewController.swift
//  Pizza-Order-App
//
//  Created by Katrina Aliashkevich on 10/13/22.
//

import UIKit
import FirebaseAuth
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

// initualize UpdateTable protocol that runs the updateTable() function and the storePizza() function
protocol UpdateTable {
    func updateTable()
    func storePizza(pizzaList: [Pizza])
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateTable {
    
    // outlet connection for the tableView variable
    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // retrieve previous pizzas from core data
        retrievePizza()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // function that stores the list of pizza objects in the core data
    func storePizza(pizzaList: [Pizza]) {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PizzaDTO")
            var fetchedResults:[NSManagedObject]
            try fetchedResults = context.fetch(request) as! [NSManagedObject]
            if fetchedResults.count > 0 {
                for result:AnyObject in fetchedResults {
                    context.delete(result as! NSManagedObject)
                }
            }
            // traverse each pizza object in pizza list
            for pizza in pizzaList {
                let pizzaDTO = NSEntityDescription.insertNewObject(forEntityName: "PizzaDTO", into: context)
                // set the size for pizza in core data
                pizzaDTO.setValue(pizza.pSize, forKey: "pSize")
                // set the crust for pizza in core data
                pizzaDTO.setValue(pizza.crust, forKey: "crust")
                // set the cheese for pizza in core data
                pizzaDTO.setValue(pizza.cheese, forKey: "cheese")
                // set the meat for pizza in core data
                pizzaDTO.setValue(pizza.meat, forKey: "meat")
                // set the veggies for pizza in core data
                pizzaDTO.setValue(pizza.veggies, forKey: "veggies")
            }
            // commit the changes
            saveContext()
        } catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    // function that retrieves the list of pizza objects from the core data
    func retrievePizza() -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PizzaDTO")
        var fetchedResults:[NSManagedObject]? = nil
        do {
            // create empty list of pizza objects
            var pizzaList:[Pizza] = []
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
            // traverse each dto instance inside the core data
            for dto in fetchedResults! {
                // create new Pizza object called pizza
                let pizza = Pizza()
                // set the size of pizza object to be the string from core data
                pizza.pSize = dto.value(forKey: "pSize") as! String
                // set the crust of pizza object to be the string from core data
                pizza.crust = dto.value(forKey: "crust") as! String
                // set the cheese of pizza object to be the string from core data
                pizza.cheese = dto.value(forKey: "cheese") as! String
                // set the meat of pizza object to be the string from core data
                pizza.meat = dto.value(forKey: "meat") as! String
                // set the veggies of pizza object to be the string from core data
                pizza.veggies = dto.value(forKey: "veggies") as! String
                // append the current pizza object to the pizzaList
                pizzaList.append(pizza)
            }
            // make the pizzaList of the Pizza object the same as the list we just created from core data
            Pizza.pizzaList = pizzaList
        } catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        return(fetchedResults)!
    }
    
    // function that clears the core data
    func clearCoreData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PizzaDTO")
        var fetchedResults:[NSManagedObject]
        do {
            try fetchedResults = context.fetch(request) as! [NSManagedObject]
            if fetchedResults.count > 0 {
                for result:AnyObject in fetchedResults {
                    context.delete(result as! NSManagedObject)
                }
            }
            saveContext()
        } catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }

    // function that saves the context if it has changed
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Function that calculates how many pizzas are in the pizzaList/tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Pizza.pizzaList.count
    }
    
    // function to access each cell (row) of the tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // assign cell to be the selected cell in tableView
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        // assign row to be the selected row index of the tableView
        let row = indexPath.row
        // assign pizza to be the pizza in pizzaList at the same index as row
        let pizza = Pizza.pizzaList[row]
        // update the textLabel of the current cell to be ingredients of the pizza
        cell.textLabel?.text = "\(pizza.pSize)\n    \(pizza.crust)\n    \(pizza.cheese)    \n    \(pizza.meat)\n    \(pizza.veggies)"
        return cell
    }
    
    // function to deselect the selected row in tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // assign cell to be the selected cell in tableView
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        // assign row to be the selected row index of the tableView
        let row = indexPath.row
        // assign pizza to be the pizza in pizzaList at the same index as row
        let pizza = Pizza.pizzaList[row]
        if editingStyle == .delete {
            Pizza.pizzaList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            // update the textLabel of the current cell to be ingredients of the pizza
            cell.textLabel?.text = "\(pizza.pSize)\n    \(pizza.crust)\n    \(pizza.cheese)    \n    \(pizza.meat)\n    \(pizza.veggies)"
            //return cell
        }
        // store the pizzaList of the Pizza object in the core data
        storePizza(pizzaList: Pizza.pizzaList)
    }
    
    // function runs before the PizzaCreationSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PizzaCreationSegue",
            let nextVC = segue.destination as? PizzaCreationVC {
             // make current View Controller the delegate of nextVC
             nextVC.updateTableDelegate = self
         }
            // run the startPizza() function of the Pizza class
            Pizza.startPizza()
            // chnage the 'back' navigation arrow to say 'pizza order' instead
            let backItem = UIBarButtonItem()
            backItem.title = "Pizza Order"
            navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        }
    
    // function that updates the tableView by reloading the data
    func updateTable() {
        self.tableView.reloadData()
    }
    
    // function runs when logOut button is pressed
    @IBAction func logOutPressed(_ sender: Any) {
        do {
            // sign out of firebase auth
            try Auth.auth().signOut()
            self.dismiss(animated: true)
        } catch {
            print("Sign Out error")
        }
    }
}
