//
//  AppDelegate.h
//  ConferenceApp
//

#import <UIKit/UIKit.h>
//#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//@property (nonatomic, retain) Reachability *internetReachable;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
