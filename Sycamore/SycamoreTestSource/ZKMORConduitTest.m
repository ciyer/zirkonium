//
//  ZKMORConduitTest.m
//  Sycamore
//
//  Created by Chandrasekhar Ramakrishnan on 23.08.06.
//  Copyright 2006 C. Ramakrishnan/ZKM. All rights reserved.
//

#import "ZKMORConduitTest.h"
#import <Sycamore/Sycamore.h>


@implementation ZKMORConduitTest

- (void)testConduit
{
	ZKMORConduit* conduit = [[ZKMORConduit alloc] init];

	XCTAssertNotNil(conduit, @"Conduit should not be nil");
	XCTAssertEqual([conduit numberOfInputBuses], (unsigned) 1, @"Conduit should have 1 input bus");
	XCTAssertEqual([conduit numberOfOutputBuses], (unsigned) 1, @"Conduit should have 1 output bus");	
}

@end
