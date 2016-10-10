//
//  DataBaseManager.m


#import "DataBaseManager.h"
#import "Conference.h"

@implementation DataBaseManager

+ (DataBaseManager *)sharedInstance
{
    static DataBaseManager *sharedInstance = nil;
    @synchronized(sharedInstance)
    {
        if(!sharedInstance)
        {
            sharedInstance = [[[self class] alloc] init];
        }
    }
    return sharedInstance;
}

- (AppDelegate *)appDelegate
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate;
}

- (NSManagedObjectContext *)getManagedObjectContext
{
    return [[self appDelegate] managedObjectContext];
}

- (void)deleteAllDataInEntity:(NSString *)entityName
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.getManagedObjectContext ];
    [fetchRequest setEntity:entity];
	
    NSError *error;
    NSArray *items = [self.getManagedObjectContext executeFetchRequest:fetchRequest error:&error];
	
    for (NSManagedObject *managedObject in items)
    {
        [self.getManagedObjectContext  deleteObject:managedObject];
    }
    
    if(![self.getManagedObjectContext  save:&error])
    {
        NSLog(@"Error In saving - error:%@",error);
    }
}

- (void)setBookmarkForEntity:(NSString *)entityName InSessionId:(NSString *)sessionId BookMarked:(NSString *)bookmarked
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.getManagedObjectContext ];
    [fetchRequest setEntity:entity];
	
    NSError *error;
    NSArray *items = [self.getManagedObjectContext  executeFetchRequest:fetchRequest error:&error];
	
    for (NSManagedObject *managedObject in items)
    {
        if ([[managedObject valueForKey:@"SessionId"] isEqualToString:sessionId])
        {
            [self.getManagedObjectContext  setValue:bookmarked forKey:@"bookmarked"];
            break;
        }
    }
    
    if(![self.getManagedObjectContext  save:&error])
    {
        NSLog(@"Error In saving - error:%@",error);
    }
}

- (void) insertDataInContactsTable:(NSDictionary *)dataDic
{
    //    dataDic = [[ApplicationHelper sharedInstance] dictionaryByReplacingNullsWithStrings:dataDic];
    
    Conference *entityObj = (Conference *)[NSEntityDescription insertNewObjectForEntityForName:@"Conference" inManagedObjectContext:self.getManagedObjectContext ];
    
    entityObj.sessionId = [[dataDic valueForKey:@"SessionId"] description];
    entityObj.sessionName = [[dataDic valueForKey:@"SessionName"] description];
    entityObj.abstract = [[dataDic valueForKey:@"Abstract"] description];
    entityObj.approvalUrl = [[dataDic valueForKey:@"ApprovalUrl"] description];
    entityObj.sessionUrl = [[dataDic valueForKey:@"SessionUrl"] description];
    entityObj.bookmarked = @"NO";
    
    NSError *error;
    if(![self.getManagedObjectContext  save:&error])
    {
        NSLog(@"Error In saving - error:%@",error);
    }
}

- (NSArray *)getDataBaseArrayOfEntity:(NSString *)entityName
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:self.getManagedObjectContext ]];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    //    [fetchRequest setReturnObjectsAsFaults:NO];
    NSError *error = nil;
    return [self.getManagedObjectContext  executeFetchRequest:fetchRequest error:&error];
}

- (NSArray *)getBookMarkedDataArrayOfEntity:(NSString *)entityName
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:self.getManagedObjectContext ]];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    //    [fetchRequest setReturnObjectsAsFaults:NO];
    NSError *error = nil;
    NSArray *actualArray = [self.getManagedObjectContext  executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *bookmarkedArray = [[NSMutableArray alloc] init];
    for (NSDictionary *tempDic in actualArray)
    {
        if([[tempDic valueForKey:@"bookmarked"] isEqualToString:@"YES"])
        {
            [bookmarkedArray addObject:tempDic];
        }
    }
    NSLog(@"booookmarked array count %i", bookmarkedArray.count);
   
    return bookmarkedArray;
}

@end
