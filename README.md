SDSCardsFireProgress
==============

A UIView derived class implementing an animated progress indicator like the one used in AppsFire.

Example of use:

    self.progressView = [[[SDSCardsFireProgressView alloc] initWithImages:[NSArray arrayWithObjects:@"image1", @"image2", @"image3", nil]] autorelease];
    self.progressView.center = self.view.center;
    [self.view addSubview:self.progressView];
    [self.progressView start];


![alt tag](https://raw.github.com/sdesimone/SDSCardsFireProgress/preview.png)
