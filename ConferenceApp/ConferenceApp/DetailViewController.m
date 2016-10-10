//
//  DetailViewController.m
//  ConferenceApp
//


#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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

  
    UIBarButtonItem *bookamrk =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(addBookmark:)];
    self.navigationItem.rightBarButtonItem=bookamrk;
    

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

- (IBAction)addBookmark:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [detailSessionDic setValue:@"YES" forKey:@"bookmarked"];
    NSError *error;
    if(![appDelegate.managedObjectContext save:&error])
    {
        NSLog(@"Error In saving - error:%@",error);
    }
    NSLog(@"GetDataBase.... %@", [[DataBaseManager sharedInstance] getDataBaseArrayOfEntity:@"Conference"]);

}
@end
