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

    #define AttackUnitChallengeStateGold                    AttackUnitChallengeStatePriceA
    #define AttackUnitChallengeStateLumber                  AttackUnitChallengeStatePriceB

    #define AttackUnitChallengePlayerInt                    AttackUnitChallengePlayerArrayInt[pid]
    #define AttackUnitChallengePlayerZuNum(num)             AttackUnitChallengePlayerInt[0+num]
    #define AttackUnitChallengePlayerWeiNum(num)            AttackUnitChallengePlayerInt[10+num]
    #define IsPlayerInAttackUnitChallenge(num)              AttackUnitChallengePlayerInt[20+num]
    #define AttackUnitChallengePlayerKillCos(num)           AttackUnitChallengePlayerInt[30+num]

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

        InitAttackUnitChallengeStateData(200,0,0,2,108,0,Buy_Unit,0,1,0,0,"奖励灵力挑战")

        InitAttackUnitChallengeStateData(220,0,0,0,108,0,Buy_Unit,'AT2A',1,0,0,"奖励解锁副本1")
        InitAttackUnitChallengeStateData(220,1,0,0,108,0,Buy_Unit,'AT2B',1,0,0,"奖励解锁副本2")
        InitAttackUnitChallengeStateData(220,2,0,0,108,0,Buy_Unit,'AT2C',1,0,0,"奖励解锁副本3")
        InitAttackUnitChallengeStateData(220,3,0,0,108,0,Buy_Unit,'AT2D',1,0,0,"奖励解锁副本4")
        InitAttackUnitChallengeStateData(220,4,0,0,108,0,Buy_Unit,'AT2E',1,0,0,"奖励解锁副本5")
        InitAttackUnitChallengeStateData(220,5,0,0,108,0,Buy_Unit,'AT2F',1,0,0,"奖励解锁副本6")
        InitAttackUnitChallengeStateData(220,6,0,0,108,0,Buy_Unit,'AT2G',1,0,0,"奖励解锁副本7")
        InitAttackUnitChallengeStateData(220,7,0,0,108,0,Buy_Unit,'AT2H',1,0,0,"奖励解锁副本8")

        InitAttackUnitChallengeStateData(210,0,0,0,108,0,Buy_Unit,'AT1A',1,0,0,"奖励法宝亲和度1")
        InitAttackUnitChallengeStateData(210,1,0,0,108,0,Buy_Unit,'AT1B',1,0,0,"奖励法宝亲和度2")
        InitAttackUnitChallengeStateData(210,2,0,0,108,0,Buy_Unit,'AT1C',1,0,0,"奖励法宝亲和度3")
        InitAttackUnitChallengeStateData(210,3,0,0,108,0,Buy_Unit,'AT1D',1,0,0,"奖励法宝亲和度4")
        InitAttackUnitChallengeStateData(210,4,0,0,108,0,Buy_Unit,'AT1E',1,0,0,"奖励法宝亲和度5")
        InitAttackUnitChallengeStateData(210,5,0,0,108,0,Buy_Unit,'AT1F',1,0,0,"奖励法宝亲和度6")
        InitAttackUnitChallengeStateData(210,6,0,0,108,0,Buy_Unit,'AT1G',1,0,0,"奖励法宝亲和度7")
        InitAttackUnitChallengeStateData(210,7,0,0,108,0,Buy_Unit,'AT1H',1,0,0,"奖励法宝亲和度8")

        InitAttackUnitChallengeStateData(230,0,0,0,108,0,Buy_Unit,'AT3A',1,0,0,"奖励副本9入场券")
        InitAttackUnitChallengeStateData(230,1,0,0,108,0,Buy_Unit,'AT3B',1,0,0,"奖励副本10入场券")
        InitAttackUnitChallengeStateData(230,2,0,0,108,0,Buy_Unit,'AT3C',1,0,0,"奖励副本11入场券")
        InitAttackUnitChallengeStateData(230,3,0,0,108,0,Buy_Unit,'AT3D',1,0,0,"奖励副本12入场券")
        InitAttackUnitChallengeStateData(230,4,0,0,108,0,Buy_Unit,'AT3E',1,0,0,"奖励副本13入场券")
        InitAttackUnitChallengeStateData(230,5,0,0,108,0,Buy_Unit,'AT3F',1,0,0,"奖励副本14入场券")
        InitAttackUnitChallengeStateData(230,6,0,0,108,0,Buy_Unit,'AT3G',1,0,0,"奖励副本15入场券")
        InitAttackUnitChallengeStateData(230,7,0,0,108,0,Buy_Unit,'AT3H',1,0,0,"奖励副本16入场券")

        InitAttackUnitChallengeStateData(250,0,0,1,108,0,Buy_Unit,0,1,0,0,"奖励资源挑战")

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
        //BJDebugMsg(YDWEId2S(id))
        UnitAddAbility(Pu[42],id)
        if  GetPlayerTechCount(Player(pid),id+167772160-1,true) > 0 or id == zero
            s = GetStockSkillConsume(zu,wei)
            //BJDebugMsg("GetStockSkillConsume")
        endif
        s = s + AttackUnitChallengeStateTypeString[zu][wei]
        if  Player(pid) == GetLocalPlayer()
            YDWESetUnitAbilityDataString(Pu[42],id,1,218,s)
            if  zu >= 200
                YDWESetUnitAbilityState(Pu[42],id,1,60)
            else
                YDWESetUnitAbilityState(Pu[42],id,1,10)
            endif
        endif
    endfunction

    function InitAttackUnitChallengeStateStock()
        for pid = 0,3
            if  IsPlaying(pid) == true
                for num = 0,AttackUnitChallengeStateStockMax
                    AddAttackUnitChallengeStateStock(pid,0,num)
                end
                AddAttackUnitChallengeStateStock(pid,210,0)
                AddAttackUnitChallengeStateStock(pid,220,0)
                UnitAddAbility(Pu[42],'AT0A')
                UnitAddAbility(Pu[42],'AT5A')
            endif
        end
    endfunction
    
    function IsCanGetAttackUnitChallengeState(int pid,int challenge)->bool
        int zu = 0
        int wei = 0
        int gold = 0
        int lumber = 0
        int othertype = 0
        int othervalue = 0
        int other = 0
        if  challenge == 0
            zu = AttackUnitChallengePlayerZuNum(challenge) 
            wei = AttackUnitChallengePlayerWeiNum(challenge)
        elseif  challenge == 1
            zu = 200
            wei = 0
        elseif  challenge == 6
            zu = 250
            wei = 0
        else
            zu = AttackUnitChallengePlayerZuNum(challenge) + 200+10*(challenge-1)
            wei = AttackUnitChallengePlayerWeiNum(challenge)
        endif
        gold = AttackUnitChallengeStateGold[zu][wei]
        lumber = AttackUnitChallengeStateLumber[zu][wei]
        othertype = AttackUnitChallengeStatePriceC[zu][wei]
        othervalue = AttackUnitChallengeStatePriceD[zu][wei]
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

    function AddAttackUnitChallengeStateLevel(int pid,int challenge)
        AttackUnitChallengePlayerWeiNum(challenge) = AttackUnitChallengePlayerWeiNum(challenge) + 1
        if  challenge == 0
            if  AttackUnitChallengePlayerWeiNum(challenge) == AttackUnitChallengeStateStockMax
                AttackUnitChallengePlayerZuNum(challenge) = AttackUnitChallengePlayerZuNum(challenge) + 1
                AttackUnitChallengePlayerWeiNum(challenge) = 0
                for num = 0,AttackUnitChallengeStateStockMax
                    AddAttackUnitChallengeStateStock(pid,AttackUnitChallengePlayerZuNum(challenge),num)
                end
            else
                AddAttackUnitChallengeStateStock(pid,AttackUnitChallengePlayerZuNum(challenge),AttackUnitChallengePlayerWeiNum(challenge))
            endif
        else
            AddAttackUnitChallengeStateStock(pid,AttackUnitChallengePlayerZuNum(challenge) + 200+10*(challenge-1),AttackUnitChallengePlayerWeiNum(challenge))
        endif
    endfunction

    function AddAttackUnitChallengeState(int pid,int sid)
        int zu = 0
        int wei = 0
        int id = 0
        int tech = 0
        int uid = 0
        int itemid = 0
        int unitnum = 0
        int challenge = 0
        real x = AttackRoomPostion[pid][1]
        real y = AttackRoomPostion[pid][2]
        unit u = null
        if  sid == 'AT0A'
            challenge = 1
            zu = 200
            wei = 0
            
            id = 'AT0A'+AttackUnitChallengePlayerWeiNum(challenge)
            BJDebugMsg(YDWEId2S(sid)+"@@"+YDWEId2S(id)+"@@"+I2S(challenge))
            tech = 'KT0A'+AttackUnitChallengePlayerWeiNum(challenge)
            uid = 'uT0A'+AttackUnitChallengePlayerWeiNum(challenge)
            if  AttackUnitChallengePlayerWeiNum(challenge) > 12
                id = 'AT0L'
                tech = 'KT0L'
                uid = 'uT0L'
            endif
        elseif  sid == 'AT5A'
            challenge = 6
            zu = 250
            wei = 0
            
            id = 'AT5A'+AttackUnitChallengePlayerWeiNum(challenge)
            BJDebugMsg(YDWEId2S(sid)+"@@"+YDWEId2S(id)+"@@"+I2S(challenge))
            tech = 'KT5A'+AttackUnitChallengePlayerWeiNum(challenge)
            uid = 'uT5A'+AttackUnitChallengePlayerWeiNum(challenge)
            if  AttackUnitChallengePlayerWeiNum(challenge) > 12
                id = 'AT5L'
                tech = 'KT5L'
                uid = 'uT5L'
            endif
        elseif  sid - 'AT9A' < 2048
            challenge = S2I(SubString(YDWEId2S(sid),2,3)) + 1
            zu = AttackUnitChallengePlayerZuNum(challenge) + 200+10*(challenge-1)
            wei = AttackUnitChallengePlayerWeiNum(challenge)

            id = AttackUnitChallengeStateTypeValueA[zu][wei]
            BJDebugMsg(YDWEId2S(sid)+"@@"+YDWEId2S(id)+"@@"+I2S(challenge))
            tech = id+167772160
            uid = id+872415232

        else
            zu = AttackUnitChallengePlayerZuNum(challenge)
            wei = AttackUnitChallengePlayerWeiNum(challenge)

            id = AttackUnitChallengeStateTypeValueA[zu][wei]
            BJDebugMsg(YDWEId2S(sid)+"@@"+YDWEId2S(id)+"@@"+I2S(challenge))
            tech = id+167772160
            uid = id+872415232

        endif
        if  IsPlayerInAttackUnitChallenge(challenge) == 0
            if  IsCanGetAttackUnitChallengeState(pid,challenge) == true
                if  AttackUnitChallengeStateType[zu][wei] == Buy_Tech
                    UnitRemoveAbility(Pu[42],id)
                    SetPlayerTechResearchedEx(Player(pid),tech)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetObjectName(id)+"！")
                    AddAttackUnitChallengeStateLevel(pid,challenge)
                elseif  AttackUnitChallengeStateType[zu][wei] == Buy_Unit
                    IsPlayerInAttackUnitChallenge(challenge) = 1
                    unitnum = AttackUnitChallengeStateTypeValueB[zu][wei]
                    for num = 1,unitnum
                        u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),uid,x-440,y+440,270)
                        UnitAddAbility(u,'AZ99')
                        SetUnitAbilityLevel(u,'AZ99',pid+1)
                        AddAttackSummonUnit.execute(pid,u)
                        SetUnitIntState(u,101,id)
                        IssuePointOrderById(u,851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                        if  (challenge == 1 or challenge == 6) and AttackUnitChallengePlayerWeiNum(challenge) > 12
                            SetUnitRealStateOfOtherIdAddValue(u,uid,1+0.3*I2R(AttackUnitChallengePlayerWeiNum(challenge)-12))
                        endif
                    end
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r为您召唤"+GetObjectName(uid)+"！")
                elseif  AttackUnitChallengeStateType[zu][wei] == Buy_Item
                    itemid = AttackUnitChallengeStateTypeValueB[zu][wei]
                    UnitRemoveAbility(Pu[42],id)
                    SetPlayerTechResearchedEx(Player(pid),tech)
                    UnitAddItemEx(Pu[1],itemid)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetObjectName(id)+"！")
                    AddAttackUnitChallengeStateLevel(pid,challenge)
                elseif  AttackUnitChallengeStateType[zu][wei] == Buy_Unit_Item
                    IsPlayerInAttackUnitChallenge(challenge) = 1
                    unitnum = AttackUnitChallengeStateTypeValueB[zu][wei]
                    itemid = AttackUnitChallengeStateTypeValueC[zu][wei]
                    for num = 1,unitnum
                        u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),uid,x-440,y+440,270)
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
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000当前正在挑战！")
        endif
        u = null
    endfunction

    function AttackUnitChallengeStateDeathEvent(int pid,unit u)
        int zu = 0
        int wei = 0
        int id = GetUnitIntState(u,101)
        int itemid = GetUnitIntState(u,102)
        int tech = id+167772160
        int unitnum = 0
        int challenge = 0
        int ran = 0
        if  id >= 'AT0A' and id <= 'AT0L'
            challenge = 1
            zu = 200
            wei = 0
        elseif  id >= 'AT5A' and id <= 'AT5L'
            challenge = 6
            zu = 250
            wei = 0
        elseif  id - 'AT9A' < 2048
            challenge = S2I(SubString(YDWEId2S(id),2,3)) + 1
            zu = AttackUnitChallengePlayerZuNum(challenge) + 200+10*(challenge-1)
            wei = AttackUnitChallengePlayerWeiNum(challenge)
        else
            zu = AttackUnitChallengePlayerZuNum(challenge)
            wei = AttackUnitChallengePlayerWeiNum(challenge)
        endif
        unitnum = AttackUnitChallengeStateTypeValueB[zu][wei]
        AttackUnitChallengePlayerKillCos(challenge) = AttackUnitChallengePlayerKillCos(challenge) + 1
        BJDebugMsg(YDWEId2S(id)+"@@"+I2S(challenge))
        if  challenge == 0
            if  unitnum >= 15
                if  ModuloInteger(AttackUnitChallengePlayerKillCos(challenge),4) == 0 or AttackUnitChallengePlayerKillCos(challenge) == unitnum
                    DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[历练挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos(challenge))+"/"+I2S(unitnum)+"|r)")
                endif
            elseif  unitnum >= 9
                if  ModuloInteger(AttackUnitChallengePlayerKillCos(challenge),3) == 0 or AttackUnitChallengePlayerKillCos(challenge) == unitnum
                    DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[历练挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos(challenge))+"/"+I2S(unitnum)+"|r)")
                endif
            elseif  unitnum >= 2
                if  ModuloInteger(AttackUnitChallengePlayerKillCos(challenge),2) == 0 or AttackUnitChallengePlayerKillCos(challenge) == unitnum
                    DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[历练挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos(challenge))+"/"+I2S(unitnum)+"|r)")
                endif
            elseif  unitnum == 1
                DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[历练挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos(challenge))+"/"+I2S(unitnum)+"|r)")
            endif
            if  AttackUnitChallengePlayerKillCos(challenge) == unitnum
                AttackUnitChallengePlayerKillCos(challenge) = 0
                UnitRemoveAbility(Pu[42],id)
                SetPlayerTechResearchedEx(Player(pid),tech)
                if  itemid > 0
                    UnitAddItemEx(Pu[1],itemid)
                endif
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetObjectName(id)+"！")
                AddAttackUnitChallengeStateLevel(pid,challenge)
                IsPlayerInAttackUnitChallenge(challenge) = 0
            endif
        else
            ///////////////////////分割判断/////////////////////
            if  challenge == 1
                DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[灵力挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos(challenge))+"/"+I2S(unitnum)+"|r)")
            elseif  challenge == 2
                DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[法宝亲和挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos(challenge))+"/"+I2S(unitnum)+"|r)")
            elseif  challenge == 3
                DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[副本解锁挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos(challenge))+"/"+I2S(unitnum)+"|r)")
            elseif  challenge == 6
                DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[资源挑战]：|r成功击杀"+GetUnitName(u)+"(|cffffcc00"+I2S(AttackUnitChallengePlayerKillCos(challenge))+"/"+I2S(unitnum)+"|r)")
            endif
            ///////////////////////分割判断/////////////////////
            if  AttackUnitChallengePlayerKillCos(challenge) == unitnum
                AttackUnitChallengePlayerKillCos(challenge) = 0
                if  challenge == 1
                    SetPlayerTechResearched(Player(pid),tech,1)
                    ran = GetRandomInt(2,6)
                    AddUnitIntState(Pu[1],108,ran)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetObjectName('AT0A')+",|cffffff00获得"+I2S(ran)+"点灵力|r！")
                    AttackUnitChallengePlayerWeiNum(challenge) = AttackUnitChallengePlayerWeiNum(challenge) + 1
                elseif  challenge == 6
                    SetPlayerTechResearched(Player(pid),tech,1)
                    UnitAddItemEx(Pu[1],'IN30')
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetObjectName('AT5A')+",|cffffff00获得"+GetObjectName('IN30')+"|r！")
                    AttackUnitChallengePlayerWeiNum(challenge) = AttackUnitChallengePlayerWeiNum(challenge) + 1
                else
                    UnitRemoveAbility(Pu[42],id)
                    SetPlayerTechResearchedEx(Player(pid),tech)
                    if  itemid > 0
                        UnitAddItemEx(Pu[1],itemid)
                    endif
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你完成"+GetObjectName(id)+"！")
                    AddAttackUnitChallengeStateLevel(pid,challenge)
                    ///////////////////////分割判断/////////////////////
                    if  challenge == 3
                        PlayerUnLockPlot.execute(pid,AttackUnitChallengePlayerWeiNum(challenge))
                        //if  AttackUnitChallengePlayerWeiNum(challenge) == 8
                        //    AddAttackUnitChallengeStateStock(pid,230,0)
                        //endif
                    endif 
                    ///////////////////////分割判断/////////////////////
                endif
                IsPlayerInAttackUnitChallenge(challenge) = 0
            endif
        endif
    endfunction

    function ItemEventOfAttackUnitChallengeState(int pid,int itid)
        int ran = 0
        if  itid == 'IZ0D'
            UnitAddAbility(Pu[1],'AG09')
            UnitMakeAbilityPermanent(Pu[1],true,'AG09')
            ShowUnit(Pu[24],true)
            UnitAddEffectOfNPC.execute(Pu[24])
            if  GetLocalPlayer() == Player(pid)
                DzFrameShow(BUTTON_Back[700+4][0], true)
            endif
            CloseCollectFrame(pid)
        elseif  itid == 'IZ0E'
            ran = GetRandomInt(0,7)
            AddPlayerMonsterSoulState(pid,ran)
            AddPlayerTechResearched(Player(pid),'RM50'+ran,1)
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]：|r|cffffff80恭喜"+GetPlayerNameOfColor(pid)+"|cffffff80获得|cffff0080“"+GetMonsterSoulLuck(ran)+"”|cffffff80！|r")
            UnitAddEffectSetSize(Pu[1],"effect_hero_levelup.mdx",3)
        elseif  itid == 'IZ0F'
            HeroAddAbilityByIndex(Pu[1],4,'S230'+GetRandomInt(0,7))
            for num = 1,3
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r|cffffff80恭喜"+GetPlayerNameOfColor(pid)+"|cffffff80觉醒了|cffff0080“[R]技能”|cffffff80！|r")
            end
            GivePlayerMissionPrize(pid,'RR0A')
        endif
    endfunction

endlibrary 
