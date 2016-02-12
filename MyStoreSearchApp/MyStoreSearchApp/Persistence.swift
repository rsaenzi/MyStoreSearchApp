//
//  Persistence.swift
//  MyStoreSearchApp
//
//  Created by Rigoberto Sáenz Imbacuán on 2/12/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import Foundation
import SQLite

class Persistence {
    
    // -------------------------
    // Members
    // -------------------------
    
    private let databaseName = "Database.db"
    private var database: Connection?
    
    private var tableBrands: Table?
    private var tableClothingTypes: Table?
    
    // Table Clients
    private let brandsColumnId = Expression<Int64>("Id")
    private let brandsColumnName = Expression<String>("Name")
    
    // Table Accounts
    private let clothingTypesColumnId = Expression<Int64>("Id")
    private let clothingTypesColumnName = Expression<Int64>("Name")
    
    
    // -------------------------
    // Singleton
    // -------------------------
    
    static let instance = Persistence()
    private init() {}
    
    
    func doInit(){
        loadDatabase()
    }
    
    
    
    // -------------------------
    // Database Loading
    // -------------------------
    
    private func loadDatabase() {
        
        do{
            
            // 0. Create path to database in documents folder
            let initPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
            let dbPathInDocuments = "\(initPath)/\(databaseName)"
            //print("Persistence: pathInDocuments = \(dbPathInDocuments)")
            
            
            // Delete Database
            do{
                try NSFileManager.defaultManager().removeItemAtPath(dbPathInDocuments)
                print("Persistence: Database deleting success")
                //return
            }catch{}
            
            // 1. Get path to database in bundle
            if let dbPathInBundle = NSBundle.mainBundle().pathForResource(databaseName, ofType: nil) {
                print("Persistence: pathInBundle = \(dbPathInBundle)")
                
                // Delete Database
                //try NSFileManager.defaultManager().removeItemAtPath(dbPathInDocuments)
                //print("Persistence: Database deleting success")
                //return
                
                // 2. Check if a database exist in documents folder
                if NSFileManager.defaultManager().fileExistsAtPath(dbPathInDocuments) == false {
                    print("Persistence: Database dont exist in R/W Documents folder")
                    
                    // 3. Copy database in bundle to documents folder
                    do {
                        try NSFileManager.defaultManager().copyItemAtURL(NSURL(fileURLWithPath: dbPathInBundle), toURL: NSURL(fileURLWithPath: dbPathInDocuments))
                        print("Persistence: Database copying success")
                        
                    }catch{
                        print("Persistence: Database copying failed")
                        return
                    }
                }
                
                // 4. Load database from documents
                print("Persistence: Database exist in R/W Documents folder")
                do{
                    database = try Connection(dbPathInDocuments)
                    print("Persistence: Database loaded from Documents folders")
                    
                }catch{
                    print("Persistence: Cant load database from Documents folders")
                    return
                }
                
                // 5. Load tables
                tableBrands = Table("Brands")
                tableClothingTypes = Table("ClothingTypes")
                print("Persistence: Database tables loaded")
                
            }else {
                print("Persistence: Database dont exist in bundle")
            }
            
        }catch{
            print("Persistence: Process failed...")
        }
    }
    
    func getAllBrands() -> [String] {
        
        // Temp Data
        var brands: [String] =  [] // ["Gap", "Banana Republic", "Boss", "Hugo Boss", "Taylor", "Rebecca Taylor"]
        print("P getAllBrands()")
        for current in brands {
            print("- \(current)")
        }
        
        
        do{
            
            // SELECT * FROM "Brands"
            for persistedBrand in try database!.prepare(tableBrands!) {
                
                // Add brand to list
                brands.insert(String(persistedBrand[brandsColumnName]), atIndex: 0)
                
                print("Persistence: Loaded Brand Id: \(String(persistedBrand[brandsColumnName]))")
            }
            
            print("Persistence: Query getAllBrands Success")
            
        }catch{
            print("Persistence: Query getAllBrands Failed")
        }
        
        
        return brands
    }
    
    func getAllClothingTypes() -> [String] {
        
        // Temp Data
        var clothingTypes: [String] = ["Denim", "Pants", "Sweaters", "Skirts", "Dresses"]
        print("P getAllClothingTypes()")
        for current in clothingTypes {
            print("- \(current)")
        }
        
        /*
        do{
            
            // SELECT * FROM "ClothingTypes"
            for persistedClothingType in try database!.prepare(tableClothingTypes!) {
                
                // Add Clothing Type to list
                clothingTypes.insert(String(persistedClothingType[clothingTypesColumnName]), atIndex: 0)
                
                print("Persistence: Loaded ClothingType Id: \(String(persistedClothingType[clothingTypesColumnName]))")
            }
            
            print("Persistence: Query getAllClothingTypes Success")
            
        }catch{
            print("Persistence: Query getAllClothingTypes Failed")
        }
        */
        
        return clothingTypes
    }
    
}