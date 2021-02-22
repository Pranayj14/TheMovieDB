//
//  TMDExtensions.swift
//  TheMovieDB
//
//  Created by User on 20/02/21.
//

import Foundation
import UIKit

// MARK: - Extension to show image on the imageview by using image url.
extension UIImageView {
    public func imageFromURL(urlString: String) {
        var activityIndicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .gray)
            // Fallback on earlier versions
        }
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        overlay.backgroundColor = UIColor.lightGray
        activityIndicator.startAnimating()
        
        if self.image == nil{
            self.addSubview(activityIndicator)
            self.addSubview(overlay)
        }
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                overlay.removeFromSuperview()
                if image == nil{
                    self.image = UIImage(named: "brokenImage")
                }else{
                    self.image = image
                    
                }
            })
        }).resume()
    }
}

