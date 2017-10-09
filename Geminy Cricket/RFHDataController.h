//
//  RFHDataController.h
//  Geminy Cricket
//
//  Created by Ryan Higgins on 10/8/17.
//  Copyright © 2017 Higgnet. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

/*
 Controller for setting up Core Data persistent storage.
 */
@interface RFHDataController : NSObject

/*
 Context where all core data objects exit.
 */
@property (nonatomic, strong) NSManagedObjectContext *mainMOC;

/*
 Save the objects in the current managed context to the hard drive.
 */
- (void)saveContext;

@end
