library DzSave initializer InitDzData uses DzDataSetting

    function InitFlushDzDataGroupLength()
        for Group = 0,DzOriginServerNum
            DzDataGroupLength(Group)= 0
        end
    endfunction
    
    function AmountDzDataGroupLength()
        for Group = 1,DzOriginServerNum
            if  DzDataGroupLength(Group) != 0
                DzServerNum = DzServerNum + 1
            endif
        end
    endfunction
    
    function GetDzDataGroupMaxMember(int Group)->int
        if  DzDataGroupLength(Group) != 0
            return 60/DzDataGroupLength(Group)
        else
            return 0
        endif
    endfunction
    
    // ! noejass
    //function interface DzPlayerDataInterface takes integer Group,integer flag returns integer
    // ! endnoejass
    
    function DisassembleDzPlayerDataOfGroup(int pid,int Group)
        int MaxMember = 0
        MaxMember = GetDzDataGroupMaxMember(Group)
        BJDebugMsg("MaxMember"+I2S(MaxMember))
        for flag = 1,MaxMember
            if  pid == 0
                DzArrayPlayerInt0[Group][flag] = S2I(SubString(DzS[Group],DzDataGroupLength(Group)*(flag-1),DzDataGroupLength(Group)*flag))
                DzArrayPlayerInt0[Group][flag] = GetDzDataMaxValue(pid,Group,flag,DzArrayPlayerInt0[Group][flag])
                //BJDebugMsg("玩家0："+I2S(Group)+" @@ "+I2S(flag)+" @@ "+I2S(DzArrayPlayerInt0[Group][flag]))
            elseif  pid == 1
                DzArrayPlayerInt1[Group][flag] = S2I(SubString(DzS[Group],DzDataGroupLength(Group)*(flag-1),DzDataGroupLength(Group)*flag))
                DzArrayPlayerInt1[Group][flag] = GetDzDataMaxValue(pid,Group,flag,DzArrayPlayerInt1[Group][flag])
                //BJDebugMsg("玩家1："+I2S(Group)+" @@ "+I2S(flag)+" @@ "+I2S(DzArrayPlayerInt1[Group][flag]))
            elseif  pid == 2
                DzArrayPlayerInt2[Group][flag] = S2I(SubString(DzS[Group],DzDataGroupLength(Group)*(flag-1),DzDataGroupLength(Group)*flag))
                DzArrayPlayerInt2[Group][flag] = GetDzDataMaxValue(pid,Group,flag,DzArrayPlayerInt2[Group][flag])
                //BJDebugMsg("玩家2："+I2S(Group)+" @@ "+I2S(flag)+" @@ "+I2S(DzArrayPlayerInt2[Group][flag]))
            elseif  pid == 3
                DzArrayPlayerInt3[Group][flag] = S2I(SubString(DzS[Group],DzDataGroupLength(Group)*(flag-1),DzDataGroupLength(Group)*flag))
                DzArrayPlayerInt3[Group][flag] = GetDzDataMaxValue(pid,Group,flag,DzArrayPlayerInt3[Group][flag])
                //BJDebugMsg("玩家3："+I2S(Group)+" @@ "+I2S(flag)+" @@ "+I2S(DzArrayPlayerInt3[Group][flag]))
            elseif  pid == 4
                DzArrayPlayerInt4[Group][flag] = S2I(SubString(DzS[Group],DzDataGroupLength(Group)*(flag-1),DzDataGroupLength(Group)*flag))
                DzArrayPlayerInt4[Group][flag] = GetDzDataMaxValue(pid,Group,flag,DzArrayPlayerInt4[Group][flag])
                //BJDebugMsg("玩家4："+I2S(Group)+" @@ "+I2S(flag)+" @@ "+I2S(DzArrayPlayerInt4[Group][flag]))
            elseif  pid == 5
                DzArrayPlayerInt5[Group][flag] = S2I(SubString(DzS[Group],DzDataGroupLength(Group)*(flag-1),DzDataGroupLength(Group)*flag))
                DzArrayPlayerInt5[Group][flag] = GetDzDataMaxValue(pid,Group,flag,DzArrayPlayerInt5[Group][flag])
                //BJDebugMsg("玩家5："+I2S(Group)+" @@ "+I2S(flag)+" @@ "+I2S(DzArrayPlayerInt5[Group][flag]))
            endif
        end
    endfunction
    
    function DisassembleDzPlayerData(int pid) //分解存档数据
        for Group = 1,DzServerNum
            DisassembleDzPlayerDataOfGroup.execute(pid,Group)
        end
    endfunction
    
    function LoadingDzMapData(int pid) //获取地图存档数据
        if  DzConA[0] == 1
            for Group = 0,DzServerNum
                DzS[Group] = DzAPI_Map_GetStoredString(Player(pid), ("DZ"+I2S(Group)))
            end
        else
            for Group = 0,DzServerNum
                DzS[Group] = "000000000000000000000000000000000000000000000000000000000000"
            end
        endif
    endfunction
    
    function LoadingDzPlayerData(int pid) //获取玩家存档数据
        DisassembleDzPlayerData(pid)
    endfunction
    
    function SaveDzPlayerDataOfGroup(int pid,int Group)
        int MaxMember = 0
        MaxMember = GetDzDataGroupMaxMember(Group)
        BJDebugMsg("MaxMember"+I2S(MaxMember))
        DzS[Group] = ""
        if  pid == 0
            for flag = 1,MaxMember
                DzS[Group] = DzS[Group]+GetStrZero(DzArrayPlayerInt0[Group][flag],DzDataGroupLength(Group))
            end
        elseif  pid == 1
            for flag = 1,MaxMember
                DzS[Group] = DzS[Group]+GetStrZero(DzArrayPlayerInt1[Group][flag],DzDataGroupLength(Group))
            end
        elseif  pid == 2
            for flag = 1,MaxMember
                DzS[Group] = DzS[Group]+GetStrZero(DzArrayPlayerInt2[Group][flag],DzDataGroupLength(Group))
            end
        elseif  pid == 3
            for flag = 1,MaxMember
                DzS[Group] = DzS[Group]+GetStrZero(DzArrayPlayerInt3[Group][flag],DzDataGroupLength(Group))
            end
        elseif  pid == 4
            for flag = 1,MaxMember
                DzS[Group] = DzS[Group]+GetStrZero(DzArrayPlayerInt4[Group][flag],DzDataGroupLength(Group))
            end
        elseif  pid == 5
            for flag = 1,MaxMember
                DzS[Group] = DzS[Group]+GetStrZero(DzArrayPlayerInt5[Group][flag],DzDataGroupLength(Group))
            end
        endif
        if  DzConA[0] == 1 and IsPlaying(pid) == true
            DzAPI_Map_StoreString( Player(pid),"DZ"+I2S(Group), DzS[Group] )
        endif
    endfunction
    
    function LoadingDzPlayerDataFlush(int pid) //再存取档数据
        for Group = 1,DzServerNum
            SaveDzPlayerDataOfGroup.execute(pid,Group)
        end
    endfunction
    
    function SaveDzPlayerData(int pid,int Group,int flag,int num) //存储玩家数据
        int data = 0
        if  DzDataGroupLength(Group) != 0
            if  flag <= GetDzDataGroupMaxMember(Group)
                data = GetDzDataMaxValue(pid,Group,flag,num)
                if  pid == 0
                    DzArrayPlayerInt0[Group][flag] = data
                elseif  pid == 1
                    DzArrayPlayerInt1[Group][flag] = data
                elseif  pid == 2
                    DzArrayPlayerInt2[Group][flag] = data
                elseif  pid == 3
                    DzArrayPlayerInt3[Group][flag] = data
                elseif  pid == 4
                    DzArrayPlayerInt4[Group][flag] = data
                elseif  pid == 5
                    DzArrayPlayerInt5[Group][flag] = data
                endif
                SaveDzPlayerDataOfGroup.execute(pid,Group)
            else
                BJDebugMsg("超过第"+I2S(Group)+"存档位")
            endif
        else
            BJDebugMsg("第"+I2S(Group)+"存档未使用")
        endif
    endfunction
    
    function GetDzPlayerData(int pid,int Group,int flag)->int //获取存储数据：玩家，组，位
        if  pid == 0
            return DzArrayPlayerInt0[Group][flag]
        elseif  pid == 1
            return DzArrayPlayerInt1[Group][flag]
        elseif  pid == 2
            return DzArrayPlayerInt2[Group][flag]
        elseif  pid == 3
            return DzArrayPlayerInt3[Group][flag]
        elseif  pid == 4
            return DzArrayPlayerInt4[Group][flag]
        elseif  pid == 5
            return DzArrayPlayerInt5[Group][flag]
        endif
        return 0
    endfunction
    
    function AddDzPlayerData(int pid,int Group,int flag,int num) //增加存储数据：玩家，组，位 数
        int data = GetDzPlayerData(pid,Group,flag)+num
        SaveDzPlayerData(pid,Group,flag,data)
    endfunction
    
    function ReduceDzPlayerData(int pid,int Group,int flag,int num) //减少存储数据：玩家，组，位 数
        int data = GetDzPlayerData(pid,Group,flag)+num
        SaveDzPlayerData(pid,Group,flag,data)
    endfunction
    
    function SetDzPlayerData(int pid,int Group,int flag,int num) //设置存储数据：玩家，组，位 数
        int data = num
        SaveDzPlayerData(pid,Group,flag,data)
    endfunction


    //兼容函数开始
    function SaveData(int pid,int Group,int flag,int num) //存储玩家数据
        int data = 0
        if  DzDataGroupLength(Group) != 0
            if  flag <= GetDzDataGroupMaxMember(Group)
                data = GetDzDataMaxValue(pid,Group,flag,num)
                if  pid == 0
                    DzArrayPlayerInt0[Group][flag] = data
                elseif  pid == 1
                    DzArrayPlayerInt1[Group][flag] = data
                elseif  pid == 2
                    DzArrayPlayerInt2[Group][flag] = data
                elseif  pid == 3
                    DzArrayPlayerInt3[Group][flag] = data
                elseif  pid == 4
                    DzArrayPlayerInt4[Group][flag] = data
                elseif  pid == 5
                    DzArrayPlayerInt5[Group][flag] = data
                endif
                SaveDzPlayerDataOfGroup.execute(pid,Group)
            else
                BJDebugMsg("超过第"+I2S(Group)+"存档位")
            endif
        else
            BJDebugMsg("第"+I2S(Group)+"存档未使用")
        endif
    endfunction
    function GetData(int pid,int Group,int flag)->int //获取存储数据：玩家，组，位
        if  pid == 0
            return DzArrayPlayerInt0[Group][flag]
        elseif  pid == 1
            return DzArrayPlayerInt1[Group][flag]
        elseif  pid == 2
            return DzArrayPlayerInt2[Group][flag]
        elseif  pid == 3
            return DzArrayPlayerInt3[Group][flag]
        elseif  pid == 4
            return DzArrayPlayerInt4[Group][flag]
        elseif  pid == 5
            return DzArrayPlayerInt5[Group][flag]
        endif
        return 0
    endfunction
    
    function AddData(int pid,int Group,int flag,int num) //增加存储数据：玩家，组，位 数
        int data = GetDzPlayerData(pid,Group,flag)+num
        SaveDzPlayerData(pid,Group,flag,data)
    endfunction
    function SetData(int pid,int Group,int flag,int num) //设置存储数据：玩家，组，位 数
        int data = num
        SaveDzPlayerData(pid,Group,flag,data)
    endfunction

    //兼容函数结束
    
    function SaveDzRoom(int pid) //房间显示
        string s1 = ""
        string s2 = ""
        string s3 = ""
        if  IsPlaying(pid) == true
            if  GetPlayerServerValueSuccess(Player(pid)) == true
                DzAPI_Map_Stat_SetStat( Player(pid), "S1", s1)
            endif
            if  GetPlayerServerValueSuccess(Player(pid)) == true
                DzAPI_Map_Stat_SetStat( Player(pid), "S2", s2)
            endif
            if  GetPlayerServerValueSuccess(Player(pid)) == true
                DzAPI_Map_Stat_SetStat( Player(pid), "S3", s3)
            endif
        endif
    endfunction

    function DzFlushOfGroup(int pid,int Group)
        int MaxMember = GetDzDataGroupMaxMember(Group)
        for flag = 1,MaxMember
            if  pid == 0
                DzArrayPlayerInt0[Group][flag] = 0
            elseif  pid == 1
                DzArrayPlayerInt1[Group][flag] = 0
            elseif  pid == 2
                DzArrayPlayerInt2[Group][flag] = 0
            elseif  pid == 3
                DzArrayPlayerInt3[Group][flag] = 0
            elseif  pid == 4
                DzArrayPlayerInt4[Group][flag] = 0
            elseif  pid == 5
                DzArrayPlayerInt5[Group][flag] = 0
            endif
        end
        DzS[Group] = "000000000000000000000000000000000000000000000000000000000000"
        DzAPI_Map_FlushStoredMission(Player(pid),"SDZ"+I2S(Group))
    endfunction
    
    function DzFlush(int pid) //清档
        for Group = 0,DzServerNum
            DzFlushOfGroup(pid,Group)
        end
        SaveDzRoom(pid)
    endfunction

    function SaveDzServerTime(int pid) //存储版本号
        DzS[0] = I2S(ServerTime)
        if  DzConA[0] == 1
            DzAPI_Map_StoreString( Player(pid),"DZ0", DzS[0] )
        endif
    endfunction
    
    insert DzGameFunc

    function IsDzDataNewPlayer(int pid)->bool
        if  (DzS[0] == "" or DzS[0] == null) and StringLength(DzS[1]) != 60
            return true
        else
            return false
        endif
    endfunction

    function DzDataNewPlayer(int pid) //新玩家
        if  IsDzDataNewPlayer(pid) == true
            for Group = 1,DzServerNum
                DzS[Group] = "000000000000000000000000000000000000000000000000000000000000"
            end
        endif
    endfunction
    
    function InitDzSetting()
        BJDebugMsg("InitDzSetting")
        DzDataBaseSetting()
        InitFlushDzDataGroupLength()
        DzDataGroupSetting()
        AmountDzDataGroupLength() //计算已使用的存档组
    endfunction
    
    function InitDzDataFunc()
        int time = 0
        BJDebugMsg("InitDzDataFunc")
        TimerStart(0.1,true)
        {
            time = time + 1
            if  time == 1
                for pid = 0,5
                    if  IsPlaying(pid) == true
                        LoadingDzMapData(pid) //载入积分
                    endif
                end
            elseif  time == 2
                for pid = 0,5
                    if  IsPlaying(pid) == true
                        if  IsDzDataNewPlayer(pid) == true
                            IsDzNewPlayer[pid] = true
                        endif
                        DzDataNewPlayer(pid) //新玩家
                    endif
                end
            elseif  time == 3
                for pid = 0,5
                    if  IsPlaying(pid) == true
                        //DzSavePublic(pid,1) //全局存档 
                    endif
                end
            elseif  time == 4
                for pid = 0,5
                    if  IsPlaying(pid) == true
                        LoadingDzPlayerData(pid) //加载游戏数据
                    endif
                end
            elseif  time == 5
                for pid = 0,5
                    if  IsPlaying(pid) == true
                        LoadingDzPlayerDataFlush(pid) //刷新游戏数据
                        if  IsDzNewPlayer[pid] == true
                            DzSaveDzTime(pid)
                        endif
                    endif
                end
            elseif  time == 6
                for pid = 0,5
                    if  IsPlaying(pid) == true
                        SaveDzServerTime(pid) //更新版本
                    endif
                end
            elseif  time == 7
                for pid = 0,5
                    if  IsPlaying(pid) == true
                        //加载科技
                    endif
                end
            elseif  time == 8
                BJDebugMsg("初始化存档加载完毕 结束计时器！！！")
                ExecuteFunc("OpenSelectMode")
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    
    function InitDzData()
        //DzFlush(0) //测试
        InitDzSetting()
        InitDzConfig()
        if  DzConA[0] == 1
            ExecuteFunc("InitDzDataFunc")
        endif
    endfunction
    
endlibrary
