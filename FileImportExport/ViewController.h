//
//  ViewController.h
//  FileImportExport
//
//  Created by Gagan on 23/04/14.
//  Copyright (c) 2014 Gagan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIDocumentInteractionControllerDelegate,UITableViewDataSource,UITableViewDataSource>
{
    UIDocumentInteractionController *documentController;
    NSMutableArray *mutableArray;
    __weak IBOutlet UITableView *myTableView;
}

@end
