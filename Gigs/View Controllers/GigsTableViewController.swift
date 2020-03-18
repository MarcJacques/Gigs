//
//  GigsTableViewController.swift
//  Gigs
//
//  Created by Marc Jacques on 3/17/20.
//  Copyright © 2020 Marc Jacques. All rights reserved.
//

import UIKit

class GigsTableViewController: UITableViewController {
//  MARK: - Properties
    
    let gigController = GigController()
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if gigController.bearer == nil {
            performSegue(withIdentifier: "LoginViewModalSegue", sender: self)
        } else {
//            TODO: fetch gigs here

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GigCell", for: indexPath)

       
        return cell
    }
}

