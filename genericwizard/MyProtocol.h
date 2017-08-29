//
//  MyProtocol.h
//  genericwizard
//
//  Created by Rabindra Nath Sharma on 24/08/17.
//  Copyright © 2017 Rabindra Nath Sharma. All rights reserved.
//

#ifndef MyProtocol_h
#define MyProtocol_h

#import <Foundation/Foundation.h>

@protocol MyProtocol <NSObject>

@required
- (void) updateTable;
- (void) optionViewDismissed;
@end

#endif /* MyProtocol_h */
