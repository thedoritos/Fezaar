//
//  FEZListCollectionViewController.m
//  Fezaar
//
//  Created by t-matsumura on 3/26/15.
//  Copyright (c) 2015 HumourStudio. All rights reserved.
//

#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>
#import "FEZListCollectionViewController.h"
#import "FEZTwitter.h"

@interface FEZListCollectionViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@property (nonatomic) FEZListCollection *listCollection;
@property (nonatomic) FEZTwitter *twitter;

@end

@implementation FEZListCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Lists";
    
    self.listCollection = [FEZListCollection collection];
    self.twitter = [[FEZTwitter alloc] init];
    
    self.listTableView.dataSource = self;
    self.listTableView.delegate = self;
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshAccount];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listCollection.length;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"listCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    FEZList *list = [self.listCollection listAtIndex:indexPath.row];
    
    cell.textLabel.text = list.name;
    cell.detailTextLabel.text = list.listDescription;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FEZList *selectedList = [self.listCollection listAtIndex:indexPath.row];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"FEZNotificationShowList" object:nil userInfo:@{@"list" : selectedList}];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.slidingViewController resetTopViewAnimated:YES];
}

#pragma mark - Private

- (void)refreshAccount
{
    [[self.twitter authorize] subscribeNext:^(ACAccount *account) {
        [self refreshListCollection];
    } error:^(NSError *error) {
        NSLog(@"Failed to refresh account with error:%@", error);
        [self updateListCollection:[FEZListCollection collection]];
    }];
}

- (void)refreshListCollection
{
    @weakify(self)
    [[self.twitter fetchLists]
     subscribeNext:^(FEZListCollection *listCollection) {
         @strongify(self)
         [self updateListCollection:listCollection];
     } error:^(NSError *error) {
         NSLog(@"Failed to fetch lists with error: %@", error);
     }];
}

- (void)updateListCollection:(FEZListCollection *)listCollection
{
    self.listCollection = listCollection;
    
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        [self.listTableView reloadData];
    });
}

@end
