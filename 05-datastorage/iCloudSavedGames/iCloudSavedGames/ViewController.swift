//
//  ViewController.swift
//  iCloudSavedGames
//
//  Created by Jon Manning on 4/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lastSaveGameDateLabel: UILabel!
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelStepper: UIStepper!
    
    // BEGIN metadata_query
    lazy var metadataQuery : NSMetadataQuery = {
        let query = NSMetadataQuery()
        
        // Search for all files whose name end in .save in the iCloud
        // container's documents folder
        query.searchScopes = [NSMetadataQueryUbiquitousDocumentsScope]
        query.predicate = NSPredicate(format: "%K LIKE '*.save'",
                                      NSMetadataItemFSNameKey)
        
        let notificationCenter = NotificationCenter.default
        
        // Call the searchComplete method when this query
        // finds content (either initially, or when new
        //changes are discovered after the app starts)
        notificationCenter.addObserver(self,
                                       selector: #selector(ViewController.searchComplete),
                                       name: .NSMetadataQueryDidFinishGathering,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(ViewController.searchComplete),
                                       name: .NSMetadataQueryDidUpdate,
                                       object: nil)
        
        return query
    }()
    
    deinit {
        // When this object is going away, tidy up after
        // the metadata query
        
        // BEGIN stop_query
        metadataQuery.stop()
        // END stop_query
        
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    // END metadata_query
    
    
    func saveGameWasUpdated(url : URL) {
        let attributes = try! FileManager.default.attributesOfItem(atPath: url.path)
        
        let date = attributes[FileAttributeKey.modificationDate] as! Date
        self.lastSaveGameDateLabel.text = date.description
    }
    
    // BEGIN resolve_conflicts
    func resolveConflictsForItemAtURL(url : URL) {
        
        // 'The version I have is correct; all others are wrong.'
        for conflictVersion in NSFileVersion.unresolvedConflictVersionsOfItem(at: url)! {
            // Mark these other versions as resolved; iCloud will tell other
            // devices to update their local copies
            conflictVersion.isResolved = true
        }
        
        // Remove our conflicted copies
        try! NSFileVersion.removeOtherVersionsOfItem(at: url)
        
    }
    // END resolve_conflicts
    
    // BEGIN search_complete
    @objc func searchComplete() {
        for item in metadataQuery.results as! [NSMetadataItem] {
            // Find the URL for the item
            let url = item.value(forAttribute: NSMetadataItemURLKey) as! URL
            
            if item.value(forAttribute: NSMetadataUbiquitousItemHasUnresolvedConflictsKey)
                as! Bool == true {
                // Another device has got a conflicting version
                // of this file, and we need to resolve it.
                self.resolveConflictsForItemAtURL(url: url)
            }
            
            // Has the file already been downloaded?
            if item.value(forAttribute: NSMetadataUbiquitousItemDownloadingStatusKey)
                as! String
                == NSMetadataUbiquitousItemDownloadingStatusCurrent {
                // This file is downloaded and is the most current version;
                // do something with it (like offer to let the user load
                // the saved game)
                self.saveGameWasUpdated(url: url)
                
            } else {
                // The file is either not downloaded at all, or is out of date
                // We need to download the file from iCloud; when it finishes
                // downloading, NSMetadataQuery will call this method again
                
                // Ask iCloud to begin downloading.
                do {
                    try FileManager.default
                        .startDownloadingUbiquitousItem(at: url)
                } catch let error {
                    print("Problem starting download of \(url): \(error)")
                }
                
                
            }
        }
    }
    // END search_complete
    
    
    func saveGameData() -> Data {
        return "This is my saved game".data(
            using: String.Encoding.utf8,
            allowLossyConversion: false
            )!
    }
    
    func saveGameLocally(data : Data) {
        print("Saving game locally.")
    }
    
    @IBAction func saveGame() {
        
        // BEGIN icloud_available
        // Get the saved data from somewhere
        let saveData : Data = self.saveGameData()
        
        // If we aren't signed in to iCloud, then we must save locally
        if FileManager.default.ubiquityIdentityToken == nil {
            saveGameLocally(data: saveData)
        }
        // END icloud_available
        
        
        // Attempt to store the file in iCloud
        
        // BEGIN store_file
        // This must always be done in the background, because
        // locating the iCloud container on disk can involve
        // setting it up, which can take time.
        OperationQueue().addOperation { () -> Void in
            
            let fileName = "Documents/MySavedGame.save"
            
            if let containerURL = FileManager.default
                .url(forUbiquityContainerIdentifier: nil) {
                
                let fileURL = containerURL.appendingPathComponent(fileName)
                
                do {
                    try saveData.write(to: fileURL,
                                       options: Data.WritingOptions.atomic
                    )
                    
                } catch let error {
                    print("Error saving file to iCloud! \(error)")
                }
            }
        }
        // END store_file
        
        
    }
    
    @IBAction func levelStepperValueChanged(_ sender: UIStepper) {
        self.levelNumber = Int(sender.value)
        updateLevelDisplay(levelNumber: self.levelNumber)
    }
    
    var levelNumber : Int {
        
        get {
            // BEGIN kv_get
            // Retrieve the value from the key-value store
            let store = NSUbiquitousKeyValueStore.default
            return Int(store.longLong(forKey: "levelNumber"))
            // END kv_get
        }
        
        set(value) {
            
            // BEGIN kv_set
            // Store the value in the key-value store
            let store = NSUbiquitousKeyValueStore.default
            store.set(Int64(value), forKey: "levelNumber")
            
            // Ensure that these changes have been saved to disk
            // (note: this doesn't sync the local iCloud container
            // with the server, that happens later when the system decides
            // it's time)
            store.synchronize()
            // END kv_set
            
        }
        
    }
    
    func updateLevelDisplay(levelNumber : Int) {
        // Ensure that we're working with the UI elements
        // on the main queue only
        OperationQueue.main.addOperation {
            self.levelStepper.value = Double(levelNumber)
            self.levelLabel.text = String(levelNumber)
        }
    }
    
    // Someone else changed the value on us, so update the
    // interface
    @objc func ubiquitousKeyValueStoreUpdated() {
        self.updateLevelDisplay(levelNumber: self.levelNumber)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start the query
        // BEGIN start_query
        metadataQuery.start()
        // END start_query
        
        OperationQueue().addOperation { () -> Void in
            // Ensure the container is set up
            if FileManager.default.url(forUbiquityContainerIdentifier: nil) != nil {
                self.updateLevelDisplay(levelNumber: self.levelNumber)
            }
        }
        
        // BEGIN kv_notify
        // Register to be notified when the key-value store
        // is changed by another device
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.ubiquitousKeyValueStoreUpdated),
                                               name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
                                               object: nil);
        // END kv_notify
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


