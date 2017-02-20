//
//  EventDetailsViewController.swift
//  TryWorkShop
//
//  Created by Ka Wing Leung on 19/2/2017.
//  Copyright © 2017年 1.0. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
    var locations : String?
    var images = UIImage(named: "hkust")
    var names : String?
    var dates : String?
    var descriptions : String?

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
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
