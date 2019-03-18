//
//  PDFAnnotationWithPath.swift
//  PDFKit Demo
//
//  Created by Tim on 06/02/2019.
//  Copyright © 2019 Tim. All rights reserved.
//

import UIKit
import PDFKit
import Foundation

extension PDFAnnotation {
    
    func contains(point: CGPoint) -> Bool {
        var hitPath: CGPath?
        
        if let path = paths?.first {
            hitPath = path.cgPath.copy(strokingWithWidth: 10.0, lineCap: .round, lineJoin: .round, miterLimit: 0)
        }
        
        return hitPath?.contains(point) ?? false
    }
}
