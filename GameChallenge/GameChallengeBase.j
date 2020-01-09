library GameChallengeBase initializer InitGameChallengeFunc uses DamageCode,PlotSelectFrame

    int array unitplayercos[6][680]

    #define unitcos unitplayercos[pid]

    int array       GameChallengPlayerInt[12][680]
    unit array      GameChallengPlayerUnit[12][680]
    bool array      GameChallengPlayerBool[12][680]

    int array      GameChallengOperaWay

    unit array      GameChallengMapUnit

    #define GameChallengInt                 GameChallengPlayerInt[pid]
    #define GameChallengUnit                GameChallengPlayerUnit[pid]
    #define GameChallengBool                GameChallengPlayerBool[pid]

    #define PlayerInChallengeShowUnit       GameChallengUnit[500]
    #define IsPlayerInChallenge             GameChallengBool[500]
    #define IsFinshChallenge(num)           GameChallengBool[500+num]

    #define PlayerInChallengeNumber         GameChallengInt[500]

    #define PlayerChallengeCosNum(num)      GameChallengInt[501+num]

    #define GameBiaoJI                      GameChallengMapUnit


    #define GameChalleng_0_JZY              GameChallengMapUnit[500]

    #define UnitAPOfPlayer  0


    /////////////////////////////////////////////////////
    /*
    新手 0-9
    副本 10-20





    //500之后
    */
    /////////////////////////////////////////////////////

    function InitGameChallengeFunc()
        ExecuteFunc("InitGameChallenge_0")
        ExecuteFunc("InitGameChallenge_1")
        ExecuteFunc("InitGameChallenge_2")
        ExecuteFunc("InitGameChallenge_3")
        ExecuteFunc("InitGameChallenge_4")
        ExecuteFunc("InitGameChallenge_5")
        ExecuteFunc("InitGameChallenge_6")
        ExecuteFunc("InitGameChallenge_7")
        ExecuteFunc("InitGameChallenge_8")
        ExecuteFunc("InitGameChallengeLeaveRctEvent")
    endfunction

    function SetUnitAPOfBool(unit u,int boolid)
        int ap = 0
        for pid = 0,3
            if  boolid > 0
                if  GameChallengBool[boolid] == false and GameChallengBool[boolid-1] == true
                    if  Player(pid) == GetLocalPlayer()
                        ap = 255
                    endif
                endif
            else 
                if  GameChallengBool[boolid] == false
                    if  Player(pid) == GetLocalPlayer()
                        ap = 255
                    endif
                endif
            endif
        end
        SetUnitVertexColor(u,255,255,255,ap)
    endfunction

    function IsCanMoveToRoom(int pid)->boolean
        if  GameChallengBool[0] == false
            return false
        endif
        if  GameChallengBool[1] == false
            return false
        endif
        if  GameChallengBool[2] == false
            return false
        endif
        if  GameChallengBool[3] == false
            return false
        endif
        if  GetUnitAbilityLevel(Pu[1],'AZ02') > 0
            return false
        endif
        return true
    endfunction


    function SetUnitFollowAlways(int id)
        int pid = id
        TimerStart(0.01,true)
        {
            if  PlayerInChallengeShowUnit != null
                SetUnitXY(PlayerInChallengeShowUnit,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function ShowHeroGetTask(int pid)
        int ap = 255
        ShowUnitOfOnlyPlayerEx(Pu[1])
        PlayerInChallengeShowUnit = CreateUnit(Player(pid),'e00A',GetUnitX(Pu[1]),GetUnitY(Pu[1]),0)
        if  Player(pid) == GetLocalPlayer()
            ap = 0
        endif
        SetUnitVertexColor(PlayerInChallengeShowUnit,255,255,255,ap)
        SetUnitFollowAlways(pid)
    endfunction

    function GetCanUsesGameChallengUnitID(int pid)->int
        for num = 500,600
            if  GameChallengUnit[num] == null
                return num
            endif
        end
        return 0
    endfunction

    function GameChallengCanUsesUnitFlush(int pid)
        for num = 500,600
            if  GameChallengUnit[num] != null
                FlushChildHashtable(ht,GetHandleId(GameChallengUnit[num]))
                RemoveUnit(GameChallengUnit[num])
                GameChallengUnit[num] = null
            endif
        end
    endfunction

    
    function CreateUsesGameChallengUnit(int pid,int num,int uid,real x,real y)
        //BJDebugMsg(I2S(num))
        GameChallengUnit[num] = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),uid,x,y,0)
        ShowUnitOfOnlyPlayer(pid,GameChallengUnit[num],UnitAPOfPlayer)
        SetUnitRealState(GameChallengUnit[num],99,num)
        UnitAddAbility(GameChallengUnit[num],'AZ99')
        SetUnitAbilityLevel(GameChallengUnit[num],'AZ99',pid+1)
    endfunction

    function CreateUsesGameChallengUnitOfAng(int pid,int num,int uid,real x,real y,real ang)
        //BJDebugMsg(I2S(num))
        GameChallengUnit[num] = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),uid,x,y,ang)
        ShowUnitOfOnlyPlayer(pid,GameChallengUnit[num],UnitAPOfPlayer)
        SetUnitRealState(GameChallengUnit[num],99,num)
        UnitAddAbility(GameChallengUnit[num],'AZ99')
        SetUnitAbilityLevel(GameChallengUnit[num],'AZ99',pid+1)
    endfunction

    function CreateUsesGameChallengUnitEx(int pid,int num,int uid,real x,real y)
        //BJDebugMsg(I2S(num))
        GameChallengUnit[num] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),uid,x,y,0)
        ShowUnitOfOnlyPlayer(pid,GameChallengUnit[num],UnitAPOfPlayer)
        SetUnitRealState(GameChallengUnit[num],99,num)
        UnitAddAbility(GameChallengUnit[num],'AZ99')
        SetUnitAbilityLevel(GameChallengUnit[num],'AZ99',pid+1)
    endfunction

    function CreateUsesGameChallengUnitExOfAng(int pid,int num,int uid,real x,real y,real ang)
        //BJDebugMsg(I2S(num))
        GameChallengUnit[num] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),uid,x,y,ang)
        ShowUnitOfOnlyPlayer(pid,GameChallengUnit[num],UnitAPOfPlayer)
        SetUnitRealState(GameChallengUnit[num],99,num)
        UnitAddAbility(GameChallengUnit[num],'AZ99')
        SetUnitAbilityLevel(GameChallengUnit[num],'AZ99',pid+1)
    endfunction

    function SetUnitPositionOfGameChalleng(unit u,real x,real y)
        UnitAddEffect(u,"effect_az_goods_lvlup(3).mdl")
        SetUnitXY(u,x,y)
        LocAddEffect(x,y,"effect_effect_az_goods_tp_target_effect(4).mdl")
    endfunction

    function UnitAddEffectOfGameChalleng(unit u)
        UnitAddEffect(u,"effect_az_goods_lvlup(3).mdl")
        UnitAddEffect(u,"effect_effect_az_goods_tp_target_effect(4).mdl")
    endfunction

    function GetGameChallengOperaSelsect()->int
        int cosa = 0
        int cosb = 0
        for num = 1,8
            if  GameChallengOperaWay[num] == 1
                cosa = cosa + 1
            elseif  GameChallengOperaWay[num] == 2
                cosb = cosb + 1
            endif
        end
        if  cosb > 4
            return 0
        endif
        return GetRandomInt(0,1)
    endfunction

    function SetUnitOverStateOfGameChalleng(int pid,unit u,int flag)
        real life = 0
        life = GetUnitRealState(u,5)*(1.0+0.2*PlayerChallengeCosNum(flag))
        SetUnitRealState(u,5,life)
    endfunction

    function PlayerFinishPlotEx(int id,int f)
        int pid = id
        int flag = f
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[副本]：|r正在结算奖励。。。")
        TimerStart(1,false)
        {
            PlayerFinishPlot(pid,flag)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function SendPlayerUnitTimer(int id,real r1,real r2)
        int pid = id
        real x = r1
        real y = r2
        TimerStart(0.1,false)
        {
            SendPlayerUnit(pid,x,y)
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    function GameChallenge_GlobalFlush(int pid,real time)
        GameChallengCanUsesUnitFlush(pid)
        ShowUnitOfAllPlayer(Pu[1])
        RemoveUnit(PlayerInChallengeShowUnit)
        PlayerInChallengeShowUnit = null
        PlayerInChallengeNumber = 0
        IsPlayerInChallenge = false
        if  time == -1
            PlayerTaskUI_Back.alpha = 0
            PlayerTaskUI_Back.show = false
        else
            ShowPlayerTaskUIOfPlayer(pid,false,time)
        endif
        PlayerTaskUI_TaskText.SetText("")
        PlayerTaskUI_ChatTextA.SetText("")
        PlayerTaskUI_ChatTextB.SetText("")
    endfunction

endlibrary







