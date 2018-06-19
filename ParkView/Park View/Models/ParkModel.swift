//
//  ParkModel.swift
//  Park View
//
//  Created by Satabdi Das on 18/06/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit
import MapKit

struct ParkModel:Decodable {
    
    var name:String?
    var boundary:[CLLocationCoordinate2D] = []
    
    var midCoordinate = CLLocationCoordinate2D()
    var overlayTopLeftCoordinate = CLLocationCoordinate2D()
    var overlayTopRightCoordinate = CLLocationCoordinate2D()
    var overlayBottomLeftCoordinate = CLLocationCoordinate2D()
    var overlayBottomRightCoordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2DMake(overlayBottomLeftCoordinate.latitude,
                                              overlayTopRightCoordinate.longitude)
        }
    }
    
    var overlayBoundingMapRect: MKMapRect {
        get {
            let topLeft = MKMapPointForCoordinate(overlayTopLeftCoordinate)
            let topRight = MKMapPointForCoordinate(overlayTopRightCoordinate)
            let bottomLeft = MKMapPointForCoordinate(overlayBottomLeftCoordinate)
            
            return MKMapRectMake(
                topLeft.x,
                topLeft.y,
                fabs(topLeft.x - topRight.x),
                fabs(topLeft.y - bottomLeft.y))
        }
    }
    
    static func parseCoord(coord: String) -> CLLocationCoordinate2D {
        
        let point = CGPointFromString(coord)
        return CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
    }
    
    enum CodingKeys: String, CodingKey {
        //case name
        case midCoord
        case boundary
        case overlayTopLeftCoord
        case overlayTopRightCoord
        case overlayBottomLeftCoord
        
    }
    
    
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
       // let arrayContainer = try decoder.container(keyedBy: CodingKeysOther.self)
        let boundaryPoints = try container.decode([String].self, forKey: .boundary)
        let stringMidCoordinate = try container.decode(String.self, forKey: .midCoord)
        midCoordinate = ParkModel.parseCoord(coord:stringMidCoordinate)
        let stringOverlayTopLeftCoord = try container.decode(String.self, forKey: .overlayTopLeftCoord)
        overlayTopLeftCoordinate = ParkModel.parseCoord(coord: stringOverlayTopLeftCoord)
        let stringOverlayTopRightCoord = try container.decode(String.self, forKey: .overlayTopRightCoord)
        overlayTopRightCoordinate = ParkModel.parseCoord(coord: stringOverlayTopRightCoord)
        let stringOverlayBottomLeftCoord = try container.decode(String.self, forKey: .overlayBottomLeftCoord)
        overlayBottomLeftCoordinate = ParkModel.parseCoord(coord: stringOverlayBottomLeftCoord)
        
       
        let cgPoints = boundaryPoints.map { CGPointFromString($0) }
        boundary = cgPoints.map { CLLocationCoordinate2DMake(CLLocationDegrees($0.x), CLLocationDegrees($0.y)) }
        
    }

}
