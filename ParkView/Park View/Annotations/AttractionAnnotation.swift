//
//  AttractionAnnotation.swift
//  Park View
//
//  Created by Satabdi Das on 18/06/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit
import MapKit

enum AttractionType: Int {
    case misc = 0
    case ride
    case food
    case firstAid
    
    func image() -> UIImage {
        switch self {
        case .misc:
            return #imageLiteral(resourceName: "star")
        case .ride:
            return #imageLiteral(resourceName: "ride")
        case .food:
            return #imageLiteral(resourceName: "food")
        case .firstAid:
            return #imageLiteral(resourceName: "firstaid")
        }
    }
}

class AttractionAnnotation: NSObject,MKAnnotation,Decodable {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var type: AttractionType
    
    enum CodingKeys: String, CodingKey {
        //case name
        case name
        case location
        case type
        case subtitle
        
    }
    
    
    static func parseCoord(coord: String) -> CLLocationCoordinate2D {
        
        let point = CGPointFromString(coord)
        return CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
    }
    
    
    required init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // let arrayContainer = try decoder.container(keyedBy: CodingKeysOther.self)
        title = try container.decode(String.self, forKey: .name)
        let typeStringRawValue = try container.decode(String.self, forKey: .type)
        type = AttractionType(rawValue: Int(typeStringRawValue)!)! ?? .misc
        subtitle = try container.decode(String.self, forKey: .subtitle)
        let stringLocation = try container.decode(String.self, forKey: .location)
        coordinate = AttractionAnnotation.parseCoord(coord:stringLocation)
        
    }
    
    

}
