piece DzGameFunc

    function ShowPlayerDzJF(int pid) //显示积分
        if  DzConA[0] == 1 
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00通关积分：|r"+I2S(GetDzPlayerData(pid,2,1)))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00守家积分：|r"+I2S(GetDzPlayerData(pid,2,2)))

            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cff00ff00输入“TG”查看通关次数|r")
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r未开启存档！")
        endif
    endfunction

    function ShowPlayerDzTGJF(int pid)//显示通关
        if  DzConA[0] == 1 
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00游戏局数：|r"+I2S(DzPlayerGames(Player(pid)))+"局")
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00总通关次数：|r"+I2S(GetDzPlayerData(pid,3,1))+"次")
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00通关难1：|r"+I2S(GetDzPlayerData(pid,3,2))+"/"+I2S(DzPlayerInitTGCos))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00通关难2：|r"+I2S(GetDzPlayerData(pid,3,3))+"/"+I2S(DzPlayerInitTGCos))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00通关难3：|r"+I2S(GetDzPlayerData(pid,3,4))+"/"+I2S(DzPlayerInitTGCos))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00通关难4：|r"+I2S(GetDzPlayerData(pid,3,5))+"/"+I2S(DzPlayerInitTGCos))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00通关难5：|r"+I2S(GetDzPlayerData(pid,3,6))+"/"+I2S(DzPlayerInitTGCos))

            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cff00ff00输入“JF”查看游戏积分|r")
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r未开启存档！")
        endif
    endfunction

    function DzPalyerSignInRefresh(int pid,int week,int mission)
        int Group = 5
        int MaxMember = 0
        BJDebugMsg("week:"+I2S(week)+" @@ TimeWeek:"+I2S(TimeWeek))
        if  week != TimeWeek
            SetDzPlayerData(pid,1,5,0) //今日签到
            SetDzPlayerData(pid,1,10,0) //经脉

            BJDebugMsg("刷新！！！！！！！！！！")
        endif
        if  mission != DzMissionWeek
            BJDebugMsg("通行证刷新")
            DzS[Group] = "000000000000000000000000000000000000000000000000000000000000"
            MaxMember = GetDzDataGroupMaxMember(Group)
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
            if  DzConA[0] == 1
                DzAPI_Map_StoreString(Player(pid),"DZ"+I2S(Group),DzS[Group])
            endif
        endif
    endfunction
    
    function DzSaveDzTime(int pid) //更新时间
        SetDzPlayerData(pid,1,1,TimeMon)
        SetDzPlayerData(pid,1,2,TimeDay)
        SetDzPlayerData(pid,1,3,TimeWeek)
        SetDzPlayerData(pid,1,8,DzMissionWeek)
    endfunction
    
    function ShowPlayerSignInLastTime(int pid)
        int mon = GetDzPlayerData(pid,1,1) //月
        int day = GetDzPlayerData(pid,1,2) //日
        int week = GetDzPlayerData(pid,1,3) //星期
        int mission = GetDzPlayerData(pid,1,8) //通行证
        BJDebugMsg("ShowPlayerSignInLastTime111")
        if  DzConA[0] == 1
            DzPalyerSignInRefresh(pid,week,mission)
            DzSaveDzTime(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[上次登录游戏日期]：|r"+I2S(mon)+"月"+I2S(day)+"日|cffffcc00[|r星期"+DayStr[week]+"|cffffcc00]|r")
            BJDebugMsg("ShowPlayerSignInLastTime222")
        endif
    endfunction

    function IsDzPalyerSignInCon(int pid)->bool
        int mon = GetDzPlayerData(pid,1,1) //月
        int day = GetDzPlayerData(pid,1,4) //日
        int TimeMonEnd = NormalMon[mon]
        //BJDebugMsg(I2S(mon)+" @@ "+I2S(day)+" @@ "+I2S(TimeMonEnd))
        if  day == 0
            return false
        else
            if  TimeDay == 1
                if  day == TimeMonEnd
                    return true
                else
                    return false
                endif
            else
                if  TimeDay-day == 1
                    return true
                else
                    return false
                endif
            endif
        endif
    endfunction
    
    function DzPalyerSignInEx(int pid) //签到
        int sign = GetDzPlayerData(pid,1,5) //今日
        int Lsign = GetDzPlayerData(pid,1,6) //连续
        int Asign = GetDzPlayerData(pid,1,7) //累积
        if  sign == 0
            SetDzPlayerData(pid,1,5,1)
            AddDzPlayerData(pid,1,7,1)
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:签到成功！")
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[累积签到]|r:"+I2S(Asign+1)+"天！")
            if  Lsign > 0
                if  IsDzPalyerSignInCon(pid) == true
                    AddDzPlayerData(pid,1,6,1)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[连续签到]|r:"+I2S(Lsign+1)+"天！")
                else
                    SetDzPlayerData(pid,1,6,1)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[连续签到]|r:1天！")
                endif
            else
                SetDzPlayerData(pid,1,6,1)
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[连续签到]|r:1天！")
            endif
            SetDzPlayerData(pid,1,4,TimeDay)
            DzSaveDzTime(pid)
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:今日已签到！")
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[累积签到]|r:"+I2S(Asign)+"天！")
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[连续签到]|r:"+I2S(Lsign)+"天！")
        endif
    endfunction

    function DzPalyerSignIn(int id)
        int pid = id
        TimerStart(0,false)
        {
            DzPalyerSignInEx(pid)
            endtimer
            flush locals
        }
        flush locals
    endfunction

endpiece

