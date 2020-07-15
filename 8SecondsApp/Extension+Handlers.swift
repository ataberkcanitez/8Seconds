//
//  Extension+Handlers.swift
//  8SecondsApp
//
//  Created by Ataberk Canıtez on 22.03.2020.
//  Copyright © 2020 Ataberk Canıtez. All rights reserved.
//

import UIKit
import AVFoundation


extension UIView{
    public func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
}




func printFonts(){
    for family: String in UIFont.familyNames
    {
        print(family)
        for names: String in UIFont.fontNames(forFamilyName: family)
        {
            print("== \(names)")
        }
    }
}




// return estimated width of given string
func getEstimatedWidthOfString(string: String, stringHeight: Int, stringFont: UIFont) -> CGFloat {
    let approximateHeightOfString = stringHeight
    let size:CGSize = CGSize(width: 1000, height: approximateHeightOfString)
    let attributes = [NSAttributedString.Key.font: stringFont]
    let estimatedFrame = NSString(string: string).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
    
    return estimatedFrame.width
}

// return estimated height of given string
func getEstimatedHeightOfString(string: String, stringWidth: Int, stringFont: UIFont) -> CGFloat {
    let approximateWidthOfString = stringWidth
    let size: CGSize = CGSize(width: approximateWidthOfString, height: 1000)
    let attributes = [NSAttributedString.Key.font: stringFont]
    let estimatedFrame = NSString(string: string).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
    
    return estimatedFrame.height
}



// CustomImageViewForRemoteImages

let allImageCache = NSCache<AnyObject, AnyObject>()
var allImageToCache: UIImage?
class RemoteImages: UIImageView{
    var imageUrlString: String?
    
    func loadImageUsingUrlString( urlString: String){
        imageUrlString = urlString
        
        self.image = nil
        let url = URL(string: urlString)
        
        if let imageFromCache = allImageCache.object(forKey: urlString as AnyObject) as? UIImage{
            image = nil
            image = imageFromCache
            return
        }
        DispatchQueue.global().async {
            if let urlUnwrapped = url{
                let data = try? Data(contentsOf: urlUnwrapped)
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    let imageToCache = UIImage(data: data)
                    if self.imageUrlString == urlString{
                        self.image = nil
                        self.image = imageToCache
                    }
                    if imageToCache != nil{
                        if let imageToCacheUnwrapped = imageToCache{
                            allImageCache.setObject(imageToCacheUnwrapped, forKey: urlString as AnyObject)

                        }
                    }
                }
            }
        }
        
        
    }
}




    enum Vibration {
    case error
    case success
    case warning
    case light
    case medium
    case heavy
    case selection
    case oldSchool

    func vibrate() {

      switch self {
      case .error:
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)

      case .success:
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)

      case .warning:
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)

      case .light:
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

      case .medium:
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

      case .heavy:
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()

      case .selection:
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()

      case .oldSchool:
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
      }

    }

}
