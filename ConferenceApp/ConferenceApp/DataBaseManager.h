//
//  DataBaseManager.h



#import <Foundation/Foundation.h>

typedef enum{
    PContacts,
    PCustomersProducts,
    PCustomers,
    PMinutesOfMeeting,
    POfflineData,
    POpportunities,
    PQuotes,
    PSampleRequests,
    PProducts
    }EntityTableName;

@interface DataBaseManager : NSObject

+ (DataBaseManager *)sharedInstance;
- (NSManagedObjectContext *)getManagedObjectContext;

- (void)deleteAllDataInEntity:(NSString *)entityName;
- (void)setBookmarkForEntity:(NSString *)entityName InSessionId:(NSString *)sessionId BookMarked:(NSString *)bookMarked;
- (void) insertDataInContactsTable:(NSDictionary *)dataDic;
- (NSArray *)getDataBaseArrayOfEntity:(NSString *)entityName;
- (NSArray *)getBookMarkedDataArrayOfEntity:(NSString *)entityName;

@end
