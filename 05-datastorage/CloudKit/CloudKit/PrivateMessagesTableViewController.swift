//
//  PrivateMessagesTableViewController.swift
//  CloudKitDemo
//
//  Created by Jon Manning on 30/1/18.
//  Copyright © 2018 Jon Manning. All rights reserved.
//

import UIKit
import CloudKit

class PrivateMessagesTableViewController: MessagesTableViewController {

    override var database: CKDatabase {
        return CKContainer.default().privateCloudDatabase
    }

}
