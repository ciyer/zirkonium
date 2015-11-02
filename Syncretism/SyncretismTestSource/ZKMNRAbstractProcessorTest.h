//
//  ZKMNRAbstractProcessorTest.h
//  Syncretism
//
//  Created by Chandrasekhar Ramakrishnan on 21.12.06.
//  Copyright 2006 C. Ramakrishnan/ZKM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Syncretism/Syncretism.h>


@interface ZKMNRAbstractProcessorTest : XCTestCase {
		//  Graph Objects
	ZKMORGraph*				graph;
	ZKMORWhiteNoise*		noise;
	ZKMORMixerMatrix*		mixer;
//	ZKMORRenderSimulator*	simulator;
	ZKMOROutputSimulator*	simulator;
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
