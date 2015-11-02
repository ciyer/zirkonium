//
//  ZKMORNoiseTest.h
//  Sycamore
//
//  Created by Chandrasekhar Ramakrishnan on 24.08.06.
//  Copyright 2006 C. Ramakrishnan/ZKM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Sycamore/Sycamore.h>


@interface ZKMORNoiseTest : XCTestCase {
	ZKMORWhiteNoise*	whiteNoise;
	ZKMORPinkNoise*		pinkNoise;


	ZKMORGraph*				graph;
	ZKMORMixerMatrix*		mixer;
	ZKMORRenderSimulator*	simulator;
	
}

@end
