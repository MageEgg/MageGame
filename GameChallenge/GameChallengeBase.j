library GameChallengeBase initializer InitGameChallengeFunc uses DamageCode,PlotSelectFrame

    int array unitplayercos[6][680]

    #define unitcos unitplayercos[pid]

    int array       GameChallengePlayerInt[12][680]
    unit array      GameChallengePlayerUnit[12][680]
    bool array      GameChallengePlayerBool[12][680]
    real array      GameChallengePlayerReal[12][680]

    int array       GameChallengeOperaWay

    unit array      GameChallengeMapUnit

    bool array      GameTeamChallengeBool

    #define GameChallengeInt                GameChallengePlayerInt[pid]
    #define GameChallengeUnit               GameChallengePlayerUnit[pid]
    #define GameChallengeBool               GameChallengePlayerBool[pid]
    #define GameChallengeReal               GameChallengePlayerReal[pid]

    #define PlayerInChallengeShowUnit       GameChallengeUnit[500]
    #define IsPlayerInChallenge             GameChallengeBool[500]
    #define IsFinshChallenge(num)           GameChallengeBool[500+num]

    #define IsPlayerInTeamChallenge         GameChallengeBool[550]
    #define IsPlayerInTeamChallenge2        GameChallengeBool[551]

    #define PlayerInChallengeNumber         GameChallengeInt[500]
    #define PlayerChallengeOverCosNum       GameChallengeInt[501]
    #define PlayerChallengeWMCos            GameChallengeInt[502]

    #define PlayerChallengeTimeCosNum(num)  GameChallengeInt[510+num]

    #define GameBiaoJI                      GameChallengeMapUnit

    #define GameChallengLeagueUnit(num)     GameChallengeMapUnit[50+num]

    #define GameTeamChallengUnit(num)       GameChallengeMapUnit[100+num]

    #define GameChallenge_0_JZY             GameChallengeMapUnit[500]
    #define GameChallenge_MJ_BOSS           GameChallengeMapUnit[501]

    #define GameTeamChallengeInt(num)       GameChallengeOperaWay[50+num]

    #define GameChallengeWM_OriginX         GameChallengeReal[0]
    #define GameChallengeWM_OriginY         GameChallengeReal[1]
    #define GameChallengeWM_MX              GameChallengeReal[2]
    #define GameChallengeWM_MY              GameChallengeReal[3]

    #define UnitAPOfPlayer 0

    int PlayerTeamChallengeCosNum = 0
    int PlayerTeamChallengeCosNum2 = 0

    group array AttackSummonUnitGroup
    group array WMSummonUnitGroup

    rect array ChallengeGameRct

    #define ChallengeRct_MJ                 ChallengeGameRct  //1-10
    #define ChallengeRct_WM(num)            ChallengeGameRct[10+num]  //1-10

    texttag array GameChallengeTexttag

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
            for num = 0,9
                IsPlayerInAttackUnitChallenge(num) = 0
                AttackUnitChallengePlayerKillCos(num) = 0
            end
        endif
    endfunction

    function AttackSummonUnitGroupDeathEvent(int pid,unit u)
        if  GameMode != 4
            FlushAttackSummonUnitGroup(pid)
            BJDebugMsg("死亡清空所有召唤的练功房怪")
        else
            BJDebugMsg("超爽模式不清除怪")
        endif
    endfunction

    function AttackSummonUnitGroupFunc()
        int pid = 0
        if  GetUnitAbilityLevel(GetEnumUnit(),'AZ99') > 0
            pid = GetUnitAbilityLevel(GetEnumUnit(),'AZ99')-1
        endif
        if  GetUnitCurrentOrder(GetEnumUnit()) == 0 
            IssuePointOrderById(GetEnumUnit(),851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
        endif
    endfunction
    
    function AttackSummonUnitGroupTimer(int pid)
        ForGroup(AttackSummonUnitGroup[pid],function AttackSummonUnitGroupFunc)
    endfunction

    function AddWMSummonUnit(int pid,unit u)
        GroupAddUnit(WMSummonUnitGroup[pid],u)
    endfunction

    function RemoveWMSummonUnit(int pid,unit u)
        GroupRemoveUnit(WMSummonUnitGroup[pid],u)
    endfunction

    function FlushWMSummonUnitGroupFunc()
        FlushChildHashtable(ht,GetHandleId(GetEnumUnit()))
        RemoveUnit(GetEnumUnit())
    endfunction

    function FlushWMSummonUnitGroup(int pid)
        if  CountUnitsInGroup(WMSummonUnitGroup[pid]) > 0
            BJDebugMsg("清空所有召唤的万魔窟怪")
            ForGroup(WMSummonUnitGroup[pid],function FlushWMSummonUnitGroupFunc)
        endif
    endfunction

    function WMSummonUnitGroupDeathEvent(int pid,unit u)
        FlushWMSummonUnitGroup(pid)
        BJDebugMsg("死亡清空所有召唤的万魔窟怪")
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
            ShowUnit(GameChallengLeagueUnit(num),false)
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
            //SetUnitAnimation(u,"attack")
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

        u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x-420,y,0)
        EXSetUnitMoveType(u,0x01)
        SetUnitColor(u,PLAYER_COLOR_YELLOW)
        u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x-590,y,0)
        EXSetUnitMoveType(u,0x01)
        SetUnitColor(u,PLAYER_COLOR_YELLOW)

        u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x+420,y,180)
        EXSetUnitMoveType(u,0x01)
        SetUnitColor(u,PLAYER_COLOR_YELLOW)
        u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x+590,y,180)
        EXSetUnitMoveType(u,0x01)
        SetUnitColor(u,PLAYER_COLOR_YELLOW)

        u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x,y+420,270)
        EXSetUnitMoveType(u,0x01)
        SetUnitColor(u,PLAYER_COLOR_YELLOW)
        u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x,y+590,270)
        EXSetUnitMoveType(u,0x01)
        SetUnitColor(u,PLAYER_COLOR_YELLOW)

        u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x,y-420,90)
        EXSetUnitMoveType(u,0x01)
        SetUnitColor(u,PLAYER_COLOR_YELLOW)
        u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x,y-590,90)
        EXSetUnitMoveType(u,0x01)
        SetUnitColor(u,PLAYER_COLOR_YELLOW)

        GameDefendUnit = CreateUnit(Player(9),'np20',-1664,-7440,90)
        OriginalDefendX = GetUnitX(GameDefendUnit)
        OriginalDefendY = GetUnitY(GameDefendUnit)
        PingMinimap(OriginalDefendX,OriginalDefendY,8)
        EXSetUnitMoveType(GameDefendUnit,0x01)
        SetUnitAnimation(GameDefendUnit,"stand 3")
        LocAddEffectSetSize(OriginalDefendX,OriginalDefendY,"effect_shengguang.mdx",5)
        x = OriginalDefendX - x
        y = OriginalDefendY - y
        for pid = 0,3
            if  IsPlaying(pid) == true 
                RemoveUnit(GameChallengeUnit[200])
                GameChallengeUnit[200] = null
                RemoveUnit(GameChallengeUnit[201])
                GameChallengeUnit[201] = null
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
                    if  time == 20
                        KillAttackUnitGroup()
                    endif
                elseif  time <= 10
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,2,"|cffffcc00[封神]：|r|cffff0000距离最终决战还剩|cff00ff00"+I2S(time)+"秒|cffff0000，请所有玩家F2前往封神台准备战斗！！！|r")
                    if  time == 1
                        for pid = 0,3
                            if  IsPlaying(pid) == true 
                                if  IsLocInRect(gg_rct_GameRect2,GetUnitX(Pu[1]),GetUnitY(Pu[1])) == false
                                    SetUnitXY(Pu[1],-6910,-6950)
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
                                    UnitAddAbility(Pu[1],'AZ96')
                                    SetUnitAbilityLevel(Pu[1],'AZ96',5)
                                    if  GetLocalPlayer() == Player(pid)
                                        SetPlayerCameraBoundsToRect(bj_mapInitialPlayableArea)
                                    endif
                                endif
                            endif
                        end
                    endif
                endif
            else
                if  GameTeamChallengeBool[10] == true  
                    OpenChangeGodStageLeagueUnit(x,y)
                endif
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

    function SetLeagueUnit(int num,bool flag)
        if  flag == true
            SetUnitOwner(GameChallengLeagueUnit(num),Player(9),true)
            UnitRemoveAbility(GameChallengLeagueUnit(num),'AZ19')
            UnitAddAbility(GameChallengLeagueUnit(num),'AZ20')
        else
            SetUnitOwner(GameChallengLeagueUnit(num),Player(11),true)
            UnitRemoveAbility(GameChallengLeagueUnit(num),'AZ19')
            UnitAddAbility(GameChallengLeagueUnit(num),'AZ21')
        endif
    endfunction

    function ShowtOperaRectRange(bool value)
        bool show = value
        for pid = 0,3
            if  IsPlaying(pid) == true 
                if  show == true
                    UnitRemoveAbility(GameChallengeUnit[200],'Apiv')
                    UnitRemoveAbility(GameChallengeUnit[201],'Apiv')
                    UnitRemoveAbility(GameChallengeUnit[202],'Apiv')
                    UnitRemoveAbility(GameChallengeUnit[203],'Apiv')
                else
                    UnitAddAbility(GameChallengeUnit[200],'Apiv')
                    UnitAddAbility(GameChallengeUnit[201],'Apiv')
                    UnitAddAbility(GameChallengeUnit[202],'Apiv')
                    UnitAddAbility(GameChallengeUnit[203],'Apiv')
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
                    x = -7554
                    y = -5312
                    GameChallengeUnit[202] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x-280,y,0)
                    GameChallengeUnit[203] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x-450,y,0)
                elseif  pid == 1
                    x = -5184
                    y = -6270
                    GameChallengeUnit[202] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x,y+280,270)
                    GameChallengeUnit[203] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x,y+450,270)
                elseif  pid == 2
                    x = -6270
                    y = -8512
                    GameChallengeUnit[202] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x+280,y,180)
                    GameChallengeUnit[203] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x+450,y,180)
                elseif  pid == 3
                    x = -8640
                    y = -7554
                    GameChallengeUnit[202] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x,y-280,90)
                    GameChallengeUnit[203] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x,y-450,90)
                endif 
                GameChallengeUnit[200] = CreateTmUnit(Player(PLAYER_NEUTRAL_PASSIVE),"effect_az_goods_tp_target(3).mdl",x,y,0,0,1.0)
                EXSetUnitMoveType(GameChallengeUnit[200],0x01)
                GameChallengeUnit[201] = CreateTmUnit(Player(PLAYER_NEUTRAL_PASSIVE),"sunwell.mdl",x,y,0,0,1.1)
                EXSetUnitMoveType(GameChallengeUnit[201],0x01)
                UnitAddAbility(GameChallengeUnit[200],'Apiv')
                UnitAddAbility(GameChallengeUnit[201],'Apiv')
                CreateTrigUnitInRange(GameChallengeUnit[201],120,function SendOperaRectRange)

                for num = 0,1
                    EXSetUnitMoveType(GameChallengeUnit[202+num],0x01)
                    SetUnitColor(GameChallengeUnit[202+num], PLAYER_COLOR_YELLOW )
                    UnitAddAbility(GameChallengeUnit[202+num],'Apiv')
                end

            endif
        end
        GameTeamChallengUnit(21) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',1614.000,-3120,270)
        GameTeamChallengUnit(22) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',1762.000,-3120,270)
        GameTeamChallengUnit(23) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',2720.250,16.5,270)
        GameTeamChallengUnit(24) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',2868.250,16.5,270)
        GameTeamChallengUnit(25) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',3600.000,-2456,270)
        GameTeamChallengUnit(26) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',3748.000,-2456,270)

        for num = 1,6
            SetUnitScale(GameTeamChallengUnit(num+20),10.5,10.5,10.5)
            SetUnitVertexColor(GameTeamChallengUnit(num+20),255,255,255,0)
            SetUnitFlyHeight(GameTeamChallengUnit(num+20),10,10000)
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

        ExecuteFunc("InitGameChallenge_11")
        ExecuteFunc("InitGameChallenge_12")

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
                if  GameChallengeBool[boolid] == false and GameChallengeBool[boolid-1] == true
                    if  Player(pid) == GetLocalPlayer()
                        ap = 255
                    endif
                endif
            else 
                if  GameChallengeBool[boolid] == false
                    if  Player(pid) == GetLocalPlayer()
                        ap = 255
                    endif
                endif
            endif
        end
        SetUnitVertexColor(u,255,255,255,ap)
    endfunction

    function IsCanMoveToRoom(int pid)->boolean
        if  GameChallengeBool[0] == false
            return false
        endif
        if  GameChallengeBool[1] == false
            return false
        endif
        if  GameChallengeBool[2] == false
            return false
        endif
        if  GameChallengeBool[3] == false
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

    function GetCanUsesGameChallengeUnitID(int pid)->int
        for num = 500,600
            if  GameChallengeUnit[num] == null
                return num
            endif
        end
        return 0
    endfunction

    function GameChallengCanUsesUnitFlush(int pid)
        for num = 500,600
            if  GameChallengeUnit[num] != null
                FlushChildHashtable(ht,GetHandleId(GameChallengeUnit[num]))
                RemoveUnit(GameChallengeUnit[num])
                GameChallengeUnit[num] = null
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

    function CreateUsesGameChallengeUnitOfAng(int pid,int num,int uid,real x,real y,real ang)
        //BJDebugMsg(I2S(num))
        GameChallengeUnit[num] = CreateUnit(Player(pid+4),uid,x,y,ang)
        ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[num],UnitAPOfPlayer)
        SetUnitRealState(GameChallengeUnit[num],99,num)
        UnitAddAbility(GameChallengeUnit[num],'AZ99')
        SetUnitAbilityLevel(GameChallengeUnit[num],'AZ99',pid+1)
        EXSetUnitCollisionType( false,GameChallengeUnit[num], 1 )
        SetUnitColor(GameChallengeUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
        IssueImmediateOrderById(GameChallengeUnit[num],852076)
    endfunction

    function CreateUsesGameChallengeUnit(int pid,int num,int uid,real x,real y)
        //BJDebugMsg(I2S(num))
        CreateUsesGameChallengeUnitOfAng(pid,num,uid,x,y,0)
    endfunction

    function CreateUsesGameChallengeUnitExOfAng(int pid,int num,int uid,real x,real y,real ang)
        //BJDebugMsg(I2S(num))
        GameChallengeUnit[num] = CreateUnit(Player(pid+4),uid,x,y,ang)
        SetUnitOwner(GameChallengeUnit[num],Player(PLAYER_NEUTRAL_PASSIVE),true)
        ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[num],UnitAPOfPlayer)
        SetUnitRealState(GameChallengeUnit[num],99,num)
        UnitAddAbility(GameChallengeUnit[num],'AZ99')
        SetUnitAbilityLevel(GameChallengeUnit[num],'AZ99',pid+1)
        EXSetUnitCollisionType( false,GameChallengeUnit[num], 1 )
        IssueImmediateOrderById(GameChallengeUnit[num],852076)
    endfunction

    function CreateUsesGameChallengeUnitEx(int pid,int num,int uid,real x,real y)
        //BJDebugMsg(I2S(num))
        CreateUsesGameChallengeUnitExOfAng(pid,num,uid,x,y,0)
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
            if  GameChallengeOperaWay[num] == 1
                cosa = cosa + 1
            elseif  GameChallengeOperaWay[num] == 2
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
        value = Pow(1.2,PlayerChallengeOverCosNum)
        SetUnitRealState(u,1,GetUnitRealState(u,1)*value)
        SetUnitRealState(u,5,GetUnitRealState(u,5)*value)
        
        //if  flag == 0 小怪
        //    value = value * 0.2
        //elseif  flag == 1 精英
        //    value = value * 0.7
        // 2 BOSS
        //endif
        //SetUnitRealStateOfOtherIdAddValue(u,'uf86',value)
    endfunction

    function SetUnitOverStateOfGameTeamChalleng(unit u,int flag)
        real value = 0
        value = Pow(1.2,PlayerTeamChallengeCosNum)
        SetUnitRealState(u,1,GetUnitRealState(u,1)*value)
        SetUnitRealState(u,5,GetUnitRealState(u,5)*value)
    endfunction

    function SetUnitOverStateOfGameTeamChalleng2(unit u,int flag)
        real value = 0
        value = Pow(1.2,PlayerTeamChallengeCosNum2)
        SetUnitRealState(u,1,GetUnitRealState(u,1)*value)
        SetUnitRealState(u,5,GetUnitRealState(u,5)*value)
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

    function ShowLeagueUnitNPC(int pid)
        for num = 1,8
            ShowUnit(GameChallengLeagueUnit(num),true)
            UnitAddEffectOfNPC(GameChallengLeagueUnit(num))
        end
        PingMinimap(GetUnitX(GameDefendUnit),GetUnitY(GameDefendUnit),5)
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神榜]：|r"+GetPlayerNameOfColor(pid)+"|cffffff00率先完成了8个副本，时渊盟军加入战场！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神榜]：|r"+GetPlayerNameOfColor(pid)+"|cffffff00率先完成了8个副本，时渊盟军加入战场！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神榜]：|r"+GetPlayerNameOfColor(pid)+"|cffffff00率先完成了8个副本，时渊盟军加入战场！！！|r")
    endfunction
    
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
            ClosePlayerTaskUIOfPlayerEx(pid)
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
            SetUnitVertexColor(GameChallengeUnit[10+num],255,255,255,0)
        end
        GameChallengeInt[10] = 0
        GameChallengeInt[11] = 0
        GameChallengeBool[10] = false
        GameChallengeBool[11] = false
        if  GameChallengeUnit[19] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengeUnit[19]))
            RemoveUnit(GameChallengeUnit[19])
            GameChallengeUnit[19] = null
        endif
    endfunction

    function GameChallenge_2Flush(int pid)
        SetUnitVertexColor(GameChallengeUnit[22],255,255,255,0)
        if  GameChallengeUnit[29] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengeUnit[29]))
            RemoveUnit(GameChallengeUnit[29])
            GameChallengeUnit[29] = null
        endif
        GameChallengeInt[20] = 0
        if  GetUnitAbilityLevel(Pu[1],'AZ04') > 0
            UnitRemoveAbility(Pu[1],'AZ04')
        endif
    endfunction

    function GameChallenge_3Flush(int pid)
        for num = 0,3
            SetUnitVertexColor(GameChallengeUnit[30+num],255,255,255,0)
        end
        GameChallengeInt[30] = 0
        if  GameChallengeUnit[39] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengeUnit[39]))
            RemoveUnit(GameChallengeUnit[39])
            GameChallengeUnit[39] = null
        endif
    endfunction

    function GameChallenge_4Flush(int pid)
        for num = 0,7
            SetUnitVertexColor(GameChallengeUnit[40+num],255,255,255,0)
        end
        GameChallengeInt[40] = 0
        SetUnitAnimation(GameChallengeUnit[43],"stand")
    endfunction

    function GameChallenge_5Flush(int pid)
        SetUnitVertexColor(GameChallengeUnit[50],255,255,255,0)
        SetUnitVertexColor(GameChallengeUnit[51],255,255,255,0)
        GameChallengeInt[50] = 0
        GameChallengeInt[51] = 0
        if  GameChallengeUnit[59] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengeUnit[59]))
            RemoveUnit(GameChallengeUnit[59])
            GameChallengeUnit[59] = null
        endif
    endfunction
    
    function GameChallenge_6Flush(int pid)
        for num = 0,3
            SetUnitVertexColor(GameChallengeUnit[60+num],255,255,255,0)
        end
        GameChallengeInt[60] = 0
        if  GameChallengeUnit[69] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengeUnit[69]))
            RemoveUnit(GameChallengeUnit[69])
            GameChallengeUnit[69] = null
        endif
    endfunction

    function GameChallenge_7Flush(int pid)
        for num = 0,9
            SetUnitVertexColor(GameChallengeUnit[70+num],255,255,255,0)
        end
    endfunction

    function GameChallenge_8Flush(int pid)
        for num = 0,3
            SetUnitVertexColor(GameChallengeUnit[80+num],255,255,255,0)
        end
        GameChallengeInt[80] = 0
        if  GameChallengeUnit[89] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengeUnit[89]))
            RemoveUnit(GameChallengeUnit[89])
            GameChallengeUnit[89] = null
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

    //地面文字
    function SetGameTeamChallengTimerText(unit wu,unit tu,int time)
        if  time >= 10
            s1 = SubString(I2S(time),0,1)
            s2 = SubString(I2S(time),1,2)
            DzSetUnitModel(wu,"UI_zhuatuzi"+SubString(I2S(time),0,1)+".mdl")
            DzSetUnitModel(tu,"UI_zhuatuzi"+SubString(I2S(time),1,2)+".mdl")
        else
            DzSetUnitModel(wu,"UI_zhuatuzi0.mdl")
            DzSetUnitModel(tu,"UI_zhuatuzi"+I2S(time)+".mdl")
        endif
    endfunction

    function OpenGameTeamChallengeTimer(int t,int fl)
        int time = t
        int flag = fl
        if  flag == 1
            SetUnitVertexColor(GameTeamChallengUnit(0),255,255,255,255)
            SetUnitVertexColor(GameTeamChallengUnit(1),255,255,255,255)
            UnitAddAbility(GameTeamChallengUnit(0),'AZ99')
            UnitAddAbility(GameTeamChallengUnit(1),'AZ99')
            SetGameTeamChallengTimerText(GameTeamChallengUnit(0),GameTeamChallengUnit(1),time)
        elseif  flag == 2
            SetUnitVertexColor(GameTeamChallengUnit(2),255,255,255,255)
            SetUnitVertexColor(GameTeamChallengUnit(3),255,255,255,255)
            UnitAddAbility(GameTeamChallengUnit(2),'AZ99')
            UnitAddAbility(GameTeamChallengUnit(3),'AZ99')
            SetGameTeamChallengTimerText(GameTeamChallengUnit(2),GameTeamChallengUnit(3),time)
        elseif  flag == 10
            SetUnitVertexColor(GameTeamChallengUnit(21),255,255,255,255)
            SetUnitVertexColor(GameTeamChallengUnit(22),255,255,255,255)
            UnitAddAbility(GameTeamChallengUnit(21),'AZ99')
            UnitAddAbility(GameTeamChallengUnit(22),'AZ99')
            SetGameTeamChallengTimerText(GameTeamChallengUnit(21),GameTeamChallengUnit(22),time)
        elseif  flag == 11
            SetUnitVertexColor(GameTeamChallengUnit(23),255,255,255,255)
            SetUnitVertexColor(GameTeamChallengUnit(24),255,255,255,255)
            UnitAddAbility(GameTeamChallengUnit(23),'AZ99')
            UnitAddAbility(GameTeamChallengUnit(24),'AZ99')
            SetGameTeamChallengTimerText(GameTeamChallengUnit(23),GameTeamChallengUnit(24),time)
        elseif  flag == 12
            SetUnitVertexColor(GameTeamChallengUnit(25),255,255,255,255)
            SetUnitVertexColor(GameTeamChallengUnit(26),255,255,255,255)
            UnitAddAbility(GameTeamChallengUnit(25),'AZ99')
            UnitAddAbility(GameTeamChallengUnit(26),'AZ99')
            SetGameTeamChallengTimerText(GameTeamChallengUnit(25),GameTeamChallengUnit(26),time)
        elseif  flag == 20
            SetUnitVertexColor(GameTeamChallengUnit(30),255,255,255,255)
            SetUnitVertexColor(GameTeamChallengUnit(31),255,255,255,255)
            UnitAddAbility(GameTeamChallengUnit(30),'AZ99')
            UnitAddAbility(GameTeamChallengUnit(31),'AZ99')
            SetGameTeamChallengTimerText(GameTeamChallengUnit(30),GameTeamChallengUnit(31),time)
        elseif  flag == 40
            SetUnitVertexColor(GameTeamChallengUnit(40),255,255,255,255)
            SetUnitVertexColor(GameTeamChallengUnit(41),255,255,255,255)
            UnitAddAbility(GameTeamChallengUnit(40),'AZ99')
            UnitAddAbility(GameTeamChallengUnit(41),'AZ99')
            SetGameTeamChallengTimerText(GameTeamChallengUnit(40),GameTeamChallengUnit(41),time)
        endif
        TimerStart(1,true)
        {
            time = time - 1
            if  time > 0
                if  flag == 1
                    if  GetUnitAbilityLevel(GameTeamChallengUnit(0),'AZ99') > 0 and GetUnitAbilityLevel(GameTeamChallengUnit(1),'AZ99') > 0
                        SetGameTeamChallengTimerText(GameTeamChallengUnit(0),GameTeamChallengUnit(1),time)
                    else
                        endtimer
                    endif
                elseif  flag == 2
                    if  GetUnitAbilityLevel(GameTeamChallengUnit(2),'AZ99') > 0 and GetUnitAbilityLevel(GameTeamChallengUnit(3),'AZ99') > 0
                        SetGameTeamChallengTimerText(GameTeamChallengUnit(2),GameTeamChallengUnit(3),time)
                    else
                        endtimer
                    endif
                elseif  flag == 10
                    if  GetUnitAbilityLevel(GameTeamChallengUnit(21),'AZ99') > 0 and GetUnitAbilityLevel(GameTeamChallengUnit(22),'AZ99') > 0
                        SetGameTeamChallengTimerText(GameTeamChallengUnit(21),GameTeamChallengUnit(22),time)
                    else
                        endtimer
                    endif
                elseif  flag == 11
                    if  GetUnitAbilityLevel(GameTeamChallengUnit(23),'AZ99') > 0 and GetUnitAbilityLevel(GameTeamChallengUnit(24),'AZ99') > 0
                        SetGameTeamChallengTimerText(GameTeamChallengUnit(23),GameTeamChallengUnit(24),time)
                    else
                        endtimer
                    endif
                elseif  flag == 12
                    if  GetUnitAbilityLevel(GameTeamChallengUnit(25),'AZ99') > 0 and GetUnitAbilityLevel(GameTeamChallengUnit(26),'AZ99') > 0
                        SetGameTeamChallengTimerText(GameTeamChallengUnit(25),GameTeamChallengUnit(26),time)
                    else
                        endtimer
                    endif
                elseif  flag == 20
                    if  GetUnitAbilityLevel(GameTeamChallengUnit(30),'AZ99') > 0 and GetUnitAbilityLevel(GameTeamChallengUnit(31),'AZ99') > 0
                        SetGameTeamChallengTimerText(GameTeamChallengUnit(30),GameTeamChallengUnit(31),time)
                    else
                        endtimer
                    endif
                elseif  flag == 40
                    if  GetUnitAbilityLevel(GameTeamChallengUnit(40),'AZ99') > 0 and GetUnitAbilityLevel(GameTeamChallengUnit(41),'AZ99') > 0  
                        SetGameTeamChallengTimerText(GameTeamChallengUnit(40),GameTeamChallengUnit(41),time)
                    else
                        endtimer
                    endif
                endif
            else    
                if  flag == 1
                    SetUnitVertexColor(GameTeamChallengUnit(0),255,255,255,0)
                    SetUnitVertexColor(GameTeamChallengUnit(1),255,255,255,0)
                    UnitRemoveAbility(GameTeamChallengUnit(0),'AZ99')
                    UnitRemoveAbility(GameTeamChallengUnit(1),'AZ99')
                elseif  flag == 2
                    SetUnitVertexColor(GameTeamChallengUnit(2),255,255,255,0)
                    SetUnitVertexColor(GameTeamChallengUnit(3),255,255,255,0)
                    UnitRemoveAbility(GameTeamChallengUnit(2),'AZ99')
                    UnitRemoveAbility(GameTeamChallengUnit(3),'AZ99')
                elseif  flag == 10
                    SetUnitVertexColor(GameTeamChallengUnit(21),255,255,255,0)
                    SetUnitVertexColor(GameTeamChallengUnit(22),255,255,255,0)
                    UnitRemoveAbility(GameTeamChallengUnit(21),'AZ99')
                    UnitRemoveAbility(GameTeamChallengUnit(22),'AZ99')
                elseif  flag == 11
                    SetUnitVertexColor(GameTeamChallengUnit(23),255,255,255,0)
                    SetUnitVertexColor(GameTeamChallengUnit(24),255,255,255,0)
                    UnitRemoveAbility(GameTeamChallengUnit(23),'AZ99')
                    UnitRemoveAbility(GameTeamChallengUnit(24),'AZ99')
                elseif  flag == 12
                    SetUnitVertexColor(GameTeamChallengUnit(25),255,255,255,0)
                    SetUnitVertexColor(GameTeamChallengUnit(26),255,255,255,0)
                    UnitRemoveAbility(GameTeamChallengUnit(25),'AZ99')
                    UnitRemoveAbility(GameTeamChallengUnit(26),'AZ99')
                elseif  flag == 20
                    SetUnitVertexColor(GameTeamChallengUnit(30),255,255,255,0)
                    SetUnitVertexColor(GameTeamChallengUnit(31),255,255,255,0)
                    UnitRemoveAbility(GameTeamChallengUnit(30),'AZ99')
                    UnitRemoveAbility(GameTeamChallengUnit(31),'AZ99')
                elseif  flag == 40
                    SetUnitVertexColor(GameTeamChallengUnit(40),255,255,255,0)
                    SetUnitVertexColor(GameTeamChallengUnit(41),255,255,255,0)
                    UnitRemoveAbility(GameTeamChallengUnit(40),'AZ99')
                    UnitRemoveAbility(GameTeamChallengUnit(41),'AZ99')
                endif
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    
    function GameTeamChallengeDoorTimer(unit wu,real time)
        unit u = wu
        TimerStart(time,false)
        {
            SetUnitVertexColor(u,255,255,255,0)
            endtimer
            flush locals
        }
        flush locals
    endfunction

endlibrary







