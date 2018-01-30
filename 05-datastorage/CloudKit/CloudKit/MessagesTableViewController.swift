//
//  MessagesTableViewController.swift
//  CloudKit
//
//  Created by Jon Manning on 30/1/18.
//  Copyright © 2018 Jon Manning. All rights reserved.
//

import UIKit
import CloudKit

// Use an enum for record keys rather than strings
// for better type-checking
enum NoteRecordKey : String {
    case contents
}

let NoteRecordType = "Note"

class MessagesTableViewController: UITableViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var database : CKDatabase {
        return CKContainer.default().publicCloudDatabase
    }
    
    @IBAction func addMessage(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Message", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            
        }
        
        alert.addAction(UIAlertAction(title: "Post", style: .default, handler: { (UIAlertAction) in
            
            let message = alert.textFields?.first?.text ?? ""
            
            OperationQueue.main.addOperation {
                self.saveNewMessage(text: message)
            }
            
        }))
        
        
        alert.addAction(
            UIAlertAction(title: "Cancel",
                          style: .cancel,
                          handler: {
                            (UIAlertAction) in
                            print("Canceled saving message")
                            
            }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func saveNewMessage(text: String) {
        
        
        let record = CKRecord(recordType: NoteRecordType)
        
        record.setObject(text as CKRecordValue, forKey: NoteRecordKey.contents.rawValue)
        
        self.database.save(record, completionHandler: { (record, error) in
            
            if let record = record {
                print("Successfully saved record \(record.recordID)")
                
                // Immediately add this record to the top of the list, which is where it would be if we'd done a full refresh
                OperationQueue.main.addOperation {
                    self.records.insert(record, at: 0)
                    self.tableView.reloadData()
                }
                
            } else if let error = error {
                print("Error saving record: \(error)")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.addButton.isEnabled = false
        
        CKContainer.default().accountStatus { (accountStatus, error) in
            
            if let error = error {
                print("Error checking account status: \(error)")
            }
            
            switch accountStatus {
            case .available:
                self.addButton.isEnabled = true
            default:
                print("The user's account is not available.")
            }
            
        }
        
        self.refreshControl = UIRefreshControl()
        
        self.refreshControl?.addTarget(self, action: #selector(MessagesTableViewController.refreshList), for: UIControlEvents.valueChanged)
        
        
        self.refreshControl?.beginRefreshing()
        self.refreshList()
        
    }
    
    @objc func refreshList() {
        print("Refreshing list!")
        
        let allRecordsPredicate = NSPredicate(format: "TRUEPREDICATE")
        
        let sortDescriptor = NSSortDescriptor(key: "modificationDate", ascending: false)
        
        let query = CKQuery(recordType: NoteRecordType, predicate: allRecordsPredicate)
        
        query.sortDescriptors = [sortDescriptor]
        
        
        self.database.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print("Failed to query records: \(error)")
            } else if let records = records {
                self.records = records
                print("Loaded \(records.count) records.")
                self.tableView.reloadData()
            } else {
                fatalError("Failed to query records, but also didn't get an error?")
            }
            
            self.refreshControl?.endRefreshing()
            
        }
        
    }
    
    var records : [CKRecord] = []
    
    lazy var dateFormatter : DateFormatter = {
        let d = DateFormatter()
        d.timeStyle = .none
        d.dateStyle = .short
        return d
    }()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.records.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)

        // Configure the cell...
        
        let record = self.records[indexPath.row]
        
        let message = record.object(forKey: "contents") as? String ?? ""
        
        let date = record.object(forKey: "modifiedAt") as? Date ?? Date()
        
        let dateString = self.dateFormatter.string(from: date)
        
        cell.textLabel?.text = message
        cell.detailTextLabel?.text = dateString

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let record = self.records[indexPath.row]
            
            
            
            self.database.delete(withRecordID: record.recordID, completionHandler: { (recordID, error) in
                
                if let error = error {
                    print("Error removing record: \(error)")
                } else if let recordID = recordID {
                    print("Removed record \(recordID)")
                } else {
                    fatalError("Didn't get a record ID or an error?")
                }
                
            })
            
            self.records.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

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
