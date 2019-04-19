//
//  NotificationViewController.swift
//  MyContentExtension
//
//  Created by Khaled Bohout on 2/14/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageview : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        guard let attachment = notification.request.content.attachments.first else {
            return
        }
        if attachment.url.startAccessingSecurityScopedResource(){
            let imagedata = try? Data.init(contentsOf : attachment.url)
            if let img = imagedata{
                imageview.image = UIImage(data: img)
            }
        }
    }

}
