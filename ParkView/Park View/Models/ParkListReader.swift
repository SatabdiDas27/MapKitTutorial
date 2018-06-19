//
//  ParkListReader.swift
//  Park View
//
//  Created by Satabdi Das on 18/06/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit
import MapKit

class ParkListReader {

     public func parseParks(fileName:String) -> ParkModel? {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "plist") else {
            return nil
        }
        
        do {
            let parData = try Data(contentsOf: fileURL, options: .mappedIfSafe)
            let parks = try PropertyListDecoder().decode(ParkModel.self, from: parData)
            return parks
        } catch {
            print(error)
            return nil
        }
    }
    
    public func parseRouteCoordinates(fileName:String) -> Any? {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "plist") else {
            return nil
        }
        
        do {
            let routeLineData = try Data(contentsOf: fileURL, options: .mappedIfSafe)
            let route = try PropertyListSerialization.propertyList(from: routeLineData, options: [], format: nil)
            return route
        } catch {
            print(error)
            return nil
        }
        
        
       
    }
    
    
    public func parseAnnotations(fileName:String) -> [AttractionAnnotation]? {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "plist") else {
            return []
        }
        
        do {
            let annotationData = try Data(contentsOf: fileURL, options: .mappedIfSafe)
            let annotations = try PropertyListDecoder().decode([AttractionAnnotation].self, from: annotationData)
            return annotations
        } catch {
            print(error)
            return []
        }
    }

}
