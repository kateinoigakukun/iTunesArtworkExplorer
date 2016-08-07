//
//  ViewController.swift
//  iTunesArtworkExplorer for Mac
//
//  Created by SaitoYuta on 2016/08/06.
//  Copyright © 2016年 SaitoYuta. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var artistLabel: NSTextField!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var apiResultTableView: NSTableView!
    @IBOutlet weak var artworkImageView: NSImageView!
    
    @IBOutlet weak var queryTextField: NSTextField!
    var model: iTunesArtworkExplorerModel!
    
    @IBAction func searchButton(sender: AnyObject) {
        self.model.getJSON(self.queryTextField.stringValue)
    }
    
    override func loadView() {
        super.loadView()
        
        self.model = iTunesArtworkExplorerModel()
        self.model.addObserver(self, forKeyPath: "isChanged", options: NSKeyValueObservingOptions.New, context: nil)
        self.apiResultTableView.setDelegate(self)
        self.apiResultTableView.setDataSource(self)
        
        NSDistributedNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onPlay), name:"com.apple.iTunes.playerInfo", object: nil)
        
        var artwork: NSImage?
        if let url = self.model.saveArtwork() {
            artwork = NSImage(contentsOfURL: url)
        }
        let currentMusic = self.model.getCurrentMusic()
        setData(currentMusic.name, artist: currentMusic.artist, artwork: artwork)
        self.model.getJSON("\(currentMusic.name) \(currentMusic.artist)")
        // Do any additional setup after loading the view.
    }
    
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if keyPath == "isChanged" {
            if self.model.isChanged == true {
                self.apiResultTableView.reloadData()
                self.model.isChanged = false
            }
        }
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.model.resultData.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        if let aTableColumn = tableColumn {
            if model.resultData.count < row + 1 { return nil }
            switch aTableColumn.identifier {
            case "Artwork":
                return model.resultData[row].artwork
            case "Title":
                return model.resultData[row].name
            case "Artist":
                return model.resultData[row].artist
            case "trackID":
                return model.resultData[row].trackID
            default:
                return nil
            }
        }
        return nil
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        do {
            if model.resultData.count < row + 1 { return true }
            let artworkURL = NSURL(string: self.model.resultData[row].artworkURL)
            let data = try NSData(contentsOfURL: artworkURL!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
            let artwork = NSImage(data: data)!
            let bmap = NSBitmapImageRep(data: artwork.TIFFRepresentation!)
            let userDir = NSProcessInfo.processInfo().environment["HOME"]!
            let highImagePath = "\(userDir)/.iTunesArtworkExplorer/highreso.jpg"
            bmap?.representationUsingType(.NSJPEGFileType, properties: [:])?
                .writeToFile(highImagePath, atomically: true)
            self.model.setArtwork(highImagePath)
        }catch{
            
        }
        return true
    }
    
    func onPlay(notification: NSNotification?)  {
        guard let artist = notification?.userInfo?["Artist"] as? String else {
            return
        }
        guard let name = notification?.userInfo?["Name"] as? String else {
            return
        }
        
        var artwork: NSImage?
        if let url = self.model.saveArtwork() {
            artwork = NSImage(contentsOfURL: url)
        }
        setData(name, artist: artist, artwork: artwork)
        self.model.getJSON("\(name) \(artist)")
        
    }
    
    func setData(name: String, artist: String, artwork: NSImage?) {
        self.artworkImageView.image = artwork
        self.titleLabel.stringValue = name
        self.artistLabel.stringValue = artist
        self.queryTextField.stringValue = "\(name) \(artist)"
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

