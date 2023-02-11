//
//  NSData+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//


@interface NSData (Dejal)

+ (NSData *)tfy_dataWithObject:(id)rootObject;

- (id)tfy_objectOfClass:(Class)class;

@end

