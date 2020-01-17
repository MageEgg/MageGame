library GameChallenge5 uses GameChallengeBase

    function GameChallenge_5Flush(int pid,real time)
        SetUnitVertexColor(GameChallengUnit[50],255,255,255,0)
        SetUnitVertexColor(GameChallengUnit[51],255,255,255,0)
        GameChallengInt[50] = 0
        if  GameChallengUnit[59] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[59]))
            RemoveUnit(GameChallengUnit[59])
            GameChallengUnit[59] = null
        endif
        GameChallenge_GlobalFlush(pid,time)
    endfunction

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
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = 16
                        y = 4640
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf55',x,y,270)
                        SetUnitOverStateOfGameChalleng(pid,GameChallengUnit[num],2)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                        SetPlayerTaskUIChatOfPlayer(pid,"剧情","土行孙归营！！！",0)
                    endif
                elseif  time == 2
                    SetUnitPositionOfGameChalleng(GameChallengUnit[num],x,4300)
                    SetPlayerTaskUIChatOfPlayer(pid,"土行孙","来者何人！！！敢私探吾营，是自送死期！！！",0)
                elseif  time == 3
                    SetUnitOwner(GameChallengUnit[num],Player(pid+4),true)
                    SetUnitColor(GameChallengUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
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
        GameChallenge_5Flush(pid,-1)
        ShowPlayerTaskUIOfPlayer(pid,true,0.01)
        SetPlayerAllianceVISION(pid,false)
        if  ty == 0
            x = -512
            y = 3936
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 5
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[50],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[51],UnitAPOfPlayer)
            SetPlayerTaskUIChatOfPlayer(pid,"任务","前往姜子牙",0.3)
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff前往姜子牙|r",0.3)
        elseif  ty == 1
            x = 16
            y = 3968
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 5
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            GameChallengInt[50] = 100
            GameChallenge_5_BTimer(pid)
        endif
    endfunction

    function EnRctGameChalleng_5_Way0()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  GameChallengUnit[59] == null and GameChallengInt[50] == 0 and IsFinshChallenge(5) == false and IsPlayerInChallenge == true
                    SetUnitVertexColor(GameChallengUnit[50],255,255,255,0)
                    SetUnitVertexColor(GameChallengUnit[51],255,255,255,0)
                    GameChallengUnit[59] = CreateUnit(Player(9),'np07',GetUnitX(Pu[1]),GetUnitY(Pu[1]),180)
                    ShowUnitOfOnlyPlayer(pid,GameChallengUnit[59],UnitAPOfPlayer)
                    UnitAddAbility(GameChallengUnit[59],'AZ99')
                    SetUnitAbilityLevel(GameChallengUnit[59],'AZ99',pid+1)
                    IssuePointOrderById(GameChallengUnit[59],851983,GetUnitX(GameChallengUnit[52]),GetUnitY(GameChallengUnit[52]))
                    SetPlayerTaskUIChatOfPlayer(pid,"姜子牙","土行孙这绳有古怪，快救我回营！",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff解救姜子牙|r",0)
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
        SetUnitFaceOfUnit(u1,Pu[1])
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

    function Challeng_5_WayB_End(int id)
        int pid = id
        TimerStart(1,false)
        {
            if  IsPlayerInChallenge == true
                if  GameChallengOperaWay[5] == 0
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","此时，惧留孙及时赶到。",0)
                    if  GetGameChallengOperaSelsect() == 0
                        GameChallengOperaWay[5] = 1
                        SetLeagueUnit(5,true)
                        SetPlayerTaskUIChatOfPlayer(pid,"惧留孙","道兄请留孽徒一命，子牙后有用他之处，可助西岐一臂之力。",1)
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-土行孙归伏]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00土行孙加入己方阵营！|r")   
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-土行孙归伏]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00土行孙加入己方阵营！|r")  
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-土行孙归伏]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00土行孙加入己方阵营！|r")                                 
                    else
                        GameChallengOperaWay[5] = 2
                        SetLeagueUnit(5,false)
                        SetPlayerTaskUIChatOfPlayer(pid,"剧情","你失手杀死了土行孙，惧留孙后以仙丹将其复活。",1)
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-土行孙归伏]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000土行孙加入敌方阵营！|r")   
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-土行孙归伏]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000土行孙加入敌方阵营！|r") 
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-土行孙归伏]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000土行孙加入敌方阵营！|r") 
                    endif
                endif
                GameChallenge_5Flush(pid,2)
                PlayerChallengeCosNum = PlayerChallengeCosNum + 1
                //奖励
                PlayerFinishPlotEx(pid,5)
            endif
            endtimer
            flush locals
        }
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
            endif
        elseif  uid == 'uf52'
            GameChallengInt[50] = GameChallengInt[50] + 1
            if  GameChallengInt[50] == 10
                GameChallengInt[50] = 0
                RemoveChainOfUnit(pid)
                IssuePointOrderById(GameChallengUnit[59],851983,GetUnitX(GameChallengUnit[54]),GetUnitY(GameChallengUnit[54]))
            endif
        elseif  uid == 'uf53' or uid == 'uf54'
            GameChallengInt[50] = GameChallengInt[50] + 1
            if  GameChallengInt[50] == 14
                RemoveChainOfUnit(pid)
                IssuePointOrderById(GameChallengUnit[59],851983,GetUnitX(GameChallengUnit[55]),GetUnitY(GameChallengUnit[55]))
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
                    SetUnitOwner(GameChallengUnit[unitcos[k]],Player(pid+4),true)
                    SetUnitColor(GameChallengUnit[unitcos[k]],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                    IssuePointOrderById(GameChallengUnit[unitcos[k]],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
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
                            x1 = x + GetRandomReal(-150,150)
                            y1 = y + GetRandomReal(-150,150)
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
                            x1 = x + GetRandomReal(-150,150)
                            y1 = y + GetRandomReal(-150,150)
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
                            x1 = x + GetRandomReal(-150,150)
                            y1 = y + GetRandomReal(-150,150)
                            CreateUsesGameChallengUnitExOfAng(pid,num,'uf53',x1,y1,Atan2(GetUnitY(Pu[1])-y1,GetUnitX(Pu[1])-x1)/0.01745)
                            UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                            UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                            SetUnitAnimation(GameChallengUnit[num],"attack")
                        endif
                    end
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        unitcos[13] = num
                        x1 = x + GetRandomReal(-150,150)
                        y1 = y + GetRandomReal(-150,150)
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf54',x1,y1,Atan2(GetUnitY(Pu[1])-y1,GetUnitX(Pu[1])-x1)/0.01745)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
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
            if  u1 == GameChallengUnit[59]
                if  GameChallengInt[50] == 14
                    GameChallengInt[50] = 0
                    SetPlayerTaskUIChatOfPlayer(pid,"白鹤童子","师叔，老爷法牒，送符印将此绳解去。",0)
                    SetPlayerTaskUIChatOfPlayer(pid,"姜子牙","谢老师慈悯。",1)
                    GameChallenge_5Flush(pid,2)
                    IsFinshChallenge(5) = true
                    //奖励
                    PlayerFinishPlotEx(pid,5)
                endif
            endif
        endif
        flush locals
    endfunction

    function InitGameChallenge_5()

        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengUnit[50] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np07',-64,3840,180)
                SetUnitVertexColor(GameChallengUnit[50],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[50],0x01)
                GameChallengUnit[51] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ07',-64,3840,0)
                SetUnitVertexColor(GameChallengUnit[51],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[51],0x01)
                GameChallengUnit[52] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-640,3840,0)
                SetUnitVertexColor(GameChallengUnit[52],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[52],0x01)
                GameChallengUnit[53] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-1216,3552,0)
                SetUnitVertexColor(GameChallengUnit[53],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[53],0x01)
                GameChallengUnit[54] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-1568,3200,0)
                SetUnitVertexColor(GameChallengUnit[54],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[54],0x01)
                GameChallengUnit[55] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-2080,2688,0)
                SetUnitVertexColor(GameChallengUnit[55],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[55],0x01)
            endif
        end

        CreateTrigUnitInRangeOfGameChallenge(-64,3840,150,function EnRctGameChalleng_5_Way0)
        CreateTrigUnitInRangeOfGameChallenge(-640,3840,150,function EnRctGameChalleng_5_Way1)
        CreateTrigUnitInRangeOfGameChallenge(-1216,3552,150,function EnRctGameChalleng_5_Way2)
        CreateTrigUnitInRangeOfGameChallenge(-1568,3200,150,function EnRctGameChalleng_5_Way3)
        CreateTrigUnitInRangeOfGameChallenge(-2080,2688,150,function EnRctGameChalleng_5_Way4)

    endfunction

endlibrary
