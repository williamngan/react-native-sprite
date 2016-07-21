#import "RCTView.h"

@interface SpriteBridge : RCTView
  @property (nonatomic, assign) BOOL *animated;
  @property (nonatomic, assign) NSInteger *imageNumber;
  @property (nonatomic, assign) NSInteger *repeatCount;
  @property (nonatomic, assign) double *duration;
  @property (nonatomic, assign) NSString *imageLayout;
@end
