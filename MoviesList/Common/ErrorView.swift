//
//  ErrorView.swift
//  MoviesList
//
//  Created by Priyanka Sabhagani on 23/04/19.
//  Copyright © 2019 Priyanka Sabhagani. All rights reserved.
//

import UIKit

class ErrorView: UIView{
    private var errMessage: String = ErrorState.noDetail.rawValue
    
    lazy var errMsgLabel: UILabel = {
        let errMsg = UILabel(frame: CGRect(x: 16, y: 0, width: self.frame.size.width - 32, height: self.frame.size.height))
        errMsg.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        errMsg.text = errMessage
        errMsg.numberOfLines = 0
        errMsg.textAlignment = .center
        return errMsg
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(errMessage: String?) {
        backgroundColor = .white
        if let errMessage = errMessage{
            self.errMessage = errMessage
        }
        addSubview(errMsgLabel)
    }
    
}
