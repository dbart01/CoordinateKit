//
//  Coordinate+CoreLocationTests.swift
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

class Coordinate_CoreLocationTests: XCTestCase {

    private let coordinates = [
        CLLocationCoordinate2D(latitude: 43.64450399, longitude: -79.38032112),
        CLLocationCoordinate2D(latitude: 43.64322258, longitude: -79.38645397),
        CLLocationCoordinate2D(latitude: 43.64300178, longitude: -79.38755409),
    ]
    
    // MARK: - Single -
    
    func testDeflate() {
        let coordinate = CLLocationCoordinate2D(
            latitude:   43.1234567,
            longitude: -79.8765432
        )
        
        let value = try! Coordinate.deflate(coordinate: coordinate)
        XCTAssertEqual(value, 9637694487388404589)
    }
    
    func testInflate() {
        let value: CompressedCoordinate = 9637694487388404589
        let coordinate = Coordinate.inflate(coordinate: value)
        
        XCTAssertEqual(coordinate.latitude,   43.1234567, accuracy: 0.000001)
        XCTAssertEqual(coordinate.longitude, -79.8765432, accuracy: 0.000001)
    }
    
    // MARK: - Collection -
    
    func testDeflateCollection() {
        let collection: [CompressedCoordinate] = try! Coordinate.deflate(coordinates: self.coordinates)
        
        XCTAssertEqual(collection.count, 3)
        XCTAssertEqual(collection, [
            4181675139767712621,
            4249105988036180845,
            4261201715308641133,
        ])
    }
    
    func testInflateCollection() {
        let compressedCoordinates: [CompressedCoordinate] = [
            4181675139767712621,
            4249105988036180845,
            4261201715308641133,
        ]
        
        let coordinates = Coordinate.inflate(coordinates: compressedCoordinates)
        
        XCTAssertEqual(coordinates[0].latitude,  self.coordinates[0].latitude,  accuracy: 0.000001)
        XCTAssertEqual(coordinates[0].longitude, self.coordinates[0].longitude, accuracy: 0.000001)
        
        XCTAssertEqual(coordinates[1].latitude,  self.coordinates[1].latitude,  accuracy: 0.000001)
        XCTAssertEqual(coordinates[1].longitude, self.coordinates[1].longitude, accuracy: 0.000001)
        
        XCTAssertEqual(coordinates[2].latitude,  self.coordinates[2].latitude,  accuracy: 0.000001)
        XCTAssertEqual(coordinates[2].longitude, self.coordinates[2].longitude, accuracy: 0.000001)
    }
}
