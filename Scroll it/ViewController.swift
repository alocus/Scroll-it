//
//  ViewController.swift
//  Scroll it
//
//  Created by Michael Dunn on 2016-09-12.
//  Copyright © 2016 Michael Dunn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var scrollWidth :CGFloat = 0.0

    var images = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // handle swipe outside of scrollview to improve UX 
        // Swipe Gesture Recognizers
        // These can be lets because they aren't mutated and I'm using the latest Selector syntax
        let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("respondToSwipeGesture:"))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector("respondToSwipeGesture:"))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        let swipeUp = UISwipeGestureRecognizer(target: self, action: Selector("respondToSwipeGesture:"))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        let swipeDown = UISwipeGestureRecognizer(target: self, action: Selector("respondToSwipeGesture:"))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeUp)
        self.view.addGestureRecognizer(swipeDown)
    }

    // Put calcualation in viewDidAppear because scrollView size can't be detemined 
    // in viewDidLoad.
    override func viewDidAppear(_ animated: Bool) {
        var contentWidth: CGFloat = 0.0
        
        scrollWidth = scrollView.frame.size.width
        
        for x in 0...2 {
            let image = UIImage(named: "icon\(x).png")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            
            var newX: CGFloat = 0.0
            
            // the mid of a frame + all the pages where an icon belong
            newX = scrollWidth/2 + scrollWidth * CGFloat(x)
            
            // dynamically calculate content width of scroll view
            contentWidth += newX
            
            scrollView.addSubview(imageView)
            
            // size of the imageView which holds an item
            let iconSize = 150
            
            // position the UIView
            imageView.frame = CGRect(x: Int(newX) - iconSize/2, y: Int(scrollView.frame.size.height/2) - iconSize/2, width: iconSize, height: iconSize)
            
        }
        
        // scrollView.backgroundColor = UIColor.purple //for debug
        
        // To allow showing of the next item in the scoll view, the scroll view itself
        // must be smaller than the frame, then clipsToBounds needs to be false.
        scrollView.clipsToBounds = false
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
        
        // print( "Count: \(images.count)")

    }
    
    // here are those protocol methods with Swift syntax
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return true
    }
    
    // Debugging - All Swipes Are Detected Now
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

