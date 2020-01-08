library DzDataSetting uses DzBase

    ///////////////////////////////////////////////////////////
    
    //请在这里记录注释存档数据
    // 组0 用于存储玩家上一次游戏时间戳
    // 组1 1位 
    // 组2
    // 组3
    // 组4 记录通行证经验
    // 组5 记录通行证任务
    // 组6

    function DzDataBaseSetting()
        DzOriginServerNum = 49 //地图已申请的存档组
    endfunction
    
    function DzDataGroupSetting()
        //初始化已使用的存档组存储方式
        //DzDataGroupLength(0) 用于版本号存储
        DzDataGroupLength(1) = 2
        DzDataGroupLength(2) = 3
        DzDataGroupLength(3) = 4
        DzDataGroupLength(4) = 5
        DzDataGroupLength(5) = 6
        DzDataGroupLength(6) = 4
        /*DzDataGroupLength(7) = 0
        DzDataGroupLength(8) = 0
        DzDataGroupLength(9) = 0
        DzDataGroupLength(10) = 0
        DzDataGroupLength(11) = 0
        DzDataGroupLength(12) = 0
        DzDataGroupLength(13) = 0
        DzDataGroupLength(14) = 0
        DzDataGroupLength(15) = 0
        DzDataGroupLength(16) = 0
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
            if  flag == 1
                max = 10
            elseif  flag >= 11
                max = 40
            endif
        elseif Group == 4
            max = 9999
        endif
        data = GetDataMaximumValue(data,max)
        return data
    endfunction


endlibrary
