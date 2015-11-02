//
//  ZKMORUtilitiesTest.mm
//  Sycamore
//
//  Created by Chandrasekhar Ramakrishnan on 24.08.06.
//  Copyright 2006 C. Ramakrishnan/ZKM. All rights reserved.
//

#import "ZKMORUtilitiesTest.h"
#import <Sycamore/Sycamore.h>
#import <Sycamore/ZKMORLoggerCPP.h>


@implementation ZKMORUtilitiesTest

- (void)setUp
{
	tz = CFTimeZoneCopyDefault();
}

- (void)tearDown
{
	CFRelease(tz);
}

- (void)clearLogger
{
	ZKMORLogger* logger = GlobalLogger();
	ZKMORReadLogToken* token;
	
	logger->BeginReading();
	while (token = logger->GetReadLogToken()) {
			//  Don't acutally log -- this causes spurious failures in the test projest
//		token->FPrint(stdout, tz);
		logger->ReturnReadLogToken(token);
	}
	logger->EndReading();	
}

- (void)testLogging
{
	// set up
	[self clearLogger];
	ZKMORLoggerSetIsLogging(YES);
	ZKMORLoggerSetLogLevel(kZKMORLogLevel_Error);
	
	// log a conduit
	ZKMORConduit* conduit = [[[ZKMORConduit alloc] init] autorelease];
	[conduit logAtLevel: kZKMORLogLevel_Error source: kZKMORLogSource_Irrelevant indent: 1];
	
	// log an object
	NSNumber* number = [NSNumber numberWithInt: 10];
	[number logAtLevel: kZKMORLogLevel_Error source: kZKMORLogSource_Irrelevant indent: 0];

	// read from the logger
	ZKMORLogger* logger = GlobalLogger();
	ZKMORReadLogToken* token;
	BOOL hasToken = NO;
	unsigned numberOfTokens = 0;
	CFIndex length;

	logger->BeginReading();
	while (token = logger->GetReadLogToken()) {
		hasToken = YES;
		numberOfTokens++;
		length = CFStringGetLength(token->logString);
			//  Don't acutally log -- this causes spurious failures in the test projest		
//		token->FPrint(stdout, tz);
		logger->ReturnReadLogToken(token);
	}
	logger->EndReading();
	
	XCTAssertTrue(hasToken, @"Loging should create a token");
	XCTAssertTrue(2 == numberOfTokens, @"Loging should create exactly two tokens, not %u tokens", numberOfTokens);
	
	// tear down
	ZKMORLoggerSetIsLogging(NO);
}

- (void)testFRand
{
	float rand1, rand2;
	rand1 = ZKMORFRand();
	rand2 = ZKMORFRand();
	XCTAssertTrue(0.f <= rand1, @"ZKMORFRand should return 0. <= number");
	XCTAssertTrue(0.f <= rand2, @"ZKMORFRand should return 0. <= number");
	XCTAssertTrue(1.f >= rand1, @"ZKMORFRand should return 1. >= number");
	XCTAssertTrue(1.f >= rand2, @"ZKMORFRand should return 1. >= number");
	XCTAssertTrue(rand1 != rand2, @"ZKMORFRand should return random numbers");
}

- (void)testWrap
{
	XCTAssertEqualWithAccuracy(ZKMORWrap0ToMax(1.1f, 1.f), 0.1f, 0.0001f, @"ZKMORWrap0ToMax(1.1f, 1.f) should return 0.1f");
}

- (void)testFold
{
	XCTAssertEqualWithAccuracy(ZKMORFold0ToMax(1.1f, 1.f), 0.9f, 0.0001f, @"ZKMORFold0ToMax(1.1f, 1.f) should return 0.9f");
	XCTAssertEqualWithAccuracy(ZKMORFold(1.1f, 1.f, 2.f), 1.1f, 0.0001f, @"ZKMORFold(1.1f, 1.f, 2.f) should return 1.1f");
	XCTAssertEqualWithAccuracy(ZKMORFold(0.9f, 1.f, 2.f), 1.1f, 0.0001f, @"ZKMORFold(0.9f, 1.f, 2.f) should return 1.1f");
	XCTAssertEqualWithAccuracy(ZKMORFold(-1.1f, -1.f, 1.f), -0.9f, 0.0001f, @"ZKMORFold(-1.1f, -1.f, 1.f) should return -0.9f");
}

- (void)testClamp
{
	XCTAssertEqualWithAccuracy(ZKMORClamp(1.1f, -1.f, 1.0), 1.f, 0.0001f, @"ZKMORClamp(1.1f, -1.f, 1.0), should return 1.f");
	XCTAssertEqualWithAccuracy(ZKMORClamp(-1.7f, -1.f, 1.0), -1.f, 0.0001f, @"ZKMORClamp(-1.7f, -1.f, 1.0), should return -1.f");
}

- (void)testInterpolate
{
	XCTAssertEqualWithAccuracy(ZKMORInterpolateValue(1.1f, -1.f, 1.0), -1.f, 0.0001f, @"ZKMORInterpolateValue(1.1f, -1.f, 1.0), should return -1.f");
	XCTAssertEqualWithAccuracy(ZKMORInterpolateValue(1.1f, -1.f, 0.5), 0.05f, 0.0001f, @"ZKMORInterpolateValue(1.1f, -1.f, 0.5), should return -0.05f");
}

- (void)testFormatError
{
	char errStr[8];
	ZKMORFormatError('errr', errStr);
	XCTAssertEqual(errStr[1], 'e', @"errr[1] was %c", errStr[1]);
	// need to cast away volitility for the compiler
	XCTAssertEqual(*((const char*) &errStr[2]), 'r', @"errr[2] was %c", errStr[2]);
	XCTAssertEqual(*((const char*) &errStr[3]), 'r', @"errr[3] was %c", errStr[3]);
	XCTAssertEqual(*((const char*) &errStr[4]), 'r', @"errr[4] was %c", errStr[4]);			
}

@end
