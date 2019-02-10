//
//  WebViewWarmuperTests.swift
//  WebViewWarmuperTests
//
//  Created by Tomoya Hayakawa on 2019/02/10.
//  Copyright © 2019年 simorgh3196. All rights reserved.
//

import XCTest
@testable import WebViewWarmuper

class WebViewWarmuperTests: XCTestCase {

    var warmuper: WebViewWarmuper!

    override func setUp() {
        warmuper = WebViewWarmuper(maxSize: 2)
    }

    func testInit() {
        XCTAssertEqual(warmuper.currentSize, 0, "expected size equal 0 after init")
    }

    func testWarmup1Instance() {
        warmuper.warmup(1) {
            XCTAssertEqual(self.warmuper.currentSize, 1, "expected size equal 1 when warmup 1 instance")
        }
    }

    func testWarmup2Instance() {
        warmuper.warmup(1) {
            XCTAssertEqual(self.warmuper.currentSize, 2, "expected size equal 2 when warmup 2 instance")
        }
    }

    func testWarmupOverMaxSizeInstance() {
        warmuper.warmup(3) {
            XCTAssertEqual(self.warmuper.currentSize, 2, "expected size equal 2 when warmup over size instance")
        }
    }

    func testWarmup1InstanceMultiTimes() {
        let exp = self.expectation(description: "call 2 times")
        exp.expectedFulfillmentCount = 2

        warmuper.warmup(1) { exp.fulfill() }
        warmuper.warmup(1) { exp.fulfill() }
        self.wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(self.warmuper.currentSize, 2, "expected size equal 2 when warmup 1 instance twice")
    }

    func testWarmupOverMaxSizeInstanceMultiTimes() {
        let exp = self.expectation(description: "call 3 times")
        exp.expectedFulfillmentCount = 3

        warmuper.warmup(1) { exp.fulfill() }
        warmuper.warmup(1) { exp.fulfill() }
        warmuper.warmup(1) { exp.fulfill() }
        self.wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(self.warmuper.currentSize, 2, "expected size equal 2 when warmup 1 instance 3 times")
    }

    func testWarmupWhenCalledByMultiThread() {
        let exp = self.expectation(description: "call 2 times")
        exp.expectedFulfillmentCount = 2

        DispatchQueue.main.async {
            self.warmuper.warmup(1) { exp.fulfill() }
        }
        DispatchQueue.global().async {
            self.warmuper.warmup(1) { exp.fulfill() }
        }
        self.wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(self.warmuper.currentSize, 2, "expected size equal 2 when call twice warmup 1 instance 2 times by multi thread")
    }

    func testWramupUpToSize() {
        let exp = self.expectation(description: "call 1 times")
        warmuper.warmup(1) { exp.fulfill() }
        self.wait(for: [exp], timeout: 1.0)

        warmuper.warmupUpToSize {
            XCTAssertEqual(self.warmuper.currentSize, 2, "expected size equal 2 when warmup up to size instance")
        }
    }

    func testGetView() {
        let exp = self.expectation(description: "call 1 times")
        warmuper.warmup(1) { exp.fulfill() }
        self.wait(for: [exp], timeout: 1.0)

        let view1 = warmuper.getView()
        XCTAssertNotNil(view1, "expected get non nil instance")

        let view2 = warmuper.getView()
        XCTAssertNil(view2, "expected get nil")
    }
}
