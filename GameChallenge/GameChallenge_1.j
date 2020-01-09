library GameChallenge1 uses GameChallengeBase

    function GameChallenge_1Flush(int pid,real time)
        for num = 0,5
            SetUnitVertexColor(GameChallengUnit[10+num],255,255,255,0)
        end
        GameChallengInt[10] = 0
        GameChallengInt[11] = 0
        GameChallengBool[10] = false
        GameChallengBool[11] = false
        if  GameChallengUnit[19] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[19]))
            RemoveUnit(GameChallengUnit[19])
            GameChallengUnit[19] = null
        endif
        GameChallenge_GlobalFlush(pid,time)
    endfunction

    function OpenGameChallenge_1(int pid,int ty)
        real x = 0
        real y = 0
        GameChallenge_1Flush(pid,-1)
        ShowPlayerTaskUIOfPlayer(pid,true,0.01)
        if  ty == 0
            x = GetRectCenterX(gg_rct_ChallengeRct_1_1)
            y = GetRectCenterY(gg_rct_ChallengeRct_1_1)
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 1
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            SetPlayerTaskUIChatOfPlayer(pid,"任务","前往云中子！",0.3)
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff前往云中子|r",0.3)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[10],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[11],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[12],UnitAPOfPlayer)
        elseif  ty == 1
            x = -4544
            y = 896
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 1
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            SetPlayerTaskUIChatOfPlayer(pid,"任务","前往文王姬昌！",0.3)
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff前往文王姬昌|r",0.3)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[14],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[15],UnitAPOfPlayer)
        endif
    endfunction

    function GameChalleng_1_XYDeathTimer(int id)
        int pid = id
        real dis1 = 0
        real dis2 = 0
        IssuePointOrderById(GameChallengUnit[19],851983,GetUnitX(GameChallengUnit[13]),GetUnitY(GameChallengUnit[13]))
        dis1 = Udis(GameChallengUnit[19],GameChallengUnit[13])
        TimerStart(0.3,true)
        {
            dis2 = dis1
            dis1 = Udis(GameChallengUnit[19],GameChallengUnit[13])
            if  GameChallengBool[11] == false
                if  dis2 < dis1
                    IssuePointOrderById(GameChallengUnit[19],851983,GetUnitX(GameChallengUnit[13]),GetUnitY(GameChallengUnit[13]))
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
        if  GameChallengInt[10] < 40
            GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
            GameChallengInt[10] = GameChallengInt[10] + 1
            GameChallengInt[11] = GameChallengInt[11] - 1
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀护冢小妖|r|n|cffffcc00累积：|r"+I2S(GameChallengInt[10])+"/40",0)
            if  GameChallengInt[10] == 1 or ModuloInteger(GameChallengInt[10],5) == 0
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r击杀护冢小妖("+I2S(GameChallengInt[10])+"/40)")
            endif
        elseif  GameChallengInt[10] == 40
            if  GameChallengBool[10] == false    
                GameChallengBool[10] = true
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r击杀护冢小妖("+I2S(GameChallengInt[10])+"/40)")
                SetUnitVertexColor(GameChallengUnit[12],255,255,255,0)
                GameChalleng_1_XYDeathTimer(pid)
            endif
        endif
    endfunction

    function GameChalleng_1_JLDeathTimer(int id,int n)
        int pid = id
        int num = n
        TimerStart(0.6,false)
        {
            if  IsPlayerInChallenge == true
                SetUnitOwner(GameChallengUnit[num],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
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
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        SetPlayerTaskUIChatOfPlayer(pid,"雷震子","这些兵器都不合适我啊。咦，那两颗红杏好像很好吃的样子！啊！！！我怎么了！！！",0)
        SetUnitPositionOfGameChalleng(GameChallengUnit[19],x,y)
        RemoveUnitTimer(GameChallengUnit[19],0.5)
        GameChallengUnit[19] = null
        TimerStart(0.4,false)
        {
            if  IsPlayerInChallenge == true
                num = GetCanUsesGameChallengUnitID(pid)
                if  num != 0
                    CreateUsesGameChallengUnitEx(pid,num,'uf12',x,y)
                    UnitAddEffect(GameChallengUnit[num],"effect_red-yumao-zhendi-paoxiao.mdx")
                    UnitAddEffect(GameChallengUnit[num],"effect_by_wood_effect_d2_shadowfiend_shadowraze_1.mdx")
                    SetUnitAnimation(GameChallengUnit[num],"attack")
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
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        SetPlayerTaskUIChatOfPlayer(pid,"云中子","奇哉！奇哉！福祸相依，待我传你玄妙真仙诀，炼就风雷金刚体！",0)
        SetPlayerTaskUITaskOfPlayer(pid,"",0)
        GameChallenge_1Flush(pid,2)
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
            if  GameChallengInt[10] < 40 and IsPlayerInChallenge == true
                num = GetCanUsesGameChallengUnitID(pid)
                if  num != 0 and GameChallengInt[11] < 5
                    x = GetUnitX(GameChallengUnit[19])+GetRandomReal(-380,380)
                    y = GetUnitY(GameChallengUnit[19])+GetRandomReal(-380,380)
                    if  IsLocInRect(gg_rct_ChallengeRct_1_4,x,y) == true
                        x = -5400+GetRandomReal(-380,380)
                        y = -720+GetRandomReal(-380,380)
                    endif
                    CreateUsesGameChallengUnit(pid,num,'uf10',x,y)
                    GameChallengInt[11] = GameChallengInt[11] + 1
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
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
                if  GameChallengUnit[19] == null and IsFinshChallenge(1) == false and IsPlayerInChallenge == true
                    SetUnitVertexColor(GameChallengUnit[11],255,255,255,0)
                    GameChallengUnit[19] = CreateUnit(Player(9),'np08',GetUnitX(Pu[1]),GetUnitY(Pu[1]),270)
                    ShowUnitOfOnlyPlayer(pid,GameChallengUnit[19],UnitAPOfPlayer)
                    UnitAddAbility(GameChallengUnit[19],'AZ99')
                    SetUnitAbilityLevel(GameChallengUnit[19],'AZ99',pid+1)
                    IssuePointOrderById(GameChallengUnit[19],851983,GetRectCenterX(gg_rct_ChallengeRct_1_1),GetRectCenterY(gg_rct_ChallengeRct_1_1))
                    SetPlayerTaskUIChatOfPlayer(pid,"云中子","雷震子，你义父有难，到剑冢取一适手兵器前去解救。",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀40个护冢小妖|r",0)
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
            if  u1 == GameChallengUnit[19]
                IssuePointOrderById(u1,851983,GetRectCenterX(gg_rct_ChallengeRct_1_2),GetRectCenterY(gg_rct_ChallengeRct_1_2))
            endif
        endif
        flush locals
    endfunction

    function FuncEnterRctChallengeRct_1_2()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengUnit[19]
                IssuePointOrderById(u1,851983,GetRectCenterX(gg_rct_ChallengeRct_1_3),GetRectCenterY(gg_rct_ChallengeRct_1_3))
            endif
        endif
        flush locals
    endfunction

    function FuncEnterRctChallengeRct_1_3()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengUnit[19]
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
            if  u1 == GameChallengUnit[19]
                if  GameChallengInt[10] < 40
                    SetUnitPosition(u1,GetRectCenterX(gg_rct_ChallengeRct_1_3),GetRectCenterY(gg_rct_ChallengeRct_1_3))
                    IssueImmediateOrderById(u1, 851993 )
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
            if  u1 == GameChallengUnit[19]
                GameChallengBool[11] = true
                IssueImmediateOrderById(u1, 851993 )
                num = GetCanUsesGameChallengUnitID(pid)
                if  num != 0
                    x = -4096
                    y = -768
                    CreateUsesGameChallengUnit(pid,num,'uf11',x,y)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    Sdofplayer(Player(pid),x,y,3)
                endif
                SetPlayerTaskUIChatOfPlayer(pid,"剧情","击杀剑灵。",0.3)
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀剑灵|r",0)
            endif
        endif
    endfunction

    function GameChalleng_1_JYDeath(int pid,unit u2)
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        GameChallengInt[12] = GameChallengInt[12] + 1
        if  GameChallengInt[12] == 2
            GameChallengInt[12] = 0
            if  GameChallengOperaWay[1] == 0
                if  GetGameChallengOperaSelsect() == 0
                    GameChallengOperaWay[1] = 1
                    SetPlayerTaskUIChatOfPlayer(pid,"雷震子","追兵已退，我便送父王回西岐。",0)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-半人祸福]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00雷震子加入己方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-半人祸福]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00雷震子加入己方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-半人祸福]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00雷震子加入己方阵营！|r")                                   
                else
                    GameChallengOperaWay[1] = 2
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","糟糕！雷震子怒意攻心，入魔远走了！",0)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-半人祸福]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000雷震子加入敌方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-半人祸福]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000雷震子加入敌方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-半人祸福]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000雷震子加入敌方阵营！|r")   
                endif
            else
                SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功击退殷破败和雷开！！！",0)
            endif
            GameChallenge_1Flush(pid,2)
            PlayerChallengeCosNum(1) = PlayerChallengeCosNum(1) + 1
            //奖励
            PlayerFinishPlotEx(pid,1)
        endif
    endfunction

    function EnRctGameChalleng_1_JY()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  GameChallengUnit[19] == null and IsPlayerInChallenge == true
                    SetUnitVertexColor(GameChallengUnit[15],255,255,255,0)
                    GameChallengUnit[19] = CreateUnit(Player(9),'np08',GetUnitX(Pu[1]),GetUnitY(Pu[1]),270)
                    ShowUnitOfOnlyPlayer(pid,GameChallengUnit[19],UnitAPOfPlayer)
                    UnitAddAbility(GameChallengUnit[19],'AZ99')
                    SetUnitAbilityLevel(GameChallengUnit[19],'AZ99',pid+1)
                    IssuePointOrderById(GameChallengUnit[19],851983,-3776,1472)
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
            if  u1 == GameChallengUnit[19]
                x = -4224
                y = 1600
                SetUnitPositionOfGameChalleng(GameChallengUnit[19],x,y)
                SetPlayerTaskUIChatOfPlayer(pid,"雷震子","纣王今既放归我父王，为何又派你俩来追袭？反复无常，实在可恨！",0)
                IssueImmediateOrderById(GameChallengUnit[19], 851993 )
                num = GetCanUsesGameChallengUnitID(pid)
                if  num != 0
                    x = -3744
                    y = 1664
                    CreateUsesGameChallengUnit(pid,num,'uf13',x,y)
                    SetUnitOverStateOfGameChalleng(pid,GameChallengUnit[num],1)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    Sdofplayer(Player(pid),x,y,3)
                    UnitAddEffect(GameChallengUnit[num],"effect_red-yumao-zhendi-paoxiao.mdx")
                    UnitAddEffect(GameChallengUnit[num],"effect_by_wood_effect_d2_shadowfiend_shadowraze_1.mdx")
                    SetUnitAnimation(GameChallengUnit[num],"attack")
                endif
                num = GetCanUsesGameChallengUnitID(pid)
                if  num != 0
                    x = -3584
                    y = 1440
                    CreateUsesGameChallengUnit(pid,num,'uf14',x,y)
                    SetUnitOverStateOfGameChalleng(pid,GameChallengUnit[num],1)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    Sdofplayer(Player(pid),x,y,3)
                    UnitAddEffect(GameChallengUnit[num],"effect_red-yumao-zhendi-paoxiao.mdx")
                    UnitAddEffect(GameChallengUnit[num],"effect_by_wood_effect_d2_shadowfiend_shadowraze_1.mdx")
                    SetUnitAnimation(GameChallengUnit[num],"attack")
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
                GameChallengUnit[10] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np09',-6304,1024,270)
                SetUnitVertexColor(GameChallengUnit[10],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[10],0x01)

                GameChallengUnit[11] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e007',-6304,1024,0)
                SetUnitVertexColor(GameChallengUnit[11],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[11],0x01)
                
                GameChallengUnit[12] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e001',GetRectMinX(gg_rct_ChallengeRct_1_4),GetRectCenterY(gg_rct_ChallengeRct_1_4),0)
                SetUnitVertexColor(GameChallengUnit[12],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[12],0x01)

                GameChallengUnit[13] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-4352,-288,0)
                SetUnitVertexColor(GameChallengUnit[13],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[13],0x01)

                GameChallengUnit[14] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np11',-4608,640,40)
                SetUnitVertexColor(GameChallengUnit[14],255,255,255,0)
                GameChallengUnit[15] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e007',-4608,640,0)
                SetUnitVertexColor(GameChallengUnit[15],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[14],0x01)
                EXSetUnitMoveType(GameChallengUnit[15],0x01)

                GameChallengUnit[16] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-3776,1472,0)
                SetUnitVertexColor(GameChallengUnit[16],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[16],0x01)
            endif
        end

        tig = CreateTrigger() //姜子牙
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[10],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_1_YZZ)

        tig = CreateTrigger() //剑灵点
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[13],100,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_1_JLD)

        tig = CreateTrigger() //救援点
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[14],100,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_1_JY)
        tig = CreateTrigger() //救援点2
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[16],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_1_JY2)


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
