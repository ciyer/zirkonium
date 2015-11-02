//
//  ZKMORAbstractProcessorTest.h
//  Sycamore
//
//  Created by Chandrasekhar Ramakrishnan on 29.08.06.
//  Copyright 2006 C. Ramakrishnan/ZKM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Sycamore/Sycamore.h>


@interface ZKMORAbstractProcessorTest : XCTestCase {
		//  Graph Objects
	ZKMORGraph*				graph;
	ZKMORWhiteNoise*		noise;
	ZKMORPinkNoise*			pinkNoise;
	ZKMORMixerMatrix*		mixer;
	ZKMORRenderSimulator*	simulator;
}

//  Test file paths
- (NSString *)dirPathForTestFiles;
- (NSString *)mp3TestFilePath;
- (NSString *)aiffTestFilePath;

//  Scratch file handling (for testing writes)
- (NSString *)scratchTestFilePath;
- (void)verifyScratchFile;
- (void)deleteScratchFile;

@end
