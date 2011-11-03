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
           
           
            
            NSError *error;
            
            NSString *theInitialFileName = [[theURL path] lastPathComponent];
            
            if (theInitialFileName==@"dyld_shared_cache_armv7")
                continue;
            
            
            NSString *theDirectoriesAndFileName = [[theInitialFileName stringByReplacingOccurrencesOfString:@"#<" withString:@"/"] substringFromIndex:1];
           
            
            NSString *theDirectories = [theDirectoriesAndFileName stringByDeletingLastPathComponent];
            
           
            
            
            [FM createDirectoryAtPath:theDirectories withIntermediateDirectories:YES attributes:nil error:&error];
            [FM moveItemAtPath:theInitialFileName toPath:theDirectoriesAndFileName error:&error];
            if (error)
            NSLog(@"%@", error);
            
                
            
}
        
}
    return 0;
}


