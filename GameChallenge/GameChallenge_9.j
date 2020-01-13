library GameChallenge9 uses GameChallengeBase

    function EnRctGameTeamChallengA()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  GameTeamChallengeBool[0] == true and GameTeamChallengeBool[1] == true
                GameChallengBool[90] = true
                SendPlayerUnit(pid,6432,3104)
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[副本]：|r您已进入团队副本，请等待挑战开始！")
            endif
        endif
        flush locals
    endfunction

    function GameTeamChallengeDoorTimer(unit wu,real time)
        unit u = wu
        TimerStart(time,false)
        {
            ShowUnit(u,false)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function OpenGameTeamChallengeTimer(int t,int fl)
        int time = t
        int flag = fl
        if  flag == 1
            ShowUnit(GameTeamChallengUnit(0),true)
            ShowUnit(GameTeamChallengUnit(1),true)
        endif
        //Se
        TimerStart(1,true)
        {

                endtimer
            //endif
            flush locals
        }
        flush locals
    endfunction

    function OpenGameTeamChallenge()
        GameTeamChallengeBool[1] = true
        for pid = 0,3
            if  IsPlaying(pid) == true
                ShowUnit(GameChallengUnit[91],true)
                SetUnitAnimation(GameChallengUnit[91],"birth")
                GameTeamChallengeDoorTimer(GameChallengUnit[91],30)
            endif
        end
        OpenGameTeamChallengeTimer(30,1)
    endfunction


    function ShowGameTeamChallengeNPC()
        for pid = 0,3
            if  IsPlaying(pid) == true
                UnitAddEffectOfNPC(GameChallengUnit[90])
            endif
        end
    endfunction

    function FlushGameTeamChallenge(int pid)
        GameChallengBool[90] = false

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
