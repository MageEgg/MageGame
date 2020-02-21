library SkillCode uses System,State,DamageCode
    scope poison
        int Poison=159379
        function PoisonNumber(unit wu)->int
         int i=1
                if  IsPlayerHasAbility(wu,'S045') == true
                    i=i+1
                endif
            return i
       endfunction
           
        function Poisontime(unit wu)->real
            real r=8
            if  IsPlayerHasAbility(wu,'S045') == true
                r=r*2
            endif
            return r
        endfunction
           
        function PoisonNumberMax(unit wu)->int
            int i=8
            if  IsPlayerHasAbility(wu,'S045') == true
                i=i*2
            endif
            return i
        endfunction
           
        function poisonBuff(unit wu,unit mb1,real damage)
            unit u=wu
            unit mb=mb1
            
            integer cs=LoadInteger(ht,GetHandleId(mb),Poison) 
             if  cs<PoisonNumberMax(u)
                SaveInteger(ht,GetHandleId(mb),Poison,cs+PoisonNumber(u))
                cs=LoadInteger(ht,GetHandleId(mb),Poison)
                UnitDamageTarget(u, mb, 10+(cs*damage), false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_POISON, WEAPON_TYPE_WHOKNOWS)      
                TimerStart(Poisontime(u),false)
                {
                    cs=LoadInteger(ht,GetHandleId(mb),Poison)
                    SaveInteger(ht,GetHandleId(mb),Poison,cs-PoisonNumber(u))
                    endtimer
                    flush locals
                }
                flush locals
            endif
            flush locals
        endfunction

        function poisondamage(unit wu1,real damage1)
            unit wu=wu1
            integer time=0
            real damage=damage1
            group g = CreateGroup()
            unit gu=null 
   
            TimerStart(1,true)
            {
                time=time+1
                if time<=8
                    GroupEnumUnitsInRange(g,GetUnitX(wu),GetUnitY(wu),2000,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
                    loop
                        gu = FirstOfGroup(g)
                        exitwhen gu == null
                            if  Udis(wu,gu)<800
                                poisonBuff(wu,gu,damage)  
                            else
                                int cs=LoadInteger(ht,GetHandleId(gu),Poison) 
                                if  cs>0
                                    UnitDamageTarget(wu, gu, (cs*damage), false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_POISON, WEAPON_TYPE_WHOKNOWS)
                                endif
                            endif
                        GroupRemoveUnit(g,gu)
                    endloop
                else
                    DestroyGroup(g)
                    wu=null
                    endtimer
                endif
                flush locals
            }
            flush locals
         endfunction
         
    endscope
    
    function UnitTimerAddSkillBuffFunc()
        timer t = GetExpiredTimer()
        unit wu = LoadUnitHandle(ht,GetHandleId(t),1)
        int i = LoadInteger(ht,GetHandleId(t),2)
        int i2 = LoadInteger(ht,GetHandleId(t),3)
        UnitRemoveAbility(wu,i)
        UnitRemoveAbility(wu,i2)
        FlushChildHashtable(ht,GetHandleId(t))
        DestroyTimer(t)
        t = null
        wu = null
    endfunction
    function UnitTimerAddSkillBuff(unit wu,int i,int i2,real time)
        timer t = CreateTimer()
        UnitAddAbility(wu,i)
        UnitMakeAbilityPermanent(wu,true,i)
        SaveUnitHandle(ht,GetHandleId(t),1,wu)
        SaveInteger(ht,GetHandleId(t),2,i)
        SaveInteger(ht,GetHandleId(t),3,i2)
        TimerStart(t,time,false,function UnitTimerAddSkillBuffFunc)
        t = null
    endfunction
    
    function UnitAddLife(unit whichunit,real amount)
        real lifea = GetUnitState(whichunit,UNIT_STATE_LIFE)
        real lifem = GetUnitState(whichunit,UNIT_STATE_MAX_LIFE)-lifea
        if  lifem != 0
            if  lifem > amount 
                lifem = amount
            endif
            SetUnitState(whichunit,UNIT_STATE_LIFE,lifea+lifem)
            DestroyEffect(AddSpecialEffect("effect_e_buffgreen2a.mdl",GetUnitX(whichunit),GetUnitY(whichunit)))
        endif
    endfunction
    
    function UnitAddMana(unit whichunit,real amount)
        real lifea = GetUnitState(whichunit,UNIT_STATE_MANA)
        real lifem = GetUnitState(whichunit,UNIT_STATE_MAX_MANA)-lifea
        if  lifem != 0
            if  lifem > amount 
                lifem = amount
            endif
            SetUnitState(whichunit,UNIT_STATE_MANA,lifea+lifem)
            DestroyEffect(AddSpecialEffect("effect_e_buffblue2.mdl",GetUnitX(whichunit),GetUnitY(whichunit)))
        endif
    endfunction

    
endlibrary 

