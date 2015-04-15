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
        
    let notificationCenter = NSNotificationCenter.defaultCenter()
        
    // Call the searchComplete method when this query
    // finds content (either initially, or when new
    //changes are discovered after the app starts)
    notificationCenter.addObserver(self,
        selector: "searchComplete",
        name: NSMetadataQueryDidFinishGatheringNotification,
        object: nil)
    notificationCenter.addObserver(self,
        selector: "searchComplete",
        name: NSMetadataQueryDidUpdateNotification,
        object: nil)
        
    return query
}()
    
deinit {
    // When this object is going away, tidy up after
    // the metadata query
        
// BEGIN stop_query
metadataQuery.stopQuery()
// END stop_query


    let notificationCenter = NSNotificationCenter.defaultCenter()
    notificationCenter.removeObserver(self)
}
// END metadata_query

    
    func saveGameWasUpdated(url : NSURL) {
        let attributes = NSFileManager.defaultManager().attributesOfItemAtPath(url.path!, error: nil)

        let date = attributes?[NSFileModificationDate] as! NSDate
        self.lastSaveGameDateLabel.text = date.description
    }
    
// BEGIN resolve_conflicts
func resolveConflictsForItemAtURL(url : NSURL) {
        
    // 'The version I have is correct; all others are wrong.'
    for conflictVersion in NSFileVersion.unresolvedConflictVersionsOfItemAtURL(url)
        as! [NSFileVersion] {
        // Mark these other versions as resolved; iCloud will tell other
        // devices to update their local copies
        conflictVersion.resolved = true
    }
        
    // Remove our conflicted copies
    NSFileVersion.removeOtherVersionsOfItemAtURL(url, error: nil)
        
}
// END resolve_conflicts
    
// BEGIN search_complete
func searchComplete() {
    for item in metadataQuery.results as! [NSMetadataItem] {
        // Find the URL for the item
        let url = item.valueForAttribute(NSMetadataItemURLKey) as! NSURL
            
        if item.valueForAttribute(NSMetadataUbiquitousItemHasUnresolvedConflictsKey)
            as! Bool == true {
            // Another device has got a conflicting version
            // of this file, and we need to resolve it.
            self.resolveConflictsForItemAtURL(url)
        }
            
        // Has the file already been downloaded?
        if item.valueForAttribute(NSMetadataUbiquitousItemDownloadingStatusKey)
            as! String
            == NSMetadataUbiquitousItemDownloadingStatusCurrent {
                // This file is downloaded and is the most current version;
                // do something with it (like offer to let the user load
                // the saved game)
                self.saveGameWasUpdated(url)
                    
        } else {
            // The file is either not downloaded at all, or is out of date
            // We need to download the file from iCloud; when it finishes
            // downloading, NSMetadataQuery will call this method again
            var error : NSError? = nil
                
            // Ask iCloud to begin downloading.
            NSFileManager.defaultManager()
                .startDownloadingUbiquitousItemAtURL(url, error:&error)
                
            // Check if starting the download didn't work:
            if error != nil {
                println("Problem starting download of \(url): \(error)")
            }
        }
    }
}
// END search_complete
    
    
    func saveGameData() -> NSData {
        return "This is my saved game".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
    }
    
    func saveGameLocally(data : NSData) {
        println("Saving game locally.")
    }
    
    @IBAction func saveGame() {
        
// BEGIN icloud_available
// Get the saved data from somewhere
let saveData : NSData = self.saveGameData()
        
// If we aren't signed in to iCloud, then we must save locally
if NSFileManager.defaultManager().ubiquityIdentityToken == nil {
    saveGameLocally(saveData)
}
// END icloud_available

        
// Attempt to store the file in iCloud
        
// BEGIN store_file
// This must always be done in the background, because
// locating the iCloud container on disk can involve
// setting it up, which can take time.
NSOperationQueue().addOperationWithBlock { () -> Void in
            
    let fileName = "Documents/MySavedGame.save"
            
    if let containerURL = NSFileManager.defaultManager()
        .URLForUbiquityContainerIdentifier(nil) {
                
        let fileURL = containerURL.URLByAppendingPathComponent(fileName)
                
        var error : NSError? = nil

        saveData.writeToURL(fileURL,
            options: NSDataWritingOptions.DataWritingAtomic,
            error: &error)
                
        if error != nil {
            println("Error saving file to iCloud!")
        }
    }
}
// END store_file

        
    }

    @IBAction func levelStepperValueChanged(sender: UIStepper) {
        self.levelNumber = Int(sender.value)
        updateLevelDisplay(self.levelNumber)
    }
    
    var levelNumber : Int {
        
        get {
// BEGIN kv_get
// Retrieve the value from the key-value store
let store = NSUbiquitousKeyValueStore.defaultStore()
return Int(store.longLongForKey("levelNumber"))
// END kv_get
        }
        
        set(value) {
            
// BEGIN kv_set
// Store the value in the key-value store
let store = NSUbiquitousKeyValueStore.defaultStore()
store.setLongLong(Int64(value), forKey: "levelNumber")
            
// Ensure that these changes have been saved to disk
// (note: this doesn't sync the local iCloud container
// with the server, that happens later when the system decides
// it's time)
store.synchronize()
// END kv_set

        }
        
    }
    
    func updateLevelDisplay(levelNumber : Int) {
        self.levelStepper.value = Double(levelNumber)
        self.levelLabel.text = String(levelNumber)
    }
    
    // Someone else change the value on us, so update the
    // interface
    func ubiquitousKeyValueStoreUpdated() {
        self.updateLevelDisplay(self.levelNumber)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
// Start the query
// BEGIN start_query
metadataQuery.startQuery()
// END start_query
        
        NSOperationQueue().addOperationWithBlock { () -> Void in
            // Ensure the container is set up
            if NSFileManager.defaultManager().URLForUbiquityContainerIdentifier(nil) != nil {
                self.updateLevelDisplay(self.levelNumber)
            }
        }
        
// BEGIN kv_notify
// Register to be notified when the key-value store
// is changed by another device
NSNotificationCenter.defaultCenter().addObserver(self,
    selector: "ubiquitousKeyValueStoreUpdated",
    name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification,
    object: nil);
// END kv_notify

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


