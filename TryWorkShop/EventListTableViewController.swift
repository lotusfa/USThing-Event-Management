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

    var locations = ["LTA","LTB","LTC","LTAD","LTE","LTA","LTB","LTC","LTAD","LTE"]
    var images = [UIImage(named: "hkust")]
    var names = [String]()
    var dates = [String]()
    var descriptions = [String]()
    var parti_ids = [SKYRecordID]()

//    //for storing selected cell data
//    var location : String = ""
//    var image = UIImage(named: "hkust")
//    var name : String = ""
//    var date : String = ""
//    var descriptionForNextPage: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //signUp()

        login()
        getEvent()
    
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
        return names.count //shld be num of events in database
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventItem", for: indexPath) as! EventListTableViewCell

        // Configure the cell...
        cell.photo.image = images[0]
        cell.name.text = names[indexPath.row]
        cell.date.text = dates[indexPath.row]
        cell.location.text = locations[indexPath.row]

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

    
    func getEvent() {
        
        print ("getting event")
        let query = SKYQuery(recordType: "event", predicate: nil)
        
        SKYContainer.default().publicCloudDatabase.perform(query) { (results, error) in
            if error != nil {
                print ("error querying events: \(error)")
                return
            }
            
            print ("Received \(results?.count) events.")
            
            for event in results as! [SKYRecord] {
                
                /*
                let beginTime = event.object(forKey: "beginTime")
                let endTime = (event["endTime"])
                let appendString = "\(beginTime) \(endTime)"
                print("print(appendString):")
                print(appendString)
                */
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = DateFormatter.Style.medium
                let string1 = dateFormatter.string(from: (event["beginTime"] as! Date))
                let string2 = dateFormatter.string(from: (event["endTime"] as! Date))
                let string3 = " - "
                let appendString = "\(string1) \(string3) \(string2)"
                
                self.names.append(event["name"] as! String)
                self.dates.append(appendString)
                self.descriptions.append(event["description"] as! String)
                self.parti_ids.append(event.recordID)
                
                print ("Name: \(event["name"])")
                //print ("Begin Time: \(event["beginTime"])")
                //print ("End Time: \(event["endTime"])")
                //print ("Got a event \(event["description"])")
            }
            self.tableView.reloadData()
        }
        
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*string2	String	""
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! EventDetailsViewController
        
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath

        vc.images = images[0]
        vc.names = names[indexPath.row]
        vc.dates = dates[indexPath.row]
        vc.locations = locations[indexPath.row]
        vc.descriptions = descriptions[indexPath.row]
        vc.parti_id = self.parti_ids[indexPath.row]
        
    }
    

}
