//
//  BlockStatus.swift
//  TreasureBound
//
//  Created by Kwasi Asante on 2019-04-11.
//  Copyright © 2019 BrokeAssGames. All rights reserved.
//

import Foundation

class BlockStatus{
    var isRunning:Bool = false
    var timeGapForNextRun:UInt32 = 0
    var currentInterval:UInt32 = 0
    
    init(isRunning:Bool, timeGapForNextRun:UInt32, currentInterval:UInt32){
        self.isRunning = isRunning
        self.timeGapForNextRun = timeGapForNextRun
        self.currentInterval = currentInterval
    }
    
    func shouldRunBlock() -> Bool{
        return self.currentInterval > self.timeGapForNextRun
    }
}
