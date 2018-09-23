//
//  ViewController.swift
//  weSwift
//
//  Created by Koray Birand on 9/23/18.
//  Copyright © 2018 Koray Birand. All rights reserved.
//

import Cocoa
import WeTransfer



class ViewController: NSViewController {
    
    private enum ViewState {
        case ready
        case selectedMedia
        case startedTransfer
        case transferInProgress
        case failed(error: Error)
        case transferCompleted(shortURL: URL)
    }
    
    @IBOutlet weak var progressView: NSProgressIndicator!
    @IBOutlet weak var titleLabel: NSTextField!
    
    private var progressObservation: NSKeyValueObservation?
    
    private var viewState: ViewState = .ready {
        didSet {
            updateInterface()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWeTransfer()
        
    }
    
    @IBAction func upload(_ sender: Any) {
        
        let uploadfile = loadFile()
        WeTransfer.uploadTransfer(named: "Koray Birand Office", containing: [uploadfile]) { [weak self] state in
            switch state {
            case .uploading(let progress):
                self?.observeUploadProgress(progress)
            case .failed(let error):
                print(error)
            case .completed(let transfer):
                if let url = transfer.shortURL {
                    print(url)
                    self?.viewState = .transferCompleted(shortURL: url)
                }
                
            default:
                break
            }
        }
        
    }
    
    private func observeUploadProgress(_ progress: Progress) {
        
        progressObservation = progress.observe(\.fractionCompleted) { [weak self] (progress, _) in
            DispatchQueue.main.async {
                self?.titleLabel.stringValue = "\(Int(progress.fractionCompleted * 100))% completed"
                self?.progressView.doubleValue = Double((progress.fractionCompleted * 100))
            }
        }
    }
    
    private func updateInterface() {
        
        switch viewState {
        case .ready:
            titleLabel.stringValue = "Add media to transfer"
        case .selectedMedia:
            titleLabel.stringValue = ""
        case .startedTransfer:
            titleLabel.stringValue = "Uploading"
        case .transferInProgress:
            titleLabel.stringValue = "Uploading"
        case .failed:
            titleLabel.stringValue = "Upload failed"
        case .transferCompleted(let shortURL):
            titleLabel.stringValue = "Transfer completed - \(shortURL.absoluteString)"
        }
    }

    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func loadFile() -> URL {
        var getURL : URL!
        if let url = NSOpenPanel().selectFileUrlOpen {
            getURL =  url
        }
        return getURL
    }
    
    private func configureWeTransfer() {
        // Configures the WeTransfer client with the required API key
        // Get an API key at https://developers.wetransfer.com
        WeTransfer.configure(with: WeTransfer.Configuration(apiKey: "YOUR API KEY"))
    }


}

