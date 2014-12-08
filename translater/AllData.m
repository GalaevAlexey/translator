

#import "AllData.h"


static AllData * _sharedInstance;

@implementation AllData
@synthesize words;
@synthesize history;

+(AllData *) sharedInstance {
    @synchronized(self) {
        if (!_sharedInstance) {
            _sharedInstance = [[AllData alloc]init];
        }
    }
    return _sharedInstance;
}
- (id)init
{
    if (self = [super init])
    {
        
        history = [[NSMutableArray alloc]init];
        
    }
    
    return self;
}

@end
