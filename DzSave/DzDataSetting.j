library DzDataSetting uses DzBase

    ///////////////////////////////////////////////////////////
    
    //请在这里记录注释存档数据
    // 组0 用于存储玩家上一次游戏时间戳
    // 组1 30位 == 1月 2日 3星期 4签到日 5今日签到 6连续签到 7累积签到 8通行证刷新 9未使用 10-20刷新 21公众号礼包 22入群礼包
    // 组2 12组 == 1通关积分 2守家积分 
    // 组3 20组 == 1总通关次数 2+通关难度次数 最高难5
    // 组4 12组 记录通行证经验
    // 组5 10组 记录通行证任务
    // 组6 20组 1经脉最大上限 2-9经脉 10+未使用
    // 组7 未使用 12组
    // 组8 未使用 12组
    // 组9 未使用 12组
    //组10 成就	30组							
    //组11 光环	30组
    //组12 翅膀	30组
    //组13 神器	30组
    //组14 称号	30组
    //组15 彩蛋 30组

    function DzDataBaseSetting()
        DzOriginServerNum = 49 //地图已申请的存档组
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
        DzDataGroupLength(7) = 5
        DzDataGroupLength(8) = 5
        DzDataGroupLength(9) = 5
        DzDataGroupLength(10) = 2
        DzDataGroupLength(11) = 2
        DzDataGroupLength(12) = 2
        DzDataGroupLength(13) = 2
        DzDataGroupLength(14) = 2
        DzDataGroupLength(15) = 2
        /*DzDataGroupLength(16) = 0
        DzDataGroupLength(17) = 0
        DzDataGroupLength(18) = 0
        DzDataGroupLength(19) = 0
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
            elseif  flag >= 3 //未使用
                max = 0
            endif
        elseif  Group == 3
            if  flag == 1 //总通关次数
                max = DzPlayerGames(Player(pid))
            elseif  flag >= 2 and flag <= 6 //通关难度
                max = DzPlayerInitTGCos
            elseif  flag >= 7 //未开启的难度
                max = 0
            endif
        elseif  Group == 4
            if  flag == 1 //通行证经验
                max = MissionDay*12
            elseif  flag >= 2 //未使用
                max = 0
            endif
        elseif  Group == 5 //不用管

        elseif  Group == 6 //不用管
            if  flag == 1 //经脉最大上限
                max = MeridiansDay*DzMeridiansDayNum
            elseif  flag >= 2 and flag <= 9 //经脉等级
                max = MeridiansMaxLv
            elseif  flag >= 10
                max = 0
            endif
        elseif  Group == 7
            max = 0
        elseif  Group == 8
            max = 0
        elseif  Group == 9
            max = 0
        elseif  Group >= 10 and Group <= 15 //不用管

        elseif  Group > 15 //未使用
            max = 0
        endif
        data = GetDataMaximumValue(data,max)
        return data
    endfunction


endlibrary
