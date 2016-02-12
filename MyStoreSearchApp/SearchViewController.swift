//
//  SearchViewController.swift
//  MyStoreSearchApp
//
//  Created by Rigoberto Sáenz Imbacuán on 2/12/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var textfieldQuery: UITextField!
    
    @IBAction func onClickSearch(sender: UIButton, forEvent event: UIEvent) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Enviamos el query de busqueda al VC de resultados
        let resultsVC = segue.destinationViewController as! ResultsViewController
        resultsVC.queryString = textfieldQuery.text!
    }
    
}
