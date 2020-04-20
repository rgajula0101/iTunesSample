//
//  MBProgressIndicator.swift
//  itunesSample
//
//  Created by Rakesh Kumar on 04/16/20.
//  Copyright © 2020 Rakesh Kumar. All rights reserved.
//

import Foundation
import MBProgressHUD

class MBProgressIndicator: NSObject {
    class func showIndicator(_ view : UIView){
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
    }
    
    class func hideIndicator(_ view : UIView){
        MBProgressHUD.hide(for: view, animated: true)
        
    }
}
