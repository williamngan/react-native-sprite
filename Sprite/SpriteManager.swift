import Foundation

// This bridges Swift to Objectiver C. See SpriteBridge.m

@objc(SpriteManager)
class SpriteManager : RCTViewManager {
  
  override func view() -> UIView! {
    return Sprite();
  }
  
  // This is a function that bridges the one from Sprite.swift
  // No idea what's reactTag, but it's needed to find the view
  // Remember to import "RCTUIManager.h" in the Bridging-Header.h
  @objc func createSequence(reactTag: NSNumber, nameWithPath:String, count:Int, format: String, duration: Double) {

    // Let's start with some spaghetti to get a view!
    self.bridge!.uiManager.addUIBlock { (uiManager: RCTUIManager!, viewRegistry:[NSNumber : UIView]!) in
      let view: Sprite = viewRegistry[reactTag] as! Sprite;
      
      // The first parameter is not named, but the second one requires a name. Whatever!
      view.createSequence( nameWithPath, count:count, format:format, duration:duration );
    }
  }
  

}