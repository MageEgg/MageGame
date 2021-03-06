library GameChallenge7 uses GameChallengeBase
    
    function OpenGameChallenge_7_A_Timer(int id)
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
                        x = 2816
                        y = 3584
                        CreateUsesGameChallengeUnitExOfAng(pid,num,'uf70',x,y,270)
                        UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
                        LocAddEffectSetSize(x,y,"effect_az-leiji.mdx",2)
                        LocAddEffectSetSize(x,y,"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengeUnit[num],"attack")
                        SetPlayerTaskUIChatOfPlayer(pid,"剧情","多宝道人登场！！！",0)
                    endif
                elseif  time == 2
                    SetUnitPositionOfGameChalleng(GameChallengeUnit[num],x,3400)
                    SetPlayerTaskUIChatOfPlayer(pid,"多宝道人","哼！尔等再三欺我教门人，今我师尊摆此诛仙阵，你们一个都别想跑！",0)
                elseif  time == 3
                    UnitAddEffectSetSize(GameChallengeUnit[num],"effect_az-leiji.mdx",2)
                    SetUnitOwner(GameChallengeUnit[num],Player(pid+4),true)
                    SetUnitColor(GameChallengeUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                    IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击败多宝道人|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_7_Zhen_1(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        SetPlayerTaskUIChatOfPlayer(pid,"通天教主","广成子曾骂我，和羽毛禽兽相并，不择而教。想来我们都师自鸿钧，元始道兄难道与我不是一本相传？",0)
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    SetPlayerTaskUIChatOfPlayer(pid,"元始天尊","你也别怪广成子。你门下胡为乱作，人言兽行。如今生灵涂炭，你心忍吗？",0)
                elseif  time == 2
                    SetPlayerTaskUIChatOfPlayer(pid,"通天教主","那按你说，你门人有理，连骂我也是该的？我已是摆了此阵，道兄就破吾此阵，便见高下。",0)
                elseif  time == 3
                    num = GetCanUsesGameChallengeUnitID(pid)
                    if  num != 0
                        x = 1504
                        y = 2720
                        CreateUsesGameChallengeUnitExOfAng(pid,num,'uf71',x,y,270)
                        SetUnitOverStateOfGameChalleng(pid,GameChallengeUnit[num],2)
                        UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
                        UnitAddEffectSetSize(GameChallengeUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengeUnit[num],"attack")
                    endif
                elseif  time == 4
                    SetUnitOwner(GameChallengeUnit[num],Player(pid+4),true)
                    SetUnitColor(GameChallengeUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                    IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","摘去诛仙阵第一剑。",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff摘去诛仙阵第一剑|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_7_Zhen_2(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        x = 4064
        y = 2300
        SendPlayerUnitTimer(pid,x,y)
        SetUnitVertexColor(GameChallengeUnit[70],255,255,255,0)
        SetUnitVertexColor(GameChallengeUnit[71],255,255,255,0)
        SetUnitVertexColor(GameChallengeUnit[75],255,255,255,0)
        SetUnitVertexColor(GameChallengeUnit[76],255,255,255,0)
        ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[72],UnitAPOfPlayer)
        UnitAddEffectOfGameChalleng(GameChallengeUnit[72])
        ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[77],UnitAPOfPlayer)
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengeUnitID(pid)
                    if  num != 0
                        x = 4064
                        y = 2528
                        CreateUsesGameChallengeUnitExOfAng(pid,num,'uf72',x,y,270)
                        SetUnitOverStateOfGameChalleng(pid,GameChallengeUnit[num],2)
                        UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
                        UnitAddEffectSetSize(GameChallengeUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengeUnit[num],"attack")
                    endif
                elseif  time == 2
                    SetUnitOwner(GameChallengeUnit[num],Player(pid+4),true)
                    SetUnitColor(GameChallengeUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                    IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","摘去诛仙阵第二剑。",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff摘去诛仙阵第二剑|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_7_Zhen_3(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        x = 4064
        y = 4600
        SendPlayerUnitTimer(pid,x,y)
        SetUnitVertexColor(GameChallengeUnit[72],255,255,255,0)
        SetUnitVertexColor(GameChallengeUnit[77],255,255,255,0)
        ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[73],UnitAPOfPlayer)
        UnitAddEffectOfGameChalleng(GameChallengeUnit[73])
        ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[78],UnitAPOfPlayer)
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengeUnitID(pid)
                    if  num != 0
                        x = 4064
                        y = 4832
                        CreateUsesGameChallengeUnitExOfAng(pid,num,'uf73',x,y,270)
                        SetUnitOverStateOfGameChalleng(pid,GameChallengeUnit[num],2)
                        UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
                        UnitAddEffectSetSize(GameChallengeUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengeUnit[num],"attack")
                    endif
                elseif  time == 2
                    SetUnitOwner(GameChallengeUnit[num],Player(pid+4),true)
                    SetUnitColor(GameChallengeUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                    IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","摘去诛仙阵第三剑。",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff摘去诛仙阵第三剑|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_7_Zhen_4(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        x = 1472
        y = 4650
        SendPlayerUnitTimer(pid,x,y)
        SetUnitVertexColor(GameChallengeUnit[73],255,255,255,0)
        SetUnitVertexColor(GameChallengeUnit[78],255,255,255,0)
        ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[74],UnitAPOfPlayer)
        UnitAddEffectOfGameChalleng(GameChallengeUnit[74])
        ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[79],UnitAPOfPlayer)
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengeUnitID(pid)
                    if  num != 0
                        x = 1472
                        y = 4896
                        CreateUsesGameChallengeUnitExOfAng(pid,num,'uf74',x,y,270)
                        SetUnitOverStateOfGameChalleng(pid,GameChallengeUnit[num],2)
                        UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
                        UnitAddEffectSetSize(GameChallengeUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengeUnit[num],"attack")
                    endif
                elseif  time == 2
                    SetUnitOwner(GameChallengeUnit[num],Player(pid+4),true)
                    SetUnitColor(GameChallengeUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                    IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","摘去诛仙阵第四剑。",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff摘去诛仙阵第四剑|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function OpenGameChallenge_7(int pid,int ty)
        real x = 0
        real y = 0
        GameChallengeFluahAll(pid,-1)
        ShowPlayerTaskUIOfPlayer(pid,true,0.01)
        SetPlayerAllianceVISION(pid,false)
        if  ty == 0
            x = 2816
            y = 3168
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 7
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            OpenGameChallenge_7_A_Timer(pid)
        elseif  ty == 1
            x = 1504
            y = 2336
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 7
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[70],UnitAPOfPlayer)
            UnitAddEffectOfGameChalleng(GameChallengeUnit[70])
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[71],UnitAPOfPlayer)
            UnitAddEffectOfGameChalleng(GameChallengeUnit[71])
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[75],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[76],UnitAPOfPlayer)
            GameChalleng_7_Zhen_1(pid)
        endif
    endfunction

    function GameChallenge_7_Death(int pid,unit u2)
        int uid = GetUnitTypeId(u2)
        GameChallengeUnit[R2I(GetUnitRealState(u2,99))] = null
        if  uid == 'uf70'
            SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功击败多宝道人！！！",0)
            GameChallengeFluahAll(pid,1)
            IsFinshChallenge(7) = true
            //奖励
            PlayerFinishPlotEx(pid,7)
        elseif  uid == 'uf71'
            SetPlayerTaskUIChatOfPlayer(pid,"剧情","绝仙阵已破，速去援助玉鼎真人破阵！",0)
            GameChalleng_7_Zhen_2(pid)
        elseif  uid == 'uf72'
            SetPlayerTaskUIChatOfPlayer(pid,"剧情","陷仙阵已破，速去援助赤精子破阵！",0)
            GameChalleng_7_Zhen_3(pid)
        elseif  uid == 'uf73'
            SetPlayerTaskUIChatOfPlayer(pid,"剧情","戮仙阵已破，速去援助广成子破阵！",0)
            GameChalleng_7_Zhen_4(pid)
        elseif  uid == 'uf74'
            SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功获取四剑！！！",0)
            if  GameChallengeOperaWay[7] == 0
                if  GetGameChallengOperaSelsect() == 0
                    GameChallengeOperaWay[7] = 1
                    SetLeagueUnit(7,true)
                    SetPlayerTaskUIChatOfPlayer(pid,"广成子","诛仙阵已破，我等随子牙取关去罢！",1)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-诛仙阵斗法]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00广成子加入己方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-诛仙阵斗法]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00广成子加入己方阵营！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-诛仙阵斗法]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00广成子加入己方阵营！|r")                                
                else
                    GameChallengeOperaWay[7] = 2
                    SetLeagueUnit(7,false)
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","诛仙阵已破，通天教主趁人不备，收走了广成子。",1)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-诛仙阵斗法]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000广成子加入敌方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-诛仙阵斗法]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000广成子加入敌方阵营！|r") 
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-诛仙阵斗法]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000广成子加入敌方阵营！|r")  
                endif
            endif
            GameChallengeFluahAll(pid,1)
            PlayerChallengeOverCosNum = PlayerChallengeOverCosNum + 1
            PlayerChallengeTimeCosNum(7) = PlayerChallengeTimeCosNum(7) + 1
            //奖励
            PlayerFinishPlotEx(pid,7)
        endif
    endfunction

    function InitGameChallenge_7()
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengeUnit[70] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np17',1760,2848,225)
                SetUnitVertexColor(GameChallengeUnit[70],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[70],0x01)
                GameChallengeUnit[71] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np16',1888,2624,225)
                SetUnitVertexColor(GameChallengeUnit[71],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[71],0x01)
                GameChallengeUnit[72] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np18',4256,2624,225)
                SetUnitVertexColor(GameChallengeUnit[72],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[72],0x01)
                GameChallengeUnit[73] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np16',4256,4864,225)
                SetUnitVertexColor(GameChallengeUnit[73],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[73],0x01)
                GameChallengeUnit[74] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np19',1664,4992,225)
                SetUnitVertexColor(GameChallengeUnit[74],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[74],0x01)
                GameChallengeUnit[75] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ08',1760,2848,0)
                SetUnitVertexColor(GameChallengeUnit[75],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[75],0x01)
                GameChallengeUnit[76] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ08',1888,2624,0)
                SetUnitVertexColor(GameChallengeUnit[76],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[76],0x01)
                GameChallengeUnit[77] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ08',4256,2624,0)
                SetUnitVertexColor(GameChallengeUnit[77],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[77],0x01)
                GameChallengeUnit[78] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ08',4256,4864,0)
                SetUnitVertexColor(GameChallengeUnit[78],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[78],0x01)
                GameChallengeUnit[79] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ08',1664,4992,0)
                SetUnitVertexColor(GameChallengeUnit[79],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[79],0x01)
            endif
        end
    endfunction


endlibrary
