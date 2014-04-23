//
//  ViewController.m
//  FileImportExport
//
//  Created by Gagan on 23/04/14.
//  Copyright (c) 2014 Gagan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    mutableArray=[NSMutableArray arrayWithObjects:@"DemoDocFile.doc",@"DemoDocxFile.docx",@"RTFDemo.rtf",@"Workbook1DemoXLS.xls",@"WorkbookXLSXDemo.xlsx",@"Rebate.pdf", nil];
}


#pragma mark-TabelView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return mutableArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"CellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
        cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    }
    cell.textLabel.text=[mutableArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *filePath=[[NSBundle mainBundle]pathForResource:[[mutableArray objectAtIndex:indexPath.row] stringByDeletingPathExtension] ofType:[[mutableArray objectAtIndex:indexPath.row]pathExtension]] ;
    [self openInFile:filePath];
}

-(void)openInFile:(NSString *)filePath
{
    documentController =[UIDocumentInteractionController  interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];
    documentController.delegate = self;
    CGRect rect = CGRectMake(0 ,0 , 0, 0);
    BOOL success;
    if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad)
    {
        success=  [documentController presentOptionsMenuFromRect:rect inView:self.view animated:YES];
    }
    else{
        UIView *view=(UIView*)[[[UIApplication sharedApplication].keyWindow subviews]objectAtIndex:0];
        success=  [documentController presentOptionsMenuFromRect:rect inView:view animated:YES];
    }
    if(success)
    {
        NSLog(@"open docs");
    }
    else
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Sorry,appropriate appliaction  not found on device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [[NSFileManager defaultManager]removeItemAtPath:filePath error:nil];
    }
}

#pragma UIDocumentIneraction Delegate
-(void)documentInteractionController:(UIDocumentInteractionController *)controller   willBeginSendingToApplication:(NSString *)application {
}

-(void)documentInteractionController:(UIDocumentInteractionController *)controller  didEndSendingToApplication:(NSString *)application {
    NSLog(@"Sending file completed to application: %@",application);
 }

-(void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
