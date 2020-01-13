library GameChallenge9 uses GameChallengeBase


    













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
