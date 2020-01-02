library GameChallenge1 uses GameChallengeBase



    function OpenGameChallenge_1(int pid)
        real x = GetRectCenterX(gg_rct_ChallengeRct_1_1)
        real y = GetRectCenterY(gg_rct_ChallengeRct_1_1)
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
            if  GameChallengInt[10] == 1 or ModuloInteger(GameChallengInt[10],5) == 0
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r击杀护冢小妖("+I2S(GameChallengInt[10])+"/40)")
            endif
        elseif  GameChallengInt[10] == 40
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r击杀护冢小妖("+I2S(GameChallengInt[10])+"/40)")
            SetUnitVertexColor(GameChallengUnit[12],255,255,255,0)
            IssuePointOrderById(GameChallengUnit[13],851983,GetRectCenterX(gg_rct_ChallengeRct_1_4),GetRectCenterY(gg_rct_ChallengeRct_1_4))
        endif
    endfunction

    function GameChalleng_1_XYTimer(int id)
        int pid = id
        TimerStart(0.2,true)
        {   
            int num = 0
            real x = 0
            real y = 0
            if  GameChallengInt[10] < 40
                num = GetCanUsesGameChallengUnitID(pid)
                x = GetUnitX(GameChallengUnit[13])+GetRandomReal(-380,-380)
                y = GetUnitX(GameChallengUnit[13])+GetRandomReal(-380,-380)
                if  IsLocInRect(gg_rct_ChallengeRct_1_4,x,y) == true
                    x = -5400+GetRandomReal(-380,-380)
                    y = -720+GetRandomReal(-380,-380)
                endif
                if  num != 0
                    BJDebugMsg(I2S(num))
                    CreateUsesGameChallengUnit(pid,num,'uf10',x,y)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                endif
            else
                endtimer
            endif
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
                GameChallengUnit[13] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np08',GetUnitX(Pu[1]),GetUnitY(Pu[1]),270)
                ShowUnitOfOnlyPlayer(pid,GameChallengUnit[13],0)
                IssuePointOrderById(GameChallengUnit[13],851983,GetRectCenterX(gg_rct_ChallengeRct_1_1),GetRectCenterY(gg_rct_ChallengeRct_1_1))
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[云中子]：|r雷震子，你义父有难，到剑冢取一适手兵器前去解救。")
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀40个护冢小妖|r")
                GameChalleng_1_XYTimer(pid)
            endif
        endif
        flush locals
    endfunction

    function FuncEnterRctChallengeRct_1_1()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengUnit[13]
                IssuePointOrderById(GameChallengUnit[13],851983,GetRectCenterX(gg_rct_ChallengeRct_1_2),GetRectCenterY(gg_rct_ChallengeRct_1_2))
            endif
        endif
        flush locals
    endfunction

    function FuncEnterRctChallengeRct_1_2()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengUnit[13]
                IssuePointOrderById(GameChallengUnit[13],851983,GetRectCenterX(gg_rct_ChallengeRct_1_3),GetRectCenterY(gg_rct_ChallengeRct_1_3))
            endif
        endif
        flush locals
    endfunction

    function FuncEnterRctChallengeRct_1_3()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengUnit[13]
                IssuePointOrderById(GameChallengUnit[13],851983,GetRectCenterX(gg_rct_ChallengeRct_1_4),GetRectCenterY(gg_rct_ChallengeRct_1_4))
            endif
        endif
        flush locals
    endfunction

    function FuncEnterRctChallengeRct_1_4()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengUnit[13]
                if  GameChallengInt[10] < 40
                    SetUnitPosition(u1,GetRectCenterX(gg_rct_ChallengeRct_1_3),GetRectCenterY(gg_rct_ChallengeRct_1_3))
                    IssueImmediateOrderById(u1, 851972 )
                endif
            endif
        endif
        flush locals
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
            endif
        end

        tig = CreateTrigger() //姜子牙
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[10],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_1_YZZ)


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
