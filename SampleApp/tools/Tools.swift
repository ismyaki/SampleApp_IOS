//
//  tools.swift
//  SmatQDemo
//
//  Created by Aki Wang on 2019/3/26.
//  Copyright © 2019 smartq. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import Network
import Alamofire
import Kingfisher

func cleanData(){
    let ud = UserDefaultsManager.getInstance()
    ud.setLogin(isLogin: false)
    ud.setApiToken(apiToken: "")
    ud.setUserId(userId: 0)
}

func log(_ TAG: String, _ str: String){
    print("\(Date().logTime()) ➤ \(TAG) ➤ \(str)")
}

func synchronized<T>(_ lock: AnyObject, _ body: () throws -> T) rethrows -> T {
    objc_sync_enter(lock)
    defer { objc_sync_exit(lock) }
    return try body()
}

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
    
    func removeDuplicates<T: Hashable>(byKey key: (Element) -> T)  -> [Element] {
        var result = [Element]()
        var seen = Set<T>()
        for value in self {
            if seen.insert(key(value)).inserted {
                result.append(value)
            }
        }
        return result
    }
}

//extension Array where Element: Hashable {
//    func removingDuplicates() -> [Element] {
//        var addedDict = [Element: Bool]()
//        return filter {
//            addedDict.updateValue(true, forKey: $0) == nil
//        }
//    }
//}
//插入字串
extension String {
    var pairs: [String] {
        var result: [String] = []
        let characters = Array(self)
        stride(from: 0, to: count, by: 2).forEach {
            result.append(String(characters[$0..<min($0+2, count)]))
        }
        return result
    }
    mutating func insert(separator: String, every n: Int) {
        self = inserting(separator: separator, every: n)
    }
    
    
    func inserting(separator: String, every n: Int) -> String {
        var result: String = ""
        let characters = Array(self)
        stride(from: 0, to: count, by: n).forEach {
            result += String(characters[$0..<min($0+n, count)])
            if $0+n < count {
                result += separator
            }
        }
        return result
    }
}

extension String {
    func replaceRegular(regular: String, with: String) -> String{
        let regex = try! NSRegularExpression(pattern: regular, options: [])
        return regex.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.count), withTemplate: with).uppercased()
    }
    
    func replace(arr: [String], with: String) -> String{
        var result = self
        for str in arr {
            result = result.replace(str: str, with: with)
        }
        return result
    }
    
    func replace(str: String, with: String) -> String{
        return self.replacingOccurrences(of: str, with: with)
    }
    
    mutating func insert(contentsOf: String, event: Int){
        for index in indices.reversed() where index != startIndex && distance(from: startIndex, to: index) % event == 0 {
            self.insert(contentsOf: contentsOf, at: index)
        }
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension UIView{
    
    func showToast(text: String){
        self.hideToast()
        let toastLb = UILabel()
        toastLb.numberOfLines = 0
        toastLb.lineBreakMode = .byWordWrapping
        toastLb.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLb.textColor = UIColor.white
        toastLb.layer.cornerRadius = 10.0
        toastLb.textAlignment = .center
        toastLb.font = UIFont.systemFont(ofSize: 15.0)
        toastLb.text = text
        toastLb.layer.masksToBounds = true
        toastLb.tag = 9999//tag：hideToast實用來判斷要remove哪個label
        
        let maxSize = CGSize(width: self.bounds.width - 40, height: self.bounds.height)
        var expectedSize = toastLb.sizeThatFits(maxSize)
        var lbWidth = maxSize.width
        var lbHeight = maxSize.height
        if maxSize.width >= expectedSize.width{
            lbWidth = expectedSize.width
        }
        if maxSize.height >= expectedSize.height{
            lbHeight = expectedSize.height
        }
        expectedSize = CGSize(width: lbWidth, height: lbHeight)
        toastLb.frame = CGRect(x: ((self.bounds.size.width)/2) - ((expectedSize.width + 20)/2), y: self.bounds.height - expectedSize.height - 40 - 20, width: expectedSize.width + 20, height: expectedSize.height + 20)
        self.addSubview(toastLb)
        
        UIView.animate(withDuration: 1.5, delay: 1.5, animations: {
            toastLb.alpha = 0.0
        }) { (complete) in
            toastLb.removeFromSuperview()
        }
    }
    
    func hideToast(){
        for view in self.subviews{
            if view is UILabel , view.tag == 9999{
                view.removeFromSuperview()
            }
        }
    }
}

extension UIImageView {
    
}

extension UIViewController {
    @objc func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func findNavController<T>(_ vc : UIViewController) -> T? {
        if vc as? T != nil {
            return vc as? T
        } else if let presentingViewController = vc.presentingViewController {
            return findNavController(presentingViewController)
        }
        return nil
    }
}

extension UIViewController: UITextFieldDelegate{
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}

extension UIView {
    func takeSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }}
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }}
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }}
}

