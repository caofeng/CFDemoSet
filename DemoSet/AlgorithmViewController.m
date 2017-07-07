//
//  AlgorithmViewController.m
//  DemoSet
//
//  Created by MountainCao on 2017/7/7.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "AlgorithmViewController.h"

@interface AlgorithmViewController ()

@end

@implementation AlgorithmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     
     排序的稳定性和复杂度
     
     不稳定：
     
     选择排序（selection sort）— O(n2)
     
     快速排序（quicksort）— O(nlogn) 平均时间, O(n2) 最坏情况; 对于大的、乱序串列一般认为是最快的已知排序
     
     堆排序 （heapsort）— O(nlogn)
     
     希尔排序 （shell sort）— O(nlogn)
     
     基数排序（radix sort）— O(n·k); 需要 O(n) 额外存储空间 （K为特征个数）

     
     
     稳定：
     
     插入排序（insertion sort）— O(n2)
     
     冒泡排序（bubble sort） — O(n2)
     
     归并排序 （merge sort）— O(n log n); 需要 O(n) 额外存储空间
     
     二叉树排序（Binary tree sort） — O(nlogn); 需要 O(n) 额外存储空间
     
     计数排序  (counting sort) — O(n+k); 需要 O(n+k) 额外存储空间，k为序列中Max-Min+1
     
     桶排序 （bucket sort）— O(n); 需要 O(k) 额外存储空间
     
     */
    
    
    NSMutableArray  *arr = [NSMutableArray arrayWithObjects:@10,@20,@30,@40,@5,@9,@100,@1000,@500,@1,@0,@15,@20,@35,@45,@55,@65,@33,@22,@11,@8,@10000,@1001,@999,@888,@777,@666, nil];
    
    
//    [self selectSort:arr];//118次
//    
//    [self bubbleSort:arr];//120次
    
//    [self quickSortArray:arr withLeftIndex:0 andRightIndex:arr.count-1];//58次
    
    [self simpleSort:arr];//24次
    
//    [self inserSort:arr];//120次
    
}

#pragma - mark 选择排序

- (void)selectSort:(NSMutableArray *)array {
    
    NSInteger count = 0;
    
    //选择排序:1<-->2,1<-->3...1<-->arr.count-1 ;2<-->3,2<-->4...2<-->arr.count-1 ; ...
    
    for (int i=0; i<array.count-1; i++) {
        
        for (int j=i+1; j<array.count; j++) {
            
            NSInteger a = ((NSNumber *)(array[i])).integerValue;
            
            NSInteger b = ((NSNumber *)(array[j])).integerValue;
            
            if (a > b) {
                
                NSInteger temp ;
                temp = a;
                array[i] = @(b);
                array[j] = @(temp);
                count ++;
            }
        }
    }
    
    NSLog(@"===%@===%ld",array,(long)count);
    
}
#pragma - mark 冒泡排序

/** 冒泡排序
 1.比较相邻的元素。如果第一个比第二个大，就交换他们两个。
 2.对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。在这一点，最后的元素应该会是最大的数。
 3.针对所有的元素重复以上的步骤，除了最后一个。
 4.持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。
 */

- (void)bubbleSort:(NSMutableArray *)array {
    
    NSInteger count = 0;
    //冒泡排序：1<-->2,2<-->3,...,array.count-2<-->array.count-1; 1<-->2,2<-->3,...,array.count-3<-->array.count-2,...
    for (int i=0; i<array.count-1; i++) {
        
        for (int j=0; j<array.count-i-1; j++) {
            
            NSInteger a = ((NSNumber *)(array[j])).integerValue;
            
            NSInteger b = ((NSNumber *)(array[j+1])).integerValue;
            
            if (a > b) {
                
                NSInteger temp ;
                temp = a;
                array[j] = @(b);
                array[j+1] = @(temp);
                count ++;
                
            }
        }
    }
    
    NSLog(@"===%@===%ld",array,(long)count);
}

#pragma - mark 快速排序

/**

1 .设置两个变量i，j ，排序开始时i = 0，就j = mutableArray.count - 1；

2 .设置数组的第一个值为比较基准数key，key = mutableArray.count[0]；

3 .因为设置key为数组的第一个值，所以先从数组最右边开始往前查找比key小的值。如果没有找到，j--继续往前搜索；如果找到则将mutableArray[i]和mutableArray[j]互换，并且停止往前搜索，进入第4步；

4 .从i位置开始往后搜索比j大的值，如果没有找到，i++继续往后搜索；如果找到则将mutableArray[i]和mutableArray[j]互换，并且停止往后搜索；

5 .重复第3、4步，直到i == j（此时刚好执行完第三步或第四部），停止排序；
*/

- (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex
{
    
    NSInteger count = 0;
    
    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
        return ;
    }
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    //记录比较基准数
    NSInteger key = [array[i] integerValue];
    
    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        count ++;
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
        count ++;
    }
    //将基准数放到正确位置
    array[i] = @(key);
    /**** 递归排序 ***/
    //排序基准数左边的
    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i - 1];
    //排序基准数右边的
    [self quickSortArray:array withLeftIndex:i + 1 andRightIndex:rightIndex];
    
    if (i==j) {
        
        NSLog(@"===%@==%ld",array,(long)count);
    }
}

#pragma - mark 简单排序
/**
 找到数组中的最小值和第一个位置的值交换；
 除去第一个值，找到数组中剩余数中的最小值和第二个位置的值交换；
 除去第一第二个值，找到数组中剩余数中的最小值和第三个位置的值交换；
 ...
 */

- (void)simpleSort:(NSMutableArray *)array {
    
    
    NSInteger i,y,min;
    NSInteger count = 0;
    
    for(i=0;i<[array count];i++){
        
        min=i;
        
        for(y=i+1;y<[array count];y++){
            
            if([[array objectAtIndex:min] intValue] > [[array objectAtIndex:y] intValue]){
                min=y;
            }
        }
        
        if(min!=i){
            
            [array exchangeObjectAtIndex:i withObjectAtIndex:min];
            count ++;
        }
    }
    
    NSLog(@"===%@==%ld",array,(long)count);
}

#pragma - mark 插入排序

- (void)inserSort:(NSMutableArray *)array
{
    
    NSInteger count = 0;
    
    if(array == nil || array.count == 0){
        return;
    }
    
    for (int i = 0; i < array.count; i++) {
        
        NSNumber *temp = array[i];
        
        int j = i-1;
        
        while (j >= 0 && [array[j] compare:temp] == NSOrderedDescending) {
            
            [array replaceObjectAtIndex:j+1 withObject:array[j]];
            
            j--;
            
            count++;
        }
        
        [array replaceObjectAtIndex:j+1 withObject:temp];
    }
    
    NSLog(@"===%@===%ld",array,(long)count);
}

#pragma - mark 希尔排序

#pragma - mark 堆排序



@end
