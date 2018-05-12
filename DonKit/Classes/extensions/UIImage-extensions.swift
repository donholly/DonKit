//
//  UIImage-extensions.swift
//  DonKit
//
//  Created by Don Holly on 12/27/17.
//

import Foundation

extension UIImage {
    
    static func mask(image: UIImage, withMask mask: UIImage) -> UIImage {
        return image.masked(with: mask)
    }
    
    func masked(with mask: UIImage) -> UIImage {
        guard
            let imageReference = cgImage,
            let maskReference = mask.cgImage,
            let dataProvider = maskReference.dataProvider,
            let imageMask = CGImage(
                maskWidth: maskReference.width,
                height: maskReference.height,
                bitsPerComponent: maskReference.bitsPerComponent,
                bitsPerPixel: maskReference.bitsPerPixel,
                bytesPerRow: maskReference.bytesPerRow,
                provider: dataProvider,
                decode: nil,
                shouldInterpolate: true
            ),
            let maskedReference = imageReference.masking(imageMask)
            else {
                return mask
        }
        
        return UIImage(cgImage: maskedReference)
    }
    
    func resizedTo(_ newSize: CGSize) -> UIImage? {
        var scaledImageRect = CGRect.zero
        
        let aspectWidth = newSize.width/size.width
        let aspectheight = newSize.height/size.height
        
        let aspectRatio = max(aspectWidth, aspectheight)
        
        scaledImageRect.size.width = size.width * aspectRatio;
        scaledImageRect.size.height = size.height * aspectRatio;
        scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0;
        scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0;
        
        UIGraphicsBeginImageContext(newSize)
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let ovalPath = UIBezierPath(ovalIn: rect)
        color.setFill()
        ovalPath.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
