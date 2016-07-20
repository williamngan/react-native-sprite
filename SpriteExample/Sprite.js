// Sprite component bridged with native component (react-native 0.29)
// By William Ngan, 7/2016

import React, { Component } from 'react';
import { requireNativeComponent, NativeModules, findNodeHandle } from 'react-native';

// refers to Sprite.swift we have in XCode
const SpriteNative = requireNativeComponent('Sprite', Sprite);

// refers to SpriteManager.swift
const SpriteManager = NativeModules.SpriteManager;

class Sprite extends Component {


  constructor(props) {
    super(props);

  }

  // Bridge to Sprite.swift's function
  createSequence(nameWithPath, count, format, duration) {
    // Use findNodeHandle from react-native.
    SpriteManager.createSequence(findNodeHandle(this), nameWithPath, count, format, duration);
  }

  // Bridge to Sprite.swift's function
  animate( shouldPlay ) {
    SpriteManager.animate( findNodeHandle(this), shouldPlay );
  }
  
  // On Mount, initiate the sequence from the props
  componentDidMount() {
    this.createSequence( this.props.imagePath, this.props.count, this.props.format, this.props.duration )
  }


  _onLayout(evt) {
    // Handle layout changes if you need
  }


  render() {
    return <SpriteNative style={ this.props.style }
                         duration={this.props.duration || 0.5}
                         onLayout={this._onLayout.bind(this)}
                         imageNumber={this.props.imageNumber || 0}
                         animated={this.props.animated || false} />;
  }

}

module.exports = Sprite;