library Summon  initializer SummonInit uses AbilityUI,OtherDamageTimer

    group array SummonGroup

    function SummonInit()
        for pid = 0,3
            SummonGroup[pid] = CreateGroup()
        end
    endfunction

    function z100Attack(unit u,unit mb1)
        unit u2 = u
        unit mb = mb1
        real x1 = GetUnitX(u2)
        real y1 = GetUnitY(u2)
        real Ang =Uang(u2,mb)
        real x2 = 50*Cos(Ang)
        real y2 = 50*Sin(Ang)
        integer time =10
        ////额外判断
        TimerStart(0.03,true)
        {
            time = time - 1
            if  time > 0
                x1 = x1 + x2
                y1 = y1 + y2
                SetUnitPosition(u2,x1,y1)
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    
    function trap(unit u1,unit summon1)
        unit u=u1
        unit summon=summon1
        real x=0
        real y=0
        group g1=CreateGroup()
        TimerStart(1,true)
        {

            if  GetUnitState(summon, UNIT_STATE_LIFE) > 0
                x=GetUnitX(summon)
                y=GetUnitY(summon)
                GroupEnumUnitsInRange(g1,x,y,400,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
                if  CountUnitsInGroup(g1) > 0
                    IndexGroup g = IndexGroup.create()
                    GroupEnumUnitsInRange(g.ejg,x,y,500,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
                    UnitDamageGroup(summon,g.ejg,GetUnitRealState(u,2)*3,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    g.destroy()
                    KillUnit(summon)
                    GroupClear(g1)
                endif
            else
                DestroyGroup(g1)
                u = null
                endtimer
            endif
        }
    endfunction
    
    function Z105Spell(unit u1,unit summon1)
        unit u=u1
        unit summon=summon1
        real x=0
        real y=0
        TimerStart(1,true)
                {
                    x=GetUnitX(summon)
                    y=GetUnitY(summon)
                    if   GetUnitState(summon, UNIT_STATE_LIFE) > 0
                         CreateTmEx(summon,"Abilities\\Weapons\\GuardTowerMissile\\GuardTowerMissile.mdl",x,y,GetUnitX(u),GetUnitY(u),GetUnitRealState(u,1),8,45,70,800,0.03,100,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa) 
                    else
                        u = null
                        endtimer
                    endif
                }
    endfunction
    
    function Z103Spell(unit u1,unit summon1)
        unit u=u1
        unit summon=summon1
        real x=0
        real y=0
        TimerStart(0.5,true)
                {
                    x=GetUnitX(summon)
                    y=GetUnitY(summon)
                    if   GetUnitState(summon, UNIT_STATE_LIFE) > 0
                            IndexGroup g = IndexGroup.create()
                            
                        if  IsPlayerHasAbility(u,'S085') == true
                            GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
                            UnitDamageGroup(summon,g.ejg,GetUnitRealState(u,2)*4,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                            g.destroy()
                            
                        else
                            GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
                            UnitDamageGroup(summon,g.ejg,GetUnitRealState(u,2)*1,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                            g.destroy()
                    
                        endif
                    else
                        u = null
                        endtimer
                    endif
                }
    endfunction

    function Summon(unit u1,real x1,real y1,integer id1)
        unit u=u1 
        real x=x1
        real y=y1
        integer id=id1
        integer Number=0
        unit summon=null
        if IsPlayerHasAbility(u,'S088') == true
            Number=Number+2
        endif

         if  GetUnitIntState(u,'FB49') > 0
             Number=Number+1
         endif

        if IsPlayerHasAbility(u,'S507') == true
            if  GetUnitRealState(u,14)>=30
                Number=Number+2
            endif
        endif

        if  id=='z100'
             Number=Number+4         //此单位最大召唤数

            loop    
                exitwhen LoadInteger(ht,GetHandleId(u),id)>=Number
                summon=CreateUnit(GetOwningPlayer(u),id,x+(100*Cos(LoadInteger(ht,GetHandleId(u),id)*0.785)),y+(100*Sin(LoadInteger(ht,GetHandleId(u),id)*0.785)),GetUnitFacing(u))
                GroupAddUnit(SummonGroup[GetPlayerId(GetOwningPlayer(u))],summon)
                SaveInteger(ht,GetHandleId(u),id,LoadInteger(ht,GetHandleId(u),id)+1)
                SetUnitRealState(summon,1,GetUnitRealState(u,1)*0.3)
                SetUnitRealState(summon,9,GetUnitRealState(u,9))
                UnitApplyTimedLife(summon, 'BHwe', 18 )
                if  IsPlayerHasAbility(u,'S085') == true
                    SetUnitRealState(summon,19,20)
                    SetUnitRealState(summon,20,50)
                endif

            endloop
        endif

        if  id=='z101'
            Number=Number+1         //此单位最大召唤数
            loop
                exitwhen LoadInteger(ht,GetHandleId(u),id)>=Number
                summon=CreateUnit(GetOwningPlayer(u),id,x,y,GetUnitFacing(u))
                GroupAddUnit(SummonGroup[GetPlayerId(GetOwningPlayer(u))],summon)
                SaveInteger(ht,GetHandleId(u),id,LoadInteger(ht,GetHandleId(u),id)+1)
                SetUnitRealState(summon,1,GetUnitRealState(u,2))
                UnitApplyTimedLife(summon, 'BHwe', 8 )
                if  IsPlayerHasAbility(u,'S085') == true
                   
                else
                   
                endif
            endloop
        endif
        
        if  id=='z102'
            Number=Number+1         //此单位最大召唤数
            loop    
                exitwhen LoadInteger(ht,GetHandleId(u),id)>=Number
                summon=CreateUnit(GetOwningPlayer(u),id,x,y,GetUnitFacing(u))
                GroupAddUnit(SummonGroup[GetPlayerId(GetOwningPlayer(u))],summon)
                SaveInteger(ht,GetHandleId(u),id,LoadInteger(ht,GetHandleId(u),id)+1)
                SetUnitRealState(summon,9,GetUnitRealState(u,9))
                UnitApplyTimedLife(summon, 'BHwe', 12 )
                if  IsPlayerHasAbility(u,'S085') == true
                    SetUnitRealState(summon,1,(GetUnitRealState(u,1)*1)+(GetUnitRealState(u,2)*1))
                else
                    SetUnitRealState(summon,1,(GetUnitRealState(u,1)*0.5)+(GetUnitRealState(u,1)*0.5))
                endif
            endloop
        endif
        
        if  id=='z103'
            Number=Number+1         //此单位最大召唤数
            loop    
                exitwhen LoadInteger(ht,GetHandleId(u),id)>=Number
                summon=CreateUnit(GetOwningPlayer(u),id,x,y,GetUnitFacing(u))
                GroupAddUnit(SummonGroup[GetPlayerId(GetOwningPlayer(u))],summon)
                SaveInteger(ht,GetHandleId(u),id,LoadInteger(ht,GetHandleId(u),id)+1)
                UnitApplyTimedLife(summon, 'BHwe', 8 )
                Z103Spell(u,summon)               
            endloop
        endif
        
       if  id=='z104'
            Number=Number+1         //寒冰陷阱
            loop    
                exitwhen LoadInteger(ht,GetHandleId(u),id)>=Number
                summon=CreateUnit(GetOwningPlayer(u),id,x,y,GetUnitFacing(u))
                GroupAddUnit(SummonGroup[GetPlayerId(GetOwningPlayer(u))],summon)
                SaveInteger(ht,GetHandleId(u),id,LoadInteger(ht,GetHandleId(u),id)+1)
                UnitApplyTimedLife(summon, 'BHwe', 60 )
                trap(u,summon)
            endloop
        endif
        
         if  id=='z105'
            Number=Number+1         //机关塔
            loop    
                exitwhen LoadInteger(ht,GetHandleId(u),id)>=Number
                summon=CreateUnit(GetOwningPlayer(u),id,x,y,GetUnitFacing(u))
                GroupAddUnit(SummonGroup[GetPlayerId(GetOwningPlayer(u))],summon)
                SaveInteger(ht,GetHandleId(u),id,LoadInteger(ht,GetHandleId(u),id)+1)
                UnitApplyTimedLife(summon, 'BHwe', 4.5 )
                Z105Spell(u,summon)
            endloop
        endif
        

    endfunction
endlibrary