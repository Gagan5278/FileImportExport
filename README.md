FileImportExport
================
This demo illustrate how to share file within applications installed in device & File share with iTuens.
 to share files within apps via iTunes add following key in your app .plist file
 UIFileSharingEnabled   :    YES
 
 
 To share files within apps open 'info' tab from your app target. Add document types as you want. To get 'Types' use following 
 apple link 
 
 https://developer.apple.com/library/mac/documentation/Miscellaneous/Reference/UTIRef/Articles/System-DeclaredUniformTypeIdentifiers.html
 
 Add types, name & file icon(Added by you).
 
 
 To get more information for file sharing you can go on following link
 
 http://mobiforge.com/design-development/importing-exporting-documents-ios?dm_switcher=true
 
 Please look into appDelegate.m file method 
 -(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if(url!=nil && [url isFileURL])// used to import documents from another apps/mail
    {
        NSData *data=[NSData dataWithContentsOfURL:url];
        NSString *fileName=[[url path] lastPathComponent];
        NSString *stringFolder=[NSString stringWithFormat:@"Documents"];
        NSString *dataPath = [NSHomeDirectory() stringByAppendingPathComponent:stringFolder ];
        dataPath=[dataPath stringByAppendingPathComponent:fileName];
        NSFileManager *fileManager=[NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:dataPath])
        {
            BOOL success=[data writeToFile:dataPath atomically:YES];
            if(success)
            {
                NSLog(@"File Saved SuccessFully");
            }
        }
        return YES;
    }
    return NO;
}


Above code save files coming from another apps.


For open-in option create UIDocumentInteractionController  object. Implement all it's delegate within your .m file.
On selection of any cell in tableView you will get option.
