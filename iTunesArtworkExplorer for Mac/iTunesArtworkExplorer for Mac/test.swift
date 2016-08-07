//
//  test.swift
//  iTunesArtworkExplorer for Mac
//
//  Created by SaitoYuta on 2016/08/08.
//  Copyright © 2016年 SaitoYuta. All rights reserved.
//

import Cocoa

class test: NSViewController {

    override func viewDidLoad() {
        if #available(OSX 10.10, *) {
            super.viewDidLoad()
        } else {
            // Fallback on earlier versions
        }
        // Do view setup here.
    }
    

    
}
