#import "RCTBridgeModule.h"
#import "RCTViewManager.h"
#import "SpriteBridge.h"


@interface RCT_EXTERN_MODULE(SpriteManager, RCTViewManager)

  RCT_EXPORT_VIEW_PROPERTY(imageNumber, NSInteger)

  RCT_EXPORT_VIEW_PROPERTY(repeatCount, NSInteger)

  RCT_EXPORT_VIEW_PROPERTY(imageLayout, NSString)

  RCT_EXPORT_VIEW_PROPERTY(animated, BOOL)

  RCT_EXPORT_VIEW_PROPERTY(duration, double)

  RCT_EXTERN_METHOD( createSequence: (nonnull NSNumber *)reactTag nameWithPath:(NSString *)nameWithPath count:(NSInteger *)count format:(NSString *)format duration:(double *)duration )

  RCT_EXTERN_METHOD( animate: (nonnull NSNumber *)reactTag shouldPlay:(BOOL *)shouldPlay )
@end