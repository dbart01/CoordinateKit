//
//  Coordinate+CoreLocation.swift
//  CoordinateKit
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

#if canImport(CoreLocation)

import CoreLocation

// MARK: - Single -

extension Coordinate {
    
    public static func deflate(coordinate: CLLocationCoordinate2D) throws -> CompressedCoordinate {
        return try self.deflate(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    public static func inflate(coordinate: CompressedCoordinate) -> CLLocationCoordinate2D {
        let (lat, lon) = self.inflate(coordinate)
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}

// MARK: - Collection -

extension Coordinate {
    
    public static func deflate(coordinates: [CLLocationCoordinate2D]) throws -> [CompressedCoordinate] {
        return try coordinates.map { try self.deflate(coordinate: $0) }
    }
    
    public static func inflate(coordinates: [CompressedCoordinate]) -> [CLLocationCoordinate2D] {
        return coordinates.map { self.inflate(coordinate: $0) }
    }
}

#endif
