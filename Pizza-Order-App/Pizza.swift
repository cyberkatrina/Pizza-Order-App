//
//  Pizza.swift
//  Pizza-Order-App
//
//  Created by Katrina Aliashkevich on 10/17/22.
//

import UIKit

// Pizza class with all the properties of a pizza
class Pizza {
    
    var pSize: String
    var crust: String
    var cheese: String
    var meat: String
    var veggies: String
    
    // initualize pizzaList variable to be an empty list
    static var pizzaList:[Pizza] = []
    // initualize current pizza variable to be nil
    static var pizza: Pizza? = nil
    
    init() {
        // default size automatically set to 'small', everything else automatically empty
        pSize = "small"
        crust = ""
        cheese = ""
        meat = ""
        veggies = ""
    }
    
    // creates an empty object of class Pizza
    static func startPizza() {
        pizza = Pizza()
    }
}
