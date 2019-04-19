//
//  ViewController.swift
//  Notifications
//
//  Created by Khaled Bohout on 2/13/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //step1: Ask for user permission
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound], completionHandler: { (granted, error) in
            if granted {
            print("notification granted")
            }
            else  {
                print(error?.localizedDescription as Any)
            
            }
        })
    }
    @IBAction func notifymebuttontapped(sender: UIButton){
        schedulenotification(inSeconds: 5, completion: {success in
            if success{
            print("great,successfully schedueled notification")
            }
            else{
                print("error scheduling notification")
            }
        })
        
    }
    func schedulenotification(inSeconds: TimeInterval,completion:@escaping (_ Success: Bool) ->()){
        
        //step2: add ann attatchment
        let image = "rick_grimes"
        guard let imageurl = Bundle.main.url(forResource: image, withExtension: "gif") else{
            completion(false)
            return
        }
        var attachment : UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "mynotification", url: imageurl, options: .none)
        
        //step3:creat notification content
        let notif = UNMutableNotificationContent()
        
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "new notification"
        notif.subtitle = "this is great!"
        notif.body = " my new ios notification app, what do you think?"
        notif.attachments = [attachment]
        
        //step4:creat notification triigger
        let notiftrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        //step5:creatrequest
        let request = UNNotificationRequest(identifier: "mynotification", content: notif, trigger: notiftrigger)
        
        //step6:register request to notification center
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            if error != nil {
                print(error as Any)
                completion(false)
            }
            else {
                completion(true)
            }
            
        })
    }
    
    }




