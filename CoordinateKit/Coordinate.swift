//
//  Coordinate.swift
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

import Foundation

public enum Coordinate {
    
    private static let rangeForLatitude  =  -90.0...90.0
    private static let rangeForLongitude = -180.0...180.0
    
    public static func deflate(latitude: Double, longitude: Double) throws -> CompressedCoordinate {
        guard self.rangeForLatitude.contains(latitude) else {
            throw Error.invalidLatitude
        }
        
        guard self.rangeForLongitude.contains(longitude) else {
            throw Error.invalidLongitude
        }
        
        return _coordinateKitDeflateCoordinate(latitude, longitude)
    }
    
    public static func inflate(_ compressedCoordinate: CompressedCoordinate) -> (latitude: Double, longitude: Double) {
        var lat: Double = 0
        var lon: Double = 0
        
        _coordinateKitInflateCoordinate(compressedCoordinate, &lat, &lon)
        
        return (lat, lon)
    }
}

// MARK: - Error -

extension Coordinate {
    public enum Error: Equatable, Swift.Error {
        case invalidLatitude
        case invalidLongitude
    }
}
