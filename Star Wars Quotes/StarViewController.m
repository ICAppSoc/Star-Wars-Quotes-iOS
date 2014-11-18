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
    
    // ADDED: When the view loads, show a quote straight away so that our Label (the quoteLabel variable) doesn't just its default text
    [self showNewQuote:nil];
}

// ADDED: This method (a function you can call on an object) is for when you tap the Color button. It changes the background of this StarViewController's view to a random color. We can access the view with self.view, where self refers to the StarViewController instance.
- (IBAction)newColor:(id)sender {
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0f green:arc4random_uniform(255)/255.0f blue:arc4random_uniform(255)/255.0f alpha:1.0];
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
        
        // ADDED: We declare a string variable (NSString object in Objective-C) to hold the quote that we get back from the server.
        NSString *quote = quoteJSON[@"quote"];
        // If you want to print out the entire server reply, uncomment the next line
//        NSLog("%@", quoteJSON);
        
        
        // UIKit operations involving views need to happen on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            // ADDED: set the text of the label to the new quote we just got off the Internet
            self.quoteLabel.text = quote;
        });
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
