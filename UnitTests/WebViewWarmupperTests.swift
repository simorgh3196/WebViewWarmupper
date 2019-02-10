//
//  WebViewWarmupperTests.swift
//  WebViewWarmupperTests
//
//  Created by Tomoya Hayakawa on 2019/02/10.
//  Copyright © 2019年 simorgh3196. All rights reserved.
//

import XCTest
@testable import WebViewWarmupper

class WebViewWarmupperTests: XCTestCase {

    var warmupper: WebViewWarmupper!

    override func setUp() {
        warmupper = WebViewWarmupper(maxSize: 2)
    }

    func testInit() {
        XCTAssertEqual(warmupper.currentSize, 0, "expected size equal 0 after init")
    }

    func testWarmup1Instance() {
        warmupper.warmup(1) {
            XCTAssertEqual(self.warmupper.currentSize, 1, "expected size equal 1 when warmup 1 instance")
        }
    }

    func testWarmup2Instance() {
        warmupper.warmup(2) {
            XCTAssertEqual(self.warmupper.currentSize, 2, "expected size equal 2 when warmup 2 instance")
        }
    }

    func testWarmupOverMaxSizeInstance() {
        warmupper.warmup(3) {
            XCTAssertEqual(self.warmupper.currentSize, 2, "expected size equal 2 when warmup over size instance")
        }
    }

    func testWarmup1InstanceMultiTimes() {
        let exp = self.expectation(description: "call 2 times")
        exp.expectedFulfillmentCount = 2

        warmupper.warmup(1) { exp.fulfill() }
        warmupper.warmup(1) { exp.fulfill() }
        self.wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(self.warmupper.currentSize, 2, "expected size equal 2 when warmup 1 instance twice")
    }

    func testWarmupOverMaxSizeInstanceMultiTimes() {
        let exp = self.expectation(description: "call 3 times")
        exp.expectedFulfillmentCount = 3

        warmupper.warmup(1) { exp.fulfill() }
        warmupper.warmup(1) { exp.fulfill() }
        warmupper.warmup(1) { exp.fulfill() }
        self.wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(self.warmupper.currentSize, 2, "expected size equal 2 when warmup 1 instance 3 times")
    }

    func testWarmupWhenCalledByMultiThread() {
        let exp = self.expectation(description: "call 2 times")
        exp.expectedFulfillmentCount = 2

        DispatchQueue.main.async {
            self.warmupper.warmup(1) { exp.fulfill() }
        }
        DispatchQueue.global().async {
            self.warmupper.warmup(1) { exp.fulfill() }
        }
        self.wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(self.warmupper.currentSize, 2, "expected size equal 2 when call twice warmup 1 instance 2 times by multi thread")
    }

    func testWramupUpToSize() {
        let exp = self.expectation(description: "call 1 times")
        warmupper.warmup(1) { exp.fulfill() }
        self.wait(for: [exp], timeout: 1.0)

        warmupper.warmupUpToSize {
            XCTAssertEqual(self.warmupper.currentSize, 2, "expected size equal 2 when warmup up to size instance")
        }
    }

    func testGetView() {
        let exp = self.expectation(description: "call 1 times")
        warmupper.warmup(1) { exp.fulfill() }
        self.wait(for: [exp], timeout: 1.0)

        let view1 = warmupper.getView()
        XCTAssertNotNil(view1, "expected get non nil instance")

        let view2 = warmupper.getView()
        XCTAssertNil(view2, "expected get nil")
    }
}
