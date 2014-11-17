//
//  StarViewController.m
//  Star Wars Quotes
//
//  Created by Blaise Rivet on 11/17/14.
//  Copyright (c) 2014 ICAppSoc. All rights reserved.
//

#import "StarViewController.h"

@interface StarViewController ()

@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;

@end

@implementation StarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // TODO: Complete code
}

- (IBAction)showNewQuote:(id)sender {
    // Requests a new Star Wars quote
    NSString *starWarsUrl = @"http://www.iheartquotes.com/api/v1/random?source=starwars&format=json";
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:starWarsUrl] completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
        if (error != nil) {
            NSLog(@"Error retrieving quote: %@", error.localizedDescription);
            return;
        }
        NSError *errorJSON = nil;
        NSDictionary *quoteJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&errorJSON];
        if (errorJSON != nil) {
            NSLog(@"Error parsing quote: %@", errorJSON.localizedDescription);
            return;
        }
        
        // TODO: Complete code
        
        // UIKit operations involving views need to happen on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            // TODO: Complete code
        });
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
