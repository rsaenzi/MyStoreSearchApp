//
//  ResultsViewController.swift
//  MyStoreSearchApp
//
//  Created by Rigoberto Sáenz Imbacuán on 2/12/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class ResultsViewController: UITableViewController {
    
    // Data Source
    private var allBrands = [String]()
    private var allClothingTypes = [String]()
    
    // Query
    public var queryString = ""
    
    // Results
    private var resultsBrands = [String]()
    private var resultsClothingTypes = [String]()
    private var resultsNone = [String]()
    
    // -------------------------
    // UIViewController
    // -------------------------
    
    override func viewDidAppear(animated: Bool) { // Called when the view is about to made visible. Default does nothing
        
        // Obtenemos la data a procesar
        allBrands = Persistence.instance.getAllBrands()
        allClothingTypes = Persistence.instance.getAllClothingTypes()
        
        // Separamos las palabras individuales del query
        let allWords: [String] = queryString.componentsSeparatedByString(" ")
        
        print("Query Words:")
        for word in allWords {
            print("- \(word)")
            
            var addedFlag = false
            
            // Buscamos la palabra en las listas
            for brandName in allBrands {
                
                if (brandName.lowercaseString.rangeOfString(word.lowercaseString) != nil) {
                    resultsBrands.append(brandName)
                    addedFlag = true
                }
            }
            
            for typeName in allClothingTypes {
                
                if (typeName.lowercaseString.rangeOfString(word.lowercaseString) != nil) {
                    resultsClothingTypes.append(typeName)
                    addedFlag = true
                }
            }
            
            if addedFlag == false {
                resultsNone.append(word)
            }
            
        }
        
        // Recargamos la data de la tabla
        self.tableView.reloadData()
    }
    
    
    // -------------------------
    // UITableViewController
    // -------------------------
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return resultsBrands.count
            
        case 1:
            return resultsClothingTypes.count
            
        case 2:
            return resultsNone.count
            
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //        print("Section: \(indexPath.section) - Row: \(indexPath.row)" )
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = resultsBrands[indexPath.row]
            
        case 1:
            cell.textLabel?.text = resultsClothingTypes[indexPath.row]
            
        case 2:
            cell.textLabel?.text = resultsNone[indexPath.row]
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Brand"
            
        case 1:
            return "Clothing Type"
            
        case 2:
            return "Result Query"
            
        default:
            return ""
        }
    }
    
}
