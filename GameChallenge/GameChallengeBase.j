library GameChallengeBase initializer InitGameChallengeFunc uses DamageCode,PlotSelectFrame

    int array unitplayercos[6][680]

    #define unitcos unitplayercos[pid]

    int array       GameChallengPlayerInt[12][680]
    unit array      GameChallengPlayerUnit[12][680]
    bool array      GameChallengPlayerBool[12][680]

    int array      GameChallengOperaWay

    unit array      GameChallengMapUnit

    bool array      GameTeamChallengeBool

    #define GameChallengInt                 GameChallengPlayerInt[pid]
    #define GameChallengUnit                GameChallengPlayerUnit[pid]
    #define GameChallengBool                GameChallengPlayerBool[pid]

    #define PlayerInChallengeShowUnit       GameChallengUnit[500]
    #define IsPlayerInChallenge             GameChallengBool[500]
    #define IsFinshChallenge(num)           GameChallengBool[500+num]

    #define IsPlayerInTeamChallenge         GameChallengBool[550]

    #define PlayerInChallengeNumber         GameChallengInt[500]
    #define PlayerChallengeCosNum           GameChallengInt[501]

    #define GameBiaoJI                      GameChallengMapUnit

    #define GameChallengLeagueUnit(num)     GameChallengMapUnit[50+num]

    #define GameTeamChallengUnit(num)       GameChallengMapUnit[100+num]

    #define GameChalleng_0_JZY              GameChallengMapUnit[500]

    #define GameTeamChallengeInt(num)       GameChallengOperaWay[50+num]

    #define UnitAPOfPlayer  0

    group array AttackSummonUnitGroup

    function AddAttackSummonUnit(int pid,unit u)
        GroupAddUnit(AttackSummonUnitGroup[pid],u)
    endfunction

    function RemoveAttackSummonUnit(int pid,unit u)
        GroupRemoveUnit(AttackSummonUnitGroup[pid],u)
    endfunction

    function FlushAttackSummonUnitGroupFunc()
        FlushChildHashtable(ht,GetHandleId(GetEnumUnit()))
        RemoveUnit(GetEnumUnit())
    endfunction

    function FlushAttackSummonUnitGroup(int pid)
        if  CountUnitsInGroup(AttackSummonUnitGroup[pid]) > 0
            BJDebugMsg("清空所有召唤的练功房怪")
            ForGroup(AttackSummonUnitGroup[pid],function FlushAttackSummonUnitGroupFunc)
        endif
    endfunction

    function AttackSummonUnitGroupDeathEvent(int pid,unit u)
        FlushAttackSummonUnitGroup(pid)
        BJDebugMsg("死亡清空所有召唤的练功房怪")
    endfunction

    function SendOperaRectRange()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        real x = 0
        real y = 0
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  GetUnitAbilityLevel(Pu[1],'AZ96') > 0
                    if  GetUnitAbilityLevel(Pu[1],'AZ96') == 1
                        if  pid == 0
                            x = 1342
                            y = -2752
                        elseif  pid == 1
                            x = 2048
                            y = -2752
                        elseif  pid == 2
                            x = 1344
                            y = -3328
                        elseif  pid == 3
                            x = 2048
                            y = -3328
                        endif
                        SendPlayerUnit(pid,x,y)
                        AddEffectInArea(1685,-3104,480,18,"effect_yanhua1.mdx")
                        AddEffectInArea(1685,-3104,480,18,"effect_yanhua2.mdx")
                    elseif  GetUnitAbilityLevel(Pu[1],'AZ96') == 2
                        if  pid == 0
                            x = 2300
                            y = -140
                        elseif  pid == 1
                            x = 2625
                            y = -460
                        elseif  pid == 2
                            x = 2240
                            y = -308
                        elseif  pid == 3
                            x = 2458
                            y = -524
                        endif
                        SendPlayerUnit(pid,x,y)
                    elseif  GetUnitAbilityLevel(Pu[1],'AZ96') == 3
                        if  pid == 0
                            x = 2976
                            y = -2720
                        elseif  pid == 1
                            x = 2976
                            y = -2880
                        elseif  pid == 2
                            x = 2848
                            y = -2720
                        elseif  pid == 3
                            x = 2848
                            y = -2880
                        endif
                        SendPlayerUnit(pid,x,y)
                    elseif  GetUnitAbilityLevel(Pu[1],'AZ96') >= 4
                        if  pid == 0
                            PlayerReviveX = -1984
                            PlayerReviveY = -7136
                        elseif  pid == 1
                            PlayerReviveX = -1344
                            PlayerReviveY = -7136
                        elseif  pid == 2
                            PlayerReviveX = -1344
                            PlayerReviveY = -7808
                        elseif  pid == 3
                            PlayerReviveX = -1984
                            PlayerReviveY = -7808
                        endif
                        SendPlayerUnit(pid,PlayerReviveX,PlayerReviveY)
                        if  GetUnitAbilityLevel(Pu[1],'AZ96') == 5
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r进入封神台！！！")
                        else    
                            SetUnitAbilityLevel(Pu[1],'AZ96',5)
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r进入封神台！！！|cff00ff00默认回城点已改为封神台！！！|r")
                        endif
                    endif
                endif
            endif
        endif
        flush locals
    endfunction

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
        for num = 1,8
            EXSetUnitMoveType(GameChallengLeagueUnit(num),0x01)
        end
    endfunction
    
    function SetLeagueUnitOverState(unit wu,real time)
        unit u = wu
        TimerStart(time,false)
        {
            UnitRemoveAbility(u,'Avul')
            EXSetUnitMoveType(u,0x02)
            LocAddEffectSetSize(GetUnitX(u),GetUnitY(u),"effect_tx_asad (24).mdx",1)
            LocAddEffectSetSize(GetUnitX(u),GetUnitY(u),"effect_az-leiji.mdx",2)
            PauseUnit(u,false)
            SetUnitAnimation(u,"attack")
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function OpenChangeGodStageLeagueUnit(real r1,real r2)
        real x = r1
        real y = r2
        int num = 0
        TimerStart(0.3,true)
        {   
            real sx = 0
            real sy = 0
            real ex = 0
            real ey = 0
            real ang = 0
            int bossnum = 0
            int bossid = 0
            num = num + 1
            if  num <= 8
                sx = GetUnitX(GameChallengLeagueUnit(num))
                sy = GetUnitY(GameChallengLeagueUnit(num))
                ex = sx + x
                ey = sy + y
                ang = GetUnitFacing(GameChallengLeagueUnit(num))
                LocAddEffect(sx,sy,"effect_az_goods_lvlup(3).mdl")
                SetUnitXY(GameChallengLeagueUnit(num),ex,ey)
                LocAddEffect(ex,ey,"effect_effect_az_goods_tp_target_effect(4).mdl")
                if  GetUnitAbilityLevel(GameChallengLeagueUnit(num),'AZ20') > 0
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[最终决战]：|r"+GetObjectName('md00'+num)+"|cff00ff00加入友军作战！|r")
                    RemoveUnit(GameChallengLeagueUnit(num))
                    GameChallengLeagueUnit(num) = CreateUnit(Player(9),'md00'+num,ex,ey,ang)

                    bossnum = (AttackUnitWNOver/3)
                    if  bossnum < 10
                        bossid = 'mb00'+ bossnum
                    else
                        bossid = 'mb10'
                    endif
                    SetUnitRealStateOfOtherId(GameChallengLeagueUnit(num),bossid)
                    SetUnitRealState(GameChallengLeagueUnit(num),1,GetUnitRealState(GameChallengLeagueUnit(num),1)*0.1)
                    SetUnitRealState(GameChallengLeagueUnit(num),5,GetUnitRealState(GameChallengLeagueUnit(num),5)*0.1)


                    UnitAddAbility(GameChallengLeagueUnit(num),'AZ20')
                    UnitAddAbility(GameChallengLeagueUnit(num),'Avul')
                    EXSetUnitMoveType(GameChallengLeagueUnit(num),0x01)
                    PauseUnit(GameChallengLeagueUnit(num),true)
                    SetLeagueUnitOverState(GameChallengLeagueUnit(num),10)
                elseif  GetUnitAbilityLevel(GameChallengLeagueUnit(num),'AZ21') > 0
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[最终决战]：|r"+GetObjectName('md00'+num)+"|cffff0000加入敌军作战！|r")
                    RemoveUnit(GameChallengLeagueUnit(num))
                    GameChallengLeagueUnit(num) = CreateUnit(Player(11),'md00'+num,ex,ey,ang)
                    
                    bossnum = (AttackUnitWNOver/3)
                    if  bossnum < 10
                        bossid = 'mb00'+ bossnum
                    else
                        bossid = 'mb10'
                    endif
                    SetUnitRealStateOfOtherId(GameChallengLeagueUnit(num),bossid)
                    SetUnitRealState(GameChallengLeagueUnit(num),1,GetUnitRealState(GameChallengLeagueUnit(num),1)*0.3)
                    SetUnitRealState(GameChallengLeagueUnit(num),5,GetUnitRealState(GameChallengLeagueUnit(num),5)*0.3)

                    UnitAddAbility(GameChallengLeagueUnit(num),'AZ21')
                    UnitAddAbility(GameChallengLeagueUnit(num),'Avul')
                    EXSetUnitMoveType(GameChallengLeagueUnit(num),0x01)
                    PauseUnit(GameChallengLeagueUnit(num),true)
                    SetLeagueUnitOverState(GameChallengLeagueUnit(num),10)
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function OpenChangeGodStage()
        real x = OriginalDefendX
        real y = OriginalDefendY
        unit u = null
        real ux = 0
        real uy = 0
        int time = 60
        RemoveUnit(GameDefendUnit)
        u = CreateTmUnit(Player(PLAYER_NEUTRAL_PASSIVE),"effect_az_goods_tp_target(3).mdl",x,y,0,0,1.8)
        EXSetUnitMoveType(u,0x01)
        u = CreateTmUnit(Player(PLAYER_NEUTRAL_PASSIVE),"sunwell.mdl",x,y,0,5,1.98)
        EXSetUnitMoveType(u,0x01)
        CreateTrigUnitInRange(u,198,function SendOperaRectRange)
        PingMinimap(x,y,8)
        GameDefendUnit = CreateUnit(Player(9),'np20',-1664,-7440,90)
        OriginalDefendX = GetUnitX(GameDefendUnit)
        OriginalDefendY = GetUnitY(GameDefendUnit)
        EXSetUnitMoveType(GameDefendUnit,0x01)
        SetUnitAnimation(GameDefendUnit,"stand 3")
        LocAddEffectSetSize(OriginalDefendX,OriginalDefendY,"effect_shengguang.mdx",5)
        x = OriginalDefendX - x
        y = OriginalDefendY - y
        for pid = 0,3
            if  IsPlaying(pid) == true 
                RemoveUnit(GameChallengUnit[200])
                GameChallengUnit[200] = null
                RemoveUnit(GameChallengUnit[201])
                GameChallengUnit[201] = null
                PlayerReviveX = -6560
                PlayerReviveY = -6592
                UnitAddAbility(Pu[1],'AZ96')
                SetUnitAbilityLevel(Pu[1],'AZ96',4)
            endif
        end
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神]：|r|cffff0000即将进入最终大决战，封神台传送阵已激活！！！请所有玩家在倒计时内F2前往封神台战斗！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神]：|r|cffff0000即将进入最终大决战，封神台传送阵已激活！！！请所有玩家在倒计时内F2前往封神台战斗！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神]：|r|cffff0000即将进入最终大决战，封神台传送阵已激活！！！请所有玩家在倒计时内F2前往封神台战斗！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神]：|r|cffff0000即将进入最终大决战，封神台传送阵已激活！！！请所有玩家在倒计时内F2前往封神台战斗！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神]：|r|cffff0000即将进入最终大决战，封神台传送阵已激活！！！请所有玩家在倒计时内F2前往封神台战斗！！！|r")
        TimerStart(1,true)
        {
            time = time - 1
            if  time > 0
                if  time > 10 and time <= 40
                    if  ModuloInteger(time,5) == 0
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[封神]：|r|cffff0000距离最终决战还剩|cff00ff00"+I2S(time)+"秒|cffff0000，请所有玩家F2前往封神台做好战斗准备！！！|r")
                    endif
                elseif  time <= 10
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,2,"|cffffcc00[封神]：|r|cffff0000距离最终决战还剩|cff00ff00"+I2S(time)+"秒|cffff0000，请所有玩家F2前往封神台准备战斗！！！|r")
                endif
            else
                OpenChangeGodStageLeagueUnit(x,y)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    
    function CreateChangeGodStageFunc()
        timer t = GetExpiredTimer()
        BJDebugMsg("CreateChangeGodStageFunc")
        OpenChangeGodStage()
        FlushChildHashtable(ht,GetHandleId(t))
        DestroyTimer(t)
        t = null
    endfunction

    function CreateChangeGodStage(real time)
        BJDebugMsg("CreateChangeGodStage")
        time = time - 60
        TimerStart(CreateTimer(),time,false,function CreateChangeGodStageFunc)
    endfunction

    function SetPlayerLeagueState(int num,bool b)
        int t = 1
        if  b == false
            t = -1
        endif
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  num == 1
                    AddUnitRealState(Pu[1],18,t*10)
                elseif  num == 2
                    AddUnitRealState(Pu[1],10,t*15)
                elseif  num == 3
                    AddUnitRealState(Pu[1],32,t*30)
                elseif  num == 4
                    AddUnitRealState(Pu[1],4,t*15)
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

    function ShowtOperaRectRange(bool value)
        bool show = value
        for pid = 0,3
            if  IsPlaying(pid) == true 
                if  show == true
                    UnitRemoveAbility(GameChallengUnit[200],'Apiv')
                    UnitRemoveAbility(GameChallengUnit[201],'Apiv')
                    UnitRemoveAbility(GameChallengUnit[202],'Apiv')
                    UnitRemoveAbility(GameChallengUnit[203],'Apiv')
                else
                    UnitAddAbility(GameChallengUnit[200],'Apiv')
                    UnitAddAbility(GameChallengUnit[201],'Apiv')
                    UnitAddAbility(GameChallengUnit[202],'Apiv')
                    UnitAddAbility(GameChallengUnit[203],'Apiv')
                endif
            endif
        end
    endfunction

    function ColserOperaATimerUnit()
        for num = 0,1
            SetUnitVertexColor(GameTeamChallengUnit(num+10),255,255,255,0)
            UnitRemoveAbility(GameTeamChallengUnit(num+10),'AZ99')
        end
    endfunction
    function ColserOperaBTimerUnit()
        for num = 2,3
            SetUnitVertexColor(GameTeamChallengUnit(num+10),255,255,255,0)
            UnitRemoveAbility(GameTeamChallengUnit(num+10),'AZ99')
        end
    endfunction
    function ColserOperaCTimerUnit()
        for num = 4,5
            SetUnitVertexColor(GameTeamChallengUnit(num+10),255,255,255,0)
            UnitRemoveAbility(GameTeamChallengUnit(num+10),'AZ99')
        end
    endfunction

    function InitOperaRectRange()
        real x = 0
        real y = 0
        for pid = 0,3
            if  IsPlaying(pid) == true 
                if  pid == 0
                    x = -7584+30
                    y = -5312
                    GameChallengUnit[202] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x-280,y,0)
                    GameChallengUnit[203] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x-450,y,0)
                elseif  pid == 1
                    x = -5184
                    y = -6240-30
                    GameChallengUnit[202] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x,y+280,270)
                    GameChallengUnit[203] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x,y+450,270)
                elseif  pid == 2
                    x = -6240-30
                    y = -8512
                    GameChallengUnit[202] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x+280,y,180)
                    GameChallengUnit[203] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x+450,y,180)
                elseif  pid == 3
                    x = -8640
                    y = -7584+30
                    GameChallengUnit[202] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x,y-280,90)
                    GameChallengUnit[203] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x,y-450,90)
                endif 
                GameChallengUnit[200] = CreateTmUnit(Player(PLAYER_NEUTRAL_PASSIVE),"effect_az_goods_tp_target(3).mdl",x,y,0,0,1.0)
                EXSetUnitMoveType(GameChallengUnit[200],0x01)
                GameChallengUnit[201] = CreateTmUnit(Player(PLAYER_NEUTRAL_PASSIVE),"sunwell.mdl",x,y,0,0,1.1)
                EXSetUnitMoveType(GameChallengUnit[201],0x01)
                UnitAddAbility(GameChallengUnit[200],'Apiv')
                UnitAddAbility(GameChallengUnit[201],'Apiv')
                CreateTrigUnitInRange(GameChallengUnit[201],120,function SendOperaRectRange)

                for num = 0,1
                    EXSetUnitMoveType(GameChallengUnit[202+num],0x01)
                    SetUnitColor(GameChallengUnit[202+num], PLAYER_COLOR_YELLOW )
                    UnitAddAbility(GameChallengUnit[202+num],'Apiv')
                end

            endif
        end
        GameTeamChallengUnit(10) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',1614.000,-3120,270)
        GameTeamChallengUnit(11) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',1762.000,-3120,270)
        GameTeamChallengUnit(12) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',2720.250,16.5,270)
        GameTeamChallengUnit(13) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',2868.250,16.5,270)
        GameTeamChallengUnit(14) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',3600.000,-2456,270)
        GameTeamChallengUnit(15) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',3748.000,-2456,270)

        for num = 0,5
            SetUnitScale(GameTeamChallengUnit(num+10),10.5,10.5,10.5)
            SetUnitVertexColor(GameTeamChallengUnit(num+10),255,255,255,0)
            SetUnitFlyHeight(GameTeamChallengUnit(num+10),10,10000)
        end
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
        ExecuteFunc("InitGameChallenge_9")
        ExecuteFunc("InitGameChallenge_10")
        ExecuteFunc("InitGameChallengeLeaveRctEvent")
        ExecuteFunc("InitGameTeamChallengeLeaveRctEvent")
        ExecuteFunc("InitOperaRectRange")
    endfunction

    function SetPlayerAllianceVISION(int pid,bool value)
        for n = 0,3
            if  n != pid
                SetPlayerAlliance(Player(pid),Player(n),ALLIANCE_SHARED_VISION,value)
            end
        end
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

    function GetCanUsesGameTeamChallengUnitID()->int
        for num = 200,300
            if  GameTeamChallengUnit(num) == null
                return num
            endif
        end
        return 0
    endfunction

    function GameTeamChallengCanUsesUnitFlushEx()
        for num = 10,20
            if  GameTeamChallengUnit(num) != null
                FlushChildHashtable(ht,GetHandleId(GameTeamChallengUnit(num)))
                RemoveUnit(GameTeamChallengUnit(num))
                GameTeamChallengUnit(num) = null
            endif
        end
    endfunction

    function GameTeamChallengCanUsesUnitFlush()
        GameTeamChallengCanUsesUnitFlushEx()
        for num = 200,300
            if  GameTeamChallengUnit(num) != null
                FlushChildHashtable(ht,GetHandleId(GameTeamChallengUnit(num)))
                RemoveUnit(GameTeamChallengUnit(num))
                GameTeamChallengUnit(num) = null
            endif
        end
    endfunction

    function UnitAddEffectOfNPC(unit u)
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_tx_asad (24).mdx")
        LocAddEffectSetSize(GetUnitX(u),GetUnitY(u),"effect_az-leiji.mdx",2)
    endfunction

    function CreateUsesGameTeamChalleng(int num,int uid,real x,real y,real ang)
        //BJDebugMsg(I2S(num))
        GameTeamChallengUnit(num) = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),uid,x,y,ang)
        SetUnitRealState(GameTeamChallengUnit(num),99,num)
        UnitAddEffectOfNPC(GameTeamChallengUnit(num))
    endfunction

    function CreateUsesGameChallengUnitOfAng(int pid,int num,int uid,real x,real y,real ang)
        //BJDebugMsg(I2S(num))
        GameChallengUnit[num] = CreateUnit(Player(pid+4),uid,x,y,ang)
        ShowUnitOfOnlyPlayer(pid,GameChallengUnit[num],UnitAPOfPlayer)
        SetUnitRealState(GameChallengUnit[num],99,num)
        UnitAddAbility(GameChallengUnit[num],'AZ99')
        SetUnitAbilityLevel(GameChallengUnit[num],'AZ99',pid+1)
        EXSetUnitCollisionType( false,GameChallengUnit[num], 1 )
        SetUnitColor(GameChallengUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
    endfunction

    function CreateUsesGameChallengUnit(int pid,int num,int uid,real x,real y)
        //BJDebugMsg(I2S(num))
        CreateUsesGameChallengUnitOfAng(pid,num,uid,x,y,0)
    endfunction

    function CreateUsesGameChallengUnitExOfAng(int pid,int num,int uid,real x,real y,real ang)
        //BJDebugMsg(I2S(num))
        GameChallengUnit[num] = CreateUnit(Player(pid+4),uid,x,y,ang)
        SetUnitOwner(GameChallengUnit[num],Player(PLAYER_NEUTRAL_PASSIVE),true)
        ShowUnitOfOnlyPlayer(pid,GameChallengUnit[num],UnitAPOfPlayer)
        SetUnitRealState(GameChallengUnit[num],99,num)
        UnitAddAbility(GameChallengUnit[num],'AZ99')
        SetUnitAbilityLevel(GameChallengUnit[num],'AZ99',pid+1)
        EXSetUnitCollisionType( false,GameChallengUnit[num], 1 )
    endfunction

    function CreateUsesGameChallengUnitEx(int pid,int num,int uid,real x,real y)
        //BJDebugMsg(I2S(num))
        CreateUsesGameChallengUnitExOfAng(pid,num,uid,x,y,0)
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
        /*int cosa = 0
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
        endif*/
        return GetRandomInt(0,1)
    endfunction

    function SetUnitOverStateOfGameChalleng(int pid,unit u,int flag)
        real value = 0
        value = 1.1+(PlayerChallengeCosNum*0.1)
        if  flag == 0 //小怪
            value = value * 0.2
        elseif  flag == 1 //1精英
            value = value * 0.7
        // 2 BOSS
        endif
        SetUnitRealStateOfOtherIdAddValue(u,'uf86',value)
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

    function CreateTrigUnitInRangeOfGameChallenge(real x,real y,real rac,code actionFunc)
        trigger tig = null
        unit u = null
        tig = CreateTrigger() 
        u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',x,y,0)
        SetUnitVertexColor(u,255,255,255,0)
        EXSetUnitMoveType(u,0x01)
        TriggerRegisterUnitInRange(tig,u,rac,null)
        TriggerAddAction(tig, actionFunc)
        tig = null
        u = null
    endfunction

    /////////////////////////顺序调整///////////////////////////////////////////////
    
    /*function GameChallenge_GlobalFlushBool(int id,real time)
        int pid = id
        TimerStart(time,false)
        {
            IsPlayerInChallenge = false
            endtimer
            flush locals
        }
        flush locals
    endfunction*/
    
    function GameChallenge_GlobalFlush(int pid,real time)
        GameChallengCanUsesUnitFlush(pid)
        ShowUnitOfAllPlayer(Pu[1])
        RemoveUnit(PlayerInChallengeShowUnit)
        PlayerInChallengeShowUnit = null
        PlayerInChallengeNumber = 0
        SetPlayerAllianceVISION(pid,true)
        //GameChallenge_GlobalFlushBool(pid,1)
        IsPlayerInChallenge = false
        if  time == -1
            if  Player(pid) == GetLocalPlayer()
                PlayerTaskUI_Back.alpha = 0
                PlayerTaskUI_Back.show = false
            endif
        else
            ShowPlayerTaskUIOfPlayer(pid,false,time)
        endif
        if  Player(pid) == GetLocalPlayer()
            PlayerTaskUI_TaskText.SetText("")
            PlayerTaskUI_ChatTextA.SetText("")
            PlayerTaskUI_ChatTextB.SetText("")
        endif
    endfunction

    function GameChallenge_1Flush(int pid)
        for num = 0,5
            SetUnitVertexColor(GameChallengUnit[10+num],255,255,255,0)
        end
        GameChallengInt[10] = 0
        GameChallengInt[11] = 0
        GameChallengBool[10] = false
        GameChallengBool[11] = false
        if  GameChallengUnit[19] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[19]))
            RemoveUnit(GameChallengUnit[19])
            GameChallengUnit[19] = null
        endif
    endfunction

    function GameChallenge_2Flush(int pid)
        SetUnitVertexColor(GameChallengUnit[22],255,255,255,0)
        if  GameChallengUnit[29] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[29]))
            RemoveUnit(GameChallengUnit[29])
            GameChallengUnit[29] = null
        endif
        GameChallengInt[20] = 0
        if  GetUnitAbilityLevel(Pu[1],'AZ04') > 0
            UnitRemoveAbility(Pu[1],'AZ04')
        endif
    endfunction

    function GameChallenge_3Flush(int pid)
        for num = 0,3
            SetUnitVertexColor(GameChallengUnit[30+num],255,255,255,0)
        end
        GameChallengInt[30] = 0
        if  GameChallengUnit[39] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[39]))
            RemoveUnit(GameChallengUnit[39])
            GameChallengUnit[39] = null
        endif
    endfunction

    function GameChallenge_4Flush(int pid)
        for num = 0,7
            SetUnitVertexColor(GameChallengUnit[40+num],255,255,255,0)
        end
        GameChallengInt[40] = 0
        SetUnitAnimation(GameChallengUnit[43],"stand")
    endfunction

    function GameChallenge_5Flush(int pid)
        SetUnitVertexColor(GameChallengUnit[50],255,255,255,0)
        SetUnitVertexColor(GameChallengUnit[51],255,255,255,0)
        GameChallengInt[50] = 0
        if  GameChallengUnit[59] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[59]))
            RemoveUnit(GameChallengUnit[59])
            GameChallengUnit[59] = null
        endif
    endfunction
    
    function GameChallenge_6Flush(int pid)
        for num = 0,3
            SetUnitVertexColor(GameChallengUnit[60+num],255,255,255,0)
        end
        GameChallengInt[60] = 0
        if  GameChallengUnit[69] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[69]))
            RemoveUnit(GameChallengUnit[69])
            GameChallengUnit[69] = null
        endif
    endfunction

    function GameChallenge_7Flush(int pid)
        for num = 0,9
            SetUnitVertexColor(GameChallengUnit[70+num],255,255,255,0)
        end
    endfunction

    function GameChallenge_8Flush(int pid)
        for num = 0,3
            SetUnitVertexColor(GameChallengUnit[80+num],255,255,255,0)
        end
        GameChallengInt[80] = 0
        if  GameChallengUnit[89] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[89]))
            RemoveUnit(GameChallengUnit[89])
            GameChallengUnit[89] = null
        endif
    endfunction

    function GameChallengeFluahAll(int pid,real time)
        GameChallenge_1Flush(pid)
        GameChallenge_2Flush(pid)
        GameChallenge_3Flush(pid)
        GameChallenge_4Flush(pid)
        GameChallenge_5Flush(pid)
        GameChallenge_6Flush(pid)
        GameChallenge_7Flush(pid)
        GameChallenge_8Flush(pid)
        GameChallenge_GlobalFlush(pid,time)
    endfunction

endlibrary