extension UIImage {
    func fixOrientation() -> UIImage
    {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi));
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0);
            transform = transform.rotated(by: CGFloat(Double.pi / 2));
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height);
            transform = transform.rotated(by: CGFloat(-Double.pi / 2));
        case .up, .upMirrored:
            break
        default:
            break
        }
        
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1);
        default:
            break;
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        let ctx = CGContext(
            data: nil,
            width: Int(self.size.width),
            height: Int(self.size.height),
            bitsPerComponent: self.cgImage!.bitsPerComponent,
            bytesPerRow: 0,
            space: self.cgImage!.colorSpace!,
            bitmapInfo: UInt32(self.cgImage!.bitmapInfo.rawValue)
        )
        
        ctx!.concatenate(transform);
        
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            // Grr...
            ctx?.draw(self.cgImage!, in: CGRect(x:0 ,y: 0 ,width: self.size.height ,height:self.size.width))
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x:0 ,y: 0 ,width: self.size.width ,height:self.size.height))
            break;
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg = ctx!.makeImage()
        let img = UIImage(cgImage: cgimg!)
        
        return img;
    }
}


func isValidEmail(str: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: str)
}

func CmToFeet(cm: Double) -> String {
    let inch = cm / 2.54
    var feet = Int(inch / 12.0)
    var inch2 = Int(round(inch.truncatingRemainder(dividingBy: 12.0)))
    if inch2 == 12 {
        feet += 1
        inch2 = 0
    }
    return "\(feet)'\(inch2)"
    //    return "\(Int(inch / 12.0))'\(Int(inch.truncatingRemainder(dividingBy: 12.0)))"
}

func isConnectedToNetwork() -> Bool {
    //    if #available(iOS 12.0, *) {
    //        // IOS 12 新方法
    //        return NWPathMonitor().currentPath.status == .satisfied
    //    } else {
    //        // 舊方法 但是似乎網路狀態不好也會判斷為沒網路!?
    //        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    //        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    //        zeroAddress.sin_family = sa_family_t(AF_INET)
    //        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
    //            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
    //                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
    //            }
    //        }
    //        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
    //        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
    //            return false
    //        }
    //        let isReachable = flags == .reachable
    //        let needsConnection = flags == .connectionRequired
    //        return isReachable && !needsConnection
    //    }
    // Alamofire 的方法
    let manager = NetworkReachabilityManager()
    return !(manager?.networkReachabilityStatus == .notReachable)
}

class CustomSlider: UISlider {
    @IBInspectable var trackHeight: CGFloat = 1
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: trackHeight))
    }
    
    private var thumbTouchSize = CGSize(width: 40, height: 40)
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let increasedBounds = bounds.insetBy(dx: -thumbTouchSize.width, dy: -thumbTouchSize.height)
        let containsPoint = increasedBounds.contains(point)
        return containsPoint
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let percentage = CGFloat((value - minimumValue) / (maximumValue - minimumValue))
        let thumbSizeHeight = thumbRect(forBounds: bounds, trackRect:trackRect(forBounds: bounds), value:0).size.height
        let thumbPosition = thumbSizeHeight + (percentage * (bounds.size.width - (2 * thumbSizeHeight)))
        let touchLocation = touch.location(in: self)
        return touchLocation.x <= (thumbPosition + thumbTouchSize.width) && touchLocation.x >= (thumbPosition - thumbTouchSize.width)
    }
    
}
//無條件取小數第幾位
//extension Double {
//    func ceiling(toDecimal decimal: Int) -> Double {
//        let numberOfDigits = abs(pow(10.0, Double(decimal))) //abs(pow(10.0, Double(decimal)))
//        if self.sign == .minus {
//            return Double(Int(self * numberOfDigits)) / numberOfDigits
//        } else {
//            return Double(ceil(self * numberOfDigits)) / numberOfDigits
//        }
//    }
//}
//四捨五入進位小數第幾位
extension Double {
    func rounding(toDecimal decimal: Int) -> Double {
        let numberOfDigits = pow(10.0, Double(decimal))
        return (self * numberOfDigits).rounded(.toNearestOrAwayFromZero) / numberOfDigits
    }
}
