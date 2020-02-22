//
//  ViewController.swift
//  DiamondAnimation
//
//  Created by MAC006 on 08/12/17.
//  Copyright © 2017 MAC006. All rights reserved.
//

import UIKit
import SAConfettiView
class ViewController: UIViewController {

    @IBOutlet weak var gifView: UIView!
    @IBOutlet weak var butImage: UIImageView!
    @IBOutlet weak var someView: UIView!
    var confettiView: SAConfettiView!
    var isRainingConfetti = false
//    @IBOutlet var confettiStatus: UILabel!
    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url: URL? = Bundle.main.url(forResource: "butterfly_small_orange", withExtension: "gif")
        let testImage = UIImage.animatedImage(withAnimatedGIFURL: url)
        let testImageArr = [UIImage(named: "butterfly_small_green.gif"),UIImage(named: "butterfly_small_orange.gif")]
        butImage.animationImages = testImage?.images
        butImage.animationRepeatCount = 0
        butImage.image = nil
        butImage.startAnimating()
        butImage.alpha = 0.0
        
        let emitterLayer = CAEmitterLayer()
        
        emitterLayer.emitterPosition = CGPoint(x: 320, y: 320)
        
        let cell = CAEmitterCell()
        cell.birthRate = 5
        cell.lifetime = 10
        cell.velocity = 100
        cell.scale = 0.1
        
        cell.emissionRange = CGFloat.pi * 2.0
        
        
        cell.contents =  testImage?.cgImage //butImage.animationImages! //UIImage(named: "diamond")?.cgImage
    
        emitterLayer.emitterCells = [cell]
        
       // view.layer.addSublayer(emitterLayer)
        

        // Create confetti view
        confettiView = SAConfettiView(frame: self.view.bounds)
        
        // Set colors (default colors are red, green and blue)
//        confettiView.colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
//                               UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
//                               UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
//                               UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
//                               UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
        
        // Set intensity (from 0 - 1, default intensity is 0.5)
        confettiView.intensity = 0.6
        // Set type
       // confettiView.type = .Diamond
        
        // For custom image
        confettiView.type = .Image(UIImage(named: "diamond")!)
        
        // Add subview
//        view.addSubview(confettiView)
        
        if (isRainingConfetti) {
            // Stop confetti
            confettiView.stopConfetti()
//            confettiStatus.text = "it's not raining confetti 🙁"
        } else {
            // Start confetti
            confettiView.startConfetti()
//            confettiStatus.text = "it's raining confetti 🙂"
        }
        isRainingConfetti = !isRainingConfetti
    }


    @IBAction func start(_ sender: Any) {
        let randomNum:UInt32 = arc4random_uniform(6)
        print(randomNum)
        let url2: URL? = Bundle.main.url(forResource: "butterfly_small\(randomNum)", withExtension: "gif")
        let testImage2 = UIImage.animatedImage(withAnimatedGIFURL: url2)
        let butImages: UIImageView = UIImageView()
       // butImages.frame = CGRect(x:0, y:0, width:50, height:50)
        butImages.animationImages = testImage2?.images
        butImages.animationRepeatCount = 0
        butImages.image = nil
        butImages.startAnimating()
        
        gifView.addSubview(butImages)
        let xRandomModified: CGFloat = CGFloat(arc4random_uniform(UInt32(self.view.frame.size.width)))
        butImages.frame = CGRect(x:100, y:self.view.frame.size.height-50, width:30, height:30)
        
    UIView.animate(withDuration: 1, animations: {
        
    }) { _ in
        UIView.animate(withDuration: 3.0,
                       delay: 0.2,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                        butImages.alpha = 0.0
                        butImages.frame = CGRect(x:xRandomModified, y:-80, width:60, height:60)
        }, completion: { (finished) -> Void in
            // ....
        })
    }
        
        
//        UIView.animate(withDuration: 2, animations: {
//            butImages.frame = CGRect(x:60, y:250, width:30, height:30)
//        }) { _ in
//            UIView.animate(withDuration: 1.5, delay: 0.8, options: [.autoreverse], animations: {
//
//                butImages.alpha = 0.0
//                butImages.frame = CGRect(x:0, y:-80, width:60, height:60)
//            })
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
//        UIView.animate(withDuration: 0.1,
//                       delay: 0.1,
//                       options: UIViewAnimationOptions.curveEaseIn,
//                       animations: { () -> Void in
//                        butImages.frame = CGRect(x:60, y:-150, width:80, height:80)
//        }, completion: { (finished) -> Void in
//            // ....
//        })
        
    
    }
    
}

extension UIImage {
    
    public class func gifImageWithData(data: NSData) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source: source)
    }
    
    public class func gifImageWithURL(gifUrl:String) -> UIImage? {
        guard let bundleURL = NSURL(string: gifUrl)
            else {
                print("image named \"\(gifUrl)\" doesn't exist")
                return nil
        }
        guard let imageData = NSData(contentsOf: bundleURL as URL) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        
        return gifImageWithData(data: imageData)
    }
    
    public class func gifImageWithName(name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        
        guard let imageData = NSData(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(data: imageData)
}

    class func delayForImageAtIndex(index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(CFDictionaryGetValue(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()), to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()), to: AnyObject.self)
        
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a! < b! {
            let c = a!
            a = b!
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b!
                b = rest
            }
        }
    }
    
    class func gcdForArray(array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(a: val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(index: Int(i), source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(array: delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames, duration: Double(duration) / 1000.0)
        
        return animation
    }
}
