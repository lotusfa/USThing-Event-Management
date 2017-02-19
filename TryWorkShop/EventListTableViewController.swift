//
//  EventListTableViewController.swift
//  TryWorkShop
//
//  Created by Ka Wing Leung on 19/2/2017.
//  Copyright © 2017年 1.0. All rights reserved.
//

import UIKit
import SKYKit

class EventListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //signUp()
        login()
        getEventList()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1 //shld be num of events in database
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventItem", for: indexPath)

        // Configure the cell...

        return cell
    }
    
    func signUp(){
        SKYContainer.default().signup(withUsername: "kelvin", password: "1234") { (user, error) in
            if error != nil {
                print ("error signing up user: \(error)")
                return
            }
            
            print ("sign up successful")
            // do something else
        }
    }
    
    func login(){
        SKYContainer.default().login(withUsername: "kelvin", password: "1234") { (user, error) in
            if error != nil {
                print ("error loggin user in \(error)")
                return
            }
            
            print ("login successful")
            // do something else
        }
    }
    
    func getEventList(){
        let query = SKYQuery(recordType: "event", predicate: nil)
        let sortDescriptor = NSSortDescriptor(key: "order", ascending: true)
        query?.sortDescriptors = [sortDescriptor]
        
        SKYContainer.default().privateCloudDatabase.perform(query) { (results, error) in
            if error != nil {
                print ("error querying todos: \(error)")
                return
            }
            
            print ("Received \(results?.count) todos.")
            for todo in results as! [SKYRecord] {
                print ("Got a todo \(todo["name"])")
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
