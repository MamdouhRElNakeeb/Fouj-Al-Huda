//
//  Extensions.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 7/28/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}

extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(NSURL(string: url)! as URL) {
                if #available(iOS 10.0, *) {
                    application.open(URL(string: url)!, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(URL(string: url)!)
                }
                return
            }
        }
    }
}

extension UIColor {
    
    class func primaryColor() -> UIColor {
     
        return UIColor(red: 101/255, green: 67/255, blue: 47/255, alpha: 1)
    }
    
    class func secondryColor() -> UIColor {
        
        return UIColor(red: 251/255, green: 184/255, blue: 24/255, alpha: 1)
    }
}

extension UIFont {
    
    static func noc_mediumSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        var font: UIFont
        if #available(iOS 8.2, *) {
            font = UIFont.systemFont(ofSize: fontSize, weight: UIFontWeightMedium)
        } else {
            font = UIFont(name: "HelveticaNeue-Medium", size: fontSize)!
        }
        return font
    }
    
}
extension NSAttributedString {
    
    func noc_sizeThatFits(size: CGSize) -> CGSize {
        let rect = boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading ], context: nil)
        return rect.integral.size
    }
    
}

extension UIView{

    class Circle{
        
        var radius: CGFloat
        var fill: UIColor
        var stroke: UIColor
        
        init(radius: CGFloat, fill: UIColor, stroke: UIColor){
            
            self.radius = radius
            self.fill = fill
            self.stroke = stroke
        }
        
        func getCircle() -> UIView{
            
            let circle = UIView()
            circle.frame = CGRect(x: 0, y: 0, width: self.radius * 2, height: self.radius * 2)
            circle.layer.cornerRadius = radius
            circle.backgroundColor = fill
            circle.addBorder(view: circle, stroke: stroke, fill: fill, radius: Int(radius), width: 4)
            return circle
        }
        
    }
    
    class Triangle{
        
        var height: CGFloat
        var width: CGFloat
        
        init(height: CGFloat, width: CGFloat) {
            
            self.width = width
            self.height = height
        }
        
        func getTriangle() -> UIView {
            
            // Create Path
            let bezierPath = UIBezierPath()
            
            // Draw Points
            bezierPath.move(to: CGPoint(x: 0, y: height))
            bezierPath.addLine(to: CGPoint(x: width, y: height))
            bezierPath.addLine(to: CGPoint(x: width, y: 0))
            bezierPath.addLine(to: CGPoint(x: 0, y: height))
            bezierPath.close()
            
            // Apply Color
            UIColor.green.setFill()
            bezierPath.fill()
            
            // Mask to Path
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = bezierPath.cgPath
            
            let triangle = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            triangle.layer.mask = shapeLayer
            
            return triangle
        }
        
    }
    
    class Polygon{
        
        var height: CGFloat
        var width: CGFloat
        
        init(height: CGFloat, width: CGFloat) {
            
            self.width = width
            self.height = height
        }
        
        func getPolygon() -> UIView {
            
            // Create Path
            let bezierPath = UIBezierPath()
            
            // Draw Points
            bezierPath.move(to: CGPoint(x: 0, y: height / 4))
            bezierPath.addLine(to: CGPoint(x: width / 2, y: 0))
            bezierPath.addLine(to: CGPoint(x: width, y: height / 4))
            bezierPath.addLine(to: CGPoint(x: width, y: height / 3))
            bezierPath.addLine(to: CGPoint(x: width / 2, y: height))
            bezierPath.addLine(to: CGPoint(x: 0, y: height / 3))
            bezierPath.addLine(to: CGPoint(x: 0, y: height / 4))
            bezierPath.close()
            
            // Apply Color
            UIColor.secondryColor().setStroke()
            bezierPath.stroke()
            
            // Mask to Path
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = bezierPath.cgPath
            
            let polygon = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            polygon.layer.mask = shapeLayer
            
            return polygon
        }
        
    }

    
    func addBorder(view: UIView, stroke: UIColor, fill: UIColor, radius: Int, width: CGFloat){
        
        
        // Add border
        let borderLayer = CAShapeLayer()
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = view.frame
        rectShape.position = view.center
        
        rectShape.path = UIBezierPath(polygonIn: view.bounds, sides: 6, lineWidth: width, cornerRadius: CGFloat(radius)).cgPath
        
            //UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.bottomRight , .topLeft, .topRight, .bottomLeft], cornerRadii: CGSize(width: radius, height: radius)).cgPath
        borderLayer.path = rectShape.path // Reuse the Bezier path
        
        //borderLayer.transform = CATransform3DMakeTranslation(view.frame.width, view.frame.width, 0)
        //borderLayer.transform = CATransform3DMakeRotation(CGFloat(Double.pi / 6), 0, 0, 1)
        
        //borderLayer.transform = CATransform3DRotate(borderLayer.transform, CGFloat(Double.pi / 6), 0.0, 0.0, 1.0)
        
        let o = 0
        borderLayer.transform = CATransform3DTranslate(borderLayer.transform, CGFloat(o), CGFloat(o), 0)
        borderLayer.transform = CATransform3DRotate(borderLayer.transform, CGFloat(Double.pi / -2), 0.0, 0.0, 1.0)
        borderLayer.transform = CATransform3DTranslate(borderLayer.transform, CGFloat(-o), CGFloat(-o), 0)
        
        borderLayer.fillColor = fill.cgColor
        borderLayer.strokeColor = stroke.cgColor
        borderLayer.lineWidth = width
        borderLayer.frame = view.bounds
        view.layer.addSublayer(borderLayer)
        //view.layer.mask = rectShape
        
        
        /*
        // Create Path
        let bezierPath = UIBezierPath()
        
        // Draw Points
        let height = width * 1.165
        bezierPath.move(to: CGPoint(x: 0, y: height / 4))
        bezierPath.addLine(to: CGPoint(x: width / 2, y: 0))
        bezierPath.addLine(to: CGPoint(x: width, y: height / 4))
        bezierPath.addLine(to: CGPoint(x: width, y: height / 3))
        bezierPath.addLine(to: CGPoint(x: width / 2, y: height))
        bezierPath.addLine(to: CGPoint(x: 0, y: height / 3))
        bezierPath.addLine(to: CGPoint(x: 0, y: height / 4))
        bezierPath.close()
        
        
        rectShape.bounds = view.frame
        rectShape.position = view.center
        rectShape.path = bezierPath.cgPath
        
        // Apply Color
        //UIColor.secondryColor().setStroke()
        //bezierPath.stroke()
        
        // Mask to Path
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = rectShape.path
        shapeLayer.fillColor = fill.cgColor
        shapeLayer.strokeColor = stroke.cgColor
        shapeLayer.frame = view.bounds
        shapeLayer.lineWidth = width
        
        
        //let polygon = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        view.layer.addSublayer(shapeLayer)
        view.layer.mask = rectShape
        */

        
    }
    
