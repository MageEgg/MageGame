library GameChallenge9 uses GameChallengeBase
















    function InitGameChallenge_9()
        GameTeamChallengUnit(0) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',6352.500,3110.250,270)
        GameTeamChallengUnit(1) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',6505.750,3108.750,270)
        GameTeamChallengUnit(2) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',8418.000,3102.000,270)
        GameTeamChallengUnit(3) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',8571.250,3100.500,270)
        ShowUnit(GameTeamChallengUnit(0),false)
        ShowUnit(GameTeamChallengUnit(1),false)
        ShowUnit(GameTeamChallengUnit(2),false)
        ShowUnit(GameTeamChallengUnit(3),false)
    endfunction

endlibrary
