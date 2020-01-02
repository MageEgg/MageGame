library GameChallenge3 uses GameChallengeBase

    function GameChallenge_3Flush(int pid)
        for num = 0,5
            SetUnitVertexColor(GameChallengUnit[20+num],255,255,255,0)
        end
        GameChallengInt[20] = 0
        GameChallengInt[21] = 0
        if  GameChallengUnit[29] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[29]))
            RemoveUnit(GameChallengUnit[29])
            GameChallengUnit[29] = null
        endif
        GameChallengCanUsesUnitFlush(pid)
        ShowUnitOfAllPlayer(Pu[1])
        RemoveUnit(PlayerInChallengeShowUnit)
        PlayerInChallengeShowUnit = null
        PlayerInChallengeNumber = 0
        IsPlayerInChallenge = false
    endfunction

    function OpenGameChallenge_3(int pid,int ty)
        real x = 0
        real y = 0
        if  ty == 0
            x = GetRectCenterX(gg_rct_ChallengeRct_1_1)
            y = GetRectCenterY(gg_rct_ChallengeRct_1_1)
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 1
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff前往云中子|r")
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[10],0)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[11],0)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[12],0)
        elseif  ty == 1
            x = -4544
            y = 896
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 1
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff前往文王姬昌|r")
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[14],0)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[15],0)
        endif
    endfunction

    function InitGameChallenge_3()
        trigger tig = null
        region rectRegion = null
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengUnit[20] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-6080,3072,0)
                SetUnitVertexColor(GameChallengUnit[20],255,255,255,0)
                
                GameChallengUnit[21] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-5536,3872,0)
                SetUnitVertexColor(GameChallengUnit[21],255,255,255,0)

                GameChallengUnit[22] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np22',-3712,2880,180)
                SetUnitVertexColor(GameChallengUnit[22],255,255,255,0)
            endif
        end

        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[20],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_2_Water1)

        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[21],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_2_Water2)

        /*tig = CreateTrigger() 
        rectRegion = CreateRegion()
        RegionAddRect(rectRegion,gg_rct_ChallengeRct_1_4)
        TriggerRegisterEnterRegion(tig,rectRegion,null)
        TriggerAddAction(tig, function FuncEnterRctChallengeRct_1_4)*/


        tig = null
        rectRegion = null
    endfunction

endlibrary


