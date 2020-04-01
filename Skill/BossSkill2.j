library BossSkill2 uses AbilityUI,OtherDamageTimer
    function JJFuncSpell01Timer(unit wu,unit tu)
        unit u1 = wu
        unit u2 = tu
        TimerStart(1,true)
        {
            int num = GetUnitIntState(u2,'AZ2A')
            UnitDamageTarget(u1,u2,GetUnitState(u2,UNIT_STATE_LIFE)*0.03,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
            num = num - 1
            SetUnitIntState(u2,'AZ2A',num - 1)
            if  num <= 0
                SetUnitIntState(u2,'AZ2A',0)
                endtimer
            endif
            flush locals
        }
        flush locals

    endfunction
    function JJFuncSpell01(unit wu,unit tu)
        if  GetUnitIntState(tu,'AZ2A') == 0
            JJFuncSpell01Timer(wu,tu)
        else
            SetUnitIntState(tu,'AZ2A',3)
        endif

    endfunction

    

    
    function JJFuncSpell02Timer(unit wu,real sx,real sy,int n)
        unit u1 = wu
        real x = sx
        real y = sy
        real x1 = x
        real y1 = y
        int num = n
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"A_yujing_boss_yuan_0.mdl",x1,y1,0,30,0.6)
        TimerStart(2,true)
        {
            
            IndexGroup g = IndexGroup.create()
            LocAddEffectSetSize(x1,y1,"effect2_by_wood_effect2_yubanmeiqin_lightning_luolei.mdl",0.5)
            GroupEnumUnitsInRange(g.ejg,x1,y1,100,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,GetUnitAttack(u1)*4.0,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
            g.destroy()
            RemoveUnit(u2)
            num = num - 1
            if  num > 0
                real ang = GetRandomReal(-3.14,3.14)
                real dis = GetRandomReal(-300,300)
                x1 = x + dis * Cos(ang)
                y1 = y + dis * Sin(ang)
                u2 = CreateTmUnit(GetOwningPlayer(u1),"A_yujing_boss_yuan_0.mdl",x1,y1,0,30,0.6)
            else
                
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    function JJFuncSpell02(unit wu,real sx,real sy)
        JJFuncSpell02Timer(wu,sx,sy,3)
    endfunction



    function JJFuncSpell03Timer(unit wu,real sx,real sy,int n)
        unit u1 = wu
        real x = sx
        real y = sy
        real x1 = x
        real y1 = y
        int num = n
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"A_yujing_boss_yuan_0.mdl",x1,y1,0,30,0.6)
        TimerStart(1.5,true)
        {
            
            IndexGroup g = IndexGroup.create()
            LocAddEffectSetSize(x1,y1,"effect2_by_wood_effect2_yubanmeiqin_lightning_luolei.mdl",0.5)
            GroupEnumUnitsInRange(g.ejg,x1,y1,100,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,GetUnitAttack(u1)*4.0,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
            g.destroy()
            RemoveUnit(u2)
            num = num - 1
            if  num > 0
                real ang = GetRandomReal(-3.14,3.14)
                real dis = GetRandomReal(-300,300)
                x1 = x + dis * Cos(ang)
                y1 = y + dis * Sin(ang)
                u2 = CreateTmUnit(GetOwningPlayer(u1),"A_yujing_boss_yuan_0.mdl",x1,y1,0,30,0.6)
            else
                
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction


    function JJFuncSpell03(unit wu,real sx,real sy)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        JJFuncSpell03Timer(u1,x1,y1,3)
        TimerStart(1.0,false)
        {
            JJFuncSpell03Timer(u1,x1,y1,3)
            endtimer
            flush locals
        }
        flush locals
    endfunction


    function JJFuncSpell04Timer(unit wu,real sx,real sy,int n)
        unit u1 = wu
        real x = sx
        real y = sy
        real x1 = x
        real y1 = y
        int num = n
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"A_yujing_boss_yuan_0.mdl",x1,y1,0,30,0.6)
        TimerStart(1.5,true)
        {
            
            IndexGroup g = IndexGroup.create()
            LocAddEffectSetSize(x1,y1,"effect2_by_wood_effect2_yubanmeiqin_lightning_luolei.mdl",0.5)
            GroupEnumUnitsInRange(g.ejg,x1,y1,100,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,GetUnitAttack(u1)*4.0,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
            g.destroy()
            RemoveUnit(u2)
            num = num - 1
            if  num > 0
                real ang = GetRandomReal(-3.14,3.14)
                real dis = GetRandomReal(-300,300)
                x1 = x + dis * Cos(ang)
                y1 = y + dis * Sin(ang)
                u2 = CreateTmUnit(GetOwningPlayer(u1),"A_yujing_boss_yuan_0.mdl",x1,y1,0,30,0.6)
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction


    function JJFuncSpell04(unit wu,real sx,real sy)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        int num = 2
        JJFuncSpell04Timer(u1,x1,y1,3)
        TimerStart(1.0,true)
        {
            num = num - 1
            JJFuncSpell04Timer(u1,x1,y1,3)

            
            if  num == 0
                endtimer
            endif
            
            
            flush locals
        }
        flush locals
    endfunction



    function JJFuncSpell05Timer(unit wu,real sx,real sy)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        int num = 2
        IndexGroup g = IndexGroup.create()
        int gg = g
        LocAddEffectSetSize(x1,y1,"effect2_az_coco_e2.mdl",2.0)
        GroupEnumUnitsInRange(g.ejg,x1,y1,200,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,g.ejg,GetUnitAttack(u1)*6.0,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
        TimerStart(1,true)
        {
            IndexGroup g = gg 
            LocAddEffect(x1,y1,"effect_az_tormentedsoul_t1.mdl")
            GroupEnumUnitsInRange(g.ejg,x1,y1,200,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,GetUnitAttack(u1)*6.0,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
            num = num - 1
            if  num <= 0
                g.destroy()
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function JJFuncSpell05(unit wu,real sx,real sy)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        int num = 4
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"A_yujing_boss_yuan_0.mdl",x1,y1,0,30,0.6)
        TimerStart(1,true)
        {
            real dis = GetRandomReal(0,300)
            real ang = GetRandomReal(-3.14,3.14)
            real x = x1 + dis * Cos(ang)
            real y = y1 + dis * Sin(ang)
            JJFuncSpell05Timer(u1,x,y)
            num = num - 1
            if  num <= 0
                RemoveUnit(u2)
                endtimer
            endif
            flush locals
        }
        flush locals
        
    endfunction

    function JJFuncSpell07(unit wu,unit tu)
        real life = GetUnitState(tu,UNIT_STATE_LIFE)
        real maxlife = GetUnitState(tu,UNIT_STATE_MAX_LIFE)
        if  life / maxlife <= 0.4
            UnitDamageTarget(wu,tu,2000000000,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,null)
            DisplayTimedTextToPlayer(GetOwningPlayer(tu),0,0,10,"|cffffcc00[系统]：|r你的生命低于40%，被因果律斩杀了")
        endif
    endfunction

    

    function JJFuncSpell08_1(unit wu,real sx,real sy)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"Abilities\\Spells\\Human\\CloudOfFog\\CloudOfFog.mdl",x1,y1,0,30,1.5)
        int time = 6
        TimerStart(1,true)
        {
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,x1,y1,250,GroupAddBuffEx(GetOwningPlayer(u1),"",'AZ06',1,852190,100))
            GroupClear(g.ejg)
            g.destroy()
            time = time - 1
            if  time <= 0
                RemoveUnit(u2)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    function JJFuncSpell08_2Timer(unit wu,real sx,real sy)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        int time = 6
        TimerStart(0.1,true)
        {
            IndexGroup g = IndexGroup.create()
            LocAddEffectSetRotate(x1,y1,GetRandomReal(1,360),"effect_zm(30).mdl")
            GroupEnumUnitsInRange(g.ejg,x1,y1,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,GetUnitAttack(u1)*2.0,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
            g.destroy()
            time = time - 1
            if  time <= 0
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    function JJFuncSpell08_2(unit wu,real sx,real sy)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"A_yujing_boss_yuan_0.mdl",x1,y1,0,30,1.8)
        TimerStart(1.5,false)
        {
            JJFuncSpell08_2Timer(u1,x1,y1)
            RemoveUnit(u2)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function JJFuncSpell08(unit wu,real sx,real sy)
        if  GetUnitAbilityLevel(wu,'AZ07') == 2
            JJFuncSpell08_2(wu,sx,sy)
        else
            JJFuncSpell08_1(wu,sx,sy)
        endif
    endfunction

    function JJFuncSpell08Damage(unit wu)
        
        
        if  GetUnitAbilityLevel(wu,'AZ07') != 2
            real life = GetUnitState(wu,UNIT_STATE_LIFE)
            real maxlife = GetUnitState(wu,UNIT_STATE_MAX_LIFE)
            if  life / maxlife <= 0.5
                UnitAddAbility(wu,'AZ07')
                SetUnitAbilityLevel(wu,'AZ07',2)
                DzSetUnitModel(wu,"moster_JJ_8_2.mdl")
                LocAddEffect(GetUnitX(wu),GetUnitY(wu),"Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl")
            endif
        endif
    endfunction

    function JJFuncSpell09Damage(unit wu)
        real life = GetUnitState(wu,UNIT_STATE_LIFE)
        real maxlife = GetUnitState(wu,UNIT_STATE_MAX_LIFE)
        int lv = 0
        if  life / maxlife <= 0.2
            lv = 5
        elseif  life / maxlife <= 0.4
            lv = 4
        elseif  life / maxlife <= 0.6
            lv = 3
        elseif  life / maxlife <= 0.8
            lv = 2
        endif
        if  GetUnitAbilityLevel(wu,'AZ07') < lv
            UnitAddAbility(wu,'AZ07')
            SetUnitAbilityLevel(wu,'AZ07',lv)
            
            DzSetUnitModel(wu,"moster_JJ_9_"+I2S(lv)+".mdl")
            LocAddEffect(GetUnitX(wu),GetUnitY(wu),"Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl")
            if  lv == 5
                SetUnitScale(wu,1.6,1.6,1.6)
            elseif  lv == 4
                SetUnitScale(wu,1.3,1.3,1.3)
            endif
        endif
    endfunction

    function JJFuncSpell09_1(unit wu,real sx,real sy)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"A_yujing_boss_yuan_0.mdl",x1,y1,0,30,2.4)
        TimerStart(1.5,false)
        {
            IndexGroup g = IndexGroup.create()
            LocAddEffectTimerOrSize(x1,y1,0,"effect2_chanrao.mdl",1.0,1.8)
            LocAddEffectSetSize(x1,y1,"effect_forestbolt.mdl",3.0)
            GroupEnumUnitsInRange(g.ejg,x1,y1,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,GetUnitAttack(u1)*12.0,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
            g.destroy()
            RemoveUnit(u2)
            endtimer
            flush locals
        }
        flush locals
    endfunction
    function JJFuncSpell09_2(unit wu,real sx,real sy)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"A_yujing_boss_yuan_0.mdl",x1,y1,0,30,2.4)
        TimerStart(1.5,false)
        {
            IndexGroup g = IndexGroup.create()
            LocAddEffectSetSize(x1,y1,"effect_forestbolth.mdl",3.0)
            GroupEnumUnitsInRange(g.ejg,x1,y1,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,GetUnitAttack(u1)*12.0,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
            g.destroy()
            RemoveUnit(u2)
            endtimer
            flush locals
        }
        flush locals
    endfunction
    function JJFuncSpell09_3(unit wu,real sx,real sy)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"A_yujing_boss_yuan_0.mdl",x1,y1,0,30,2.4)
        TimerStart(1.5,false)
        {
            IndexGroup g = IndexGroup.create()
            LocAddEffectSetSize(x1,y1,"effect_az_kaer_t1.mdl",1.5)
            GroupEnumUnitsInRange(g.ejg,x1,y1,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,GetUnitAttack(u1)*12.0,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
            g.destroy()
            RemoveUnit(u2)
            endtimer
            flush locals
        }
        flush locals
    endfunction
    function JJFuncSpell09_4(unit wu,real sx,real sy)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"A_yujing_boss_yuan_0.mdl",x1,y1,0,30,2.4)
        TimerStart(1.5,false)
        {
            IndexGroup g = IndexGroup.create()
            LocAddEffectSetSize(x1,y1,"effect_az_cwdullahan_d1target.mdl",1.6)
            LocAddEffectSetSize(x1,y1,"effect_green-texiao-shandian.mdl",1.6)
            GroupEnumUnitsInRange(g.ejg,x1,y1,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,GetUnitAttack(u1)*12.0,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
            g.destroy()
            RemoveUnit(u2)
            endtimer
            flush locals
        }
        flush locals
    endfunction
    function JJFuncSpell09_5(unit wu,real sx,real sy)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"A_yujing_boss_yuan_0.mdl",x1,y1,0,30,2.4)
        TimerStart(1.5,false)
        {
            IndexGroup g = IndexGroup.create()
            LocAddEffectSetSize(x1,y1,"effect_hero_grandmagus_n1s_z_down.mdl",1.6)
            GroupEnumUnitsInRange(g.ejg,x1,y1,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,GetUnitAttack(u1)*12.0,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
            g.destroy()
            RemoveUnit(u2)
            endtimer
            flush locals
        }
        flush locals
    endfunction
    function JJFuncSpell09(unit wu,real sx,real sy)
        int lv = GetUnitAbilityLevel(wu,'AZ07')
        if  lv == 5
            JJFuncSpell09_5(wu,sx,sy)
        elseif  lv == 4
            JJFuncSpell09_4(wu,sx,sy)
        elseif  lv == 3
            JJFuncSpell09_3(wu,sx,sy)
        elseif  lv == 3
            JJFuncSpell09_2(wu,sx,sy)
        else
            JJFuncSpell09_1(wu,sx,sy)
        endif
    endfunction

    function JJFuncSpell10Timer(unit wu,real sx,real sy)
        unit u1 = wu
        real ang = GetRandomReal(-3.14,3.14)
        real dis = GetRandomReal(-300,300)
        real x1 = sx + dis * Cos(ang)
        real y1 = sy + dis * Sin(ang)
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"A_yujing_boss_yuan_0.mdl",x1,y1,0,30,1.2)
        int time = 0
        TimerStart(1.3,true)
        {
            time = time + 1
            if  time == 1
                LocAddEffectTimer(x1,y1,"effect_BigFireBall.mdl",1.0)
            else
                IndexGroup g = IndexGroup.create()
                LocAddEffectSetSize(x1,y1,"effect_az_tormentedsoul_t1.mdl",0.5)
                GroupEnumUnitsInRange(g.ejg,x1,y1,200,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                UnitDamageGroup(u1,g.ejg,GetUnitAttack(u1)*12.0,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
                g.destroy()
                LocAddEffectSetSize(x1,y1,"effect_AA_bwaxec.mdl",1.2)
                
                RemoveUnit(u2)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    function JJFuncSpell10(unit wu,real sx,real sy)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        int num = 5
        JJFuncSpell10Timer(u1,x1,y1)
        TimerStart(0.5,true)
        {
            JJFuncSpell10Timer(u1,x1,y1)
            num = num - 1
            if  num <= 0
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction


endlibrary
