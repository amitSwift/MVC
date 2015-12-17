//
//  categoriesTableControl.m
//  Fashion
//
//  Created by Lakhwinder Singh on 10/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "CategoriesTableControl.h"
#import "LibOften.h"

@interface CategoriesTableControl () {
    NSArray *items;
}

@property (weak, nonatomic) id <CategoriesTableDelegate> delegateTable;

@end

@implementation CategoriesTableControl

+ (instancetype)controlWithDelegate:(id<CategoriesTableDelegate>)delegateTable {
    CategoriesTableControl *control = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"CategoriesTableControl"];
    control.delegateTable = delegateTable;
    return control;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    items = @[@"Beauty Products", @"Dresses", @"Celebrity Dresses", @"Day Dresses", @"Little Black Dress", @"Maxi Dresses", @"MIDI Dresses", @"Party Dresses", @"Hats", @"Hoodies", @"Jewellery", @"Playsuits & Jumpsuits", @"Scarves, Hats & Gloves", @"Shirts", @"Sportswear", @"Swimwear & Beachwear", @"Trousers"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegateTable selectCategory];
}

@end


