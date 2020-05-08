piece DzGameFunc

    function ShowPlayerDzJF(int pid) //显示积分
        if  DzConA[0] == 1 
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00地图等级：|r"+I2S(DzPlayerLv(Player(pid))-DzPlayerLvAdd(Player(pid)))+"+|cff00ff00"+I2S(DzPlayerLvAdd(Player(pid))))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00通关积分：|r"+I2S(GetDzPlayerData(pid,2,1)))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00异变积分：|r"+I2S(GetDzPlayerData(pid,2,4)))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00龙宫积分：|r"+I2S(GetDzPlayerData(pid,2,6)))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00战勋点：|r"+I2S(GetDzPlayerData(pid,16,1))+"  |cffffcc00当局获得：|r"+I2S(DzHeroMedalGameExp)+"/"+I2S(GameLevel*32)+"  |cffffcc00今日获得：|r"+I2S(GetDzPlayerData(pid,16,2))+"/"+I2S(896))//MaxHeroBaseMedal*MaxGameLevel))  
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00万魔窟：|r"+I2S(GetDzPlayerData(pid,2,3))+"层")

            if  DzConA[24] == 1
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00狂欢积分：|r"+I2S(GetDzPlayerData(pid,18,1)) +"  |cffffcc00今日获得：|r"+I2S(GetDzPlayerData(pid,18,3))+"/2000")
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00祖传矿铲：|r"+I2S(GetDzPlayerData(pid,18,2)) +"  |cffffcc00今日获得：|r"+I2S(GetDzPlayerData(pid,18,4))+"/4")
            endif

            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cff00ff00输入“TG”查看通关次数|r")
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r未开启存档！")
        endif
    endfunction

    function ShowPlayerDzTGJF(int pid)//显示通关
        if  DzConA[0] == 1 
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00游戏局数：|r"+I2S(DzPlayerGames(Player(pid)))+"局  |cffffcc00总通关次数：|r"+I2S(GetDzPlayerData(pid,3,1))+"次")

            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00经典模式：|r")

            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00难1  |r"+I2S(GetDzPlayerData(pid,3,2))+"/"+I2S(DzPlayerInitTGCos[1])+"  |cffffcc00难2  |r"+I2S(GetDzPlayerData(pid,3,3))+"/"+I2S(DzPlayerInitTGCos[2])+"  |cffffcc00难3  |r"+I2S(GetDzPlayerData(pid,3,4))+"/"+I2S(DzPlayerInitTGCos[3]))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00难4  |r"+I2S(GetDzPlayerData(pid,3,5))+"/"+I2S(DzPlayerInitTGCos[4])+"  |cffffcc00难5  |r"+I2S(GetDzPlayerData(pid,3,6))+"/"+I2S(DzPlayerInitTGCos[5])+"  |cffffcc00难6  |r"+I2S(GetDzPlayerData(pid,3,7))+"/"+I2S(DzPlayerInitTGCos[6]))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00难7  |r"+I2S(GetDzPlayerData(pid,3,8))+"/"+I2S(DzPlayerInitTGCos[7])+"  |cffffcc00难8  |r"+I2S(GetDzPlayerData(pid,3,9))+"/"+I2S(DzPlayerInitTGCos[8])+"  |cffffcc00难9  |r"+I2S(GetDzPlayerData(pid,3,10))+"/"+I2S(DzPlayerInitTGCos[9]))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00难10：|r"+I2S(GetDzPlayerData(pid,3,11))+"/"+I2S(DzPlayerInitTGCos[10]))
            
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00异变模式：|r")
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00难1  |r"+I2S(GetDzPlayerData(pid,20,2))+"/"+I2S(DzPlayerInitVariationTGCos[1])+"  |cffffcc00难2  |r"+I2S(GetDzPlayerData(pid,20,3))+"/"+I2S(DzPlayerInitVariationTGCos[2])+"  |cffffcc00难3  |r"+I2S(GetDzPlayerData(pid,20,4))+"/"+I2S(DzPlayerInitVariationTGCos[3]))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00难4  |r"+I2S(GetDzPlayerData(pid,20,5))+"/"+I2S(DzPlayerInitVariationTGCos[4])+"  |cffffcc00难5  |r"+I2S(GetDzPlayerData(pid,20,6))+"/"+I2S(DzPlayerInitVariationTGCos[5])+"  |cffffcc00难6  |r"+I2S(GetDzPlayerData(pid,20,7))+"/"+I2S(DzPlayerInitVariationTGCos[6]))
            //DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00难7  |r"+I2S(GetDzPlayerData(pid,20,8))+"/"+I2S(DzPlayerInitVariationTGCos[7])+"  |cffffcc00难8  |r"+I2S(GetDzPlayerData(pid,20,9))+"/"+I2S(DzPlayerInitVariationTGCos[8])+"  |cffffcc00难9  |r"+I2S(GetDzPlayerData(pid,20,10))+"/"+I2S(DzPlayerInitVariationTGCos[9]))
            //DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00难10：|r"+I2S(GetDzPlayerData(pid,20,11))+"/"+I2S(DzPlayerInitVariationTGCos[10]))

            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cff00ff00输入“JF”查看游戏积分|r")
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r未开启存档！")
        endif
    endfunction

    function DzPalyerSignInRefresh(int pid,int week,int mission)
        BJDebugMsg("week:"+I2S(week)+" @@ TimeWeek:"+I2S(TimeWeek))
        if  week != TimeWeek

            SetDzPlayerData(pid,1,10,0) //经脉
            SetDzPlayerData(pid,1,11,0) //龙王
            SetDzPlayerData(pid,1,12,0) //龟丞相
            
            SetDzPlayerData(pid,16,2,0) //当天战勋点
            SetDzPlayerData(pid,18,3,0) //活动刷新
            SetDzPlayerData(pid,18,4,0) //活动刷新
            BJDebugMsg("刷新！！！！！！！！！！")
        endif
        if  mission != DzMissionWeek
            BJDebugMsg("通行证刷新")
            SetDzPlayerData(pid,1,5,0) //今日签到
            SetDzPlayerData(pid,2,5,0) //每日钻石清空
            DzFlushOfGroupZero(pid,5)
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


    //使用钻石
    function GetPlayerFood(int pid)->int
        return PlayerFoodFree + PlayerFoodStart
    endfunction
    function RePlayerFoodShow(int pid)
        int food = PlayerFoodFree + PlayerFoodStart
        SetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_FOOD_USED,food)
    endfunction
    function UsePlayerFood(int id,int u)
        int pid = id
        int use = u
        if  PlayerFoodStart > 0
            if  PlayerFoodStart >= use
                //BJDebugMsg("使用当局钻石"+I2S(use)+"个")
                PlayerFoodStart = PlayerFoodStart - use
                use = 0
            else
                //BJDebugMsg("使用当局钻石"+I2S(PlayerFoodStart)+"个")
                use = use - PlayerFoodStart
                PlayerFoodStart = 0
            endif
        endif
        
        if  PlayerFoodFree > 0 and use > 0
            if  PlayerFoodFree >= use
                PlayerFoodFree = PlayerFoodFree - use
                use = 0
            else
                use = use - PlayerFoodFree
                PlayerFoodFree = 0
            endif
            if  DzBool == false
                SetDzPlayerData(pid,2,5,PlayerFoodFree)
            else
                BJDebugMsg("设置签到钻石为"+I2S(PlayerFoodFree))
            endif
        endif
        
        
        RePlayerFoodShow(pid)
    endfunction
    
    function AddPlayerFoodByIndex(int pid,int index,int num)
        PlayerInt[pid][50+index] = PlayerInt[pid][50+index] + num
        RePlayerFoodShow(pid)
    endfunction


    
    function DzPalyerSignInEx(int pid) //签到
        int sign = GetDzPlayerData(pid,1,5) //今日
        int Lsign = GetDzPlayerData(pid,1,6) //连续
        int Asign = GetDzPlayerData(pid,1,7) //累积
        int give = 0
        if  sign == 0
            
            
            SetDzPlayerData(pid,1,5,1)
            AddDzPlayerData(pid,1,7,1)
            
            if  Lsign > 0
                if  IsDzPalyerSignInCon(pid) == true
                    AddDzPlayerData(pid,1,6,1)
                    Lsign = Lsign + 1
                else
                    SetDzPlayerData(pid,1,6,1)
                    Lsign = 1
                endif
            else
                SetDzPlayerData(pid,1,6,1)//第一天
                Lsign = 1
            endif
            give = 6+Lsign
            if  give > 14
                give = 14
            endif
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:签到成功！奖励签到钻石x|cff00ff00"+I2S(give)+"|r，签到钻石仅当天有效！")
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[累积签到]|r:"+I2S(Asign+1)+"天！")
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[连续签到]|r:"+I2S(Lsign)+"天！")
            SetDzPlayerData(pid,2,5,give)
            AddPlayerFoodByIndex(pid,1,give)
            
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

    //英雄熟练度
    function FlushDzHeroExp(int pid,int uid) //清空
        int id = GetDataBinaryConversion(uid,'H000')
        //BJDebugMsg("清空的 英雄为："+YDWEId2S(uid)+"，英雄熟练度引索："+I2S(id))
        int zu = 7
        int wei = id
        if  id > 30
            zu = 8
            wei = wei - 30
        endif
        SetDzPlayerData(pid,zu,wei,0)
        SetDzPlayerData(pid,9,id,0)
    endfunction

    function GetDzHeroExp(int pid,int uid)->int //获取英雄经验
        int id = GetDataBinaryConversion(uid,'H000')
        //BJDebugMsg("GetDzHeroExp 英雄为："+YDWEId2S(uid)+"，英雄熟练度引索："+I2S(id))
        int zu = 7
        int wei = id
        if  id > 30
            zu = 8
            wei = wei - 30
        endif
        if  id > 0
            return GetDzPlayerData(pid,zu,wei)
        else
            return 0
        endif
    endfunction

    function GetDzHeroExpLevel(int pid,int uid)->int
        int id = GetDataBinaryConversion(uid,'H000')
        //BJDebugMsg("GetDzHeroExpLevel 英雄为："+YDWEId2S(uid)+"，英雄熟练度引索："+I2S(id))
        if  id > 0
            return GetDzPlayerData(pid,9,id)
        else
            return 0
        endif
    endfunction

    function GetDzHeroExpLevelCount(int pid,int level)->int
        int cos = 0
        for k = 0,5
            for num = 0,9
                if  GetDzHeroExpLevel(pid,'H000' + num + k * 256) == level
                    cos = cos + 1
                endif
            end
        end
        return cos
    endfunction

    function GetDzHeroNeedExp(int level)->int
        if  level == 1
            return MaxHeroNeedExp0
        elseif  level == 2
            return MaxHeroNeedExp0 + MaxHeroNeedExp1 
        elseif  level == 3
            return MaxHeroNeedExp0 + MaxHeroNeedExp1 + MaxHeroNeedExp2
        elseif  level == 4
            return MaxHeroNeedExp0 + MaxHeroNeedExp1 + MaxHeroNeedExp2 + MaxHeroNeedExp3
        elseif  level == 5
            return MaxHeroNeedExp0 + MaxHeroNeedExp1 + MaxHeroNeedExp2 + MaxHeroNeedExp3 + MaxHeroNeedExp4
        else
            return 0
        endif
    endfunction

    function InitDzHeroExpDataEx(int pid)
        for level = 1,MaxHeroExpLevel
            DzHeroExpLevelCount[level] = GetDzHeroExpLevelCount(pid,level)
            DzHeroExpLevelCount[0] = DzHeroExpLevelCount[0] + DzHeroExpLevelCount[level]*level
        end
        BJDebugMsg("当前英雄熟练度总等级"+I2S(DzHeroExpLevelCount[0]))
        for level = 1,MaxHeroExpLevel
            BJDebugMsg("其中英雄熟练度"+I2S(level)+"级总数量为"+I2S(DzHeroExpLevelCount[level]))
        end
    endfunction
    //初始化熟练度
    function InitDzHeroExpData(int pid)
        int game = DzPlayerGames(Player(pid))+1//局数
        int maxexp = (1+MaxGameLevel)*game //最大经验
        int allexp = 0
        int levelexp = 0
        int nowexp = 0
        BJDebugMsg("玩家Pid"+I2S(pid)+" 当前局数为："+I2S(game)+" 最大经验为"+I2S(maxexp))
        for k = 0,5
            for num = 0,9
                levelexp = GetDzHeroNeedExp(GetDzHeroExpLevel(pid,'H000' + num + k * 256))
                nowexp = GetDzHeroExp(pid,'H000' + num + k * 256)
                allexp = levelexp + nowexp
                if  maxexp > 0
                    maxexp = maxexp - allexp
                    if  maxexp < 0
                        if  k >= 3
                            SetDzPlayerDataOnlyValue(pid,8,num + (k-3) * 10,0)
                        else
                            SetDzPlayerDataOnlyValue(pid,7,num + k * 10,0)
                        endif
                        SetDzPlayerDataOnlyValue(pid,9,num + k * 10,0)
                    endif
                else    
                    if  k >= 3
                        SetDzPlayerDataOnlyValue(pid,8,num + (k-3) * 10,0)
                    else
                        SetDzPlayerDataOnlyValue(pid,7,num + k * 10,0)
                    endif
                    SetDzPlayerDataOnlyValue(pid,9,num + k * 10,0)
                endif
            end
        end
        SaveDzPlayerDataOfGroup.execute(pid,7)
        SaveDzPlayerDataOfGroup.execute(pid,8)
        SaveDzPlayerDataOfGroup.execute(pid,9)
        InitDzHeroExpDataEx(pid)
    endfunction

    //单英雄增加熟练度
    function AddDzHeroExp(unit u,int num)
        int pid = GetPlayerId(GetOwningPlayer(u))
        int id = GetDataBinaryConversion(GetUnitTypeId(u),'H000')
        BJDebugMsg("英雄为："+YDWEId2S(GetUnitTypeId(u))+"，英雄熟练度引索："+I2S(id))
        int exp = 0
        int level = 0
        int zu = 7
        int wei = id
        if  id > 30
            zu = 8
            wei = wei - 30
        endif
        exp = GetDzPlayerData(pid,zu,wei)
        level = GetDzPlayerData(pid,9,id)
        BJDebugMsg("当前熟练度等级为"+I2S(level)+"级，经验为"+I2S(exp))
        exp = exp + num
        if  level == 4
            if  MaxHeroExpLevel != level
                if  exp >= MaxHeroNeedExp4
                    exp = exp-MaxHeroNeedExp4
                    AddDzPlayerData(pid,9,id,1)
                endif
                SetDzPlayerData(pid,zu,wei,exp)
            else
                SetDzPlayerData(pid,zu,wei,0)
            endif
        elseif  level == 3
            if  MaxHeroExpLevel != level
                if  exp >= MaxHeroNeedExp3
                    exp = exp-MaxHeroNeedExp3
                    AddDzPlayerData(pid,9,id,1)
                endif
                SetDzPlayerData(pid,zu,wei,exp)
            else
                SetDzPlayerData(pid,zu,wei,0)
            endif
        elseif  level == 2
            if  MaxHeroExpLevel != level
                if  exp >= MaxHeroNeedExp2
                    exp = exp-MaxHeroNeedExp2
                    AddDzPlayerData(pid,9,id,1)
                endif
                SetDzPlayerData(pid,zu,wei,exp)
            else
                SetDzPlayerData(pid,zu,wei,0)
            endif
        elseif  level == 1
            if  MaxHeroExpLevel != level
                if  exp >= MaxHeroNeedExp1
                    exp = exp-MaxHeroNeedExp1
                    AddDzPlayerData(pid,9,id,1)
                endif
                SetDzPlayerData(pid,zu,wei,exp)
            else
                SetDzPlayerData(pid,zu,wei,0)
            endif
        elseif  level == 0
            if  exp >= MaxHeroNeedExp0
                exp = exp-MaxHeroNeedExp0
                AddDzPlayerData(pid,9,id,1)
            endif
            SetDzPlayerData(pid,zu,wei,exp)
        endif
        BJDebugMsg("增加后熟练度等级为"+I2S(GetDzPlayerData(pid,9,id))+"级，经验为"+I2S(GetDzPlayerData(pid,zu,wei)))
        InitDzHeroExpDataEx(pid)
    endfunction
    
    //通关刷新
    function InitDzPlayerTG(int pid)
        int TGcos = GetDzPlayerData(pid,3,1) //通关总次数
        int PGcos = DzPlayerGames(Player(pid)) //局数
        int ndtg = 0
        if  PGcos < TGcos
            TGcos = PGcos
            SetDzPlayerData(pid,3,1,TGcos)
        endif
        for NanDu = 1,MaxGameLevel
            if  TGcos > 0
                if  TGcos >= GetDzPlayerData(pid,3,NanDu+1)
                    TGcos = TGcos - GetDzPlayerData(pid,3,NanDu+1)
                else
                    SetDzPlayerData(pid,3,NanDu+1,TGcos)
                    TGcos = 0
                endif
            else
                SetDzPlayerData(pid,3,NanDu+1,0)
            endif
        end
    endfunction

    //房间显示
    function GetDzPlayerMaxNanDu(int pid)->int //最高难度
        int lv = 0
        for nandu = 1,MaxGameLevel
            if  GetDzPlayerData(pid,3,1+nandu) > 0
                if  lv < nandu
                    lv = nandu
                endif
            endif
        end
        return lv
    endfunction

    function GetDzPlayerMaxNanDuString(int pid)->string
        int lv = GetDzPlayerMaxNanDu(pid)
        if  lv > 0
            return "N"+I2S(lv)
        else
            return "未通关"
        endif
    endfunction

    function GetDzHeroMedal(int pid)->int //战勋等级
        int Medal = GetDzPlayerData(pid,16,1)
        int lv = DzPlayerLv(Player(pid))
        if  Medal >= 28718 and  lv >= 14
            return 10
        elseif  Medal >= 23198 and  lv >= 12
            return 9
        elseif  Medal >= 18180 and  lv >= 11
            return 8
        elseif  Medal >= 13619 and  lv >= 10
            return 7
        elseif  Medal >= 9472 and  lv >= 8
            return 6
        elseif  Medal >= 6400 and  lv >= 7
            return 5
        elseif  Medal >= 3840 and  lv >= 6
            return 4
        elseif  Medal >= 1792 and  lv >= 4
            return 3
        elseif  Medal >= 640 and  lv >= 3
            return 2
        elseif  Medal >= 128 and  lv >= 2
            return 1
        else
            return 0
        endif
    endfunction

    function GetDzHeroMedalString(int pid)->string
        int lv = GetDzHeroMedal(pid)
        return "战勋Lv" + I2S(lv)
    endfunction

    ////////////////////////排行榜类存储////////////////////
    function InitInfiniteModelJF(int pid)
        int dataA = 0
        int dataB = 0
        dataA = DzAPI_Map_GetStoredInteger(Player(pid),"WJ1") //万魔窟
        dataB = GetDzPlayerData(pid,2,3) //万魔窟
        if  dataA > dataB
            DzAPI_Map_StoreInteger(Player(pid),"WJ1",dataB)
        endif
    endfunction
    
    function SetInfiniteModelJF(int pid,int jf)
        int data = 0
        data = GetDzPlayerData(pid,2,3) //万魔窟
        if  jf > data
            SetDzPlayerData(pid,2,3,jf)
            DzAPI_Map_StoreInteger(Player(pid),"WJ1",jf)
            BJDebugMsg("万魔窟排行榜存储："+I2S(jf)+"层")
        endif
    endfunction


    

endpiece

