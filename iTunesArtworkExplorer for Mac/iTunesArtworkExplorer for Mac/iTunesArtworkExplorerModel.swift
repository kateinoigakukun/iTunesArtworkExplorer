//
//  File.swift
//  iTunesArtworkExplorer for Mac
//
//  Created by SaitoYuta on 2016/08/06.
//  Copyright © 2016年 SaitoYuta. All rights reserved.
//

import Foundation
import APIKit
import SwiftyJSON
import ScriptingBridge

class iTunesArtworkExplorerModel: NSObject {
    var resultData: [iTunesAPIEntity] = []
    dynamic var isChanged: Bool = false
    func getJSON(term: String) {
        self.resultData = []
        let request = iTunesSearchAPI(term: term, country: .jp, limit: 10)
        Session.sendRequest(request) {
            result in
            switch result {
            case .Success(let json):
                
                let results = json["results"]
                results.arrayValue.forEach {result in
                    let item = result.dictionaryValue
                    let urlStr = item["artworkUrl100"]!.stringValue
                    let artworkURL = NSURL(string: urlStr)
                    do {
                        let data = try NSData(contentsOfURL: artworkURL!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                        let artwork = NSImage(data: data)!
                        artwork.size.height = 100
                        artwork.size.width = 100
                        
                        let name = item["trackName"]!.stringValue
                        let artist = item["artistName"]!.stringValue
                        let trackID = item["trackId"]!.stringValue
                        let artworkURL = urlStr.stringByReplacingOccurrencesOfString("100", withString: "1400")
                        let entity = iTunesAPIEntity(
                            name: name,
                            artist: artist,
                            artwork: artwork,
                            trackID: trackID,
                            artworkURL: artworkURL
                        )
                        self.resultData.append(entity)
                        
                    }catch{
                        print("error")
                    }
                }
                self.isChanged = true
                
                
            case .Failure(let error):
                print("error: \(error)")
            }
        }
        
    }
    
    func getCurrentMusic() -> (name: String, artist: String) {
        let getNameAS = "tell application \"iTunes\"\n"
        +                   "set currentTrack to current track\n"
        +                   "return name of currentTrack\n"
        +               "end tell"
        
        let getArtist = "tell application \"iTunes\"\n"
        +                   "set currentTrack to current track\n"
        +                   "return artist of currentTrack\n"
        +               "end tell"
        var name: String = ""
        var artist: String = ""
        
        var err : NSDictionary?
        if let scriptObject = NSAppleScript(source: getNameAS) {
            let output = scriptObject.executeAndReturnError(&err)
            if let _name = output.stringValue {
                name = _name
            }
        }
        if let scriptObject = NSAppleScript(source: getArtist) {
            let output = scriptObject.executeAndReturnError(&err)
            if let _artist = output.stringValue {
                artist = _artist
            }
        }
        return (name: name, artist: artist)
        
    }
    func setArtwork(newArtworkPath: String) {
        let appleScript =   "tell application \"iTunes\"\n"
        +                       "set f to POSIX file \"\(newArtworkPath)\"\n"
        +                       "set data of artwork 1 of current track to (read f as picture)\n"
        +                   "end tell"
        
        var err : NSDictionary?
        if let scriptObject = NSAppleScript(source: appleScript) {
            scriptObject.executeAndReturnError(&err)
            let alert = NSAlert()
            alert.messageText = "アートワークをセットしました。"
            alert.runModal()
            
        }
        
    }
    func saveArtwork() -> NSURL? {
        let appleScript =   "tell application \"iTunes\"\n"
        +                       "set currentArtwork to first artwork of current track\n"
        +                       "set srcBytes to raw data of currentArtwork\n"
        +                       "if format of currentArtwork is «class PNG » then\n"
        +                           "set ext to \".png\"\n"
        +                       "else\n"
        +                           "set ext to \".jpg\"\n"
        +                       "end if\n"
        +                   "end tell\n"
        +                   "do shell script \"mkdir -p ~/.iTunesArtworkExplorer\"\n"
        +                   "set fileName to (((path to home folder) as text) & \".iTunesArtworkExplorer:cover\" & ext)\n"
        +                   "set outFile to open for access file fileName with write permission\n"
        +                   "set eof outFile to 0\n"
        +                   "write srcBytes to outFile\n"
        +                   "close access outFile\n"
        +                   "return POSIX path of (alias fileName)"
        
        var err : NSDictionary?
        if let scriptObject = NSAppleScript(source: appleScript) {
             let output = scriptObject.executeAndReturnError(&err)
             if let res = output.stringValue {
                return NSURL(fileURLWithPath: res, isDirectory: false)
            }else{
                return nil
            }
        }
        return nil

    }
}