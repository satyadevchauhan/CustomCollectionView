//
//  ViewController.m
//  CustomCollectionView
//
//  Created by Satyadev on 20/02/17.
//  Copyright © 2017 Satyadev Chauhan. All rights reserved.
//

#import "ViewController.h"
#import "ParentCollectionViewCell.h"
#import "CollectionReusableViewHeader.h"
#import "CollectionReusableViewFooter.h"

static NSString * const ParentCollectionViewCellIdentifier = @"ParentCollectionViewCellIdentifier";
static NSString * const CollectionReusableViewHeaderIdentifier = @"CollectionReusableViewHeaderIdentifier";
static NSString * const CollectionReusableViewFooterIdentifier = @"CollectionReusableViewFooterIdentifier";

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectioView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"CollectionView Example";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.collectioView registerNib:[UINib nibWithNibName:@"ParentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ParentCollectionViewCellIdentifier];
    
    [self.collectioView registerNib:[UINib nibWithNibName:@"CollectionReusableViewHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionReusableViewHeaderIdentifier];
    
    [self.collectioView registerNib:[UINib nibWithNibName:@"CollectionReusableViewFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:CollectionReusableViewFooterIdentifier];
    
    self.collectioView.delegate = self;
    self.collectioView.dataSource = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ParentCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:ParentCollectionViewCellIdentifier forIndexPath:indexPath];
    
    return collectionCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        CollectionReusableViewHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionReusableViewHeaderIdentifier forIndexPath:indexPath];
        headerView.headerTitle.text = [NSString stringWithFormat:@"Header %ld", (long)indexPath.section+1];
        headerView.backgroundColor = [UIColor greenColor];
        reusableView = headerView;
        
    } else if (kind == UICollectionElementKindSectionFooter) {
        
        CollectionReusableViewFooter *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:CollectionReusableViewFooterIdentifier forIndexPath:indexPath];
        footerView.footerTitle.text = [NSString stringWithFormat:@"Footer %ld", (long)indexPath.section+1];
        footerView.backgroundColor = [UIColor yellowColor];
        reusableView = footerView;
        
    } else {
        
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:CollectionReusableViewFooterIdentifier forIndexPath:indexPath];
        
        reusableView = footerView;
    }
    
    return reusableView;
}

//Set width and height for Cell
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectioView.bounds.size.width, 100);
}

//Set width and height for Header
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(collectionView.bounds.size.width, 34);
}

//Set width and height for Footer
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(collectionView.bounds.size.width, 34);
}

@end

