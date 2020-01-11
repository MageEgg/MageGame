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

    #define GameChallengLeagueUnit(num)     GameChallengMapUnit[50+num]


    #define GameChalleng_0_JZY              GameChallengMapUnit[500]

    #define UnitAPOfPlayer  0


    /////////////////////////////////////////////////////
    /*
    新手 0-9
    副本 10-20





    //500之后
    */
    /////////////////////////////////////////////////////

    function InitGameChallengeLeagueUnit()
        real ang = 0
        for num = 1,9
            RemoveUnit(CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'md01',0,0,0))
        end
        ang = Atan2(OriginalDefendY+6592,OriginalDefendX+7456)/0.01745
        GameChallengLeagueUnit(1) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np91',-7456,-6592,ang)
        ang = Atan2(OriginalDefendY+6400,OriginalDefendX+7232)/0.01745
        GameChallengLeagueUnit(2) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np92',-7232,-6400,ang)
        ang = Atan2(OriginalDefendY+6400,OriginalDefendX+6592)/0.01745
        GameChallengLeagueUnit(3) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np93',-6592,-6400,ang)
        ang = Atan2(OriginalDefendY+6592,OriginalDefendX+6368)/0.01745
        GameChallengLeagueUnit(4) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np94',-6368,-6592,ang)
        ang = Atan2(OriginalDefendY+7264,OriginalDefendX+6368)/0.01745
        GameChallengLeagueUnit(5) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np95',-6368,-7264,ang)
        ang = Atan2(OriginalDefendY+7488,OriginalDefendX+6592)/0.01745
        GameChallengLeagueUnit(6) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np96',-6592,-7488,ang)
        ang = Atan2(OriginalDefendY+7488,OriginalDefendX+7232)/0.01745
        GameChallengLeagueUnit(7) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np97',-7232,-7488,ang)
        ang = Atan2(OriginalDefendY+7264,OriginalDefendX+7456)/0.01745
        GameChallengLeagueUnit(8) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np98',-7456,-7264,ang)
    endfunction

    /*
        real x = GetUnitX(GameChallengLeagueUnit(num))
        real y = GetUnitY(GameChallengLeagueUnit(num))
        real ang = GetUnitFacing(GameChallengLeagueUnit(num))
        EXSetUnitMoveType(GameChallengLeagueUnit(num),0x01)
            for i = 1,40
                value = GetTypeIdReal(uid,i)
                if  value != 0
                    if  i == 9
                        AddUnitRealState(GameChallengLeagueUnit(num),i,R2I(value))
                    elseif  i == 3
                        SetUnitRealState(GameChallengLeagueUnit(num),i,R2I(value)/2)
                    elseif  i == 5
                        SetUnitRealState(GameChallengLeagueUnit(num),i,GetTypeIdReal(uid,1)*30)
                    else
                        SetUnitRealState(GameChallengLeagueUnit(num),i,R2I(value))
                    endif
                endif
            end
            SetUnitRealState(GameChallengLeagueUnit(num),1,value)*/

    function OpenChangeGodStageA()
        for pid = 0,3
            if  IsPlaying(pid) == true
                UnitRemoveAbility(Pu[1],'Avul')
                PlayerReviveX = -1344
                PlayerReviveY = -7136
                SendPlayerUnitBarringCamera(pid,OriginalDefendX+200*Cos(45*pid*0.01745),PlayerReviveY+200*Cos(45*pid*0.01745))
            endif
        end
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神]：|r|cffff0000即将进入最终大决战，大决战无法离开封神台！！！请做好准备！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神]：|r|cffff0000即将进入最终大决战，大决战无法离开封神台！！！请做好准备！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神]：|r|cffff0000即将进入最终大决战，大决战无法离开封神台！！！请做好准备！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神]：|r|cffff0000即将进入最终大决战，大决战无法离开封神台！！！请做好准备！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神]：|r|cffff0000即将进入最终大决战，大决战无法离开封神台！！！请做好准备！！！|r")
    endfunction

    function OpenChangeGodStageB()
        for pid = 0,3
            if  IsPlaying(pid) == true
                UnitRemoveAbility(Pu[1],'Avul')
                PlayerReviveX = -1344
                PlayerReviveY = -7136
                SendPlayerUnitBarringCamera(pid,OriginalDefendX+200*Cos(45*pid*0.01745),PlayerReviveY+200*Cos(45*pid*0.01745))
            endif
        end
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神]：|r|cffff0000即将进入最终大决战，大决战无法离开封神台！！！请做好准备！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神]：|r|cffff0000即将进入最终大决战，大决战无法离开封神台！！！请做好准备！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神]：|r|cffff0000即将进入最终大决战，大决战无法离开封神台！！！请做好准备！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神]：|r|cffff0000即将进入最终大决战，大决战无法离开封神台！！！请做好准备！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神]：|r|cffff0000即将进入最终大决战，大决战无法离开封神台！！！请做好准备！！！|r")
    endfunction

    function OpenChangeGodStage()
        SetPlayerCameraBoundsToRect(bj_mapInitialPlayableArea)
        KillAttackUnitGroup()
        ShowBossDamageUI(false)
        PanCameraToTimed(-1664,-7440,0)
        RemoveUnit(GameDefendUnit)
        GameDefendUnit = CreateUnit(Player(9),'np20',-1664,-7440,90)
        OriginalDefendX = GetUnitX(GameDefendUnit)
        OriginalDefendY = GetUnitY(GameDefendUnit)
        EXSetUnitMoveType(GameDefendUnit,0x01)
        SetUnitAnimation(GameDefendUnit,"stand 3")
        LocAddEffectSetSize(OriginalDefendX,OriginalDefendY,"effect_shengguang.mdx",5)
        for pid = 0,3
            if  IsPlaying(pid) == true  
                UnitAddAbility(Pu[1],'Avul')
                UnitAddAbility(Pu[1],'AZ02')
            endif
        end
        TimerStart(1,false)
        {
            if  GameLevel < 3
                ExecuteFunc("OpenChangeGodStageA")
            else
                ExecuteFunc("OpenChangeGodStageB")
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function CreateChangeGodStage(real time)
        if  GameLevel < 3
            time = time - 10
        else
            time = time - 20
        endif
        TimerStart(time,false)
        {
            ExecuteFunc("OpenChangeGodStage")
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function SetPlayerLeagueState(int num,bool b)
        int t = 1
        if  b == false
            t = -1
        endif
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  num == 1
                    AddUnitRealState(Pu[1],3,t*10)
                elseif  num == 2
                    AddUnitRealState(Pu[1],10,t*15)
                elseif  num == 3
                    AddUnitRealState(Pu[1],32,t*30)
                elseif  num == 4
                    AddUnitRealState(Pu[1],33,t*30)
                elseif  num == 5
                    AddUnitRealState(Pu[1],19,t*10)
                elseif  num == 6
                    AddUnitRealState(Pu[1],9,t*100)
                elseif  num == 7
                    AddUnitRealState(Pu[1],31,t*30)
                elseif  num == 8
                    AddUnitRealState(Pu[1],25,t*15)
                endif
            endif
        end
    endfunction

    function SetLeagueUnit(int num,bool flag)
        if  flag == true
            SetUnitOwner(GameChallengLeagueUnit(num),Player(9),true)
            UnitRemoveAbility(GameChallengLeagueUnit(num),'AZ19')
            UnitAddAbility(GameChallengLeagueUnit(num),'AZ20')
            UnitAddAbility(GameChallengLeagueUnit(num),'AZ7A'+num-1)
            SetPlayerLeagueState(num,true)
        else
            SetUnitOwner(GameChallengLeagueUnit(num),Player(11),true)
            UnitRemoveAbility(GameChallengLeagueUnit(num),'AZ19')
            UnitAddAbility(GameChallengLeagueUnit(num),'AZ21')
            UnitAddAbility(GameChallengLeagueUnit(num),'AZ8A'+num-1)
        endif
    endfunction

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
        real de = 0
        if  PlayerChallengeCosNum(flag) > 0
            life = GetUnitRealState(u,5)
            for num = 1,PlayerChallengeCosNum(flag)
                life = life * 1.2
            end
            SetUnitRealState(u,5,life)

            de = GetUnitRealState(u,3)
            de = de + 8*PlayerChallengeCosNum(flag)
            if  de > 96
                de = 96
            endif
            SetUnitRealState(u,3,de)

            de = GetUnitRealState(u,4)
            de = de + 8*PlayerChallengeCosNum(flag)
            if  de > 96
                de = 96
            endif
            SetUnitRealState(u,4,de)
        endif
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

    function CreateTrigUnitInRange(real x,real y,real rac,code actionFunc)
        trigger tig = null
        unit u = null
        tig = CreateTrigger() //姜子牙
        u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',x,y,0)
        SetUnitVertexColor(u,255,255,255,0)
        EXSetUnitMoveType(u,0x01)
        TriggerRegisterUnitInRange(tig,u,rac,null)
        TriggerAddAction(tig, actionFunc)
        tig = null
        u = null
    endfunction

endlibrary







