//
//  CustomMedicationCell.h
//  myMedical
//
//  Created by Tristan Freeman on 11/5/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomMedicationCell : UITableViewCell
{
    IBOutlet UILabel *medName;
    IBOutlet UILabel *medStrength;
    IBOutlet UILabel *medForm;
}
@property (nonatomic, strong)IBOutlet UILabel *medName;
@property (nonatomic, strong)IBOutlet UILabel *medStrength;
@property (nonatomic, strong)IBOutlet UILabel *medForm;

@end
