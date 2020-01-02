library GameChallenge2 uses GameChallengeBase

    function OpenGameChallenge_2(int pid,int ty)
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

endlibrary


