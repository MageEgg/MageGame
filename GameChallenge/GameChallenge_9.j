library GameChallenge9 uses GameChallengeBase

    bool array GameTeamChallengeBool
    








    function EnRctGameTeamChallengA()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  GameTeamChallengeBool[0] == true
                GameChallengBool[90] = true
                SendPlayerUnit(pid,6432,3104)
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[副本]：|r您已进入团队副本，请等待挑战开始！")
            endif
        endif
        flush locals
    endfunction

    function FlushGameTeamChallenge(int pid)

    endfunction


    function InitGameChallenge_9()

        GameTeamChallengUnit(0) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',6339.000,3097.250,270)
        GameTeamChallengUnit(1) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',6494.000,3097.000,270)
        GameTeamChallengUnit(2) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',6490.750,6330.000,270)
        GameTeamChallengUnit(3) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',6645.750,6329.750,270)
        ShowUnit(GameTeamChallengUnit(0),false)
        ShowUnit(GameTeamChallengUnit(1),false)
        ShowUnit(GameTeamChallengUnit(2),false)
        ShowUnit(GameTeamChallengUnit(3),false)

        
    endfunction

endlibrary
