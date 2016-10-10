//
//  NewViewController.h
//  ConferenceApp
//


#import <UIKit/UIKit.h>

@interface NewViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    __weak IBOutlet UITableView *listTableView;
}

- (NSArray *)getDataBaseArrayOfEntity:(NSString *)entityName;

@end
