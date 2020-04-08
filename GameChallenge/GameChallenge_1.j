library GameChallenge1 uses GameChallengeBase

    function OpenGameChallenge_1(int pid,int ty)
        real x = 0
        real y = 0
        GameChallengeFluahAll(pid,-1)
        ShowPlayerTaskUIOfPlayer(pid,true,0.01)
        SetPlayerAllianceVISION(pid,false)
        if  ty == 0
            x = GetRectCenterX(gg_rct_ChallengeRct_1_1)
            y = GetRectCenterY(gg_rct_ChallengeRct_1_1)
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 1
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            SetPlayerTaskUIChatOfPlayer(pid,"任务","前往云中子！",0.3)
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff前往云中子|r",0.3)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[10],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[11],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[12],UnitAPOfPlayer)
        elseif  ty == 1
            x = -4544
            y = 896
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 1
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            SetPlayerTaskUIChatOfPlayer(pid,"任务","前往文王姬昌！",0.3)
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff前往文王姬昌|r",0.3)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[14],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[15],UnitAPOfPlayer)
        endif
    endfunction

    function GameChalleng_1_XYDeathTimer(int id)
        int pid = id
        real dis1 = 0
        real dis2 = 0
        IssuePointOrderById(GameChallengeUnit[19],851983,GetUnitX(GameChallengeUnit[13]),GetUnitY(GameChallengeUnit[13]))
        dis1 = Udis(GameChallengeUnit[19],GameChallengeUnit[13])
        TimerStart(0.3,true)
        {
            dis2 = dis1
            dis1 = Udis(GameChallengeUnit[19],GameChallengeUnit[13])
            if  GameChallengeBool[11] == false
                if  dis2 < dis1
                    IssuePointOrderById(GameChallengeUnit[19],851983,GetUnitX(GameChallengeUnit[13]),GetUnitY(GameChallengeUnit[13]))
                endif
            else
                BJDebugMsg("END GameChalleng_1_XYDeathTimer")
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_1_XYDeath(int pid,unit u2)
        if  GameChallengeInt[10] < 20
            GameChallengeUnit[R2I(GetUnitRealState(u2,99))] = null
            GameChallengeInt[10] = GameChallengeInt[10] + 1
            GameChallengeInt[11] = GameChallengeInt[11] - 1
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀小妖|r|n|cffffcc00累积：|r"+I2S(GameChallengeInt[10])+"/20",0)
            if  GameChallengeInt[10] == 1 or ModuloInteger(GameChallengeInt[10],5) == 0
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r击杀护冢小妖("+I2S(GameChallengeInt[10])+"/20)")
            endif
        elseif  GameChallengeInt[10] == 20
            if  GameChallengeBool[10] == false
                GameChallengeBool[10] = true
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r击杀护冢小妖("+I2S(GameChallengeInt[10])+"/20)")
                SetUnitVertexColor(GameChallengeUnit[12],255,255,255,0)
                GameChalleng_1_XYDeathTimer(pid)
                GameChallengeInt[10] = 21
            endif
        endif
    endfunction

    function GameChalleng_1_JLDeathTimer(int id,int n)
        int pid = id
        int num = n
        TimerStart(0.6,false)
        {
            if  IsPlayerInChallenge == true
                SetUnitOwner(GameChallengeUnit[num],Player(pid+4),true)
                SetUnitColor(GameChallengeUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击败雷震子|r",0)
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_1_JLDeath(int id,unit u2)
        int pid = id
        real x = -3936
        real y = -192
        int num = 0
        GameChallengeUnit[R2I(GetUnitRealState(u2,99))] = null
        SetPlayerTaskUIChatOfPlayer(pid,"雷震子","这些兵器都不合适我啊。咦，那两颗红杏好像很好吃的样子！啊！！！我怎么了！！！",0)
        SetUnitPositionOfGameChalleng(GameChallengeUnit[19],x,y)
        RemoveUnitTimer(GameChallengeUnit[19],0.5)
        GameChallengeUnit[19] = null
        TimerStart(0.4,false)
        {
            if  IsPlayerInChallenge == true
                num = GetCanUsesGameChallengeUnitID(pid)
                if  num != 0
                    CreateUsesGameChallengeUnitEx(pid,num,'uf12',x,y)
                    UnitAddEffect(GameChallengeUnit[num],"effect_red-yumao-zhendi-paoxiao.mdx")
                    UnitAddEffect(GameChallengeUnit[num],"effect_by_wood_effect_d2_shadowfiend_shadowraze_1.mdx")
                    SetUnitAnimation(GameChallengeUnit[num],"attack")
                endif
                Sdofplayer(Player(pid),x,y,3)
                GameChalleng_1_JLDeathTimer(pid,num)
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_1_LZZDeath(int pid,unit u2)
        GameChallengeUnit[R2I(GetUnitRealState(u2,99))] = null
        SetPlayerTaskUIChatOfPlayer(pid,"云中子","奇哉！奇哉！福祸相依，待我传你玄妙真仙诀，炼就风雷金刚体！",0)
        SetPlayerTaskUITaskOfPlayer(pid,"",0)
        GameChallengeFluahAll(pid,1)
        IsFinshChallenge(1) = true
        //奖励
        PlayerFinishPlotEx(pid,1)
    endfunction

    function GameChalleng_1_XYTimerEx(int id)
        int pid = id
        TimerStart(0.15,true)
        {   
            int num = 0
            real x = 0
            real y = 0
            /*if  GameChallengeBool[10] == false
                BJDebugMsg("GameChallengeBool[10] FFF"+I2S(GameChallengeInt[10]))
            else
                BJDebugMsg("GameChallengeBool[10] TTT"+I2S(GameChallengeInt[10]))
            endif*/
            if  GameChallengeInt[10] <= 20 and GameChallengeBool[10] == false and IsPlayerInChallenge == true
                num = GetCanUsesGameChallengeUnitID(pid)
                if  num != 0 and GameChallengeInt[11] < 5
                    x = GetUnitX(GameChallengeUnit[19])+GetRandomReal(-150,150)
                    y = GetUnitY(GameChallengeUnit[19])+GetRandomReal(-150,150)
                    if  IsLocInRect(gg_rct_ChallengeRct_1_4,x,y) == true
                        x = -5400+GetRandomReal(-150,150)
                        y = -720+GetRandomReal(-150,150)
                    endif
                    CreateUsesGameChallengeUnit(pid,num,'uf10',x,y)
                    GameChallengeInt[11] = GameChallengeInt[11] + 1
                    IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_1_XYTimer(int id)
        int pid = id
        TimerStart(1,false)
        {
            if  IsPlayerInChallenge == true
                GameChalleng_1_XYTimerEx(pid)
            endif
            endtimer   
            flush locals
        }
        flush locals
    endfunction 


    function EnRctGameChalleng_1_YZZ()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  GameChallengeUnit[19] == null and IsFinshChallenge(1) == false and IsPlayerInChallenge == true
                    SetUnitVertexColor(GameChallengeUnit[11],255,255,255,0)
                    GameChallengeUnit[19] = CreateUnit(Player(9),'np08',GetUnitX(Pu[1]),GetUnitY(Pu[1]),270)
                    ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[19],UnitAPOfPlayer)
                    UnitAddAbility(GameChallengeUnit[19],'AZ99')
                    SetUnitAbilityLevel(GameChallengeUnit[19],'AZ99',pid+1)
                    IssuePointOrderById(GameChallengeUnit[19],851983,GetRectCenterX(gg_rct_ChallengeRct_1_1),GetRectCenterY(gg_rct_ChallengeRct_1_1))
                    SetPlayerTaskUIChatOfPlayer(pid,"云中子","雷震子，你义父有难，到剑冢取一适手兵器前去解救。",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀20个护冢小妖|r",0)
                    GameChalleng_1_XYTimer(pid)
                endif
            endif
        endif
        flush locals
    endfunction

    function FuncEnterRctChallengeRct_1_1()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengeUnit[19]
                IssuePointOrderById(u1,851983,GetRectCenterX(gg_rct_ChallengeRct_1_2),GetRectCenterY(gg_rct_ChallengeRct_1_2))
            endif
        endif
        flush locals
    endfunction

    function FuncEnterRctChallengeRct_1_2()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengeUnit[19]
                IssuePointOrderById(u1,851983,GetRectCenterX(gg_rct_ChallengeRct_1_3),GetRectCenterY(gg_rct_ChallengeRct_1_3))
            endif
        endif
        flush locals
    endfunction

    function FuncEnterRctChallengeRct_1_3()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengeUnit[19]
                BJDebugMsg("gg_rct_ChallengeRct_1_4")
                IssuePointOrderById(u1,851983,GetRectCenterX(gg_rct_ChallengeRct_1_4),GetRectCenterY(gg_rct_ChallengeRct_1_4))
            endif
        endif
        flush locals
    endfunction

    function FuncEnterRctChallengeRct_1_4()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengeUnit[19]
                if  GameChallengeInt[10] < 20
                    SetUnitPosition(u1,GetRectCenterX(gg_rct_ChallengeRct_1_3),GetRectCenterY(gg_rct_ChallengeRct_1_3))
                    IssueImmediateOrderById(u1, 851993 )
                    SetUnitFaceOfUnit(u1,Pu[1])
                endif
            endif
        endif
        flush locals
    endfunction

    function EnRctGameChalleng_1_JLD()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        int num = 0
        real x = 0
        real y = 0
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengeUnit[19]
                GameChallengeBool[11] = true
                IssueImmediateOrderById(u1, 851993 )
                SetUnitFaceOfUnit(u1,Pu[1])
                num = GetCanUsesGameChallengeUnitID(pid)
                if  num != 0
                    x = -4096
                    y = -768
                    CreateUsesGameChallengeUnit(pid,num,'uf11',x,y)
                    IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    Sdofplayer(Player(pid),x,y,3)
                endif
                SetPlayerTaskUIChatOfPlayer(pid,"剧情","击杀剑灵。",0.3)
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀剑灵|r",0)
            endif
        endif
    endfunction

    function GameChalleng_1_JYDeath(int pid,unit u2)
        GameChallengeUnit[R2I(GetUnitRealState(u2,99))] = null
        GameChallengeInt[12] = GameChallengeInt[12] + 1
        if  GameChallengeInt[12] == 2
            GameChallengeInt[12] = 0
            if  GameChallengeOperaWay[1] == 0
                if  GetGameChallengOperaSelsect() == 0
                    GameChallengeOperaWay[1] = 1
                    SetLeagueUnit(1,true)
                    SetPlayerTaskUIChatOfPlayer(pid,"雷震子","追兵已退，我便送父王回西岐。",0)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-半人祸福]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00雷震子加入己方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-半人祸福]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00雷震子加入己方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-半人祸福]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00雷震子加入己方阵营！|r")                                   
                else
                    GameChallengeOperaWay[1] = 2
                    SetLeagueUnit(1,false)
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","糟糕！雷震子怒意攻心，入魔远走了！",0)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-半人祸福]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000雷震子加入敌方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-半人祸福]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000雷震子加入敌方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-半人祸福]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000雷震子加入敌方阵营！|r")   
                endif
            else
                SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功击退殷破败和雷开！！！",0)
            endif
            GameChallengeFluahAll(pid,1)
            PlayerChallengeOverCosNum = PlayerChallengeOverCosNum + 1
            PlayerChallengeTimeCosNum(1) = PlayerChallengeTimeCosNum(1) + 1
            //奖励
            PlayerFinishPlotEx(pid,1)

            if  GetUnitTypeId(Pu[1]) == 'H022' //彩蛋
                if  DzPlayerLv(Player(pid)) >= 6
                    if  GameLevel >= 3
                        if  GetPlayerTechCount(Player(pid),'RDAG',true) == 0
                            SetDzPlayerData(pid,15,7,7)
                            SetPlayerTechResearchedEx(Player(pid),'RDAG')
                            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000爸，我回来了|r（永久存档）！")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000爸，我回来了|r，但可惜难度不够要求！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000爸，我回来了|r，但可惜地图等级不够要求！")
                endif
            endif
        endif
    endfunction

    function EnRctGameChalleng_1_JY()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  GameChallengeUnit[19] == null and IsPlayerInChallenge == true
                    SetUnitVertexColor(GameChallengeUnit[15],255,255,255,0)
                    GameChallengeUnit[19] = CreateUnit(Player(9),'np08',GetUnitX(Pu[1]),GetUnitY(Pu[1]),270)
                    ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[19],UnitAPOfPlayer)
                    UnitAddAbility(GameChallengeUnit[19],'AZ99')
                    SetUnitAbilityLevel(GameChallengeUnit[19],'AZ99',pid+1)
                    IssuePointOrderById(GameChallengeUnit[19],851983,-3776,1472)
                    SetPlayerTaskUIChatOfPlayer(pid,"雷震子","父王，孩儿救你来也，且待我退去追兵！",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff跟随雷震子|r",0)
                endif
            endif
        endif
        flush locals
    endfunction

    function EnRctGameChalleng_1_JY2()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        int num = 0
        real x = 0
        real y = 0
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengeUnit[19]
                x = -4224
                y = 1600
                SetUnitPositionOfGameChalleng(GameChallengeUnit[19],x,y)
                SetPlayerTaskUIChatOfPlayer(pid,"雷震子","纣王今既放归我父王，为何又派你俩来追袭？反复无常，实在可恨！",0)
                IssueImmediateOrderById(GameChallengeUnit[19], 851993 )
                SetUnitFaceOfUnit(GameChallengeUnit[19],Pu[1])
                num = GetCanUsesGameChallengeUnitID(pid)
                if  num != 0
                    x = -3744
                    y = 1664
                    CreateUsesGameChallengeUnit(pid,num,'uf13',x,y)
                    SetUnitOverStateOfGameChalleng(pid,GameChallengeUnit[num],2)
                    IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    Sdofplayer(Player(pid),x,y,3)
                    UnitAddEffect(GameChallengeUnit[num],"effect_red-yumao-zhendi-paoxiao.mdx")
                    UnitAddEffect(GameChallengeUnit[num],"effect_by_wood_effect_d2_shadowfiend_shadowraze_1.mdx")
                    SetUnitAnimation(GameChallengeUnit[num],"attack")
                endif
                num = GetCanUsesGameChallengeUnitID(pid)
                if  num != 0
                    x = -3584
                    y = 1440
                    CreateUsesGameChallengeUnit(pid,num,'uf14',x,y)
                    SetUnitOverStateOfGameChalleng(pid,GameChallengeUnit[num],2)
                    IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    Sdofplayer(Player(pid),x,y,3)
                    UnitAddEffect(GameChallengeUnit[num],"effect_red-yumao-zhendi-paoxiao.mdx")
                    UnitAddEffect(GameChallengeUnit[num],"effect_by_wood_effect_d2_shadowfiend_shadowraze_1.mdx")
                    SetUnitAnimation(GameChallengeUnit[num],"attack")
                endif
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击退殷破败和雷开|r",0)
            endif
        endif
    endfunction

    function InitGameChallenge_1()
        trigger tig = null
        region rectRegion = null
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengeUnit[10] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np09',-6304,1024,270)
                SetUnitVertexColor(GameChallengeUnit[10],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[10],0x01)

                GameChallengeUnit[11] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ07',-6304,1024,0)
                SetUnitVertexColor(GameChallengeUnit[11],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[11],0x01)
                
                GameChallengeUnit[12] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ01',GetRectMinX(gg_rct_ChallengeRct_1_4),GetRectCenterY(gg_rct_ChallengeRct_1_4),0)
                SetUnitVertexColor(GameChallengeUnit[12],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[12],0x01)

                GameChallengeUnit[13] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-4352,-288,0)
                SetUnitVertexColor(GameChallengeUnit[13],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[13],0x01)

                GameChallengeUnit[14] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np11',-4608,640,40)
                SetUnitVertexColor(GameChallengeUnit[14],255,255,255,0)
                GameChallengeUnit[15] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ07',-4608,640,0)
                SetUnitVertexColor(GameChallengeUnit[15],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[14],0x01)
                EXSetUnitMoveType(GameChallengeUnit[15],0x01)

                GameChallengeUnit[16] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-3776,1472,0)
                SetUnitVertexColor(GameChallengeUnit[16],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[16],0x01)
            endif
        end

        CreateTrigUnitInRangeOfGameChallenge(-6304,1024,150,function EnRctGameChalleng_1_YZZ)
        CreateTrigUnitInRangeOfGameChallenge(-4352,-288,100,function EnRctGameChalleng_1_JLD)
        CreateTrigUnitInRangeOfGameChallenge(-4608,640,100,function EnRctGameChalleng_1_JY)
        CreateTrigUnitInRangeOfGameChallenge(-3776,1472,100,function EnRctGameChalleng_1_JY2)

        tig = CreateTrigger() //
        rectRegion = CreateRegion()
        RegionAddRect(rectRegion,gg_rct_ChallengeRct_1_1)
        TriggerRegisterEnterRegion(tig,rectRegion,null)
        TriggerAddAction(tig, function FuncEnterRctChallengeRct_1_1)

        tig = CreateTrigger() //
        rectRegion = CreateRegion()
        RegionAddRect(rectRegion,gg_rct_ChallengeRct_1_2)
        TriggerRegisterEnterRegion(tig,rectRegion,null)
        TriggerAddAction(tig, function FuncEnterRctChallengeRct_1_2)

        tig = CreateTrigger() //
        rectRegion = CreateRegion()
        RegionAddRect(rectRegion,gg_rct_ChallengeRct_1_3)
        TriggerRegisterEnterRegion(tig,rectRegion,null)
        TriggerAddAction(tig, function FuncEnterRctChallengeRct_1_3)

        tig = CreateTrigger() //
        rectRegion = CreateRegion()
        RegionAddRect(rectRegion,gg_rct_ChallengeRct_1_4)
        TriggerRegisterEnterRegion(tig,rectRegion,null)
        TriggerAddAction(tig, function FuncEnterRctChallengeRct_1_4)

        tig = null
        rectRegion = null
    endfunction

endlibrary
