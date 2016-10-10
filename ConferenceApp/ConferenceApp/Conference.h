//
//  Conference.h
//  ConferenceApp
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Conference : NSManagedObject

@property (nonatomic, retain) NSString * abstract;
@property (nonatomic, retain) NSString * approvalUrl;
@property (nonatomic, retain) NSString * sessionId;
@property (nonatomic, retain) NSString * sessionName;
@property (nonatomic, retain) NSString * sessionUrl;
@property (nonatomic, retain) NSString * bookmarked;

@end
