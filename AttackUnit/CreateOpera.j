library CreateOpera uses DamageCode 
    
    group AttackOperaGroup_B_1 = null
    group AttackOperaGroup_B_2 = null
    group AttackOperaGroup_C_1 = null
    
    real AttackUnitOperaBossDamage = 0

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

    function AttackOperaADamageGold()
        real angle = 0
        real distance = 0
        real x = 1685
        real y = -3104
        real rac = 400
        AddEffectInAreaSetSize(x,y,rac,1.5,8,"Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl")
        for num = 1,5
            angle = GetRandomReal(0, 6.283) 
            distance = SquareRoot(GetRandomReal(1.0, rac * rac)) 
            CreateItem('I00A',x + Cos(angle) * distance,y + Sin(angle) * distance)
        end
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  IsLocInRect(gg_rct_AttackOpera_A,GetUnitX(Pu[1]),GetUnitY(Pu[1])) == true
                    DisplayTimedTextToPlayer(Player(pid),0,0,6,"|cffffcc00[新春]：|r|cffff3737运气太好了，年兽掉落了大量金币！！！|r")
                endif
            endif
        end
    endfunction
    function AttackOperaADamage(real damage)
        real life = GetUnitState(AttackUnitOperaBoss,UNIT_STATE_MAX_LIFE)*0.1
        int cos = 0
        AttackUnitOperaBossDamage = AttackUnitOperaBossDamage + damage
        if  AttackUnitOperaBossDamage/life >= 1
            cos = S2I(SubString(R2S(AttackUnitOperaBossDamage/life),0,1))
            for num = 1,cos
                AttackOperaADamageGold()
            end
            AttackUnitOperaBossDamage = AttackUnitOperaBossDamage - cos*life
        endif
    endfunction

    function AttackOperaAGold(real x,real y)
        LocAddText(x,y,"年兽金币：+300",255,202,0,255,90,0.025)
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  IsLocInRect(gg_rct_AttackOpera_A,GetUnitX(Pu[1]),GetUnitY(Pu[1])) == true
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,300)
                    //UnitAddText(Pu[1],"年兽金币：+300",255,202,0,255,90,0.023)
                endif
            endif
        end
    endfunction
    
    function AttackOperaAEnding(int flag)
        int time = 0
        FlushChildHashtable(ht,GetHandleId(OperaTimer))
        DestroyTimer(OperaTimer)
        OperaTimer = null
        SetUnitOwner(AttackUnitOperaBoss,Player(PLAYER_NEUTRAL_PASSIVE),true)
        EXSetUnitMoveType(AttackUnitOperaBoss,0x04)
        SetUnitFlyHeight(AttackUnitOperaBoss,1450,10000.00)
        FlushChildHashtable(ht,GetHandleId(AttackUnitOperaBoss))
        RemoveUnitTimer(AttackUnitOperaBoss,0.5)
        AttackUnitOperaBoss = null
        ExecuteFunc("ColserOperaATimerUnit")
        if  flag == 0
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[新春]：|r|cffff0000年兽逃走啦！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[新春]：|r|cffff0000年兽逃走啦！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[新春]：|r|cffff0000年兽逃走啦！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[新春]：|r|cffff0000年兽逃走啦！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[新春]：|r|cffff0000年兽逃走啦！！！")
        elseif  flag == 1
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[新春]：|r|cff00ff00成功把年兽赶跑了！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[新春]：|r|cff00ff00成功把年兽赶跑了！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[新春]：|r|cff00ff00成功把年兽赶跑了！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[新春]：|r|cff00ff00成功把年兽赶跑了！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[新春]：|r|cff00ff00成功把年兽赶跑了！！！")
        endif
        AddEffectInArea(1685,-3104,480,18,"effect_yanhua1.mdx")
        AddEffectInArea(1685,-3104,480,18,"effect_yanhua2.mdx")
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
                        BossDamageFrameName.SetText("|cFF33FF00BOSS伤害排行|r")
                    endif
                endif
            else
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
        int time = LoadInteger(ht,GetHandleId(OperaTimer),1)
        time = time - 1
        SaveInteger(ht,GetHandleId(OperaTimer),1,time)
        BossDamageFrameName.SetText("|cFF33FF00年兽伤害排行 限时"+I2S(time)+"秒|r")
        if  (ModuloInteger(time,5) == 0 or time <= 5) and time > 0 
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[新春]：|r|cffff3737年兽挑战时间剩余|cff00ff00"+I2S(time)+"秒|cffff3737！！！|r")
        endif
        if  time == 30
            OpenGameTeamChallengeTimer.execute(30,10)
        elseif  time == 0
            AttackOperaAEnding(0)
        endif
    endfunction

    function CreateOperaATimer()
        int time = 35
        OperaTimer = CreateTimer()
        SaveInteger(ht,GetHandleId(OperaTimer),1,time)
        TimerStart(OperaTimer,1,true,function CreateOperaATimerFunc)
    endfunction

    function CreateGameOperaA(real t)
        real time = t - 60
        TimerStart(time,false)
        {
            ExecuteFunc("CreateOperaA")
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    function CreateOperaA()
        CreateOperaATimer()
        OpenAttackShowUI("UI_AttackShow_2.tga",5)
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
        TimerStart(3,false)
        {
            ExecuteFunc("CreateOperaA2")
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function CreateOperaA2()
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
        AttackUnitOperaBoss = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'mc01',1685,-3104,270)
        SetUnitOwner(AttackUnitOperaBoss,Player(PLAYER_NEUTRAL_PASSIVE),true)
        AddUnitRealState(AttackUnitOperaBoss,4,15*(PlayerNum-1))
        AddUnitRealState(AttackUnitOperaBoss,18,15*(PlayerNum-1))
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
            EXSetUnitMoveType(AttackUnitOperaBoss,0x02)
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    ////////////////////////////////////////分割线/////////////////////////////////////////

    function AttackOperaBEnding(int flag)
        int time = 0
        unit uu = null
        if  LoadInteger(ht,GetHandleId(OperaTimer),1) >= 70
            BJDebugMsg("闻太师任务")
            for pid = 0,3
                if  IsPlaying(pid) == true
                    MissionAddNumFunc.execute(pid,20,1)
                endif
            end
        endif
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

        FlushChildHashtable(ht,GetHandleId(AttackUnitOperaBoss))
        AttackUnitOperaBoss = null
        ExecuteFunc("ColserOperaBTimerUnit")

        if  flag == 0
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[西征]：|r|cffff0000闻太师讨伐失败！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[西征]：|r|cffff0000闻太师讨伐失败！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[西征]：|r|cffff0000闻太师讨伐失败！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[西征]：|r|cffff0000闻太师讨伐失败！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[西征]：|r|cffff0000闻太师讨伐失败！！！")
        elseif  flag == 1
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[西征]：|r|cff00ff00闻太师讨伐成功！！！所有玩家奖励"+GetObjectName('I015')+"|cff00ff00（发放至助手背包）！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[西征]：|r|cff00ff00闻太师讨伐成功！！！所有玩家奖励"+GetObjectName('I015')+"|cff00ff00（发放至助手背包）！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[西征]：|r|cff00ff00闻太师讨伐成功！！！所有玩家奖励"+GetObjectName('I015')+"|cff00ff00（发放至助手背包）！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[西征]：|r|cff00ff00闻太师讨伐成功！！！所有玩家奖励"+GetObjectName('I015')+"|cff00ff00（发放至助手背包）！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[西征]：|r|cff00ff00闻太师讨伐成功！！！所有玩家奖励"+GetObjectName('I015')+"|cff00ff00（发放至助手背包）！！！|r")
            for pid = 0,3
                if  IsPlaying(pid) == true
                    UnitAddItemEx(Pu[2],'I015')
                    GivePlayerMissionPrize(pid,'RR0D')
                endif
            end
        endif
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
                        BossDamageFrameName.SetText("|cFF33FF00BOSS伤害排行|r")
                    endif
                endif
            else
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
    
    function CreateOperaBTimerFunc()
        int time = LoadInteger(ht,GetHandleId(OperaTimer),1)
        time = time - 1
        SaveInteger(ht,GetHandleId(OperaTimer),1,time)
        BossDamageFrameName.SetText("|cFF33FF00闻太师伤害排行 限时"+I2S(time)+"秒|r")
        if  (ModuloInteger(time,5) == 0 or time <= 10) and time > 0 
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[西征]：|r|cffff3737闻太师挑战时间剩余|cff00ff00"+I2S(time)+"秒|cffff3737！！！|r")
        endif
        if  time == 90
            OpenGameTeamChallengeTimer.execute(90,11)
        elseif  time == 0
            AttackOperaBEnding(0)
        endif
    endfunction

    function CreateOperaBTimer()
        int time = 91
        OperaTimer = CreateTimer()
        SaveInteger(ht,GetHandleId(OperaTimer),1,time)
        TimerStart(OperaTimer,1,true,function CreateOperaBTimerFunc)
    endfunction

    function CreateGameOperaB(real t)
        real time = t - 100
        TimerStart(time,false)
        {
            ExecuteFunc("CreateOperaB")
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    function CreateOperaB()
        OpenAttackShowUI("UI_AttackShow_3.tga",5)
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[西征]：|r|cffff3737闻太师带军进攻西岐！！！速从练功房传送阵前往援助！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[西征]：|r|cffff3737闻太师带军进攻西岐！！！速从练功房传送阵前往援助！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[西征]：|r|cffff3737闻太师带军进攻西岐！！！速从练功房传送阵前往援助！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[西征]：|r|cffff3737闻太师带军进攻西岐！！！速从练功房传送阵前往援助！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[西征]：|r|cffff3737闻太师带军进攻西岐！！！速从练功房传送阵前往援助！！！|r")
        ShowtOperaRectRange.execute(true)
        for pid = 0,3
            if  IsPlaying(pid) == true
                UnitAddAbility(Pu[1],'AZ96')
                SetUnitAbilityLevel(Pu[1],'AZ96',2)
            endif
        end
        TimerStart(3,false)
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
        AttackUnitOperaBoss = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'mc06',3800,1020,225)
        SetUnitOwner(AttackUnitOperaBoss,Player(PLAYER_NEUTRAL_PASSIVE),true)
        AddUnitRealState(AttackUnitOperaBoss,4,15*(PlayerNum-1))
        AddUnitRealState(AttackUnitOperaBoss,18,15*(PlayerNum-1))
        UnitAddAbility(AttackUnitOperaBoss,'AZ01')
        LocAddEffect(3800,1020,"effect_blue-chuansong.mdx")
        GroupAddUnit(AttackOperaGroup_B_2,AttackUnitOperaBoss)
        
        u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'mc02',3136,672,225)
        SetUnitOwner(u,Player(PLAYER_NEUTRAL_PASSIVE),true)
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
        GroupAddUnit(AttackOperaGroup_B_2,u)
        SetUnitOwnerTimer(u,PLAYER_NEUTRAL_AGGRESSIVE,3.5)

        u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'mc03',3488,672,225)
        SetUnitOwner(u,Player(PLAYER_NEUTRAL_PASSIVE),true)
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
        GroupAddUnit(AttackOperaGroup_B_2,u)
        SetUnitOwnerTimer(u,PLAYER_NEUTRAL_AGGRESSIVE,3.5)

        u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'mc04',3136,352,225)
        SetUnitOwner(u,Player(PLAYER_NEUTRAL_PASSIVE),true)
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
        GroupAddUnit(AttackOperaGroup_B_2,u)
        SetUnitOwnerTimer(u,PLAYER_NEUTRAL_AGGRESSIVE,3.5)

        u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'mc05',3488,352,225)
        SetUnitOwner(u,Player(PLAYER_NEUTRAL_PASSIVE),true)
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
        GroupAddUnit(AttackOperaGroup_B_2,u)
        SetUnitOwnerTimer(u,PLAYER_NEUTRAL_AGGRESSIVE,3.5)

        for num = 0,9
            x = 2816 - 260*Cos(36*(10-num)*0.01745)
            y = 960 - 260*Sin(36*(10-num)*0.01745)
            u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'e00B',x,y,225)
            SetUnitOwner(u,Player(PLAYER_NEUTRAL_PASSIVE),true)
            SetUnitRealStateOfOtherId(u,'m012')
            LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
            GroupAddUnit(AttackOperaGroup_B_2,u)
        end
        for num = 0,7
            x = 2816 - 150*Cos(45*(8-num)*0.01745)
            y = 960 - 150*Sin(45*(8-num)*0.01745)
            u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'eZ04',x,y,225)
            SetUnitOwner(u,Player(PLAYER_NEUTRAL_PASSIVE),true)
            SetUnitRealStateOfOtherId(u,'m012')
            LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
            GroupAddUnit(AttackOperaGroup_B_2,u)
        end
        u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'e00B',2816,960,225)
        SetUnitOwner(u,Player(PLAYER_NEUTRAL_PASSIVE),true)
        SetUnitRealStateOfOtherId(u,'m012')
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
        GroupAddUnit(AttackOperaGroup_B_2,u)
        for num = 0,9
            x = 3712 - 260*Cos(36*(10-num)*0.01745)
            y = 96 - 260*Sin(36*(10-num)*0.01745)
            u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'e00B',x,y,225)
            SetUnitOwner(u,Player(PLAYER_NEUTRAL_PASSIVE),true)
            SetUnitRealStateOfOtherId(u,'m012')
            LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
            GroupAddUnit(AttackOperaGroup_B_2,u)
        end
        for num = 0,7
            x = 3712 - 150*Cos(45*(8-num)*0.01745)
            y = 96 - 150*Sin(45*(8-num)*0.01745)
            u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'eZ04',x,y,225)
            SetUnitOwner(u,Player(PLAYER_NEUTRAL_PASSIVE),true)
            SetUnitRealStateOfOtherId(u,'m012')
            LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-chuansong.mdx")
            GroupAddUnit(AttackOperaGroup_B_2,u)
        end
        u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'e00B',3712,96,225)
        SetUnitOwner(u,Player(PLAYER_NEUTRAL_PASSIVE),true)
        SetUnitRealStateOfOtherId(u,'m012')
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
            SetUnitOwner(GetEnumUnit(),Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
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
    
    ////////////////////////////////分割线///////////////////////////////

    function AttackOperaCEnding(int flag)
        int time = 0
        real x = 0
        real y = 0
        FlushChildHashtable(ht,GetHandleId(OperaTimer))
        DestroyTimer(OperaTimer)
        OperaTimer = null
        SetUnitOwner(AttackUnitOperaBoss,Player(PLAYER_NEUTRAL_PASSIVE),true)
        EXSetUnitMoveType(AttackUnitOperaBoss,0x04)
        x = GetUnitX(AttackUnitOperaBoss)
        y = GetUnitY(AttackUnitOperaBoss)
        AddEffectInArea(x,y,480,18,"effect_yanhua1.mdx")
        AddEffectInArea(x,y,480,18,"effect_yanhua2.mdx")
        SetUnitFlyHeight(AttackUnitOperaBoss,1450,10000.00)
        FlushChildHashtable(ht,GetHandleId(AttackUnitOperaBoss))
        RemoveUnitTimer(AttackUnitOperaBoss,0.5)
        AttackUnitOperaBoss = null
        ExecuteFunc("ColserOperaCTimerUnit")

        if  flag == 0
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[擒妖]：|r|cffff0000妲己抓拿失败！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[擒妖]：|r|cffff0000妲己抓拿失败！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[擒妖]：|r|cffff0000妲己抓拿失败！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[擒妖]：|r|cffff0000妲己抓拿失败！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[擒妖]：|r|cffff0000妲己抓拿失败！！！")
        elseif  flag == 1
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[擒妖]：|r|cff00ff00妲己抓拿成功！！！所有玩家奖励"+GetObjectName('I015')+"|cff00ff00（发放至助手背包）！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[擒妖]：|r|cff00ff00妲己抓拿成功！！！所有玩家奖励"+GetObjectName('I015')+"|cff00ff00（发放至助手背包）！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[擒妖]：|r|cff00ff00妲己抓拿成功！！！所有玩家奖励"+GetObjectName('I015')+"|cff00ff00（发放至助手背包）！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[擒妖]：|r|cff00ff00妲己抓拿成功！！！所有玩家奖励"+GetObjectName('I015')+"|cff00ff00（发放至助手背包）！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[擒妖]：|r|cff00ff00妲己抓拿成功！！！所有玩家奖励"+GetObjectName('I015')+"|cff00ff00（发放至助手背包）！！！|r")
            for pid = 0,3
                if  IsPlaying(pid) == true
                    UnitAddItemEx(Pu[2],'I015')
                    GivePlayerMissionPrize(pid,'RR0E')
                endif
            end
        endif
        TimerStart(1,true)
        {
            if  time < 5
                time = time + 1
                if  time < 4
                    AddEffectInArea(x,y,480,18,"effect_yanhua1.mdx")
                    AddEffectInArea(x,y,480,18,"effect_yanhua2.mdx")
                    if  time == 3
                        ShowBossDamageUI(false)
                        ShowBossDamageStringOperaC()
                        BossDamageFrameName.SetText("|cFF33FF00BOSS伤害排行|r")
                    endif
                endif
            else
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
    
    function CreateOperaCTimerFunc()
        int time = LoadInteger(ht,GetHandleId(OperaTimer),1)
        time = time - 1
        SaveInteger(ht,GetHandleId(OperaTimer),1,time)
        BossDamageFrameName.SetText("|cFF33FF00妲己伤害排行 限时"+I2S(time)+"秒|r")
        if  (ModuloInteger(time,5) == 0 or time <= 5) and time > 0 
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[擒妖]：|r|cffff3737妲己挑战时间剩余|cff00ff00"+I2S(time)+"秒|cffff3737！！！|r")
        endif
        if  time == 30
            OpenGameTeamChallengeTimer.execute(30,12)
        elseif  time == 0
            AttackOperaCEnding(0)
        endif
    endfunction

    function CreateOperaCTimer()
        int time = 31
        OperaTimer = CreateTimer()
        SaveInteger(ht,GetHandleId(OperaTimer),1,time)
        TimerStart(OperaTimer,1,true,function CreateOperaCTimerFunc)
    endfunction

    function CreateGameOperaC(real t)
        real time = t - 60
        TimerStart(time,false)
        {
            ExecuteFunc("CreateOperaC")
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function CreateOperaC()
        RemoveUnit(CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ03',-100000,-100000,0))
        OpenAttackShowUI("UI_AttackShow_4.tga",5)
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[擒妖]：|r|cffff3737姜子牙已带众人前往摘星楼抓拿妲己！！！速从练功房传送阵前往援助！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[擒妖]：|r|cffff3737姜子牙已带众人前往摘星楼抓拿妲己！！！速从练功房传送阵前往援助！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[擒妖]：|r|cffff3737姜子牙已带众人前往摘星楼抓拿妲己！！！速从练功房传送阵前往援助！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[擒妖]：|r|cffff3737姜子牙已带众人前往摘星楼抓拿妲己！！！速从练功房传送阵前往援助！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[擒妖]：|r|cffff3737姜子牙已带众人前往摘星楼抓拿妲己！！！速从练功房传送阵前往援助！！！|r")
        ShowtOperaRectRange.execute(true)
        for pid = 0,3
            if  IsPlaying(pid) == true
                UnitAddAbility(Pu[1],'AZ96')
                SetUnitAbilityLevel(Pu[1],'AZ96',3)
            endif
        end
        TimerStart(3,false)
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
        AttackUnitOperaBoss = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'mc07',3760,-2800,180)
        SetUnitOwner(AttackUnitOperaBoss,Player(PLAYER_NEUTRAL_PASSIVE),true)
        AddUnitRealState(AttackUnitOperaBoss,4,15*(PlayerNum-1))
        AddUnitRealState(AttackUnitOperaBoss,18,15*(PlayerNum-1))
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
            EXSetUnitMoveType(AttackUnitOperaBoss,0x02)
            AttackPlayingHero(AttackUnitOperaBoss)
            endtimer
            flush locals
        }
        flush locals
    endfunction

endlibrary
