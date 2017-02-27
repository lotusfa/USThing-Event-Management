//
//  EventDetailsViewController.swift
//  TryWorkShop
//
//  Created by Ka Wing Leung on 19/2/2017.
//  Copyright © 2017年 1.0. All rights reserved.
//

import UIKit
import SKYKit
import SwiftyJSON

class EventDetailsViewController: UIViewController {
    var locations : String?
    var images = UIImage(named: "hkust")
    var names : String?
    var dates : String?
    var descriptions : String?
    var eventRecord_id : SKYRecordID!
    var parti : JSON!
    var myITSC = "kelvinITSC"

    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var location: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        photo.image = images
        name.text = names
        fee.text = "$1,000"
        date.text = dates
        location.text = locations
        eventDescription.text = descriptions
        
        print("\(name.text)")
        print("\(date.text)")
        print("\(location.text)")
        print("\(eventDescription.text)")
        print("123")
        print("\(eventRecord_id.recordName)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func joinPressed(_ sender: UIButton) {
        //retrieve itsc
        //MR_findAllWithPredicate function will find the user isLoggedin in local database
//        NSArray *users = [User MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"isLoggedin == 1"]];
//        if (users.count > 0) {
//            User *user = users[0];
//            _logggedinasLabel.text = [NSString stringWithFormat:@"Logged in as %@",user.username];
//        }
//        else {
//            let alert = UIAlertController(title: "You have not logged in yet.", message: "", preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
        
        //retrieve participants and update it
        let recordID = SKYRecordID(recordType: "event", name: eventRecord_id.recordName)
        print("\(eventRecord_id.recordName)")
        SKYContainer.default().publicCloudDatabase.fetchRecord(with: recordID) { (record, error) in
            if error != nil {
                print ("error fetching todo: \(error)")
                return
            }
            
            let eventParticipants = record?.object(forKey: "participants") as! NSDictionary
            
            let string1 = (eventParticipants.value(forKeyPath: "participants") as! String)
            let string2 = self.myITSC
            let string3 = "-"
            let appendString = "\(string1)\(string3)\(string2)"

            eventParticipants.setValue( "\(appendString)" , forKey: "participants")
            
            let jsonData = "{  \"participants\": \"\(appendString)\"}"
            //let jsonData = "{\"participants\": \"-hnwongab\"}"
            print(jsonData)
            
            let updatedParti = jsonData //shld modify parti and store to updatedParti
            
            /*
            let updatedRecord = SKYRecord(recordType: "event", name: self.eventRecord_id.recordName)
            updatedRecord?.setObject(<#T##object: Any!##Any!#>, forKey: "participants" as NSCopying!)
            updatedRecord?.setObject(appendString, forKey: "participants" as NSCopying!)
            SKYContainer.default().publicCloudDatabase.save(updatedRecord, completion: nil)
            */
            
            
            print ("\(eventParticipants)")
            let updatedRecord = SKYRecord(recordType: "event")
            updatedRecord?.setObject( eventParticipants , forKey: "participants" as NSCopying!)
            
            let publicDB = SKYContainer.default().publicCloudDatabase
            publicDB?.save(updatedRecord , completion: { (record, error) in
                if error != nil {
                    print ("error saving participants: \(error)")
                    return
                }
                
                print ("saved participants with record = \(record?.recordID)")
            })
            
            print ("updated")
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
