library Summon uses AbilityUI,OtherDamageTimer

    function GetHeroSummonNum(unit u)->int
        int num = 0
        if  IsPlayerHasAbility(u,'S088') == true
            num = num + 2
        endif
        if  GetUnitIntState(u,'FB49') > 0
            num = num + 1
        endif
        return num
    endfunction

    function Z103DamageEx(unit u)
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,GetUnitX(u),GetUnitY(u),600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        UnitDamageGroup(u,g.ejg,GetUnitRealState(u,1),false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
    endfunction

    function Z103Damage(unit wu)
        unit u1 = wu
        Z103DamageEx(u1)
        TimerStart(0.5,true)
        {
            if  GetUnitState(u1, UNIT_STATE_LIFE) >= 0.4 and GetUnitTypeId(u1) == 'z103'
                Z103DamageEx(u1)
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SummonFollow(unit wu,unit tu)
        unit u1 = wu
        unit u2 = tu
        int uid = GetUnitTypeId(u2)
        TimerStart(0.1,true)
        {
            if  GetUnitState(u2, UNIT_STATE_LIFE) >= 0.4 and GetUnitTypeId(u2) == uid
                if  Udis(u1,u2) > 800
                    SetUnitXY(u2,GetUnitX(u2)+GetRandomReal(-200,200),GetUnitY(u2)+GetRandomReal(-200,200))
                    UnitAddEffect(u2,"effect_az_pafeathermoon_b.mdl")
                    IssuePointOrderById(u2,851983,GetUnitX(u2)+GetRandomReal(-250,250),GetUnitY(u2)+GetRandomReal(-250,250))
                endif
                if  GetUnitCurrentOrder(u2) == 0
                    IssuePointOrderById(u2,851983,GetUnitX(u2)+GetRandomReal(-250,250),GetUnitY(u2)+GetRandomReal(-250,250))
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function HeroSpellSummon(unit u,real x,real y,integer id)
        integer num = GetHeroSummonNum(u)
        unit u2 = null
        if  id == 'z102'
            num = num + 1
            for k = 1,num
                u2 = CreateUnit(GetOwningPlayer(u),id,x,y,GetUnitFacing(u))
                SetUnitRealState(u2,1,GetUnitRealState(u,1))
                SetUnitRealState(u2,22,100)
                UnitApplyTimedLife(u2,'BHwe',12)
                SummonFollow(u,u2)
            end
        endif
        if  id == 'z103'
            num = num + 1
            for k = 1,num
                u2 = CreateUnit(GetOwningPlayer(u),id,x,y,GetUnitFacing(u))
                SetUnitRealState(u2,1,GetUnitRealState(u,1))
                UnitApplyTimedLife(u2,'BHwe',4)
                SummonFollow(u,u2)
                Z103Damage(u2)               
            end
        endif
        flush locals
    endfunction
endlibrary