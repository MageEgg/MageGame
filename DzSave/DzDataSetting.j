library DzDataSetting uses DzBase

    //////////////////////////////////////////////////////////
    //使用的宏定义
    #define MaxGameLevel 9

    #define MaxHeroExpLevel 3 //最大等级
    #define MaxHeroNeedExp0 12 //经验需求
    #define MaxHeroNeedExp1 24 //经验需求
    #define MaxHeroNeedExp2 36 //经验需求
    #define MaxHeroNeedExp3 72 //经验需求
    #define MaxHeroNeedExp4 96 //经验需求

    #define MaxHeroBaseMedal 128 //一天战勋点

    int array DzHeroUseArrayInt[12][680]
    #define DzHeroUseInt                DzHeroUseArrayInt[pid]
    #define DzHeroExpLevelCount         DzHeroUseInt

    #define DzHeroMedalDeathCos         DzHeroUseInt[50]
    #define DzHeroMedalGameExp          DzHeroUseInt[51]

    #define InfiniteModeACosNum 80

    ///////////////////////////////////////////////////////////
    
    //请在这里记录注释存档数据
    // 组0 用于存储玩家上一次游戏时间戳
    // 组1 30位 == 1月 2日 3星期 4签到日 5今日签到 6连续签到 7累积签到 8通行证刷新 9未使用 10-20刷新 21公众号礼包 22入群礼包
    // 组2 12组 == 1通关积分 2守家积分 3万魔窟 
    // 组3 20组 == 1总通关次数 2+通关难度次数
    // 组4 12组 记录通行证经验
    // 组5 10组 记录通行证任务
    // 组6 20组 1经脉最大上限 2-9经脉 10+未使用
    // 组7 英雄熟练度 30组
    // 组8 英雄熟练度 30组
    // 组9 熟练度等级 60组
    // 组10 成就	30组							
    // 组11 光环	30组
    // 组12 翅膀	30组
    // 组13 神器	30组
    // 组14 称号	30组
    // 组15 彩蛋    30组
    // 组16 10组 1战勋点 2当天战勋点
    // 组17 20组 == 1疯狂总次数 2+通关难疯狂度次数 
    // 组18 12组 活动常用组 1积分1 2积分2 3积分1上限 

    function DzDataBaseSetting()
        DzOriginServerNum = 49 //地图已申请的存档组
        DzPlayerInitTGCos[1] = 15
        DzPlayerInitTGCos[2] = 15
        DzPlayerInitTGCos[3] = 15
        DzPlayerInitTGCos[4] = 15
        DzPlayerInitTGCos[5] = 15
        DzPlayerInitTGCos[6] = 15
        DzPlayerInitTGCos[7] = 15
        DzPlayerInitTGCos[8] = 15
        DzPlayerInitTGCos[9] = 15
        //DzPlayerInitTGCos[10] = 10

        DzPlayerInitCrazyTGCos[1] = 1
        DzPlayerInitCrazyTGCos[2] = 1
        DzPlayerInitCrazyTGCos[3] = 1
        DzPlayerInitCrazyTGCos[4] = 1
        DzPlayerInitCrazyTGCos[5] = 1
        DzPlayerInitCrazyTGCos[6] = 1
        DzPlayerInitCrazyTGCos[7] = 1
        DzPlayerInitCrazyTGCos[8] = 1
        DzPlayerInitCrazyTGCos[9] = 1
        //DzPlayerInitCrazyTGCos[10] = 1
    endfunction
    
    function DzDataGroupSetting()
        //初始化已使用的存档组存储方式
        //DzDataGroupLength(0) 用于版本号存储
        DzDataGroupLength(1) = 2
        DzDataGroupLength(2) = 5
        DzDataGroupLength(3) = 3
        DzDataGroupLength(4) = 5
        DzDataGroupLength(5) = 6
        DzDataGroupLength(6) = 3
        DzDataGroupLength(7) = 2
        DzDataGroupLength(8) = 2
        DzDataGroupLength(9) = 1
        DzDataGroupLength(10) = 2
        DzDataGroupLength(11) = 2
        DzDataGroupLength(12) = 2
        DzDataGroupLength(13) = 2
        DzDataGroupLength(14) = 2
        DzDataGroupLength(15) = 2
        DzDataGroupLength(16) = 6
        DzDataGroupLength(17) = 3
        DzDataGroupLength(18) = 5
        /*DzDataGroupLength(19) = 0
        DzDataGroupLength(20) = 0
        DzDataGroupLength(21) = 0
        DzDataGroupLength(22) = 0
        DzDataGroupLength(23) = 0
        DzDataGroupLength(24) = 0
        DzDataGroupLength(25) = 0
        DzDataGroupLength(26) = 0
        DzDataGroupLength(27) = 0
        DzDataGroupLength(28) = 0
        DzDataGroupLength(29) = 0*/
    endfunction
    
    function GetDzDataMaxValue(int pid,int Group,int flag,int data)->int
        int max = GetDzDataGroupMaxValue(Group)
        //在此处添加 组 位 最大值
        if  Group == 1
            if  flag == 7
                max = GamePuOverDay //累积签到 
            elseif  flag == 9 //未使用
                max = 0
            elseif  flag == 10 //经脉今日上限
                max = DzMeridiansDayNum
            elseif  flag >= 11 and flag <= 20
                max = 0
            elseif  flag == 21 or flag == 22 //公众号礼包 入群礼包
                max = 1
            elseif  flag >= 23 //未使用
                max = 0
            endif
        elseif  Group == 2
            if  flag == 1 //通关积分
                max = R2I(Pow(DzPlayerLv(Player(pid)),2)*255)
                if  max > 5000
                    max = 5000
                endif
            elseif  flag == 2 //守家积分
                max = R2I(Pow(DzPlayerLv(Player(pid)),2)*240)
                if  max > 5000
                    max = 5000
                endif
            elseif  flag == 3 //万魔窟
                max = InfiniteModeACosNum 
            elseif  flag >= 4 //未使用
                max = 0
            endif
        elseif  Group == 3
            if  flag == 1 //总通关次数
                max = DzPlayerGames(Player(pid))+1
            elseif  flag >= 2 and flag <= MaxGameLevel+1 //通关难度
                max = DzPlayerInitTGCos[flag-1]
            elseif  flag >= MaxGameLevel+2 //未开启的难度
                max = 0
            endif
        elseif  Group == 4
            if  flag == 1 //通行证经验
                max = MissionDay*6
            elseif  flag == 2 //通行证经验
                max = (MissionDay-20)*6
            elseif  flag >= 3 //未使用
                max = 0
            endif
        elseif  Group == 5 //不用管

        elseif  Group == 6 //不用管
            if  flag == 1 //经脉最大上限
                max = MeridiansDay*DzMeridiansDayNum -3
            elseif  flag >= 2 and flag <= 9 //经脉等级
                max = MeridiansMaxLv
            elseif  flag >= 10
                max = 0
            endif
        elseif  Group == 7
            max = MaxHeroNeedExp2 //MaxHeroNeedExp4
        elseif  Group == 8
            max = MaxHeroNeedExp2 //MaxHeroNeedExp4
        elseif  Group == 9
            max = MaxHeroExpLevel
        elseif  Group >= 10 and Group <= 15 //不用管

        elseif  Group == 16 
            if  flag == 1 //战勋
                max = GamePuOverDay*896 //MaxHeroBaseMedal*MaxGameLevel
            elseif  flag == 2 //当天战勋点
                max = 896 //MaxHeroBaseMedal*MaxGameLevel
            else
                max = 0
            endif
        elseif  Group == 17
            if  flag == 1 //总通关次数
                max = DzPlayerGames(Player(pid))+1
            elseif  flag >= 2 and flag <= MaxGameLevel+1 //通关难度
                max = DzPlayerInitCrazyTGCos[flag-1]
            elseif  flag >= MaxGameLevel+2 //未开启的难度
                max = 0
            endif
        elseif  Group == 18 //活动存档组
            if  flag == 1
                max = 3000
            elseif  flag == 2
                max = Holiday51*2
            elseif  flag == 3
                max = 1000
            elseif  flag > 3
                max = 0
            endif
        elseif  Group > 18 //未使用
            max = 0
        endif
        data = GetDataMaximumValue(data,max)
        return data
    endfunction


endlibrary
