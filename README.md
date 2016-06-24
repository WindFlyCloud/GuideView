# GuideView
可以很快的集成引导页
#### 代码实现

	  // 引导页在程序中只会显示一次
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    int a=[[userDefaults objectForKey:@"isShow"] intValue];
    if (a!=10) {
        [userDefaults setObject:@"10" forKey:@"isShow"];
        LeadScrollView * leadView =   [[LeadScrollView alloc]init];
        [self.window addSubview:leadView];
        
        [userDefaults synchronize];
    }

#### Images
![image](http://huaban.com/pins/639991615/) 
