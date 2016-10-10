//
//  BookMarkedListViewController.m
//  ConferenceApp
//


#import "BookMarkedListViewController.h"
#import "BookmarkremoveViewController.h"

@interface BookMarkedListViewController ()

@end

@implementation BookMarkedListViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - TableView DataSources

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[DataBaseManager sharedInstance] getBookMarkedDataArrayOfEntity:@"Conference"].count;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    cell.textLabel.text = [[[[DataBaseManager sharedInstance] getBookMarkedDataArrayOfEntity:@"Conference"] objectAtIndex:indexPath.row] valueForKey:@"SessionId"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Pushing next view
    BookmarkremoveViewController *detailView = [[BookmarkremoveViewController alloc] initWithNibName:@"BookmarkremoveViewController" bundle:nil];
    detailView.detailSessionDic = [[[DataBaseManager sharedInstance] getBookMarkedDataArrayOfEntity:@"Conference"] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailView animated:YES];
}

////////////

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
