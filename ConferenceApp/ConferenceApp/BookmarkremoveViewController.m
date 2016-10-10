//
//  BookmarkremoveViewController.m
//  ConferenceApp
//

#import "BookmarkremoveViewController.h"

@interface BookmarkremoveViewController ()

@end

@implementation BookmarkremoveViewController
@synthesize detailSessionDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIBarButtonItem *Sessions =[[UIBarButtonItem alloc]initWithTitle:@"Remove" style:UIBarButtonItemStylePlain target:self action:@selector(removeBookamrk:)];
    
    self.navigationItem.rightBarButtonItem=Sessions;

    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    NSLog(@"dddddd ... %@", detailSessionDic);
    
    sessionIdLbl.text = [detailSessionDic valueForKey:@"sessionId"];
    sessionURLLbl.text = [detailSessionDic valueForKey:@"sessionUrl"];
    abstractLabel.text = [detailSessionDic valueForKey:@"abstract"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)removeBookamrk:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [detailSessionDic setValue:@"NO" forKey:@"bookmarked"];
    NSError *error;
    if(![appDelegate.managedObjectContext save:&error])
    {
        NSLog(@"Error In saving - error:%@",error);
    }
    NSLog(@"GetDataBase.... %@", [[DataBaseManager sharedInstance] getDataBaseArrayOfEntity:@"Conference"]);
    
}




@end
