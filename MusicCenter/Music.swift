//
//  Music.swift
//  MusicCenter
//
//  Created by sylvain vincent on 13/11/2016.
//  Copyright © 2016 sylvain vincent. All rights reserved.
//

import Foundation

public class Music: NSObject {
    
    var name: String
    var url: String
    var data: NSData?
    
    init(name: String, url: String, data: NSData?) {
        self.name = name
        self.url = url
        self.data = data
    }
    
}
