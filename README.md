# Animated Image Sequence for React Native (iOS)
`react-native-sprite` is a React Native component for animating a sequence of images. Under the hood, it bridges UIImageView to animate images in native iOS.

This is experimental and currently works in XCode **7.3** with React Native **0.29**. React Native is a bit of a moving target and many things undocumented. Please file [issues](https://github.com/williamngan/react-native-sprite/issues) or ping [@williamngan](https://twitter.com/williamngan) for bugs and suggestions.  

The folders are organized like this:

- [**Sprite**](./Sprite) : the iOS bridge stuff
- [**SpriteComponent**](./SpriteComponent) : Component for react-native
- [**SpriteExample**](./SpriteExample) An example react-native project with Sprite component

&nbsp;   
   
## Example
First, download or clone this repo, and then go to Terminal or CMD, and run `npm install` in the `SpriteExample` folder. This will download the `react-native` library. It may take a while.

Then, run `react-native run-ios` in `SpriteExample` folder. You should see this when it finishes building. Woot!

![example](./images/demo.gif)



## Component Properties
The Sprite component has the following props:

- **imagePath** : A string to specify "folder/name". Eg, if you have "world0.png ... world10.png" in "hello" folder, the `imagePath` would be "hello/world"   
- **format** : Your image file's extension. Eg, "png" or "jpg"
- **count** : Number of images in your sequence
- **duration** : Time in seconds to play a full cycle of your image sequence. Eg, 0.5 = play a full sequence every 500 milliseconds.
- **animated** : A boolean to start or stop the animation
- **imageNumber** : When not animating, you can display a specific image by its number. Eg, 3 will display "img3.png"
- **repeatCount** : Number of loops to play before animation stops. If unspecified, animation will play continuously.
- **contentMode** : A string key to specify how to lay out the image in view. Valid keys are: `contain, cover, stretch, top, bottom, left, right, topLeft, topRight, bottomLeft, bottomRight`. Default is "contain" if unspecified.

Additionally, Sprite component also provides 2 methods: `createSequence(nameWithPath, count, format, duration)` and `animate( shouldPlay )` if you need them instead of using props above.

Take a look at `index.ios.js` in `SpriteExample` folder for reference.   

![code](./images/componentCode.png)
    
&nbsp;

## Setting it up in your project

Add this component into your react-native project in these 7 tedious steps! I wish there's an easier way :expressionless:

**1)** Open your iOS project in XCode (eg, in `ProjectFoo/ios/ProjectFoo.xcodeproj`). `ProjectFoo` is your react-native project folder.

**2)** In XCode, right-click on your `ProjectFoo` folder, and select "Add Files to ProjectFoo..."   
   
![addFiles](./images/addFiles.png)   

**3)** Navigate to your downloaded `react-native-sprite` folder, click the subfolder `Sprite`, and select all files in there, and click "Add".   
   
![addFiles](./images/selectFiles.png)   

**4)** At this point, XCode will ask if you want to create a Bridging Header. Yes, create it.   
(In case you miss it, you can manually create a header file named "ProjectFoo-Bridging-Header.h" later.) 
   
![addFiles](./images/createBridge.png)   

**5)** Next, add a folder of images that you want to animate. You can find some images in [`react-native-sprite/SpriteExample/ios/rider`](./SpriteExample/ios/rider) for testing. Like step #2, right-click the project folder and select "Add files..."   

**6)** Click on the generated bridge header file from step 4 (`ProjectFoo-Bridging-Header.h`), and add these two lines into the file.   
   
```objective-c
#import "RCTViewManager.h"
#import "RCTUIManager.h"
```   
   
![addFiles](./images/bridgeHeader.png)   
   
**7)** Almost there! Finally, add the `Sprite.js` file from `SpriteComponent` folder to your ReactNative project. (Not in XCode "ios" project.) Then you can use it as a component like this:   
   
```javascript
const Sprite = require('./Sprite.js');

...

render() {
  return (<View {props}><Sprite {props} /></View>)
}
```
 
Take a look at `index.ios.js` in `SpriteExample` folder for reference.   
&nbsp;    



## Have fun!
![noidea](./images/noIdeaCat.png)
