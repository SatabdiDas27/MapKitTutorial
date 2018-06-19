//
//  ParkMapOverlayView.swift
//  Park View
//
//  Created by Satabdi Das on 18/06/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit
import MapKit

/*MKOverlayRenderer. You subclass this to set up what you want to display in each spot. In this app, for example, you’ll draw an image of the rollercoaster or restaurant.
A MKOverlayRenderer is really just a special kind of UIView, as it inherits from UIView. However, you shouldn’t add an MKOverlayRenderer directly to a MKMapView. Instead, MapKit expects this to be an MKMapView.*/

class ParkMapOverlayView: MKOverlayRenderer {
    var overlayImage: UIImage
    
    init(overlay:MKOverlay, overlayImage:UIImage) {
        self.overlayImage = overlayImage
        super.init(overlay: overlay)
    }
    
    /*draw is the real meat of this class. It defines how MapKit should render this view when given a specific MKMapRect, MKZoomScale, and the CGContext of the graphic context, with the intent to draw the overlay image onto the context at the appropriate scale.
     you can see that the code below uses the passed MKMapRect to get a CGRect, in order to determine the location to draw the CGImage of the UIImage on the provided context.*/
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        guard let imageReference = overlayImage.cgImage else { return }
        
        let rect = self.rect(for:overlay.boundingMapRect)
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -rect.size.height)
        context.draw(imageReference, in: rect)
    }

}
