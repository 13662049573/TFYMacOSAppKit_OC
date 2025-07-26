//
//  TFYDatePickerChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYDatePickerChainModel;
@interface TFYDatePickerChainModel : TFYBaseControlChainModel<TFYDatePickerChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ datePickerStyle) (NSDatePickerStyle);
TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ bezeled) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ bordered) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ drawsBackground) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ backgroundColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ textColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ datePickerMode) (NSDatePickerMode);
TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ datePickerElements) (NSDatePickerElementFlags);
TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ calendar) (NSCalendar*);
TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ locale) (NSLocale*);
TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ timeZone) (NSTimeZone*);
TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ dateValue) (NSDate*);
TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ timeInterval) (NSTimeInterval);
TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ minDate) (NSDate*);
TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ maxDate) (NSDate*);
TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ presentsCalendarOverlay) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYDatePickerChainModel * (^ delegate) (id<NSDatePickerCellDelegate>);

@end
TFY_CATEGORY_EXINTERFACE(NSDatePicker, TFYDatePickerChainModel)
NS_ASSUME_NONNULL_END
