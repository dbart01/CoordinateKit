//
//  Coordinate+DataTests.swift
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
import CoreLocation
import CoordinateKit

class Coordinate_DataTests: XCTestCase {
    
    private let coordinates = [
        CLLocationCoordinate2D(latitude: 43.64450399, longitude: -79.38032112),
        CLLocationCoordinate2D(latitude: 43.64322258, longitude: -79.38645397),
        CLLocationCoordinate2D(latitude: 43.64300178, longitude: -79.38755409),
    ]
    
    private let coordinatesData = Data(base64Encoded: "bbvvV2JLCDptu+ElYtv3Om27QR1i1CI7")!
    
    // MARK: - Data -
    
    func testDeflateToData() {
        let data: Data = Coordinate.deflate(coordinatesToData: self.coordinates)
        
        XCTAssertEqual(data.count, 24)
        XCTAssertEqual(data, self.coordinatesData)
    }
    
    func testInflateFromData() {
        let coordinates = Coordinate.inflate(data: self.coordinatesData)
        
        self.assertCoordinates(coordinates)
    }
    
    func testInflateInvalidData() {
        let data        = Data(base64Encoded: "bW9w")!
        let coordinates = Coordinate.inflate(data: data)
        
        XCTAssertTrue(coordinates.isEmpty)
    }
    
    // MARK: - Base64 -
    
    func testDeflateToBase64() {
        let base64 = Coordinate.deflate(coordinatesToBase64: self.coordinates)
        
        XCTAssertEqual(base64, "bbvvV2JLCDptu+ElYtv3Om27QR1i1CI7")
    }
    
    func testInflateFromBase64() {
        let coordinates = Coordinate.inflate(base64: "bbvvV2JLCDptu+ElYtv3Om27QR1i1CI7")
        
        self.assertCoordinates(coordinates)
    }
    
    func testInflateFromInvalidBase64() {
        let coordinates = Coordinate.inflate(base64: "#-#-#-#")
        
        XCTAssertTrue(coordinates.isEmpty)
    }
    
    // MARK: - Assert -
    
    private func assertCoordinates(_ coordinates: [CLLocationCoordinate2D]?) {
        XCTAssertNotNil(coordinates)
        XCTAssertEqual(coordinates!.count, 3)
        
        XCTAssertEqual(coordinates![0].latitude,   43.64450399, accuracy: 0.000001)
        XCTAssertEqual(coordinates![0].longitude, -79.38032112, accuracy: 0.000001)
        
        XCTAssertEqual(coordinates![1].latitude,   43.64322258, accuracy: 0.000001)
        XCTAssertEqual(coordinates![1].longitude, -79.38645397, accuracy: 0.000001)
        
        XCTAssertEqual(coordinates![2].latitude,   43.64300178, accuracy: 0.000001)
        XCTAssertEqual(coordinates![2].longitude, -79.38755409, accuracy: 0.000001)
    }
}
