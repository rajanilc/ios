//
//  BookmarkremoveViewController.h
//  ConferenceApp
//


#import <UIKit/UIKit.h>

@interface BookmarkremoveViewController : UIViewController
{
    __weak IBOutlet UILabel *sessionIdLbl;
    __weak IBOutlet UILabel *sessionURLLbl;
    __weak IBOutlet UILabel *abstractLabel;
    
    
}
@property (nonatomic,retain) NSDictionary *detailSessionDic;

- (IBAction)setBookMarkClicked:(id)sender;
@end
