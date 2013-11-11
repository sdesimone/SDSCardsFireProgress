SDSCardsFireProgress
==============

A progress indicator inspired by AppsFire progress animation. That is:

 - 3 "cards" evenly spaced around a half-circle;
 - at each step in your progress, the set of card will rotate around the circle;
 - nice part is: each card has its own velocity, so they will start close to one another, then they will set a bit apart, and finally they will get back to the original relative distance.

Have a look at the demo to see it in action!

Example of use:

    self.progressView = [[[SDSCardsFireProgressView alloc] initWithImages:[NSArray arrayWithObjects:@"image1", @"image2", @"image3", nil]] autorelease];
    self.progressView.center = self.view.center;
    [self.view addSubview:self.progressView];
    [self.progressView start];


![alt tag](https://raw.github.com/sdesimone/SDSCardsFireProgress/master/preview.png)
