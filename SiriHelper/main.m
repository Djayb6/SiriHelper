//
//  main.m
//  SiriHelper
//
//  Created by Jean-Baptiste Peraldi on 10/22/11.
//  Copyright (c) 2011 djayb6. All rights reserved.
//

#import <Foundation/Foundation.h>

// Change to match your config
#define ROOT @"/absolute/path/to/Siri/files/folder"

#define FM [NSFileManager defaultManager]


int main (int argc, const char * argv[])
{

    @autoreleasepool {
       
        [FM changeCurrentDirectoryPath:ROOT];
        
        NSURL *directoryToScan = [NSURL fileURLWithPath:ROOT];
        
        NSDirectoryEnumerator *theEnum = [FM enumeratorAtURL:directoryToScan includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles errorHandler:nil];
       
        
        for (NSURL *theURL in theEnum) {
           
           
            NSString *theInitialFileName = [[theURL path] lastPathComponent];
            
            if (theInitialFileName==@"dyld_shared_cache_armv7")
                continue;
            
            
            NSString *theDirectoriesAndFileName = [[theInitialFileName stringByReplacingOccurrencesOfString:@"#<" withString:@"/"] substringFromIndex:1];
           
            NSString *theDirectories = [theDirectoriesAndFileName stringByDeletingLastPathComponent];
            
            NSError *error1=nil;
            NSError *error2=nil;
            
            [FM createDirectoryAtPath:theDirectories withIntermediateDirectories:YES attributes:nil error:&error1];
            [FM moveItemAtPath:theInitialFileName toPath:theDirectoriesAndFileName error:&error2];
            
            if (error1) {NSLog(@"%@", error1);}
            if (error2) {NSLog(@"%@", error2);}
            
                
            
}
        
}
    return 0;
}


