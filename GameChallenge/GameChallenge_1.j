library GameChallenge1 uses GameChallengeBase

    function GameChallenge_1Flush(int pid)
        for num = 0,3
            SetUnitVertexColor(GameChallengUnit[10+num],255,255,255,0)
        end
        GameChallengInt[10] = 0
        GameChallengInt[11] = 0
        if  GameChallengUnit[19] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[19]))
            RemoveUnit(GameChallengUnit[19])
        endif
        GameChallengCanUsesUnitFlush(pid)
        ShowUnitOfAllPlayer(Pu[1])
        RemoveUnit(PlayerInChallengeShowUnit)
        PlayerInChallengeShowUnit = null
        PlayerInChallengeNumber = 0
        IsPlayerInChallenge = false
    endfunction

    function OpenGameChallenge_1(int pid)
        real x = GetRectCenterX(gg_rct_ChallengeRct_1_1)
        real y = GetRectCenterY(gg_rct_ChallengeRct_1_1)
        IsPlayerInChallenge = true
        PlayerInChallengeNumber = 1
        SendPlayerUnit(pid,x,y)
        ShowHeroGetTask(pid)
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff前往云中子|r")
        ShowUnitOfOnlyPlayer(pid,GameChallengUnit[10],0)
        ShowUnitOfOnlyPlayer(pid,GameChallengUnit[11],0)
        ShowUnitOfOnlyPlayer(pid,GameChallengUnit[12],0)
    endfunction

    function GameChalleng_1_XYDeath(int pid,unit u2)
        if  GameChallengInt[10] < 40
            GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
            GameChallengInt[10] = GameChallengInt[10] + 1
            GameChallengInt[11] = GameChallengInt[11] - 1
            if  GameChallengInt[10] == 1 or ModuloInteger(GameChallengInt[10],5) == 0
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r击杀护冢小妖("+I2S(GameChallengInt[10])+"/40)")
            endif
        elseif  GameChallengInt[10] == 40
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r击杀护冢小妖("+I2S(GameChallengInt[10])+"/40)")
            SetUnitVertexColor(GameChallengUnit[12],255,255,255,0)
            IssuePointOrderById(GameChallengUnit[19],851983,GetUnitX(GameChallengUnit[13]),GetUnitY(GameChallengUnit[13]))
        endif
    endfunction

    function GameChalleng_1_JLDeathTimer(int id,int n,real r1,real r2)
        int pid = id
        real x = r1
        real y = r2
        int num = n
        TimerStart(0.6,false)
        {
            SetUnitOwner(GameChallengUnit[num],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
            IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击败雷震子|r")
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
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[雷震子]：|r这些兵器都不合适我啊。咦，那两颗红杏好像很好吃的样子！啊！！！我怎么了！！！")
        UnitAddEffect(GameChallengUnit[19],"effect_az_goods_lvlup(3).mdl")
        SetUnitXY(GameChallengUnit[19],x,y)
        LocAddEffect(x,y,"effect_effect_az_goods_tp_target_effect(4).mdl")
        RemoveUnitTimer(GameChallengUnit[19],0.5)
        GameChallengUnit[19] = null
        TimerStart(0.4,false)
        {
            num = GetCanUsesGameChallengUnitID(pid)
            if  num != 0
                CreateUsesGameChallengUnitEx(pid,num,'uf12',x,y)
                UnitAddEffect(GameChallengUnit[num],"effect_red-yumao-zhendi-paoxiao.mdx")
                UnitAddEffect(GameChallengUnit[num],"effect_by_wood_effect_d2_shadowfiend_shadowraze_1.mdx")
                SetUnitAnimation(GameChallengUnit[num],"attack")
            endif
            Sdofplayer(Player(pid),x,y,3)
            GameChalleng_1_JLDeathTimer(pid,num,x,y)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_1_LZZDeath(int pid,unit u2)
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[云中子]：|r奇哉！奇哉！福祸相依，待我传你玄妙真仙诀，炼就风雷金刚体！")
        GameChallenge_1Flush(pid)
        //奖励
        PlayerFinishPlot(pid,1)
    endfunction

    function GameChalleng_1_XYTimerEx(int id)
        int pid = id
        TimerStart(0.2,true)
        {   
            int num = 0
            real x = 0
            real y = 0
            if  GameChallengInt[10] < 40
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
            GameChalleng_1_XYTimerEx(pid)
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
                SetUnitVertexColor(GameChallengUnit[11],255,255,255,0)
                GameChallengUnit[19] = CreateUnit(Player(9),'np08',GetUnitX(Pu[1]),GetUnitY(Pu[1]),270)
                ShowUnitOfOnlyPlayer(pid,GameChallengUnit[19],0)
                UnitAddAbility(GameChallengUnit[19],'AZ99')
                SetUnitAbilityLevel(GameChallengUnit[19],'AZ99',pid+1)
                IssuePointOrderById(GameChallengUnit[19],851983,GetRectCenterX(gg_rct_ChallengeRct_1_1),GetRectCenterY(gg_rct_ChallengeRct_1_1))
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[云中子]：|r雷震子，你义父有难，到剑冢取一适手兵器前去解救。")
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀40个护冢小妖|r")
                GameChalleng_1_XYTimer(pid)
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
                IssueImmediateOrderById(u1, 851993 )
                num = GetCanUsesGameChallengUnitID(pid)
                if  num != 0
                    x = -4096
                    y = -768
                    CreateUsesGameChallengUnit(pid,num,'uf11',x,y)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    Sdofplayer(Player(pid),x,y,3)
                endif
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀剑灵|r")
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
                GameChallengUnit[11] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e007',-6304,1024,0)
                SetUnitVertexColor(GameChallengUnit[11],255,255,255,0)
                
                GameChallengUnit[12] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e001',GetRectMinX(gg_rct_ChallengeRct_1_4),GetRectCenterY(gg_rct_ChallengeRct_1_4),0)
                SetUnitVertexColor(GameChallengUnit[12],255,255,255,0)

                GameChallengUnit[13] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-4352,-288,0)
                SetUnitVertexColor(GameChallengUnit[10],255,255,255,0)
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
