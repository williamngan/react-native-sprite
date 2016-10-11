// Sprite example with swift native component (react-native 0.29)
// By William Ngan, 7/2016


// With references to tutorials and code samples from these. Yes they are all done differently in different versions of react-native on different dates!
// https://facebook.github.io/react-native/docs/native-modules-ios.html
// https://facebook.github.io/react-native/docs/communication-ios.html
// https://medium.com/@jpdriver/vending-pure-swift-views-in-react-native-3f417349e3c6#.wwp2uii0p
// http://browniefed.com/blog/react-native-how-to-bridge-a-swift-view/
// https://github.com/Jpadilla1/react-native-ios-charts/


import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  Dimensions,
  TouchableHighlight,
  Slider,
  View
} from 'react-native';

const Sprite = require('./Sprite.js');

class SpriteExample extends Component {
  constructor(props) {
    super( props );
    this.state = {
      imageNumber: -1,
      animated: false,
      spriteHeight: 215,
      duration: 1
    };

  }

  componentDidMount() {

  }


  render() {

    let windowWidth = Dimensions.get("window").width;

    return (
      <View style={{flex: 1, flexDirection: 'column', alignItems: 'center'}}>

        <View style={{ flex: 0.5, flexDirection: 'column', backgroundColor: "#333", alignItems: 'center', justifyContent: 'center'}}>

          <View style={{ width: windowWidth, padding: 10, backgroundColor: "#000"}}>

            <Sprite ref="sprite" style={{flex: 1, alignSelf: 'stretch', height: this.state.spriteHeight}}
                    imagePath="rider/rider"
                    format="png"
                    count={10}
                    duration={this.state.duration}
                    imageNumber={this.state.imageNumber}
                    animated={this.state.animated} />

          </View>
        </View>

        <View style={{ flex: 0.5, flexDirection: 'column', alignItems: 'center', width: windowWidth, padding: 30}}>
          <View style={{flexDirection: "row"}}>
            <TouchableHighlight style={styles.button} underlayColor="#39F" onPress={this._onPlay.bind(this)}>
              <Text style={styles.buttonLabel}>{ (!this.state.animated) ? "Play sprite" : "Stop"}</Text>
            </TouchableHighlight>
          </View>

          <View style={{flexDirection: "row"}}>
            <View style={styles.sliderLabelWrap}><Text>Speed</Text></View>
            <Slider style={styles.slider} maximumValue={2} minimumValue={0.15} value={1} onSlidingComplete={this._onSpeed.bind(this)} />
          </View>


          <View style={{flexDirection: "row"}}>
            <View style={styles.sliderLabelWrap}><Text>Frames</Text></View>
            <Slider style={styles.slider} maximumValue={10} minimumValue={0} onValueChange={this._onFrame.bind(this)} />
          </View>


          <View style={{flexDirection: "row"}}>
            <View style={styles.sliderLabelWrap}><Text>Height</Text></View>
            <Slider style={styles.slider} maximumValue={300} minimumValue={150} value={215} onValueChange={this._onResize.bind(this)} />
          </View>

        </View>


      </View>
    );
  }


  _onPlay() {
    this.setState({animated: !this.state.animated});
  }

  _onFrame(value) {
    if (this.state.animated) this.setState({animated: false});

    let f = Math.floor( value );
    if (f != this.state.imageNumber) {
      this.setState( {imageNumber: f} );
    }

  }

  _onResize(value) {
    let h = Math.floor(value);

    if ( Math.abs(h-this.state.spriteHeight) > 5) {
      this.setState( {spriteHeight: h} );
    }
  }

  _onSpeed(value) {
    if (!this.state.animated) this.setState({animated: true});

    let v = Math.abs(2-value) + 0.15
    this.setState({duration: v});
  }


  // Step through the frames (not used)
  _onNext() {
    this.setState({imageNumber: this.state.imageNumber+1});
  }

  _onPrev() {
    let n = this.state.imageNumber-1;
    if (n<0) n = 10;
    this.setState({imageNumber: n});
  }


}

const styles = StyleSheet.create({


  button: {
    paddingLeft: 75,
    paddingRight: 75,
    paddingTop: 15,
    paddingBottom: 15,
    marginBottom: 25,
    marginTop: 10,
    backgroundColor: "#36c"
  },

  buttonLabel: {
    color: "#FFF",
    fontSize: 20,
    fontWeight: "600"
  },

  slider: {
    height: 30,
    margin: 20,
    flex: 1,
    alignSelf: 'stretch'
  },

  sliderLabel: {
    height: 30,
    paddingRight: 20
  },

  sliderLabelWrap: {
    alignItems: 'center',
    justifyContent: "center",
    width: 60
  }

});


// register component
AppRegistry.registerComponent('SpriteExample', () => SpriteExample);
