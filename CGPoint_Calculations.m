//
//  CGPoint_Calculations.m
//  LIBRARY
//
//  Created by Derek Neely on 4/14/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import "CGPoint_Calculations.h"

@implementation CGPoint_Calculations

/* Math code all pulled from http://forums.macrumors.com/showthread.php?t=508042 */

CGPoint vectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) {
    // NSLog(@"Point One: %f, %f", firstPoint.x, firstPoint.y);
    // NSLog(@"Point Two: %f, %f", secondPoint.x, secondPoint.y);
 
    CGFloat xDifference = firstPoint.x - secondPoint.x;
    CGFloat yDifference = firstPoint.y - secondPoint.y;
 
    CGPoint result = CGPointMake(xDifference, yDifference);
 
    return result;
}
 
CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) {
    CGFloat distance;
 
    //Square difference in x
    CGFloat xDifferenceSquared = pow(firstPoint.x - secondPoint.x, 2);
    // NSLog(@"xDifferenceSquared: %f", xDifferenceSquared);
 
    // Square difference in y
    CGFloat yDifferenceSquared = pow(firstPoint.y - secondPoint.y, 2);
    // NSLog(@"yDifferenceSquared: %f", yDifferenceSquared);
 
    // Add and take Square root
    distance = sqrt(xDifferenceSquared + yDifferenceSquared);
    // NSLog(@"Distance: %f", distance);
    
    return distance;
}

CGFloat angleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint) {
    CGPoint previousDifference = vectorBetweenPoints(firstPoint, secondPoint);
    CGFloat xDifferencePrevious = previousDifference.x;
 
    CGFloat previousDistance = distanceBetweenPoints(firstPoint, secondPoint);
    CGFloat previousRotation = acosf(xDifferencePrevious / previousDistance); 
 
    return previousRotation;
}
 
@end
