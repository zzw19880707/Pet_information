//
//  HomeDetailTableView.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-12-10.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "HomeDetailTableView.h"

@implementation HomeDetailTableView
@synthesize index;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark ----datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *listIndentifier=@"HomeDetailCell";
    UITableViewCell *cell=[tableView  dequeueReusableCellWithIdentifier:listIndentifier];
    
    if (cell==nil) {//nib文件名
        switch (self.homeType) {
            case kDetailDiseaseType://4常见病列表
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:listIndentifier];
                break;
            case kDetailNearType://5附近列表
                switch (self.index) {
                    case 0://主人
                        cell=[[[NSBundle mainBundle] loadNibNamed:@"NearPeopleCell" owner:self options:nil]lastObject];
                        
                        break;
                    case 1://宠物
                        cell=[[[NSBundle mainBundle] loadNibNamed:@"NearPetCell" owner:self options:nil]lastObject];
                        
                        break;
                    case 2://商家
                        cell=[[[NSBundle mainBundle] loadNibNamed:@"NearUnitCell" owner:self options:nil]lastObject];
                        
                        break;
                    case 3://医院
                        cell=[[[NSBundle mainBundle] loadNibNamed:@"NearUnitCell" owner:self options:nil]lastObject];
                        
                        break;
                    case 4://club
                        cell=[[[NSBundle mainBundle] loadNibNamed:@"NearUnitCell" owner:self options:nil]lastObject];
                        
                        break;
                    default:
                        break;
                }
                break;
            case kDetailMedicineType://3药品列表
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:listIndentifier];
                break;

    
            default:
                break;
        }
    }
    
    switch (self.homeType) {
        case kDetailDiseaseType://4常见病列表
            cell = [self setDiseaseCell:cell andIndexPath : indexPath];
            break;
        case kDetailNearType://5附近列表
            switch (self.index) {
                case 0://主人
                    
                    break;
                case 1://宠物
                    
                    break;
                case 2://商家
                    
                    break;
                case 3://医院
                    
                    break;
                case 4://club
                    
                    break;
                default:
                    break;
            }
            break;
        case kDetailMedicineType://3药品列表
            cell = [self setMedicineCell:cell andIndexPath : indexPath];
            break;
        default:
            break;
    }

    
    
    
    return  cell;
    
}
//常见病cell
-(UITableViewCell *)setDiseaseCell:(UITableViewCell *)cell andIndexPath:(NSIndexPath *) indexPath{
    cell.textLabel.text = [self.data[indexPath.row] objectForKey:@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
//附近人cell
-(UITableViewCell *)setNearPeopleCell:(UITableViewCell *)cell andIndexPath:(NSIndexPath *) indexPath{
    cell.textLabel.text = self.data[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
//附近宠物cell
-(UITableViewCell *)setNearPetCell:(UITableViewCell *)cell andIndexPath:(NSIndexPath *) indexPath{
    cell.textLabel.text = self.data[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
//附近医院、商店、club cell
-(UITableViewCell *)setNearUnitCell:(UITableViewCell *)cell andIndexPath:(NSIndexPath *) indexPath{
    cell.textLabel.text = self.data[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
//药品cell
-(UITableViewCell *)setMedicineCell:(UITableViewCell *)cell andIndexPath:(NSIndexPath *) indexPath{
    cell.textLabel.text = [self.data[indexPath.row] objectForKey:@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.homeType) {
        case kDetailDiseaseType://4常见病列表
            return 44;
        case kDetailNearType://5附近列表
            switch (self.index) {
                case 0://主人
                    return 80;
                case 1://宠物
                    return 60;
                case 2://商家
                    return 100;
                case 3://医院
                    return 100;
                case 4://club
                    return 100;
                default:
                    return 44;
            }
            break;
        case kDetailMedicineType://3药品列表
            return 80;
            break;
        default:
            return 44;
    }
}

@end
