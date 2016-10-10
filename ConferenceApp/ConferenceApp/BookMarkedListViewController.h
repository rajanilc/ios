//
//  BookMarkedListViewController.h
//  ConferenceApp
//


#import <UIKit/UIKit.h>

@interface BookMarkedListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    
    __weak IBOutlet UITableView *bookmarkTableView;
}
@end
