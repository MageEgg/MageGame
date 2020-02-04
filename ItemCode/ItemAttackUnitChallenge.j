library ItemAttackUnitChallenge uses DamageCode,ItemGameFunc

    int array AttackUnitChallengeStatePriceA[400][20]
    int array AttackUnitChallengeStatePriceB[400][20]
    int array AttackUnitChallengeStatePriceC[400][20]
    int array AttackUnitChallengeStatePriceD[400][20]

    int array AttackUnitChallengeStateType[400][20]
    int array AttackUnitChallengeStateTypeValueA[400][20]
    int array AttackUnitChallengeStateTypeValueB[400][20]
    int array AttackUnitChallengeStateTypeValueC[400][20]
    int array AttackUnitChallengeStateTypeValueD[400][20]

    string array AttackUnitChallengeStateTypeString[400][20]

    int array AttackUnitChallengePlayerArrayInt[12][680]

    #define AttackUnitChallengeStateGold            AttackUnitChallengeStatePriceA
    #define AttackUnitChallengeStateLumber          AttackUnitChallengeStatePriceB

    #define AttackUnitChallengePlayerInt            AttackUnitChallengePlayerArrayInt[pid]
    #define AttackUnitChallengePlayerZuNum          AttackUnitChallengePlayerInt[0]
    #define AttackUnitChallengePlayerWeiNum         AttackUnitChallengePlayerInt[1]
    #define AttackUnitChallengePlayerKillCos        AttackUnitChallengePlayerInt[2]

    #define Buy_Tech 0             
    #define Buy_Unit 1             
    #define Buy_Item 2              
    #define Buy_Unit_Item 3        

    #define AttackUnitChallengeStateStockMax 8

    function InitAttackUnitChallengeStateData(int zu,int wei,int gold,int lumber,int othertype,int othervalue,int typeid,int typea,int typeb,int typec,int typed,string s)                                                    
        AttackUnitChallengeStateGold[zu][wei] = gold
        AttackUnitChallengeStateLumber[zu][wei] = lumber
        AttackUnitChallengeStatePriceC[zu][wei] = othertype
        AttackUnitChallengeStatePriceD[zu][wei] = othervalue

        AttackUnitChallengeStateType[zu][wei] = typeid //购买类型
        AttackUnitChallengeStateTypeValueA[zu][wei] = typea //类型参数
        AttackUnitChallengeStateTypeValueB[zu][wei] = typeb //类型参数 
        AttackUnitChallengeStateTypeValueC[zu][wei] = typec //类型参数 
        AttackUnitChallengeStateTypeValueD[zu][wei] = typed //类型参数 未使用的

        AttackUnitChallengeStateTypeString[zu][wei] = s
    endfunction

    function InitAttackUnitChallengeState()
        //轮数 次数 金币 玄铁 属性消耗序号 属性消耗值 挑战类型 技能ID 参数1 参数2 说明
        InitAttackUnitChallengeStateData(0,0,0,0,108,0,Buy_Unit,'ATAA',6,0,0,"奖励击杀金币+3")
        InitAttackUnitChallengeStateData(0,1,0,0,108,0,Buy_Unit,'ATAB',1,0,0,"奖励练功房怪物+2")
        InitAttackUnitChallengeStateData(0,2,0,0,108,0,Buy_Unit,'ATAC',6,0,0,"奖励金币加成+20%")
        InitAttackUnitChallengeStateData(0,3,0,0,108,0,Buy_Unit_Item,'ATAD',1,'IZ0D',0,"奖励副本NPC出现，解锁门票挑战")
        InitAttackUnitChallengeStateData(0,4,0,0,108,0,Buy_Unit,'ATAE',1,0,0,"奖励攻击速度+40%")
        InitAttackUnitChallengeStateData(0,5,0,0,108,0,Buy_Unit_Item,'ATAF',12,'IS14',0,"奖励药品升级，使用后立即恢复40%生命值，每秒恢复5%生命值，持续6秒")
        InitAttackUnitChallengeStateData(0,6,0,0,108,0,Buy_Unit,'ATAG',8,0,0,"奖励金币")
        InitAttackUnitChallengeStateData(0,7,0,0,108,0,Buy_Unit,'ATAH',1,0,0,"奖励攻击")

        InitAttackUnitChallengeStateData(1,0,0,0,108,0,Buy_Unit,'ATAI',8,0,0,"奖励玄铁")
        InitAttackUnitChallengeStateData(1,1,0,0,108,0,Buy_Unit_Item,'ATAJ',1,'IZ0E',0,"奖励随机兽魂一个")
        InitAttackUnitChallengeStateData(1,2,0,0,108,0,Buy_Unit,'ATAK',1,0,0,"奖励固定生命&防御")
        InitAttackUnitChallengeStateData(1,3,0,0,108,0,Buy_Unit_Item,'ATAL',1,'CS23',0,"奖励攻击速度+30%、残破技能进阶石")
        InitAttackUnitChallengeStateData(1,4,0,0,108,0,Buy_Unit_Item,'ATAM',12,'IS14',0,"奖励药品升级：使用后立即恢复40%生命值，每秒恢复4%生命值，持续6秒。药水持续时间内，攻击速度+30%")
        InitAttackUnitChallengeStateData(1,5,0,0,108,0,Buy_Unit_Item,'ATAN',1,'IZ0F',0,"奖励14随机R技能")
        InitAttackUnitChallengeStateData(1,6,0,0,108,0,Buy_Unit_Item,'ATAO',15,'IS14',0,"奖励15药品升级：使用后立即恢复40%生命值，每秒恢复8%生命值，持续6秒。药水持续时间内，攻击速度+30%，冷却缩减+15%.")
        InitAttackUnitChallengeStateData(1,7,0,0,108,0,Buy_Unit,'ATAP',20,0,0,"奖励16生命%&固定防御")

        ExecuteFunc("InitAttackUnitChallengeStateStock")
    endfunction

    function GetStockSkillConsume(int zu,int wei)->string
        int id = AttackUnitChallengeStateTypeValueA[zu][wei] 
        string s = "|cff00ffff挑战消耗：|r"
        if  AttackUnitChallengeStateGold[zu][wei] > 0
            s = s + "|n"+"|cffffcc00金币：|r"+ I2S(AttackUnitChallengeStateGold[zu][wei])
        endif
        if  AttackUnitChallengeStateLumber[zu][wei] > 0
            s = s + "|n"+"|cffffcc00玄铁：|r"+ I2S(AttackUnitChallengeStateLumber[zu][wei])
        endif
        if  AttackUnitChallengeStatePriceC[zu][wei] > 0 and AttackUnitChallengeStatePriceD[zu][wei] > 0
            s = s + "|n"+"|cffffcc00"+StateName[AttackUnitChallengeStatePriceC[zu][wei]]+"：|r" + I2S(AttackUnitChallengeStatePriceD[zu][wei])
        endif
        if  s == "|cff00ffff挑战消耗：|r"
            return ""
        else
            return s+"|n|n"
        endif
    endfunction

    function AddAttackUnitChallengeStateStock(int pid,int zu,int wei)
        int id = AttackUnitChallengeStateTypeValueA[zu][wei]
        int zero = AttackUnitChallengeStateTypeValueA[zu][0]
        string s = ""
        BJDebugMsg(YDWEId2S(id))
        UnitAddAbility(Pu[42],id)
        if  GetPlayerTechCount(Player(pid),id+167772160-1,true) > 0 or id == zero
            s = GetStockSkillConsume(zu,wei)
            BJDebugMsg("GetStockSkillConsume")
        endif
        s = s + AttackUnitChallengeStateTypeString[zu][wei]
        if  Player(pid) == GetLocalPlayer()
            YDWESetUnitAbilityDataString(Pu[42],id,1,218,s)
        endif
    endfunction

    function InitAttackUnitChallengeStateStock()
        for pid = 0,3
            if  IsPlaying(pid) == true
                for num = 0,AttackUnitChallengeStateStockMax
                    AddAttackUnitChallengeStateStock(pid,0,num)
                end
            endif
        end
    endfunction

    function IsCanGetAttackUnitChallengeState(int pid)->bool
        int zu = AttackUnitChallengePlayerZuNum
        int wei = AttackUnitChallengePlayerWeiNum
        int gold = AttackUnitChallengeStateGold[zu][wei]
        int lumber = AttackUnitChallengeStateLumber[zu][wei]
        int othertype = AttackUnitChallengeStatePriceC[zu][wei]
        int othervalue = AttackUnitChallengeStatePriceD[zu][wei]
        int other = 0
        if  othertype > 0 and othervalue > 0
            other = othervalue
        endif
        if  gold > 0 and lumber > 0 and other > 0
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD) >= gold
                if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER) >= lumber
                    if  othertype < 100
                        if  GetUnitRealState(Pu[1],othertype) >= other
                            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                            AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                            AddUnitRealState(Pu[1],othertype,-other)
                            return true
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的"+StateName[othertype]+"不足"+I2S(other)+"！|r")
                            return false
                        endif
                    else
                        if  GetUnitIntState(Pu[1],othertype) >= other
                            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                            AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                            AddUnitIntState(Pu[1],othertype,-other)
                            return true
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的"+StateName[othertype]+"不足"+I2S(other)+"！|r")
                            return false
                        endif
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的玄铁不足"+I2S(lumber)+"！|r")
                    return false
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的金币不足"+I2S(gold)+"！|r")
                return false
            endif
        elseif  gold > 0 and lumber > 0 and other == 0
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD) >= gold
                if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER) >= lumber
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                    return true
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的玄铁不足"+I2S(lumber)+"！|r")
                    return false
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的金币不足"+I2S(gold)+"！|r")
                return false
            endif
        elseif  gold > 0 and lumber == 0 and other > 0
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD) >= gold
                if  othertype < 100
                    if  GetUnitRealState(Pu[1],othertype) >= other
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                        AddUnitRealState(Pu[1],othertype,-other)
                        return true
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的"+StateName[othertype]+"不足"+I2S(other)+"！|r")
                        return false
                    endif
                else
                    if  GetUnitIntState(Pu[1],othertype) >= other
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                        AddUnitIntState(Pu[1],othertype,-other)
                        return true
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的"+StateName[othertype]+"不足"+I2S(other)+"！|r")
                        return false
                    endif
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的金币不足"+I2S(gold)+"！|r")
                return false
            endif
        elseif  gold == 0 and lumber > 0 and other > 0
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER) >= lumber
                if  othertype < 100
                    if  GetUnitRealState(Pu[1],othertype) >= other
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                        AddUnitRealState(Pu[1],othertype,-other)
                        return true
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的"+StateName[othertype]+"不足"+I2S(other)+"！|r")
                        return false
                    endif
                else
                    if  GetUnitIntState(Pu[1],othertype) >= other
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                        AddUnitIntState(Pu[1],othertype,-other)
                        return true
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的"+StateName[othertype]+"不足"+I2S(other)+"！|r")
                        return false
                    endif
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的玄铁不足"+I2S(lumber)+"！|r")
                return false
            endif
        elseif  gold > 0 and lumber == 0 and other == 0
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD) >= gold
                AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                return true
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的金币不足"+I2S(gold)+"！|r")
                return false
            endif
        elseif  gold == 0 and lumber > 0 and other == 0
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER) >= lumber
                AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                return true
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的玄铁不足"+I2S(lumber)+"！|r")
                return false
            endif
        elseif  gold == 0 and lumber == 0 and other > 0
            if  othertype < 100
                if  GetUnitRealState(Pu[1],othertype) >= other
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                    AddUnitRealState(Pu[1],othertype,-other)
                    return true
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的"+StateName[othertype]+"不足"+I2S(other)+"！|r")
                    return false
                endif
            else
                if  GetUnitIntState(Pu[1],othertype) >= other
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
                    AddUnitIntState(Pu[1],othertype,-other)
                    return true
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000您的"+StateName[othertype]+"不足"+I2S(other)+"！|r")
                    return false
                endif
            endif
        elseif  gold == 0 and lumber == 0 and other == 0
            return true
        endif
        return false
    endfunction

    function AddAttackUnitChallengeStateLevel(int pid)
        AttackUnitChallengePlayerWeiNum = AttackUnitChallengePlayerWeiNum + 1
        if  AttackUnitChallengePlayerWeiNum == AttackUnitChallengeStateStockMax
            AttackUnitChallengePlayerZuNum = AttackUnitChallengePlayerZuNum + 1
            AttackUnitChallengePlayerWeiNum = 0
            for num = 0,AttackUnitChallengeStateStockMax
                AddAttackUnitChallengeStateStock(pid,AttackUnitChallengePlayerZuNum,num)
            end
        else
            AddAttackUnitChallengeStateStock(pid,AttackUnitChallengePlayerZuNum,AttackUnitChallengePlayerWeiNum)
        endif
    endfunction

    function AddAttackUnitChallengeState(int pid)
        int zu = AttackUnitChallengePlayerZuNum
        int wei = AttackUnitChallengePlayerWeiNum
        int id = AttackUnitChallengeStateTypeValueA[zu][wei]
        int tech = id+167772160
        int uid = id+872415232
        int itemid = 0
        int unitnum = 0
        real x = AttackRoomPostion[pid][1]
        real y = AttackRoomPostion[pid][2]
        unit u = null
        if  IsCanGetAttackUnitChallengeState(pid) == true
            if  AttackUnitChallengeStateType[zu][wei] == Buy_Tech
                UnitRemoveAbility(Pu[42],id)
                SetPlayerTechResearchedEx(Player(pid),tech)
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetObjectName(id)+"！")
                AddAttackUnitChallengeStateLevel(pid)
            elseif  AttackUnitChallengeStateType[zu][wei] == Buy_Unit
                unitnum = AttackUnitChallengeStateTypeValueB[zu][wei]
                for num = 1,unitnum
                    u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),uid,x-460,y+460,270)
                    UnitAddAbility(u,'AZ99')
                    SetUnitAbilityLevel(u,'AZ99',pid+1)
                    AddAttackSummonUnit.execute(pid,u)
                    SetUnitIntState(u,101,id)
                    IssuePointOrderById(u,851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                end
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r为您召唤"+GetObjectName(uid)+"！")
            elseif  AttackUnitChallengeStateType[zu][wei] == Buy_Item
                itemid = AttackUnitChallengeStateTypeValueB[zu][wei]
                UnitRemoveAbility(Pu[42],id)
                SetPlayerTechResearchedEx(Player(pid),tech)
                UnitAddItemEx(Pu[1],itemid)
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetObjectName(id)+"！")
                AddAttackUnitChallengeStateLevel(pid)
            elseif  AttackUnitChallengeStateType[zu][wei] == Buy_Unit_Item
                unitnum = AttackUnitChallengeStateTypeValueB[zu][wei]
                itemid = AttackUnitChallengeStateTypeValueC[zu][wei]
                for num = 1,unitnum
                    u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),uid,x-460,y+460,270)
                    UnitAddAbility(u,'AZ99')
                    SetUnitAbilityLevel(u,'AZ99',pid+1)
                    AddAttackSummonUnit.execute(pid,u)
                    SetUnitIntState(u,101,id)
                    SetUnitIntState(u,102,itemid)
                    IssuePointOrderById(u,851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                end
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r为您召唤"+GetObjectName(uid)+"！")
            endif
        endif
        u = null
    endfunction

    function AttackUnitChallengeStateDeathEvent(int pid,unit u)
        int zu = AttackUnitChallengePlayerZuNum
        int wei = AttackUnitChallengePlayerWeiNum
        int id = GetUnitIntState(u,101)
        int itemid = GetUnitIntState(u,102)
        int tech = id+167772160
        int unitnum = AttackUnitChallengeStateTypeValueB[zu][wei]
        AttackUnitChallengePlayerKillCos = AttackUnitChallengePlayerKillCos + 1
        if  unitnum >= 15
            if  ModuloInteger(AttackUnitChallengePlayerKillCos,4) == 0 or AttackUnitChallengePlayerKillCos == unitnum
                DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[历练挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos)+"/"+I2S(unitnum)+"|r)")
            endif
        elseif  unitnum >= 9
            if  ModuloInteger(AttackUnitChallengePlayerKillCos,3) == 0 or AttackUnitChallengePlayerKillCos == unitnum
                DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[历练挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos)+"/"+I2S(unitnum)+"|r)")
            endif
        elseif  unitnum >= 2
            if  ModuloInteger(AttackUnitChallengePlayerKillCos,2) == 0 or AttackUnitChallengePlayerKillCos == unitnum
                DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[历练挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos)+"/"+I2S(unitnum)+"|r)")
            endif
        elseif  unitnum == 1
            DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[历练挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos)+"/"+I2S(unitnum)+"|r)")
        endif
        if  AttackUnitChallengePlayerKillCos == unitnum
            AttackUnitChallengePlayerKillCos = 0
            UnitRemoveAbility(Pu[42],id)
            SetPlayerTechResearchedEx(Player(pid),tech)
            if  itemid > 0
                UnitAddItemEx(Pu[1],itemid)
            endif
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetObjectName(id)+"！")
            AddAttackUnitChallengeStateLevel(pid)
        endif
    endfunction

endlibrary 
