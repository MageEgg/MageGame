library BossSkill2 uses AbilityUI,OtherDamageTimer

    function JJFuncSpell01(unit wu,unit tu)


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
            UnitDamageGroup(u1,g.ejg,1000,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
            g.destroy()
            RemoveUnit(u2)
            num = num - 1
            if  num > 0
                real ang = GetRandomReal(-3.14,3.14)
                real dis = GetRandomReal(-400,400)
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
            UnitDamageGroup(u1,g.ejg,1000,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
            g.destroy()
            RemoveUnit(u2)
            num = num - 1
            if  num > 0
                real ang = GetRandomReal(-3.14,3.14)
                real dis = GetRandomReal(-500,500)
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
            UnitDamageGroup(u1,g.ejg,1000,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
            g.destroy()
            RemoveUnit(u2)
            num = num - 1
            if  num > 0
                real ang = GetRandomReal(-3.14,3.14)
                real dis = GetRandomReal(-500,500)
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
            if  num == 1
                JJFuncSpell04Timer(u1,x1,y1,3)
            elseif  num == 0
                JJFuncSpell04Timer(u1,x1,y1,3)
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
        LocAddEffect(x1,y1,"effect2_az_coco_e2.mdl")
        GroupEnumUnitsInRange(g.ejg,x1,y1,100,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,g.ejg,1000,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
        TimerStart(1,true)
        {
            IndexGroup g = gg 
            LocAddEffectSetSize(x1,y1,"effect_az_tormentedsoul_t1.mdl",0.5)
            GroupEnumUnitsInRange(g.ejg,x1,y1,100,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,1000,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
        int num = 3
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"A_yujing_boss_yuan_0.mdl",x1,y1,0,30,0.6)
        TimerStart(2,true)
        {
            JJFuncSpell05Timer(u1,x1,y1)
            num = num - 1
            if  num <= 0
                RemoveUnit(u2)
                endtimer
            endif
            flush locals
        }
        flush locals
        
    endfunction

endlibrary
