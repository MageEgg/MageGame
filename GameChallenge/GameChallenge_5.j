library GameChallenge5 uses GameChallengeBase

    function GameChallenge_5Flush(int pid)
        SetUnitVertexColor(GameChallengUnit[50],255,255,255,0)
        SetUnitVertexColor(GameChallengUnit[51],255,255,255,0)
        GameChallengInt[50] = 0
        if  GameChallengUnit[59] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[59]))
            RemoveUnit(GameChallengUnit[59])
            GameChallengUnit[59] = null
        endif
        GameChallengCanUsesUnitFlush(pid)
        ShowUnitOfAllPlayer(Pu[1])
        RemoveUnit(PlayerInChallengeShowUnit)
        PlayerInChallengeShowUnit = null
        PlayerInChallengeNumber = 0
        IsPlayerInChallenge = false
    endfunction

    function OpenGameChallenge_5(int pid,int ty)
        real x = 0
        real y = 0
        GameChallenge_5Flush(pid)
        if  ty == 0
            x = -512
            y = 3936
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 5
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[50],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[51],UnitAPOfPlayer)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff前往姜子牙|r")
        elseif  ty == 1
            x = -1728
            y = -896
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 5
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r天仙赵公明助闻太师攻打西岐，神秘大能-陆压传子牙“钉头七箭书”应对。")
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff前往姜子牙|r")
        endif
    endfunction

    function EnRctGameChalleng_5_Way0()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  GameChallengUnit[59] == null and IsFinshChallenge(5) == false and IsPlayerInChallenge == true
                    SetUnitVertexColor(GameChallengUnit[50],255,255,255,0)
                    SetUnitVertexColor(GameChallengUnit[51],255,255,255,0)
                    GameChallengUnit[59] = CreateUnit(Player(9),'np07',GetUnitX(Pu[1]),GetUnitY(Pu[1]),180)
                    ShowUnitOfOnlyPlayer(pid,GameChallengUnit[59],UnitAPOfPlayer)
                    UnitAddAbility(GameChallengUnit[59],'AZ99')
                    SetUnitAbilityLevel(GameChallengUnit[59],'AZ99',pid+1)
                    IssuePointOrderById(GameChallengUnit[59],851983,GetUnitX(GameChallengUnit[52]),GetUnitY(GameChallengUnit[52]))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[姜子牙]：|r土行孙这绳有古怪，快救我回营！")
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff解救姜子牙|r")
                endif
            endif
        endif
        flush locals
    endfunction

    function RemoveChainOfUnit(int pid)
        for k = 0,3
            RemoveUnit(GameChallengUnit[unitcos[100+k]])
            GameChallengUnit[unitcos[100+k]] = null
            unitcos[100+k] = 0
        end
    endfunction

    function CreateChainOfUnit(int pid,unit wu)
        unit u1 = wu
        real x = GetUnitX(u1)
        real y = GetUnitY(u1)
        int num = 0
        IssueImmediateOrderById(u1,851993)
        num = GetCanUsesGameChallengUnitID(pid)
        if  num != 0
            unitcos[100] = num
            CreateUsesGameChallengUnitExOfAng(pid,num,'e00D',x+100,y,90)
            UnitAddEffectOfGameChalleng(GameChallengUnit[num])
        endif
        num = GetCanUsesGameChallengUnitID(pid)
        if  num != 0
            unitcos[101] = num
            CreateUsesGameChallengUnitExOfAng(pid,num,'e00D',x-100,y,90)
            UnitAddEffectOfGameChalleng(GameChallengUnit[num])
        endif
        num = GetCanUsesGameChallengUnitID(pid)
        if  num != 0
            unitcos[102] = num
            CreateUsesGameChallengUnitExOfAng(pid,num,'e00D',x,y+100,0)
            UnitAddEffectOfGameChalleng(GameChallengUnit[num])
        endif
        num = GetCanUsesGameChallengUnitID(pid)
        if  num != 0
            unitcos[103] = num
            CreateUsesGameChallengUnitExOfAng(pid,num,'e00D',x,y-100,0)
            UnitAddEffectOfGameChalleng(GameChallengUnit[num])
        endif
        flush locals
    endfunction

    function GameChalleng_5_WayDeath(int pid,unit u2)
        int uid = GetUnitTypeId(u2)
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        if  uid == 'uf51'
            GameChallengInt[50] = GameChallengInt[50] + 1
            if  GameChallengInt[50] == 7
                GameChallengInt[50] = 0
                RemoveChainOfUnit(pid)
                IssuePointOrderById(GameChallengUnit[59],851983,GetUnitX(GameChallengUnit[53]),GetUnitY(GameChallengUnit[53]))
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff解救姜子牙|r")
            endif
        elseif  uid == 'uf52'
            GameChallengInt[50] = GameChallengInt[50] + 1
            if  GameChallengInt[50] == 10
                GameChallengInt[50] = 0
                RemoveChainOfUnit(pid)
                IssuePointOrderById(GameChallengUnit[59],851983,GetUnitX(GameChallengUnit[54]),GetUnitY(GameChallengUnit[54]))
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff解救姜子牙|r")
            endif
        elseif  uid == 'uf53'
            GameChallengInt[50] = GameChallengInt[50] + 1
            if  GameChallengInt[50] == 13
                RemoveChainOfUnit(pid)
                IssuePointOrderById(GameChallengUnit[59],851983,GetUnitX(GameChallengUnit[55]),GetUnitY(GameChallengUnit[55]))
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff解救姜子牙|r")
            endif
        endif
    endfunction

    function EnRctGameChalleng_5_WayTimer(int id,int n)
        int pid = id
        int cos = n
        TimerStart(1,false)
        {
            if  IsPlayerInChallenge == true
                for k = 1,cos
                    SetUnitOwner(GameChallengUnit[unitcos[k]],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                    IssuePointOrderById(GameChallengUnit[unitcos[k]],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                end
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff解救姜子牙|r")
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function EnRctGameChalleng_5_Way1()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        int num = 0
        real x = 0
        real y = 0
        real x1 = 0
        real y1 = 0
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengUnit[59]
                if  GameChallengInt[50] == 0
                    GameChallengInt[50] = 1
                    x = GetUnitX(GameChallengUnit[52])+80
                    y = GetUnitY(GameChallengUnit[52])+80
                    SetUnitPositionOfGameChalleng(u1,x,y)
                    CreateChainOfUnit(pid,u1)
                    for k = 1,6
                        num = GetCanUsesGameChallengUnitID(pid)
                        if  num != 0
                            unitcos[k] = num
                            x1 = x + GetRandomReal(-350,350)
                            y1 = y + GetRandomReal(-350,350)
                            CreateUsesGameChallengUnitExOfAng(pid,num,'uf51',x1,y1,Atan2(GetUnitY(Pu[1])-y1,GetUnitX(Pu[1])-x1)/0.01745)
                            UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                            UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                            SetUnitAnimation(GameChallengUnit[num],"attack")
                        endif
                    end
                    EnRctGameChalleng_5_WayTimer(pid,6)
                endif
            endif
        endif
        flush locals
    endfunction

    function EnRctGameChalleng_5_Way2()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        int num = 0
        real x = 0
        real y = 0
        real x1 = 0
        real y1 = 0
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengUnit[59]
                if  GameChallengInt[50] == 0
                    GameChallengInt[50] = 1
                    x = GetUnitX(GameChallengUnit[53])+80
                    y = GetUnitY(GameChallengUnit[53])+80
                    SetUnitPositionOfGameChalleng(u1,x,y)
                    CreateChainOfUnit(pid,u1)
                    for k = 1,9
                        num = GetCanUsesGameChallengUnitID(pid)
                        if  num != 0
                            unitcos[k] = num
                            x1 = x + GetRandomReal(-350,350)
                            y1 = y + GetRandomReal(-350,350)
                            CreateUsesGameChallengUnitExOfAng(pid,num,'uf52',x1,y1,Atan2(GetUnitY(Pu[1])-y1,GetUnitX(Pu[1])-x1)/0.01745)
                            UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                            UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                            SetUnitAnimation(GameChallengUnit[num],"attack")
                        endif
                    end
                    EnRctGameChalleng_5_WayTimer(pid,9)
                endif
            endif
        endif
        flush locals
    endfunction

    function EnRctGameChalleng_5_Way3()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        int num = 0
        real x = 0
        real y = 0
        real x1 = 0
        real y1 = 0
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengUnit[59]
                if  GameChallengInt[50] == 0
                    GameChallengInt[50] = 1
                    x = GetUnitX(GameChallengUnit[54])+80
                    y = GetUnitY(GameChallengUnit[54])+80
                    SetUnitPositionOfGameChalleng(u1,x,y)
                    CreateChainOfUnit(pid,u1)
                    for k = 1,12
                        num = GetCanUsesGameChallengUnitID(pid)
                        if  num != 0
                            unitcos[k] = num
                            x1 = x + GetRandomReal(-350,350)
                            y1 = y + GetRandomReal(-350,350)
                            CreateUsesGameChallengUnitExOfAng(pid,num,'uf53',x1,y1,Atan2(GetUnitY(Pu[1])-y1,GetUnitX(Pu[1])-x1)/0.01745)
                            UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                            UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                            SetUnitAnimation(GameChallengUnit[num],"attack")
                        endif
                    end
                    EnRctGameChalleng_5_WayTimer(pid,12)
                endif
            endif
        endif
        flush locals
    endfunction

    function EnRctGameChalleng_5_Way4()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengUnit[59]
                if  GameChallengInt[50] == 13
                    GameChallengInt[50] = 0
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[白鹤童子]：|r师叔，老爷法牒，送符印将此绳解去。")
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[姜子牙]：|r谢老师慈悯。")
                    GameChallenge_5Flush(pid)
                    IsFinshChallenge(5) = true
                    //奖励
                    PlayerFinishPlotEx(pid,5)
                endif
            endif
        endif
        flush locals
    endfunction

    function InitGameChallenge_5()
        trigger tig = null
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengUnit[50] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np07',-64,3840,180)
                SetUnitVertexColor(GameChallengUnit[50],255,255,255,0)
                GameChallengUnit[51] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e007',-64,3840,0)
                SetUnitVertexColor(GameChallengUnit[51],255,255,255,0)

                GameChallengUnit[52] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-640,3840,0)
                SetUnitVertexColor(GameChallengUnit[52],255,255,255,0)
                GameChallengUnit[53] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-1216,3552,0)
                SetUnitVertexColor(GameChallengUnit[53],255,255,255,0)
                GameChallengUnit[54] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-1568,3200,0)
                SetUnitVertexColor(GameChallengUnit[54],255,255,255,0)
                GameChallengUnit[55] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-2080,2688,0)
                SetUnitVertexColor(GameChallengUnit[55],255,255,255,0)
            endif
        end
        
        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[50],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_5_Way0)

        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[52],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_5_Way1)

        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[53],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_5_Way2)

        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[54],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_5_Way3)

        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[55],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_5_Way4)

        tig = null
    endfunction

endlibrary
