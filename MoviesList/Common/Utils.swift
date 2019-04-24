//
//  Utils.swift
//  MoviesList
//
//  Created by Priyanka Sabhagani on 23/04/19.
//  Copyright © 2019 Priyanka Sabhagani. All rights reserved.
//
import UIKit

class Utils {
    private var errorView: ErrorView?
    
    func showErrorView(errMessage: String?, yIndex: CGFloat = 0, view: UIView) {
        if let _ = errorView{
            //It's already visible
            return
        }
        errorView = ErrorView(frame: CGRect(x: 0, y: yIndex, width: view.frame.size.width, height: view.frame.size.height - yIndex))
        errorView?.setupView(errMessage: errMessage)
        if let errorView = errorView{
            view.addSubview(errorView)
        }
    }
    
    func hideErrorView(view: UIView) {
        if let errorView = self.errorView{
            for view in view.subviews{
                if view == errorView{
                    view.removeFromSuperview()
                    self.errorView = nil
                }
            }
        }
    }
    
}
