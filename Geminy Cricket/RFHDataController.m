//
//  RFHDataController.m
//  Geminy Cricket
//
//  Created by Ryan Higgins on 10/8/17.
//  Copyright © 2017 Higgnet. All rights reserved.
//

#import "RFHDataController.h"
#import "RFHAppDelegate.h"
#import "Stats+CoreDataProperties.h"

@interface RFHDataController ()

@property (nonatomic, strong) NSManagedObjectContext *writerMOC;

@end

@implementation RFHDataController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupCoreData];
    }
    return self;
}

/*
 Setups Core data, including: managed object model,
 persistent store coordinator, managed object contexts, and persistent store.
 After setup is complete, makes calls to load the root view controller, and
 load items from disk into RAM.
 */
- (void)setupCoreData {
    // setup managed object model
    NSManagedObjectModel *model =
    [[NSManagedObjectModel alloc]
     initWithContentsOfURL:[self geminyCricketModelURL]];
    
    // setup persistent store coordinator
    NSPersistentStoreCoordinator *psc =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    
    NSError *error;
    NSMutableDictionary *storeOptions = [[NSMutableDictionary alloc] init];
    [storeOptions setValue:[NSNumber numberWithBool:YES]
                    forKey:NSMigratePersistentStoresAutomaticallyOption];
    [storeOptions setValue:[NSNumber numberWithBool:YES]
                    forKey:NSInferMappingModelAutomaticallyOption];
    NSPersistentStore *store = nil;
    store = [psc addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:[self persistentStoreURL]
                                    options:storeOptions
                                      error:&error];
    
    
    // setup managed object contexts
    self.mainMOC = [[NSManagedObjectContext alloc]
                    initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.writerMOC = [[NSManagedObjectContext alloc]
                      initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [self.writerMOC setPersistentStoreCoordinator:psc];
    [self.mainMOC setParentContext:self.writerMOC];
    
    if (![[NSUserDefaults standardUserDefaults]
          objectForKey:@"preloadedStats"]) {
        [self preloadStats];
        [[NSUserDefaults standardUserDefaults]
         setObject:[NSNumber numberWithBool:YES] forKey:@"preloadedStats"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //NSLog(@"core date completed setup");
        [self fetchStatsManagedObject];
        [self updateUI];
    });
    
    
}

#pragma mark - Model Paths

- (NSURL *)geminyCricketModelURL {
    return [[NSBundle mainBundle] URLForResource:@"GeminyCricket"
                                   withExtension:@"momd"];
}

- (NSURL *)persistentStoreURL {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = [fm URLsForDirectory:NSDocumentDirectory
                                inDomains:NSUserDomainMask];
    NSURL *documentDirectory = [paths lastObject];
    NSURL *persistentStorePath =
    [documentDirectory URLByAppendingPathComponent:@"GeminyCricket.sqlite"];
    return persistentStorePath;
}

#pragma mark - Database Seeding

- (void)preloadStats {
    NSEntityDescription *statsEntity =
    [NSEntityDescription entityForName:@"Stats"
                inManagedObjectContext:self.mainMOC];
    Stats *stats = [[Stats alloc]
                    initWithEntity:statsEntity
                    insertIntoManagedObjectContext:self.mainMOC];
    stats.wins = 0;
    stats.losses = 0;
    stats.winStreak = 0;
    stats.longestWinStreak = 0;
    stats.flawlessVictories = 0;
    
    [self saveContext];
}

#pragma mark - Saving

/*
 Save the objects in the current managed context to the hard drive.
 */
- (void)saveContext {
    // Pass the save from the context on the main queue to a context on
    // a background queue.
    
    // mainMOC will pass saves to writerMOC
    [[self mainMOC] performBlockAndWait:^{
        if (![[self mainMOC] hasChanges]) {
            return;
        }
        NSError *error;
        if (![[self mainMOC] save:&error]) {
            //NSLog(@"main moc unable to save");
            // main moc unable to save
        } else {
           // NSLog(@"main moc saved");
        }
    }];
    
    // writerMOC will perform asynchronous saves to hard disk
    [[self writerMOC] performBlock:^{
        if (![[self writerMOC] hasChanges]) {
            return;
        }
        NSError *error;
        if (![[self writerMOC] save:&error]) {
            //NSLog(@"writer moc unable to save");
            // writer moc unable to save
        } else {
            //NSLog(@"writer moc saved");
        }
    }];
}

#pragma mark - UI

- (void)updateUI {
    RFHAppDelegate *delegate = (RFHAppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate setupUI];
}

- (void)fetchStatsManagedObject {
    // create fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setReturnsObjectsAsFaults:NO];
    NSEntityDescription *statsEntity = [NSEntityDescription entityForName:@"Stats" inManagedObjectContext:self.mainMOC];
    [request setEntity:statsEntity];
    
    // execute fetch request
    NSError *error;
    NSArray *items = [[NSArray alloc] init];
    items = [self.mainMOC executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"error fetching stats");
    }
    Stats *stats = [items objectAtIndex:0];
    RFHAppDelegate *delegate = (RFHAppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.stats = stats;
    
}

@end
