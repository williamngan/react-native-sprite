//
//  Sprite.swift
//  Created by William Ngan on 7/15/16.
//

import UIKit

// This is the actual View in swift that we want to bridge to javascript

public class Sprite: UIView {
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
  
  public var sprite:UIImageView?
  
  
  /**
   Image Name property
   Add your image files to XCode.
   For example if you have a folder called "riderFolder",
   and files like "rider0.png", "rider1.png", etc inside
   imageName should be "riderFolder/rider"
   */
  public var imageName: String = ""
  
  
  /**
   Set sprite's animationRepeatCount when it's animating
  */
  public var _repeatCount: Int = 0;
  
  public func setRepeatCount( n: Int ) {
    print("repeat", n)
    if n >= 0 && n != sprite!.animationRepeatCount {
      sprite!.animationRepeatCount = n

      if _animated {
        sprite!.startAnimating()
      }
    }
  }

  /**
    Image Number property
    This is used to control which image to display by its index
  */
  private var _imageNumber: Int = 0

  // bridge for React property setter
  public func setImageNumber( n: Int ) {
    
    _imageNumber = n
    if !sprite!.isAnimating() && seq != nil {
      
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
  private var _animated: Bool = false
  
  public func animate( shouldPlay: Bool ) {
    setAnimated(shouldPlay)
  }
  
  // bridge for React property setter
  public func setAnimated( shouldPlay:Bool ) {
    _animated = shouldPlay
    
    if _animated != sprite!.isAnimating() {
      if shouldPlay {
        sprite!.animationImages = seq
        sprite!.animationRepeatCount = _repeatCount
        sprite!.startAnimating()

      } else {
        sprite!.stopAnimating()
      }
    }
  }
  
  
  // storing both the css-style string and the contentMode enum for use in layoutSubViews etc
  private var _imageLayout: String = "contain"
  private var _contentMode: UIViewContentMode = UIViewContentMode.ScaleAspectFit
  
  /**
   Bridge UIImageView's contentMode to a css style string for React Native
  */
  public func setImageLayout( mode:String ) {
    
    if mode == _imageLayout {
      return
    }
    
    var c = UIViewContentMode.ScaleAspectFit
    
    switch mode {
      case "contain":
        c = UIViewContentMode.ScaleAspectFit
      case "cover":
        c = UIViewContentMode.ScaleAspectFill
      case "stretch":
        c = UIViewContentMode.ScaleToFill
      case "redraw":
        c = UIViewContentMode.Redraw
      case "center":
        c = UIViewContentMode.Center
      case "top":
        c = UIViewContentMode.Top
      case "bottom":
        c = UIViewContentMode.Bottom
      case "left":
        c = UIViewContentMode.Left
      case "right":
        c = UIViewContentMode.Right
      case "topLeft", "top-left":
        c = UIViewContentMode.TopLeft
      case "topRight", "top-right":
        c = UIViewContentMode.TopRight
      case "bottomLeft", "bottom-left":
        c = UIViewContentMode.BottomLeft
      case "bottomRight", "bottom-right":
        c = UIViewContentMode.BottomRight
      default:
        c = UIViewContentMode.ScaleAspectFit
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
  public var count: Int = 10
  
  
  /**
   File format property
   Matches your image files' extension. "png" or "jpg" for example
  */
  public var format: String = "png"
  
  
  /**
   Duration property
   Set the number of seconds per full animated cycle
  */
  private var duration: Double = 0.5
  
  // bridge to React property setter
  public func setDuration( d:Double ) {
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
  public func createSequence( nameWithPath:String, count:Int, format: String, duration: Double) {
    
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
  override public func layoutSubviews() {
    sprite!.contentMode = _contentMode
    sprite!.frame = CGRect(x: 0, y:0, width: frame.width, height: frame.height)
  }
  

}