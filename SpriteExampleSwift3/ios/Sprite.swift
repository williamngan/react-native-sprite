//
//  Sprite.swift
//  Created by William Ngan on 7/15/16.
//

import UIKit

// This is the actual View in swift that we want to bridge to javascript

open class Sprite: UIView {
  override public init(frame: CGRect) {
    super.init(frame: frame)
    
    // an UIImageView inside this view. Still need to figure out how to pass react props to width height here
    sprite = UIImageView( frame: frame )
    
    /// For testing only. These should be set in javascript
    // let image = UIImage(named: "rider/rider1.png")
    // sprite.image = image
    // imageName = "rider/rider"
    // count = 11
    // createSequence(imageName, num: count)
    
    
    self.addSubview(sprite!)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError( "init(coder:) has not been implemented" )
  }
  
  open var sprite:UIImageView?
  
  
  /**
   Image Name property
   Add your image files to XCode.
   For example if you have a folder called "riderFolder",
   and files like "rider0.png", "rider1.png", etc inside
   imageName should be "riderFolder/rider"
   */
  open var imageName: String = ""
  
  
  /**
   Set sprite's animationRepeatCount when it's animating
  */
  open var repeatCount: Int = 0;
  
  
  /**
    Image Number property
    This is used to control which image to display by its index
  */
  fileprivate var _imageNumber: Int = 0

  // bridge for React property setter
  open func setImageNumber( _ n: Int ) {
    
    _imageNumber = n
    if !sprite!.isAnimating && seq != nil {
      
      // boundary
      _imageNumber = _imageNumber % seq!.count
      if _imageNumber < 0 { _imageNumber = seq!.count + _imageNumber }
      
      sprite!.image = seq![_imageNumber]
    }
  }
  
  
  /**
   Animated property
   Controls whether the images should be played
   */
  fileprivate var _animated: Bool = false
  
  open func animate( _ shouldPlay: Bool ) {
    setAnimated(shouldPlay)
  }
  
  // bridge for React property setter
  open func setAnimated( _ shouldPlay:Bool ) {
    _animated = shouldPlay
    
    if _animated != sprite!.isAnimating {
      if shouldPlay {
        sprite!.animationImages = seq
        sprite!.animationRepeatCount = repeatCount
        sprite!.startAnimating()

      } else {
        sprite!.stopAnimating()
      }
    }
  }
  
  
  // storing both the css-style string and the contentMode enum for use in layoutSubViews etc
  fileprivate var _imageLayout: String = "contain"
  fileprivate var _contentMode: UIViewContentMode = UIViewContentMode.scaleAspectFit
  
  /**
   Bridge UIImageView's contentMode to a css style string for React Native
  */
  open func setImageLayout( _ mode:String ) {
    
    if mode == _imageLayout {
      return
    }
    
    var c = UIViewContentMode.scaleAspectFit
    
    switch mode {
      case "contain":
        c = UIViewContentMode.scaleAspectFit
      case "cover":
        c = UIViewContentMode.scaleAspectFill
      case "stretch":
        c = UIViewContentMode.scaleToFill
      case "redraw":
        c = UIViewContentMode.redraw
      case "center":
        c = UIViewContentMode.center
      case "top":
        c = UIViewContentMode.top
      case "bottom":
        c = UIViewContentMode.bottom
      case "left":
        c = UIViewContentMode.left
      case "right":
        c = UIViewContentMode.right
      case "topLeft", "top-left":
        c = UIViewContentMode.topLeft
      case "topRight", "top-right":
        c = UIViewContentMode.topRight
      case "bottomLeft", "bottom-left":
        c = UIViewContentMode.bottomLeft
      case "bottomRight", "bottom-right":
        c = UIViewContentMode.bottomRight
      default:
        c = UIViewContentMode.scaleAspectFit
    }
    
    _imageLayout = mode
    _contentMode = c
    sprite!.contentMode = c
    
  }
  
  
  /**
   Count property
   This should match the number of images in your image sequence
   "rider0.png" ... "rider9.png" => 10 images
   */
  open var count: Int = 10
  
  
  /**
   File format property
   Matches your image files' extension. "png" or "jpg" for example
  */
  open var format: String = "png"
  
  
  /**
   Duration property
   Set the number of seconds per full animated cycle
  */
  fileprivate var duration: Double = 0.5
  
  // bridge to React property setter
  open func setDuration( _ d:Double ) {
    duration = d
    sprite!.animationDuration = duration
    
    // seems setting duration will stop animation. Restart it if animated is true
    if _animated {
      sprite!.startAnimating()
    }
  }
  
  
  // store an array of UIImage sequence
  var seq: [UIImage]?
  
  
  /**
   Initiate the sprite by creating a sequence
   - nameWithPath: "folder/image-name" to set imageName
   - count: number of images
   - format: image files' extension, for example, "png" or "jpg"
   - duration: number of seconds per full animation cycle
  */
  open func createSequence( _ nameWithPath:String, count:Int, format: String, duration: Double) {
    
    self.imageName = nameWithPath
    self.count = count
    self.format = format
    self.duration = duration
  
    if count > 0 && !imageName.isEmpty {
      
      sprite!.image = UIImage(named: "\(imageName)0.\(format)")
      
      seq = Array<UIImage>()
      
      for i in 0...count {
        let n = "\(imageName)\(i).\(format)"
        let image = UIImage(named: n)
        if image != nil {
          seq!.append( image! )
        }
      }
      
      sprite!.animationImages = seq
      sprite!.animationDuration = duration
      sprite!.contentMode = _contentMode
      
    }
    
  }
  
  
  // When the layout changes, update the UIImageView sprite sizes too
  override open func layoutSubviews() {
    sprite!.contentMode = _contentMode
    sprite!.frame = CGRect(x: 0, y:0, width: frame.width, height: frame.height)
  }
  

}