    func removeBorder(view: UIView){
        // remove border
        view.layer.removeFromSuperlayer()
    }
    
   func dropShadow() {
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: -1, height: 0)
        self.layer.shadowRadius = 3
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    
    func dropShadow2() {
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: -1, height: 0)
        self.layer.shadowRadius = 9
        
        //self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        //self.layer.cornerRadius = 15
        self.layer.masksToBounds = false
    }
    
    
    func outerGlow() {
        
        self.layer.shadowColor = UIColor(red: 252/255, green: 247/255, blue: 192/255, alpha: 1).cgColor
        self.layer.shadowOpacity = 2
        self.layer.shadowOffset = CGSize(width: -1, height: 0)
        self.layer.shadowRadius = 5
        
        //self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        //self.layer.cornerRadius = 5
        
        self.layer.masksToBounds = false
    }
}


extension UIBezierPath {
    
    /// Create UIBezierPath for regular polygon with rounded corners
    ///
    /// - parameter rect:            The CGRect of the square in which the path should be created.
    /// - parameter sides:           How many sides to the polygon (e.g. 6=hexagon; 8=octagon, etc.).
    /// - parameter lineWidth:       The width of the stroke around the polygon. The polygon will be inset such that the stroke stays within the above square. Default value 1.
    /// - parameter cornerRadius:    The radius to be applied when rounding the corners. Default value 0.
    
    convenience init(polygonIn rect: CGRect, sides: Int, lineWidth: CGFloat = 1, cornerRadius: CGFloat = 0) {
        self.init()
        
        let theta = 2 * CGFloat.pi / CGFloat(sides)                        // how much to turn at every corner
        let offset = cornerRadius * tan(theta / 2)                  // offset from which to start rounding corners
        let squareWidth = min(rect.size.width, rect.size.height)    // width of the square
        
        // calculate the length of the sides of the polygon
        
        var length = squareWidth - lineWidth
        if sides % 4 != 0 {                                         // if not dealing with polygon which will be square with all sides ...
            length = length * cos(theta / 2) + offset / 2           // ... offset it inside a circle inside the square
        }
        let sideLength = length * tan(theta / 2)
        
        // start drawing at `point` in lower right corner, but center it
        
        var point = CGPoint(x: rect.origin.x + rect.size.width / 2 + sideLength / 2 - offset, y: rect.origin.y + rect.size.height / 2 + length / 2)
        var angle = CGFloat.pi
        move(to: point)
        
        // draw the sides and rounded corners of the polygon
        
        for _ in 0 ..< sides {
            point = CGPoint(x: point.x + (sideLength - offset * 2) * cos(angle), y: point.y + (sideLength - offset * 2) * sin(angle))
            addLine(to: point)
            
            let center = CGPoint(x: point.x + cornerRadius * cos(angle + .pi / 2), y: point.y + cornerRadius * sin(angle + .pi / 2))
            addArc(withCenter: center, radius: cornerRadius, startAngle: angle - .pi / 2, endAngle: angle + theta - .pi / 2, clockwise: true)
            
            point = currentPoint
            angle += theta
        }
        
        close()
        
        self.lineWidth = lineWidth           // in case we're going to use CoreGraphics to stroke path, rather than CAShapeLayer
        lineJoinStyle = .round
    }
    
}
