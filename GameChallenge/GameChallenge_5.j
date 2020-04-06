library GameChallenge5 uses GameChallengeBase

    function GameChallenge_5_BTimer(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengeUnitID(pid)
                    if  num != 0
                        x = 16
                        y = 4640
                        CreateUsesGameChallengeUnitExOfAng(pid,num,'uf55',x,y,270)
                        SetUnitOverStateOfGameChalleng(pid,GameChallengeUnit[num],2)
                        UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
                        UnitAddEffectSetSize(GameChallengeUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengeUnit[num],"attack")
                        SetPlayerTaskUIChatOfPlayer(pid,"剧情","土行孙归营！！！",0)
                    endif
                elseif  time == 2
                    SetUnitPositionOfGameChalleng(GameChallengeUnit[num],x,4300)
                    SetPlayerTaskUIChatOfPlayer(pid,"土行孙","来者何人！！！敢私探吾营，是自送死期！！！",0)
                elseif  time == 3
                    SetUnitOwner(GameChallengeUnit[num],Player(pid+4),true)
                    SetUnitColor(GameChallengeUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                    IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击败土行孙|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function OpenGameChallenge_5(int pid,int ty)
        real x = 0
        real y = 0
        GameChallengeFluahAll(pid,-1)
        ShowPlayerTaskUIOfPlayer(pid,true,0.01)
        SetPlayerAllianceVISION(pid,false)
        if  ty == 0
            x = -512
            y = 3936
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 5
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[50],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[51],UnitAPOfPlayer)
            SetPlayerTaskUIChatOfPlayer(pid,"任务","前往姜子牙",0.3)
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff前往姜子牙|r",0.3)
        elseif  ty == 1
            x = 16
            y = 3968
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 5
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            GameChallengeInt[50] = 100
            GameChallenge_5_BTimer(pid)
        endif
    endfunction

    function EnRctGameChalleng_5_GoWayTimer(unit wu,real x,real y)
        unit u1 = wu
        real x1 = x
        real y1 = y
        TimerStart(0.8,false)
        {
            IssuePointOrderById(u1,851983,x1,y1)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function EnRctGameChalleng_5_Way0()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  GameChallengeUnit[59] == null and GameChallengeInt[50] == 0 and IsFinshChallenge(5) == false and IsPlayerInChallenge == true
                    SetUnitVertexColor(GameChallengeUnit[50],255,255,255,0)
                    SetUnitVertexColor(GameChallengeUnit[51],255,255,255,0)
                    GameChallengeUnit[59] = CreateUnit(Player(9),'np07',GetUnitX(Pu[1]),GetUnitY(Pu[1]),180)
                    ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[59],UnitAPOfPlayer)
                    UnitAddAbility(GameChallengeUnit[59],'AZ99')
                    SetUnitAbilityLevel(GameChallengeUnit[59],'AZ99',pid+1)
                    IssuePointOrderById(GameChallengeUnit[59],851983,GetUnitX(GameChallengeUnit[52]),GetUnitY(GameChallengeUnit[52]))
                    //EnRctGameChalleng_5_EndWayTimer(GameChallengeUnit[59])
                    SetPlayerTaskUIChatOfPlayer(pid,"姜子牙","土行孙这绳有古怪，快救我回营！",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff解救姜子牙|r",0)
                endif
            endif
        endif
        flush locals
    endfunction

    function RemoveChainOfUnit(int pid)
        for k = 0,3
            RemoveUnit(GameChallengeUnit[unitcos[100+k]])
            GameChallengeUnit[unitcos[100+k]] = null
            unitcos[100+k] = 0
        end
    endfunction

    function CreateChainOfUnit(int pid,unit wu)
        unit u1 = wu
        real x = GetUnitX(u1)
        real y = GetUnitY(u1)
        int num = 0
        IssueImmediateOrderById(u1,851993)
        SetUnitFaceOfUnit(u1,Pu[1])
        num = GetCanUsesGameChallengeUnitID(pid)
        if  num != 0
            unitcos[100] = num
            CreateUsesGameChallengeUnitExOfAng(pid,num,'e00D',x+100,y,90)
            UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
        endif
        num = GetCanUsesGameChallengeUnitID(pid)
        if  num != 0
            unitcos[101] = num
            CreateUsesGameChallengeUnitExOfAng(pid,num,'e00D',x-100,y,90)
            UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
        endif
        num = GetCanUsesGameChallengeUnitID(pid)
        if  num != 0
            unitcos[102] = num
            CreateUsesGameChallengeUnitExOfAng(pid,num,'e00D',x,y+100,0)
            UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
        endif
        num = GetCanUsesGameChallengeUnitID(pid)
        if  num != 0
            unitcos[103] = num
            CreateUsesGameChallengeUnitExOfAng(pid,num,'e00D',x,y-100,0)
            UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
        endif
        flush locals
    endfunction

    function Challeng_5_WayB_End(int id)
        int pid = id
        TimerStart(1,false)
        {
            if  IsPlayerInChallenge == true
                if  GameChallengeOperaWay[5] == 0
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","此时，惧留孙及时赶到。",0)
                    if  GetGameChallengOperaSelsect() == 0
                        GameChallengeOperaWay[5] = 1
                        SetLeagueUnit(5,true)
                        SetPlayerTaskUIChatOfPlayer(pid,"惧留孙","道兄请留孽徒一命，子牙后有用他之处，可助西岐一臂之力。",1)
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-土行孙归伏]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00土行孙加入己方阵营！|r")   
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-土行孙归伏]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00土行孙加入己方阵营！|r")  
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-土行孙归伏]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00土行孙加入己方阵营！|r")                                 
                    else
                        GameChallengeOperaWay[5] = 2
                        SetLeagueUnit(5,false)
                        SetPlayerTaskUIChatOfPlayer(pid,"剧情","你失手杀死了土行孙，惧留孙后以仙丹将其复活。",1)
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-土行孙归伏]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000土行孙加入敌方阵营！|r")   
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-土行孙归伏]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000土行孙加入敌方阵营！|r") 
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-土行孙归伏]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000土行孙加入敌方阵营！|r") 
                    endif
                endif
                GameChallengeFluahAll(pid,1)
                PlayerChallengeOverCosNum = PlayerChallengeOverCosNum + 1
                PlayerChallengeTimeCosNum(5) = PlayerChallengeTimeCosNum(5) + 1
                //奖励
                PlayerFinishPlotEx(pid,5)

                if  GetUnitTypeId(Pu[1]) == 'H002' //彩蛋
                    if  DzPlayerLv(Player(pid)) >= 4
                        if  GameLevel >= 2
                            if  GetRandomReal(0,1) <= 0.6
                                if  GetPlayerTechCount(Player(pid),'RDAM',true) == 0
                                    SetDzPlayerData(pid,15,13,13)
                                    SetPlayerTechResearchedEx(Player(pid),'RDAM')
                                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000我自己来|r（永久存档）！")
                                endif
                            else
                                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000我自己来|r，但可惜运气太差了没激活存档！")
                            endif
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000我自己来|r，但可惜难度不够要求！")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000我自己来|r，但可惜地图等级不够要求！")
                    endif
                endif
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_5_WayDeath(int pid,unit u2)
        int uid = GetUnitTypeId(u2)
        GameChallengeUnit[R2I(GetUnitRealState(u2,99))] = null
        if  uid == 'uf51'
            GameChallengeInt[50] = GameChallengeInt[50] + 1
            if  GameChallengeInt[50] == 7
                GameChallengeInt[50] = 0
                RemoveChainOfUnit(pid)
                IssuePointOrderById(GameChallengeUnit[59],851983,GetUnitX(GameChallengeUnit[53]),GetUnitY(GameChallengeUnit[53]))
                EnRctGameChalleng_5_GoWayTimer(GameChallengeUnit[59],GetUnitX(GameChallengeUnit[53]),GetUnitY(GameChallengeUnit[53]))
            endif
        elseif  uid == 'uf52'
            GameChallengeInt[50] = GameChallengeInt[50] + 1
            if  GameChallengeInt[50] == 10
                GameChallengeInt[50] = 0
                RemoveChainOfUnit(pid)
                IssuePointOrderById(GameChallengeUnit[59],851983,GetUnitX(GameChallengeUnit[54]),GetUnitY(GameChallengeUnit[54]))
                EnRctGameChalleng_5_GoWayTimer(GameChallengeUnit[59],GetUnitX(GameChallengeUnit[54]),GetUnitY(GameChallengeUnit[54]))
            endif
        elseif  uid == 'uf53' or uid == 'uf54'
            GameChallengeInt[50] = GameChallengeInt[50] + 1
            if  GameChallengeInt[50] == 14
                RemoveChainOfUnit(pid)
                IssuePointOrderById(GameChallengeUnit[59],851983,GetUnitX(GameChallengeUnit[55]),GetUnitY(GameChallengeUnit[55]))
                EnRctGameChalleng_5_GoWayTimer(GameChallengeUnit[59],GetUnitX(GameChallengeUnit[55]),GetUnitY(GameChallengeUnit[55]))
            endif
        elseif  uid == 'uf55'
            SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功击败土行孙！！！",0)
            Challeng_5_WayB_End(pid)
        endif
    endfunction

    function EnRctGameChalleng_5_WayTimer(int id,int n)
        int pid = id
        int cos = n
        TimerStart(1,false)
        {
            if  IsPlayerInChallenge == true
                for k = 1,cos
                    SetUnitOwner(GameChallengeUnit[unitcos[k]],Player(pid+4),true)
                    SetUnitColor(GameChallengeUnit[unitcos[k]],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                    IssuePointOrderById(GameChallengeUnit[unitcos[k]],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                end
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
            if  u1 == GameChallengeUnit[59]
                if  GameChallengeInt[50] == 0
                    GameChallengeInt[50] = 1
                    x = GetUnitX(GameChallengeUnit[52])+80
                    y = GetUnitY(GameChallengeUnit[52])+80
                    SetUnitPositionOfGameChalleng(u1,x,y)
                    CreateChainOfUnit(pid,u1)
                    for k = 1,6
                        num = GetCanUsesGameChallengeUnitID(pid)
                        if  num != 0
                            unitcos[k] = num
                            x1 = x + GetRandomReal(-150,150)
                            y1 = y + GetRandomReal(-150,150)
                            CreateUsesGameChallengeUnitExOfAng(pid,num,'uf51',x1,y1,Atan2(GetUnitY(Pu[1])-y1,GetUnitX(Pu[1])-x1)/0.01745)
                            UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
                            UnitAddEffectSetSize(GameChallengeUnit[num],"effect_az-leiji.mdx",2)
                            SetUnitAnimation(GameChallengeUnit[num],"attack")
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
            if  u1 == GameChallengeUnit[59]
                if  GameChallengeInt[50] == 0
                    GameChallengeInt[50] = 1
                    x = GetUnitX(GameChallengeUnit[53])+80
                    y = GetUnitY(GameChallengeUnit[53])+80
                    SetUnitPositionOfGameChalleng(u1,x,y)
                    CreateChainOfUnit(pid,u1)
                    for k = 1,9
                        num = GetCanUsesGameChallengeUnitID(pid)
                        if  num != 0
                            unitcos[k] = num
                            x1 = x + GetRandomReal(-150,150)
                            y1 = y + GetRandomReal(-150,150)
                            CreateUsesGameChallengeUnitExOfAng(pid,num,'uf52',x1,y1,Atan2(GetUnitY(Pu[1])-y1,GetUnitX(Pu[1])-x1)/0.01745)
                            UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
                            UnitAddEffectSetSize(GameChallengeUnit[num],"effect_az-leiji.mdx",2)
                            SetUnitAnimation(GameChallengeUnit[num],"attack")
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
            if  u1 == GameChallengeUnit[59]
                if  GameChallengeInt[50] == 0
                    GameChallengeInt[50] = 1
                    x = GetUnitX(GameChallengeUnit[54])+80
                    y = GetUnitY(GameChallengeUnit[54])+80
                    SetUnitPositionOfGameChalleng(u1,x,y)
                    CreateChainOfUnit(pid,u1)
                    for k = 1,12
                        num = GetCanUsesGameChallengeUnitID(pid)
                        if  num != 0
                            unitcos[k] = num
                            x1 = x + GetRandomReal(-150,150)
                            y1 = y + GetRandomReal(-150,150)
                            CreateUsesGameChallengeUnitExOfAng(pid,num,'uf53',x1,y1,Atan2(GetUnitY(Pu[1])-y1,GetUnitX(Pu[1])-x1)/0.01745)
                            UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
                            UnitAddEffectSetSize(GameChallengeUnit[num],"effect_az-leiji.mdx",2)
                            SetUnitAnimation(GameChallengeUnit[num],"attack")
                        endif
                    end
                    num = GetCanUsesGameChallengeUnitID(pid)
                    if  num != 0
                        unitcos[13] = num
                        x1 = x + GetRandomReal(-150,150)
                        y1 = y + GetRandomReal(-150,150)
                        CreateUsesGameChallengeUnitExOfAng(pid,num,'uf54',x1,y1,Atan2(GetUnitY(Pu[1])-y1,GetUnitX(Pu[1])-x1)/0.01745)
                        UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
                        UnitAddEffectSetSize(GameChallengeUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengeUnit[num],"attack")
                    endif
                    EnRctGameChalleng_5_WayTimer(pid,13)
                endif
            endif
        endif
        flush locals
    endfunction

    function EnRctGameChalleng_5_Way4()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengeUnit[59]
                if  GameChallengeInt[50] == 14
                    GameChallengeInt[50] = 0
                    SetPlayerTaskUIChatOfPlayer(pid,"白鹤童子","师叔，老爷法牒，送符印将此绳解去。",0)
                    SetPlayerTaskUIChatOfPlayer(pid,"姜子牙","谢老师慈悯。",1)
                    GameChallengeFluahAll(pid,1)
                    IsFinshChallenge(5) = true
                    //奖励
                    PlayerFinishPlotEx(pid,5)

                    /*if  GetUnitTypeId(Pu[1]) == 'H011' //彩蛋
                        if  DzPlayerLv(Player(pid)) >= 6
                            if  GameLevel >= 3
                                if  GetPlayerTechCount(Player(pid),'RDAE',true) == 0
                                    SetDzPlayerData(pid,15,5,5)
                                    SetPlayerTechResearchedEx(Player(pid),'RDAE')
                                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000我救我自己|r（永久存档）！")
                                endif
                            else
                                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000我救我自己|r，但可惜难度不够要求！")
                            endif
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000我救我自己|r，但可惜地图等级不够要求！")
                        endif
                    endif*/
                    if  GetUnitTypeId(Pu[1]) == 'H002' //彩蛋
                        if  DzPlayerLv(Player(pid)) >= 2
                            if  GetPlayerTechCount(Player(pid),'RDAL',true) == 0
                                SetDzPlayerData(pid,15,12,12)
                                SetPlayerTechResearchedEx(Player(pid),'RDAL')
                                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000抓了再救|r（永久存档）！")
                            endif
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000抓了再救|r，但可惜地图等级不够要求！")
                        endif
                    endif
                endif
            endif
        endif
        flush locals
    endfunction

    function InitGameChallenge_5()

        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengeUnit[50] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np07',-64,3840,180)
                SetUnitVertexColor(GameChallengeUnit[50],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[50],0x01)
                GameChallengeUnit[51] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ07',-64,3840,0)
                SetUnitVertexColor(GameChallengeUnit[51],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[51],0x01)
                GameChallengeUnit[52] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-640,3840,0)
                SetUnitVertexColor(GameChallengeUnit[52],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[52],0x01)
                GameChallengeUnit[53] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-1216,3552,0)
                SetUnitVertexColor(GameChallengeUnit[53],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[53],0x01)
                GameChallengeUnit[54] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-1568,3200,0)
                SetUnitVertexColor(GameChallengeUnit[54],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[54],0x01)
                GameChallengeUnit[55] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-2080,2688,0)
                SetUnitVertexColor(GameChallengeUnit[55],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[55],0x01)
            endif
        end

        CreateTrigUnitInRangeOfGameChallenge(-64,3840,150,function EnRctGameChalleng_5_Way0)
        CreateTrigUnitInRangeOfGameChallenge(-640,3840,150,function EnRctGameChalleng_5_Way1)
        CreateTrigUnitInRangeOfGameChallenge(-1216,3552,150,function EnRctGameChalleng_5_Way2)
        CreateTrigUnitInRangeOfGameChallenge(-1568,3200,150,function EnRctGameChalleng_5_Way3)
        CreateTrigUnitInRangeOfGameChallenge(-2080,2688,150,function EnRctGameChalleng_5_Way4)

    endfunction

endlibrary
