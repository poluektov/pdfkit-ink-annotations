//
//  DrawingGestureRecognizer.swift
//  PDFKit Demo
//
//  Created by Tim on 29/01/2019.
//  Copyright © 2019 Tim. All rights reserved.
//

import UIKit

protocol DrawingGestureRecognizerDelegate: class {
    func gestureRecognizerBegan(_ location: CGPoint)
    func gestureRecognizerMoved(_ location: CGPoint)
    func gestureRecognizerEnded(_ location: CGPoint)
}

class DrawingGestureRecognizer: UIGestureRecognizer {
    weak var drawingDelegate: DrawingGestureRecognizerDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first,
            touch.type == .pencil, // Comment this line to test on simulator without Apple Pencil
            let numberOfTouches = event?.allTouches?.count,
            numberOfTouches == 1 {
            state = .began
            
            let location = touch.location(in: self.view)
            drawingDelegate?.gestureRecognizerBegan(location)
        } else {
            state = .failed
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        state = .changed
        
        guard let location = touches.first?.location(in: self.view) else { return }
        drawingDelegate?.gestureRecognizerMoved(location)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self.view) else {
            state = .ended
            return
        }
        drawingDelegate?.gestureRecognizerEnded(location)
        state = .ended
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .failed
    }
}
