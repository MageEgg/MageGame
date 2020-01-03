library GameChallenge5 uses GameChallengeBase
    
    function GameChallenge_5Flush(int pid)
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
            x = -1728
            y = -896
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 5
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r天仙赵公明助闻太师攻打西岐，神秘大能-陆压传子牙“钉头七箭书”应对。")
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

    function EnRctGameChalleng_5_Way1()

    endfunction
    function EnRctGameChalleng_5_Way2()

    endfunction
    function EnRctGameChalleng_5_Way3()

    endfunction
    function EnRctGameChalleng_5_Way4()

    endfunction

    function InitGameChallenge_5()
        trigger tig = null
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengUnit[50] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-640,3840,0)
                SetUnitVertexColor(GameChallengUnit[50],255,255,255,0)
                GameChallengUnit[51] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-1216,3552,0)
                SetUnitVertexColor(GameChallengUnit[51],255,255,255,0)
                GameChallengUnit[52] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-1568,3200,0)
                SetUnitVertexColor(GameChallengUnit[52],255,255,255,0)
                GameChallengUnit[53] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-2080,2688,0)
                SetUnitVertexColor(GameChallengUnit[53],255,255,255,0)
            endif
        end

        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[50],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_5_Way1)

        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[51],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_5_Way2)

        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[52],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_5_Way3)

        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[53],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_5_Way4)

        tig = null
    endfunction

endlibrary
