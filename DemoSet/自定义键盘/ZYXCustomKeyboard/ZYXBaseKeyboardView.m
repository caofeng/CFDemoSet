//
//  ZYXBaseKeyboardView.m
//
//  Copyright © 2016 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "ZYXBaseKeyboardView.h"
#import "ZYXKeyButton.h"


@implementation ZYXBaseKeyboardView

- (NSMutableArray *)charArrayList {
    
    if (!_charArrayList) {
        _charArrayList = [self getCharacterList];
    }
    
    return _charArrayList;
}

- (NSMutableArray *)buttonList {
    
    if (!_buttonList) {
        _buttonList = [[NSMutableArray alloc] init];
    }
    
    return _buttonList;
}

- (NSMutableArray *)getCharacterList {
    
    return [[NSMutableArray alloc] init];
}

#pragma mark - Touch Events

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];
    
    CGPoint location = [[touches anyObject] locationInView:self];
    
    for (ZYXKeyButton *b in self.buttonList) {
        
        if(CGRectContainsPoint(b.frame, location)) {
            [b showPopupToButton];
        } else {
            [b hidenPopupToButton];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent: (UIEvent *)event {
    
    for (ZYXKeyButton *b in self.buttonList){
        
        [b hidenPopupToButton];
    }
}

#pragma mark -

- (void)addPopupToButton:(UIButton *)b {
    
    if ([self popUpToButtonPosition:b] == ZYXNumberViewImageNone) {
        return;
    }
}

- (void)startTimerDel {
    
    if (_deleteKeyTimer == nil) {
        _deleteKeyTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                           target:self
                                                         selector:@selector(deleteClick:)
                                                         userInfo:nil
                                                          repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_deleteKeyTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimerDel {
    
    if ([_deleteKeyTimer isValid]) {
        [_deleteKeyTimer invalidate];
        _deleteKeyTimer = nil;
    }
}

- (void)deleteClick:(id)sender{

}

- (void)deleteLongPressed:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged) {
        [self startTimerDel];
        
    } else{
        [self stopTimerDel];
    }
}

- (ZYXNumberViewImage)popUpToButtonPosition:(UIButton *)button {
    
    return ZYXNumberViewImageNone;
}

@end
