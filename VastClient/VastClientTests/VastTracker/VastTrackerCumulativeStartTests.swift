//
//  VastTrackerCumulativeStartTests.swift
//  VastClientTests
//
//  Created by Jan Bednar on 01/02/2019.
//  Copyright © 2019 John Gainfort Jr. All rights reserved.
//

import XCTest
@testable import VastClient

/** Midroll test case scenario
 
 When using cumulative tracking but you need to adjust start time, because the ad is starting during the main content.
 */
class VastTrackerCumulativeStartTests: XCTestCase {
    var vastTracker: VastTracker!
    var deleagteSpy: VastTrackerDelegateSpy!
    
    let ad1 = VastAd.make(skipOffset: nil, duration: 5, sequence: 1)
    
    lazy var model: VastModel = {
        return VastModel(version: "4.0", ads: [ad1], errors: [])
    }()
    
    override func setUp() {
        deleagteSpy = VastTrackerDelegateSpy()
        vastTracker = VastTracker(vastModel: model, startTime: 15, supportAdBuffets: false, delegate: deleagteSpy, trackProgressCumulatively: true)
    }
    
    func test_trackingDoesNotStartBeforeStartTime() {
        let times = Double.makeArray(from: 14, to: 14)
        times.forEach { try? vastTracker.updateProgress(time: $0) }
        
        XCTAssertEqual(vastTracker.totalAds, 1)
        XCTAssertEqual(deleagteSpy.lastStartedAd, nil)
        XCTAssertFalse(deleagteSpy.adBreakStarted)
        XCTAssertFalse(deleagteSpy.firstQuartileDone)
        XCTAssertFalse(deleagteSpy.midpointDone)
        XCTAssertFalse(deleagteSpy.thirdQuartileDone)
        XCTAssertFalse(deleagteSpy.adComplete)
        XCTAssertFalse(deleagteSpy.adBreakComplete)
    }
    
    func test_trackingStartsWithFirstAdAtStartTime() {
        let times = Double.makeArray(from: 15, to: 16)
        times.forEach { try? vastTracker.updateProgress(time: $0) }
        
        XCTAssertEqual(vastTracker.totalAds, 1)
        XCTAssertTrue(deleagteSpy.adBreakStarted)
        XCTAssertEqual(deleagteSpy.lastStartedAd, self.ad1)
        
        XCTAssertFalse(deleagteSpy.firstQuartileDone)
        XCTAssertFalse(deleagteSpy.midpointDone)
        XCTAssertFalse(deleagteSpy.thirdQuartileDone)
        XCTAssertFalse(deleagteSpy.adComplete)
        XCTAssertFalse(deleagteSpy.adBreakComplete)
    }
    
    func test_trackingFirstAdHitsFirstQuartile() {
        let times = Double.makeArray(from: 15, to: 17)
        times.forEach { try? vastTracker.updateProgress(time: $0) }
        
        XCTAssertEqual(vastTracker.totalAds, 1)
        XCTAssertTrue(deleagteSpy.adBreakStarted)
        XCTAssertEqual(deleagteSpy.lastStartedAd, self.ad1)
        XCTAssertTrue(deleagteSpy.firstQuartileDone)
        
        XCTAssertFalse(deleagteSpy.midpointDone)
        XCTAssertFalse(deleagteSpy.thirdQuartileDone)
        XCTAssertFalse(deleagteSpy.adComplete)
        XCTAssertFalse(deleagteSpy.adBreakComplete)
    }
}
