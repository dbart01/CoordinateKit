//
//  CoordinateTests.swift
//  CoordinateKitTests
//
//  The MIT License (MIT)
//
//  Copyright (c) 2019 Dima Bart
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import XCTest
import CoordinateKit

class CoordinateTests: XCTestCase {

    // MARK: - Deflate -
    
    func testDeflate() {
        let latitude:  Double = 43.1234567
        let longitude: Double = -79.8765432
        
        let value = try! Coordinate.deflate(latitude: latitude, longitude: longitude)
        XCTAssertEqual(value, 9637694487388404589)
    }
    
    func testDeflateInvalidLatitude() {
        let latitude:  Double = 110.1234567
        let longitude: Double = -79.8765432
        
        do {
            _ = try Coordinate.deflate(latitude: latitude, longitude: longitude)
            XCTFail()
        } catch Coordinate.Error.invalidLatitude {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testDeflateInvalidLongitude() {
        let latitude:  Double = 43.1234567
        let longitude: Double = -205.8765432
        
        do {
            _ = try Coordinate.deflate(latitude: latitude, longitude: longitude)
            XCTFail()
        } catch Coordinate.Error.invalidLongitude {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    // MARK: - Inflate -
    
    func testInflate() {
        let value: CompressedCoordinate = 9637694487388404589
        let (latitude, longitude) = Coordinate.inflate(value)
        
        XCTAssertEqual(latitude,   43.1234567, accuracy: 0.000001)
        XCTAssertEqual(longitude, -79.8765432, accuracy: 0.000001)
    }
}
