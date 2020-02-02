library ItemAttackUnitChallenge uses DamageCode,ItemGameFunc

    int array AttackUnitChallengeStatePriceA[400][20]
    int array AttackUnitChallengeStatePriceB[400][20]
    int array AttackUnitChallengeStatePriceC[400][20]
    int array AttackUnitChallengeStatePriceD[400][20]

    int array AttackUnitChallengeStateType[400][20]
    int array AttackUnitChallengeStateTypeValueA[400][20]
    int array AttackUnitChallengeStateTypeValueB[400][20]
    int array AttackUnitChallengeStateTypeValueC[400][20]

    string array AttackUnitChallengeStateTypeString[400][20]

    int array AttackUnitChallengePlayerArrayInt[12][680]

    #define AttackUnitChallengeStateGold            AttackUnitChallengeStatePriceA
    #define AttackUnitChallengeStateLumber          AttackUnitChallengeStatePriceB

    #define AttackUnitChallengePlayerInt            AttackUnitChallengePlayerArrayInt[pid]
    #define AttackUnitChallengePlayerZuNum          AttackUnitChallengePlayerInt[0]
    #define AttackUnitChallengePlayerWeiNum         AttackUnitChallengePlayerInt[1]

    #define Buy_Tech 0             
    #define Buy_Unit 1             
    #define Buy_Item 2              
    #define Buy_Unit_Item 3        

    #define AttackUnitChallengeStateStockMax 8

    function InitAttackUnitChallengeStateData(int zu,int wei,int gold,int lumber,int othertype,int othervalue,int typeid,int typea,int typeb,int typec,string s)                                                    
        AttackUnitChallengeStateGold[zu][wei] = gold
        AttackUnitChallengeStateLumber[zu][wei] = lumber
        AttackUnitChallengeStatePriceC[zu][wei] = othertype
        AttackUnitChallengeStatePriceD[zu][wei] = othervalue

        AttackUnitChallengeStateType[zu][wei] = typeid //购买类型
        AttackUnitChallengeStateTypeValueA[zu][wei] = typea //类型参数
        AttackUnitChallengeStateTypeValueB[zu][wei] = typeb //类型参数 未使用的
        AttackUnitChallengeStateTypeValueC[zu][wei] = typec //类型参数 未使用的

        AttackUnitChallengeStateTypeString[zu][wei] = s
    endfunction

    function InitAttackUnitChallengeState()
        //轮数 次数 金币 玄铁 属性消耗序号 属性消耗值 挑战类型 技能ID 参数1 参数2 说明
        InitAttackUnitChallengeStateData(0,0,1000,10,0,0,Buy_Tech,'ATAA',0,0,"奖励xxx")
        InitAttackUnitChallengeStateData(0,1,1000,10,0,0,Buy_Tech,'ATAB',0,0,"奖励xxx")
        InitAttackUnitChallengeStateData(0,2,1000,10,0,0,Buy_Tech,'ATAC',0,0,"奖励xxx")
        InitAttackUnitChallengeStateData(0,3,1000,10,108,100,Buy_Unit,'ATAD',0,0,"奖励xxx")
        InitAttackUnitChallengeStateData(0,4,1000,10,108,50,Buy_Tech,'ATAE',0,0,"奖励xxx")
        InitAttackUnitChallengeStateData(0,5,1000,10,108,50,Buy_Tech,'ATAF',0,0,"奖励xxx")
        InitAttackUnitChallengeStateData(0,6,1000,10,108,50,Buy_Tech,'ATAG',0,0,"奖励xxx")
        InitAttackUnitChallengeStateData(0,7,1000,10,108,60,Buy_Item,'ATAH','ID16',0,"奖励xxx")
        InitAttackUnitChallengeStateData(0,8,1000,10,108,80,Buy_Tech,'ATAE',0,0,"奖励xxx")
        InitAttackUnitChallengeStateData(0,9,1000,10,108,90,Buy_Tech,'ATAF',0,0,"奖励xxx")
        InitAttackUnitChallengeStateData(0,10,1000,10,108,100,Buy_Tech,'ATAG',0,0,"奖励xxx")
        InitAttackUnitChallengeStateData(0,11,1000,10,108,120,Buy_Unit_Item,'ATAH','ID16',0,"奖励xxx")

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
        return s+"|n|n"
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
        int itemid = AttackUnitChallengeStateTypeValueB[zu][wei]
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
                u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),uid,x,y,270)
                UnitAddAbility(u,'AZ99')
                SetUnitAbilityLevel(u,'AZ99',pid+1)
                AddAttackSummonUnit.execute(pid,u)
                SetUnitRealState(u,97,id)
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r为您召唤"+GetObjectName(uid)+"！")
            elseif  AttackUnitChallengeStateType[zu][wei] == Buy_Item
                UnitRemoveAbility(Pu[42],id)
                SetPlayerTechResearchedEx(Player(pid),tech)
                UnitAddItemEx(Pu[1],itemid)
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetObjectName(id)+"！")
                AddAttackUnitChallengeStateLevel(pid)
            elseif  AttackUnitChallengeStateType[zu][wei] == Buy_Unit_Item
                u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),uid,x,y,270)
                UnitAddAbility(u,'AZ99')
                SetUnitAbilityLevel(u,'AZ99',pid+1)
                AddAttackSummonUnit.execute(pid,u)
                SetUnitRealState(u,97,id)
                SetUnitRealState(u,98,itemid)
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r为您召唤"+GetObjectName(uid)+"！")
            endif
        endif
        u = null
    endfunction

    function AttackUnitChallengeStateDeathEvent(int pid,unit u)
        int id = R2I(GetUnitRealState(u,97))
        int itemid = R2I(GetUnitRealState(u,98))
        int tech = id+167772160
        UnitRemoveAbility(Pu[42],id)
        SetPlayerTechResearchedEx(Player(pid),tech)
        if  itemid > 0
            UnitAddItemEx(Pu[1],itemid)
        endif
        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetObjectName(id)+"！")
        AddAttackUnitChallengeStateLevel(pid)
    endfunction

endlibrary 
