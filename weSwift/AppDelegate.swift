//
//  AppDelegate.swift
//  weSwift
//
//  Created by Koray Birand on 9/23/18.
//  Copyright © 2018 Koray Birand. All rights reserved.
//

import Cocoa

extension NSOpenPanel {
    var selectUrlOpen: URL? {
        title = "Select Folder"
        allowsMultipleSelection = false
        canChooseDirectories = true
        canChooseFiles = false
        canCreateDirectories = true
        //allowedFileTypes = ["mov","mp4"]  // to allow only images, just comment out this line to allow any file type to be selected
        return runModal() == .OK ? urls.first : nil
    }
    
    var selectFileUrlOpen: URL? {
        title = "Select Database"
        allowsMultipleSelection = false
        canChooseDirectories = false
        canChooseFiles = true
        canCreateDirectories = false
        //allowedFileTypes = ["db","sql"]  // to allow only images, just comment out this line to allow any file type to be selected
        return runModal() == .OK ? urls.first : nil
    }
    
    var exportFolder: URL? {
        title = "Select Folder to Export"
        allowsMultipleSelection = false
        canChooseDirectories = true
        canChooseFiles = false
        canCreateDirectories = true
        return runModal() == .OK ? urls.first : nil
    }
}

extension NSSavePanel {
    var selectUrlSave: URL? {
        title = "Select Folder and Name"
        nameFieldStringValue = "newname.jpg"
        canCreateDirectories = true
        return runModal() == .OK ? url : nil
    }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

