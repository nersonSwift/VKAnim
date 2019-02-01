//
//  ViewController.swift
//  VKAnim
//
//  Created by Александр Сенин on 01/02/2019.
//  Copyright © 2019 Александр Сенин. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var imageee: UIImageView!
    
    var player: AVAudioPlayer!
    var daaaaaa = true
    var glass: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDouble))
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
        
        
    }
    @objc func handleDouble(recognizer: UITapGestureRecognizer) {
        if glass != nil{
            glass.removeFromSuperview()
        }
        let g = captureScreen()
        glass = UIView()
        view.addSubview(glass)
        let swipeRightRecognizer = UIPanGestureRecognizer(target: self, action: #selector(loop))
        glass.addGestureRecognizer(swipeRightRecognizer)
        
        glass.layer.contents = g.cgImage
        
        print(glass.layer.contentsRect)
        
        let x: CGFloat = 150
        let y: CGFloat = 20
        
        let kx = x / view.frame.width
        let ky = y / view.frame.height
        
        glass.frame = CGRect(x: -view.frame.height / 3, y: -view.frame.height / 3, width: view.frame.height * 1.6, height: view.frame.height * 1.6)
        glass.layer.contentsRect = CGRect(x: -(view.frame.height / view.frame.width) / 3, y: -1 / 3, width: (view.frame.height / view.frame.width) * 1.6, height: 1.6)
        glass.layer.cornerRadius = view.frame.height * 1.6 / 2
        glass.layer.masksToBounds = true
        
        if daaaaaa{
            view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            imageee.image = #imageLiteral(resourceName: "123.jpg")
            daaaaaa = false
        }else{
            view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            imageee.image = #imageLiteral(resourceName: "12345.jpg")
            daaaaaa = true
        }
        
        let n = self.view.frame.height / 5 / self.view.frame.height
        let kn = self.view.frame.height / 5 / self.view.frame.width
        
        UIView.animate(withDuration: 2, delay: 0, options: [.layoutSubviews], animations: {
            
            self.glass.frame = CGRect(x: x, y: y, width: self.view.frame.height / 5, height: self.view.frame.height / 5)
            
            print(self.glass.layer.contentsRect)
            self.glass.layer.contentsRect = CGRect(x: kx, y: ky, width: kn, height: n)
            
            self.glass.layer.cornerRadius = self.view.frame.height / 10 / 2
            
        })
        
    }
    @objc func loop(recognizer: UIPanGestureRecognizer){
        let viewr = recognizer.view!
        print(viewr.layer.contentsRect)
        
        switch recognizer.state {
        case .began: break
        case .changed:
            let trans = recognizer.translation(in: self.view)
            let newX = trans.x + viewr.transform.tx
            let newY = trans.y + viewr.transform.ty
            
            let contrntWi = viewr.layer.contentsRect.width
            let contrntHe = viewr.layer.contentsRect.height
            
            viewr.transform.tx = newX
            viewr.transform.ty = newY
            
            let kx = viewr.frame.minX / view.frame.width
            let ky = viewr.frame.minY / view.frame.height
            
            //print("x - \(x) y - \(y)")
            print("kx - \(kx) ky - \(ky)")
            
            viewr.layer.contentsRect = CGRect(x: kx, y: ky, width: contrntWi, height: contrntHe)
            
            
            
            recognizer.setTranslation(CGPoint.zero, in: self.view)
            print(viewr.layer.contentsRect)
            
            
        case .ended: break
        default: break
        }
    }
    
    func captureScreen() -> UIImage {
        var window: UIWindow? = UIApplication.shared.keyWindow
        window = UIApplication.shared.windows[0]
        UIGraphicsBeginImageContextWithOptions(window!.frame.size, window!.isOpaque, 0.0)
        window!.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
