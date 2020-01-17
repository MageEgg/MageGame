library CreateOpera uses DamageCode 
    
    group AttackOperaGroup_B_1 = null
    group AttackOperaGroup_B_2 = null
    group AttackOperaGroup_C_1 = null
    
    function KillAttackUnitGroupFunc()
        bool UI = false
        if  GetUnitAbilityLevel(GetEnumUnit(),'AZ01') > 0 and UI == false
            UI = true
            ShowBossDamageUI(false)
        endif
        KillUnit(GetEnumUnit())
    endfunction

    function KillAttackUnitGroup()
        ForGroup(AttackUnitGroup,function KillAttackUnitGroupFunc)
    endfunction
    
    /*function StopAttackUnitGroupFunc()
        bool UI = false
        UnitAddAbility(GetEnumUnit(),'Avul')
        PauseUnit(GetEnumUnit(),true)
        if  GetUnitAbilityLevel(GetEnumUnit(),'AZ01') > 0 and UI == false
            UnitRemoveAbility(GetEnumUnit(),'AZ01')
            UI = true
            ShowBossDamageUI(false)
        endif
    endfunction
    function StopAttackUnitGroup()
        ForGroup(AttackUnitGroup,function StopAttackUnitGroupFunc)
    endfunction
    
    function GoonAttackUnitGroupFunc()
        UnitRemoveAbility(GetEnumUnit(),'Avul')
        PauseUnit(GetEnumUnit(),false)
    endfunction
    function GoonAttackUnitGroup()
        ForGroup(AttackUnitGroup,function GoonAttackUnitGroupFunc)
    endfunction*/
    
    function GetAttackPlayingHeroId()->int
        if  GetRandomInt(0,1) == 0
            for pid = 0,3
                if  IsPlaying(pid) == true
                    return pid
                endif
            end
        else
            for pid = 0,3
                if  IsPlaying(3-pid) == true
                    return 3-pid
                endif
            end
        endif
        return 0
    endfunction
    function AttackPlayingHero(unit u)
        int pid = GetAttackPlayingHeroId()
        IssuePointOrderById(u,851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
    endfunction
    
    function AttackOperaAEnding()
        int time = 0
        FlushChildHashtable(ht,GetHandleId(OperaTimer))
        DestroyTimer(OperaTimer)
        OperaTimer = null
        AddEffectInArea(1685,-3104,480,18,"effect_yanhua1.mdx")
        AddEffectInArea(1685,-3104,480,18,"effect_yanhua2.mdx")
        if  GetUnitState(AttackUnitOperaBoss,UNIT_STATE_MAX_LIFE) > 0.4
            SetUnitOwner(AttackUnitOperaBoss,Player(PLAYER_NEUTRAL_PASSIVE),true)
            SetUnitFlyHeight(AttackUnitOperaBoss,1450,10000.00)
        endif
        FlushChildHashtable(ht,GetHandleId(AttackUnitOperaBoss))
        RemoveUnitTimer(AttackUnitOperaBoss,0.5)
        TimerStart(1,true)
        {
            if  time < 5
                time = time + 1
                if  time < 4
                    AddEffectInArea(1685,-3104,480,18,"effect_yanhua1.mdx")
                    AddEffectInArea(1685,-3104,480,18,"effect_yanhua2.mdx")
                    if  time == 3
                        ShowBossDamageUI(false)
                        ShowBossDamageStringOperaA()
                    endif
                endif
            else
                AttackUnitOperaBoss = null
                ShowtOperaRectRange.execute(false)
                for pid = 0,3
                    if  IsPlaying(pid) == true
                        UnitRemoveAbility(Pu[1],'AZ96')
                    endif
                end
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    
    function CreateOperaATimerFunc()
        AttackOperaAEnding()
    endfunction

    function CreateOperaATimer()
        OperaTimer = CreateTimer()
        TimerStart(OperaTimer,100,false,function CreateOperaATimerFunc)
    endfunction
    
    function CreateOperaA()
        OpenAttackShowUI("UI_AttackShow_2.tga",0.5)
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[新春]：|r|cffff3737年兽出现啦！！！可从练功房传送阵前往讨伐！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[新春]：|r|cffff3737年兽出现啦！！！可从练功房传送阵前往讨伐！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[新春]：|r|cffff3737年兽出现啦！！！可从练功房传送阵前往讨伐！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[新春]：|r|cffff3737年兽出现啦！！！可从练功房传送阵前往讨伐！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[新春]：|r|cffff3737年兽出现啦！！！可从练功房传送阵前往讨伐！！！|r")
        ShowtOperaRectRange.execute(true)
        for pid = 0,3
            if  IsPlaying(pid) == true
                UnitAddAbility(Pu[1],'AZ96')
                SetUnitAbilityLevel(Pu[1],'AZ96',1)
            endif
        end
        ExecuteFunc("CreateOperaA2")
    endfunction

    function CreateOperaA2()
        CreateOperaATimer()
        AddEffectInArea(1685,-3104,480,18,"effect_yanhua1.mdx")
        AddEffectInArea(1685,-3104,480,18,"effect_yanhua2.mdx")
        TimerStart(1.0,false)
        {
            ExecuteFunc("CreateOperaA3")
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    function CreateOperaA3()
        AttackUnitOperaBoss = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'mc01',1685,-3104,270)
        UnitAddAbility(AttackUnitOperaBoss,'AZ01')
        SetUnitFlyHeight(AttackUnitOperaBoss,0,10000.00)
        TimerStart(0.1,false)
        {
            LocAddEffectSetSize(1685,-3104,"effect_[dz.spell]001.mdl",0.7)
            ExecuteFunc("CreateOperaA4")
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    function CreateOperaA4()
        ExecuteFunc("ClearDamageRanking")
        ShowBossDamageUI(true)
        SetUnitAnimation(AttackUnitOperaBoss,"attack")
        LocAddEffectSetSize(1685,-3104,"effect_red-yumao-zhendi-paoxiao.mdx",2)
        TimerStart(0.5,false)
        {
            SetUnitOwner(AttackUnitOperaBoss,Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
            ExecuteFunc("CreateOperaATimer")
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    ////////////////////////////////////////分割线/////////////////////////////////////////
    function OpenOperaB_Boss()
        SetUnitOwner(AttackUnitOperaBoss,Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
        AttackPlayingHero(AttackUnitOperaBoss)
    endfunction
    function AttackOperaBEnding(int flag)
    endfunction
    /*function AttackOperaBEndingWin()
        int time = 0
        AddEffectInArea(2795,26,1000,35,"effect_yanhua1.mdx")
        AddEffectInArea(2795,26,1000,35,"effect_yanhua2.mdx")
        TimerStart(1,true)
        {
            if  time < 5
                time = time + 1
                if  time < 4
                    AddEffectInArea(2795,26,1000,35,"effect_yanhua1.mdx")
                    AddEffectInArea(2795,26,1000,35,"effect_yanhua2.mdx")
                    if  time == 3
                        ShowBossDamageUI(false)
                        ShowBossDamageStringOperaB()
                    endif
                endif
            else
                if  GameLevel == 1 and GameOverBoolJu == false
                    AttackUnitWin()
                else
                    SetPlayerCameraBoundsToRect(bj_mapInitialPlayableArea)
                    for pid = 0,3
                        if  IsPlaying(pid) == true
                            UnitRemoveAbility(Pu[1],'AZ02')
                            PlayerReviveX = -6656
                            PlayerReviveY = -6656
                            SendPlayerUnit(pid,PlayerReviveX,PlayerReviveY)
                        endif
                    end
                    GoonAttackUnitGroup()
                    CreateNextTimer(AttackUnitOrderNum)
                endif
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    
    
    function AttackOperaBEnding(int flag)
        unit uu = null
        FlushChildHashtable(ht,GetHandleId(OperaTimer))
        DestroyTimer(OperaTimer)
        OperaTimer = null
        loop
            uu = FirstOfGroup(AttackOperaGroup_B_1)
            exitwhen uu == null
            GroupRemoveUnit(AttackOperaGroup_B_1,uu)
            FlushChildHashtable(ht,GetHandleId(uu))
            RemoveUnit(uu)
        endloop
        GroupClear(AttackOperaGroup_B_1)
        DestroyGroup(AttackOperaGroup_B_1)
        AttackOperaGroup_B_1 = null
        loop
            uu = FirstOfGroup(AttackOperaGroup_B_2)
            exitwhen uu == null
            GroupRemoveUnit(AttackOperaGroup_B_2,uu)
            FlushChildHashtable(ht,GetHandleId(uu))
            RemoveUnit(uu)
        endloop
        GroupClear(AttackOperaGroup_B_2)
        DestroyGroup(AttackOperaGroup_B_2)
        AttackOperaGroup_B_2 = null
        AttackUnitOperaBoss = null
        if  flag == 1
            ExecuteFunc("GameOver")
        elseif  flag == 0
            AttackOperaBEndingWin()
        endif
        flush locals
    endfunction
    
    function CreateOperaBTimerFunc()
        AttackOperaBEnding(1)
    endfunction
    
    function CreateOperaBTimer()
        OperaTimerUIText = "击杀闻太师"
        OperaTimer = CreateTimer()
        TimerStart(OperaTimer,100,false,function CreateOperaBTimerFunc)
    endfunction
    
    function CreateOperaB()
        StopAttackUnitGroup()
        SetPlayerCameraBoundsToRect(bj_mapInitialPlayableArea)
        PanCameraToTimed(2795,26,0)
        OpenAttackShowUI("UI_AttackShow_3.tga",0.5)
        TimerStart(1,false)
        {
            ExecuteFunc("CreateOperaB2")
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    function SetUnitOwnerTimer(unit wu,int id,real time)
        unit u = wu
        int pid = id
        TimerStart(time,false)
        {
            SetUnitOwner(u,Player(pid),true)
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    function CreateOperaB2()
        unit u = null
        real x = 0
        real y = 0
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  pid == 0
                    PlayerReviveX = 2300
                    PlayerReviveY = -140
                    SendPlayerUnitBarringCamera(pid,PlayerReviveX,PlayerReviveY)
                elseif  pid == 1
                    PlayerReviveX = 2625
                    PlayerReviveY = -460
                    SendPlayerUnitBarringCamera(pid,PlayerReviveX,PlayerReviveY)
                elseif  pid == 2
                    PlayerReviveX = 2240
                    PlayerReviveY = -308
                    SendPlayerUnitBarringCamera(pid,PlayerReviveX,PlayerReviveY)
                elseif  pid == 3
                    PlayerReviveX = 2458
                    PlayerReviveY = -524
                    SendPlayerUnitBarringCamera(pid,PlayerReviveX,PlayerReviveY)
                endif
                UnitAddAbility(Pu[1],'AZ02')
            endif
        end
        SetPlayerCameraBoundsToRect(gg_rct_AttackOpera_B)
        AttackOperaGroup_B_1 = CreateGroup()
        
        u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np00',1800,-960,45)
        LocAddEffect(3800,1020,"effect_blue-chuansong.mdx")
        GroupAddUnit(AttackOperaGroup_B_1,u)
        for num = 0,9
            x = 1952 - 260*Cos(36*(10-num)*0.01745)
            y = 128 - 260*Sin(36*(10-num)*0.01745)
            u = CreateUnit(Player(9),'e00B',x,y,45)
            SetUnitState(u,UNIT_STATE_MAX_LIFE,1)
            LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
            GroupAddUnit(AttackOperaGroup_B_1,u)
        end
        for num = 0,7
            x = 1952 - 150*Cos(45*(8-num)*0.01745)
            y = 128 - 150*Sin(45*(8-num)*0.01745)
            u = CreateUnit(Player(9),'eZ04',x,y,45)
            SetUnitState(u,UNIT_STATE_MAX_LIFE,1)
            LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
            GroupAddUnit(AttackOperaGroup_B_1,u)
        end
        u = CreateUnit(Player(9),'e00B',1952,128,45)
        SetUnitState(u,UNIT_STATE_MAX_LIFE,1)
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
        GroupAddUnit(AttackOperaGroup_B_1,u)
        for num = 0,9
            x = 2848 - 260*Cos(36*(10-num)*0.01745)
            y = -832 - 260*Sin(36*(10-num)*0.01745)
            u = CreateUnit(Player(9),'e00B',x,y,45)
            SetUnitState(u,UNIT_STATE_MAX_LIFE,1)
            LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
            GroupAddUnit(AttackOperaGroup_B_1,u)
        end
        for num = 0,7
            x = 2848 - 150*Cos(45*(8-num)*0.01745)
            y = -832 - 150*Sin(45*(8-num)*0.01745)
            u = CreateUnit(Player(9),'eZ04',x,y,45)
            SetUnitState(u,UNIT_STATE_MAX_LIFE,1)
            LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
            GroupAddUnit(AttackOperaGroup_B_1,u)
        end
        u = CreateUnit(Player(9),'e00B',2848,-832,45)
        SetUnitState(u,UNIT_STATE_MAX_LIFE,1)
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
        GroupAddUnit(AttackOperaGroup_B_1,u)
        
        
        AttackOperaGroup_B_2 = CreateGroup()
        AttackUnitOperaBoss = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'mc06',3800,1020,225)
        UnitAddAbility(AttackUnitOperaBoss,'AZ01')
        LocAddEffect(3800,1020,"effect_blue-chuansong.mdx")
        GroupAddUnit(AttackOperaGroup_B_2,AttackUnitOperaBoss)
        
        u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'mc02',3136,672,225)
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
        GroupAddUnit(AttackOperaGroup_B_2,u)
        SetUnitOwnerTimer(u,PLAYER_NEUTRAL_AGGRESSIVE,3.5)

        u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'mc03',3488,672,225)
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
        GroupAddUnit(AttackOperaGroup_B_2,u)
        SetUnitOwnerTimer(u,PLAYER_NEUTRAL_AGGRESSIVE,3.5)

        u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'mc04',3136,352,225)
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
        GroupAddUnit(AttackOperaGroup_B_2,u)
        SetUnitOwnerTimer(u,PLAYER_NEUTRAL_AGGRESSIVE,3.5)

        u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'mc05',3488,352,225)
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
        GroupAddUnit(AttackOperaGroup_B_2,u)
        SetUnitOwnerTimer(u,PLAYER_NEUTRAL_AGGRESSIVE,3.5)

        for num = 0,9
            x = 2816 - 260*Cos(36*(10-num)*0.01745)
            y = 960 - 260*Sin(36*(10-num)*0.01745)
            u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'e00B',x,y,225)
            SetUnitRealStateOfOtherId(u,'m012')
            SetUnitRealState(u,1,GetUnitRealState(u,1)/3)
            LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
            GroupAddUnit(AttackOperaGroup_B_2,u)
        end
        for num = 0,7
            x = 2816 - 150*Cos(45*(8-num)*0.01745)
            y = 960 - 150*Sin(45*(8-num)*0.01745)
            u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'eZ04',x,y,225)
            SetUnitRealStateOfOtherId(u,'m012')
            SetUnitRealState(u,1,GetUnitRealState(u,1)/3)
            LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
            GroupAddUnit(AttackOperaGroup_B_2,u)
        end
        u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'e00B',2816,960,225)
        SetUnitRealStateOfOtherId(u,'m012')
            SetUnitRealState(u,1,GetUnitRealState(u,1)/3)
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
        GroupAddUnit(AttackOperaGroup_B_2,u)
        for num = 0,9
            x = 3712 - 260*Cos(36*(10-num)*0.01745)
            y = 96 - 260*Sin(36*(10-num)*0.01745)
            u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'e00B',x,y,225)
            SetUnitRealStateOfOtherId(u,'m012')
            SetUnitRealState(u,1,GetUnitRealState(u,1)/3)
            LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
            GroupAddUnit(AttackOperaGroup_B_2,u)
        end
        for num = 0,7
            x = 3712 - 150*Cos(45*(8-num)*0.01745)
            y = 96 - 150*Sin(45*(8-num)*0.01745)
            u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'eZ04',x,y,225)
            SetUnitRealStateOfOtherId(u,'m012')
            SetUnitRealState(u,1,GetUnitRealState(u,1)/3)
            LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
            GroupAddUnit(AttackOperaGroup_B_2,u)
        end
        u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'e00B',3712,96,225)
        SetUnitRealStateOfOtherId(u,'m012')
        SetUnitRealState(u,1,GetUnitRealState(u,1)/3)
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
        GroupAddUnit(AttackOperaGroup_B_2,u)
        
        TimerStart(1.5,false)
        {
            ExecuteFunc("CreateOperaB3")
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    function AttackOperaGroup_B_1Func()
        if  GetUnitTypeId(GetEnumUnit()) != 'np00'
            IssuePointOrderById(GetEnumUnit(),851983,GetUnitX(GetEnumUnit())+250,GetUnitY(GetEnumUnit())+250)
        endif
    endfunction
    function AttackOperaGroup_B_2Func()
        if  GetUnitTypeId(GetEnumUnit()) >= 'mc02' and GetUnitTypeId(GetEnumUnit()) <= 'mc06'
            if  GetUnitTypeId(GetEnumUnit()) != 'mc06'
                AttackPlayingHero(GetEnumUnit())
            endif
        else
            IssuePointOrderById(GetEnumUnit(),851983,GetUnitX(GetEnumUnit())-200,GetUnitY(GetEnumUnit())-200)
        endif
    endfunction
    
    function CreateOperaB3()
        ForGroup(AttackOperaGroup_B_1,function AttackOperaGroup_B_1Func)
        ForGroup(AttackOperaGroup_B_2,function AttackOperaGroup_B_2Func)
        CreateOperaBTimer()
        ExecuteFunc("ClearDamageRanking")
        ShowBossDamageUI(true)
    endfunction

    function OpenOperaB_Boss()
        SetUnitOwner(AttackUnitOperaBoss,Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
        AttackPlayingHero(AttackUnitOperaBoss)
    endfunction
    */
    ////////////////////////////////分割线///////////////////////////////
    /*
    function AttackOperaCEnding()
        int time = 0
        real x = 0
        real y = 0
        FlushChildHashtable(ht,GetHandleId(OperaTimer))
        DestroyTimer(OperaTimer)
        OperaTimer = null
        SetUnitOwner(AttackUnitOperaBoss,Player(PLAYER_NEUTRAL_PASSIVE),true)
        x = GetUnitX(AttackUnitOperaBoss)
        y = GetUnitY(AttackUnitOperaBoss)
        AddEffectInArea(x,y,480,18,"effect_yanhua1.mdx")
        AddEffectInArea(x,y,480,18,"effect_yanhua2.mdx")
        SetUnitFlyHeight(AttackUnitOperaBoss,1450,10000.00)
        FlushChildHashtable(ht,GetHandleId(AttackUnitOperaBoss))
        RemoveUnitTimer(AttackUnitOperaBoss,0.5)
        TimerStart(1,true)
        {
            if  time < 5
                time = time + 1
                if  time < 4
                    AddEffectInArea(x,y,480,18,"effect_yanhua1.mdx")
                    AddEffectInArea(x,y,480,18,"effect_yanhua2.mdx")
                endif
            else
                AttackUnitOperaBoss = null
                SetPlayerCameraBoundsToRect(bj_mapInitialPlayableArea)
                ShowBossDamageUI(false)
                ShowBossDamageString()
                for pid = 0,3
                    if  IsPlaying(pid) == true
                        UnitRemoveAbility(Pu[1],'AZ02')
                        PlayerReviveX = -6656
                        PlayerReviveY = -6656
                        SendPlayerUnit(pid,PlayerReviveX,PlayerReviveY)
                    endif
                end
                GoonAttackUnitGroup()
                CreateNextTimer(AttackUnitOrderNum)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    
    function CreateOperaCTimerFunc()
        AttackOperaCEnding()
    endfunction
    
    function CreateOperaCTimer()
        OperaTimerUIText = "击杀妲己"
        OperaTimer = CreateTimer()
        TimerStart(OperaTimer,60,false,function CreateOperaCTimerFunc)
    endfunction

    function CreateOperaC()
        StopAttackUnitGroup()
        SetPlayerCameraBoundsToRect(bj_mapInitialPlayableArea)
        RemoveUnit(CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ03',-100000,-100000,0))
        PanCameraToTimed(GetRectCenterX(gg_rct_AttackOpera_C),GetRectCenterY(gg_rct_AttackOpera_C),0)
        OpenAttackShowUI("UI_AttackShow_4.tga",0.5)
        TimerStart(1,false)
        {
            ExecuteFunc("CreateOperaC2")
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    function CreateOperaC2()
        unit u = null
        unit fire = null
        real x = 0
        real y = 0
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  pid == 0
                    PlayerReviveX = 2976
                    PlayerReviveY = -2720
                    SendPlayerUnitBarringCamera(pid,PlayerReviveX,PlayerReviveY)
                elseif  pid == 1
                    PlayerReviveX = 2976
                    PlayerReviveY = -2880
                    SendPlayerUnitBarringCamera(pid,PlayerReviveX,PlayerReviveY)
                elseif  pid == 2
                    PlayerReviveX = 2848
                    PlayerReviveY = -2720
                    SendPlayerUnitBarringCamera(pid,PlayerReviveX,PlayerReviveY)
                elseif  pid == 3
                    PlayerReviveX = 2848
                    PlayerReviveY = -2880
                    SendPlayerUnitBarringCamera(pid,PlayerReviveX,PlayerReviveY)
                endif
                UnitAddAbility(Pu[1],'AZ02')
            endif
        end
        SetPlayerCameraBoundsToRect(gg_rct_AttackOpera_C)
        AttackOperaGroup_C_1 = CreateGroup()
        fire = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ02',4620,-2840,0)
        GroupAddUnit(AttackOperaGroup_C_1,fire)
        for pid = 0,3
            for k = 0,4
                x = 2848+100*k
                y = -2656+120*pid
                if  k >= 3
                    u = CreateUnit(Player(9),'e00B',x,y,0)
                    LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
                    GroupAddUnit(AttackOperaGroup_C_1,u)
                    SetUnitAnimation(u,"stand victory")
                else
                    u = CreateUnit(Player(9),'eZ05',x,y,0)
                    LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
                    GroupAddUnit(AttackOperaGroup_C_1,u)
                    IssueTargetOrderById(u,851983,fire)
                endif
            end
        end
        for pid = 0,3
            for k = 0,4
                x = 2848+100*k
                y = -2944-120*pid
                if  k >= 3
                    u = CreateUnit(Player(9),'e00B',x,y,0)
                    LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
                    GroupAddUnit(AttackOperaGroup_C_1,u)
                    SetUnitAnimation(u,"stand victory")
                else
                    u = CreateUnit(Player(9),'eZ05',x,y,0)
                    LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
                    GroupAddUnit(AttackOperaGroup_C_1,u)
                    IssueTargetOrderById(u,851983,fire)
                endif
            end
        end
        TimerStart(1.8,false)
        {
            ExecuteFunc("CreateOperaC3")
            endtimer
            flush locals
        }
        flush locals
    endfunction
     
    function CreateOperaC3()
        AttackUnitOperaBoss = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'mc07',3760,-2800,180)
        UnitAddAbility(AttackUnitOperaBoss,'AZ01')
        SetUnitFlyHeight(AttackUnitOperaBoss,0,1900)
        SetUnitAnimation(AttackUnitOperaBoss,"attack slam")
        LocAddEffect(3800,1020,"effect_blue-chuansong.mdx")
        TimerStart(1.0,false)
        {
            unit uu = null
            RemoveUnitTimer(CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ03',3760,-2800,0),1)
            SetUnitAnimation(AttackUnitOperaBoss,"attack")
            loop
                uu = FirstOfGroup(AttackOperaGroup_C_1)
                exitwhen uu == null
                GroupRemoveUnit(AttackOperaGroup_C_1,uu)
                FlushChildHashtable(ht,GetHandleId(uu))
                KillUnit(uu)
            endloop
            GroupClear(AttackOperaGroup_C_1)
            DestroyGroup(AttackOperaGroup_C_1)
            AttackOperaGroup_C_1 = null
            ExecuteFunc("CreateOperaC4")
            ExecuteFunc("CreateOperaCTimer")
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    function CreateOperaC4()
        ExecuteFunc("ClearDamageRanking")
        ShowBossDamageUI(true)
        TimerStart(0.4,false)
        {
            SetUnitOwner(AttackUnitOperaBoss,Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
            AttackPlayingHero(AttackUnitOperaBoss)
            endtimer
            flush locals
        }
        flush locals
    endfunction
    */
    

endlibrary
