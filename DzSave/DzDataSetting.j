library DzDataSetting uses SystemCodes

    #define DzEdition                 DzArrayBaseInt[0]
    #define DzOriginServerNum         DzArrayBaseInt[1]
    #define DzServerNum               DzArrayBaseInt[2]
    #define DzDataGroupLength(num)    DzArrayBaseInt[10+num]

    function GetDzDataGroupMaxValue(int Group)->int
        if  DzDataGroupLength(Group) == 2
            return 99
        elseif  DzDataGroupLength(Group) == 3
            return 999
        elseif  DzDataGroupLength(Group) == 4
            return 9999
        elseif  DzDataGroupLength(Group) == 5
            return 99999
        elseif  DzDataGroupLength(Group) == 6
            return 999999
        else
            return 0
        endif
    endfunction
    
    function GetDataMaximumValue(int data,int max)->int
        if  data > 0
            if  data > max 
                data = max
            endif
        else
            data = 0
        endif
        return data
    endfunction

    ///////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////
    
    //请在这里记录注释存档数据
    // 组0 用于记录版本
    // 组1 长度2 共30位 1
    // 组2
    // 组3
    // 组4 记录通行证经验
    // 组5 记录通行证任务
    // 组6

    function DzDataBaseSetting()
        DzEdition = 1000 //地图版本号
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
        elseif 
            max = 9999
        endif
        data = GetDataMaximumValue(data,max)
        return data
    endfunction


endlibrary
