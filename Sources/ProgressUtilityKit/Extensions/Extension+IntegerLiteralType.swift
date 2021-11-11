//
//  Extension+IntegerLiteralType.swift
//  
//
//  Created by Ahmed Shendy on 11/11/21.
//
import UIKit

extension IntegerLiteralType {
    func toRadians() -> CGFloat {
        return CGFloat(self) * CGFloat.pi / 180.0
    }
}
