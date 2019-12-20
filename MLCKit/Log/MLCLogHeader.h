//
//  MLCLogHeader.h
//  Pods
//
//  Created by menglingchao on 2019/12/20.
//

#ifndef MLCLogHeader_h
#define MLCLogHeader_h

#if DEBUG
#define  MLCLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])
#else
#define MLCLog(...)
#endif

#endif /* MLCLogHeader_h */
