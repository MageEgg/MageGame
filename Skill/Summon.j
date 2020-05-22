library Summon uses AbilityUI,OtherDamageTimer

    function CameraSetTargetNoiseTimer(int playerid,real magnitude,int Type,real time)
        int pid = playerid
        real richter = magnitude
        if  richter > 5.0
            richter = 5.0
        elseif  richter < 2.0
            richter = 2.0
        endif
        if  GetLocalPlayer() == Player(pid)
            if  Type == 1 or Type == 5 or Type == 7
                CameraSetTargetNoiseEx(magnitude*2.0, magnitude*Pow(10,richter),true)
            endif
            if  Type == 2 or Type == 5 or Type == 8
                CameraSetSourceNoiseEx(magnitude*2.0, magnitude*Pow(10,richter),true)
            endif
            if  Type == 3 or Type == 6 or Type == 7
                CameraSetTargetNoiseEx(magnitude*2.0, magnitude*Pow(10,richter),false)
            endif
            if  Type == 4 or Type == 6 or Type == 8
                CameraSetSourceNoiseEx(magnitude*2.0, magnitude*Pow(10,richter),false)
            endif
        endif
        TimerStart(time,false)
        {
            if  GetLocalPlayer() == Player(pid)
                CameraSetSourceNoise(0, 0)
                CameraSetTargetNoise(0, 0)
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    function GetHeroSummonNum(unit u)->int
        int num = 0
        int i1 = 0
        if  IsPlayerHasAbility(u,'S088') == true
            num = num + 2
        endif

        i1 = GetUnitIntState(u,'FY03')
        if  i1 >= 3
            num = num + 1
            if  i1 >= 6
                num = num + 2
            endif
        endif
        
        return num
    endfunction

    function Z103DamageEx(unit wu,real x,real y,real damage)
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(wu),"Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl","origin",0))
        UnitDamageGroup(wu,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
    endfunction

    function Z103Damage(unit wu,real sx,real sy,real dam)
        unit u1 = wu
        real damage = dam
        real x = sx
        real y = sy
        int time = 7
        Z103DamageEx(u1,x,y,damage)
        TimerStart(0.5,true)
        {
            time = time - 1
            Z103DamageEx(u1,x,y,damage)
            if  time <= 0
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
        int pid = GetPlayerId(GetOwningPlayer(u1))
        TimerStart(0.1,true)
        {
            if  GetUnitState(u2, UNIT_STATE_LIFE) >= 0.4 and GetUnitTypeId(u2) == uid
                if  Udis(u1,u2) > 800
                    SetUnitXY(u2,GetUnitX(Pu[1])+GetRandomReal(-200,200),GetUnitY(Pu[1])+GetRandomReal(-200,200))
                    UnitAddEffect(u2,"effect_az_pafeathermoon_b.mdl")
                endif

                if  GetUnitCurrentOrder(u2) == 0
                    if  GetUnitTypeId(Pu[6]) > 0
                        IssueTargetOrderById(u2,851983,Pu[6])
                    else
                        IssuePointOrderById(u2,851983,GetUnitX(Pu[1])+GetRandomReal(-500,500),GetUnitY(Pu[1])+GetRandomReal(-500,500))
                    endif
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction



    function HeroSpellSummon(unit u,real x,real y,integer id,real damage)
        int pid = GetPlayerId(GetOwningPlayer(u))
        integer num = GetHeroSummonNum(u)
        unit u2 = null
        real x2 = 0
        real y2 = 0
        if  id == 'z102'
            num = num + 1
            for k = 1,num
                u2 = CreateUnit(GetOwningPlayer(u),id,x,y,GetUnitFacing(u))
                SetUnitRealState(u2,1,damage)
                SetUnitRealState(u2,22,GetUnitRealState(u,22))
                SetUnitRealState(u2,15,GetUnitRealState(u,15))
                SetUnitRealState(u2,17,GetUnitRealState(u,17))
                SetUnitRealState(u2,19,GetUnitRealState(u,19))
                SetUnitRealState(u2,20,GetUnitRealState(u,20))
                UnitApplyTimedLife(u2,'BHwe',6)
                SummonFollow(u,u2)
            end
        endif



        if  id == 'z103'
            num = num + 1
            if  num == 1
                Z103Damage(u,x,y,damage)
                if  ShowEffect == true
                    UnitApplyTimedLife(CreateUnit(GetOwningPlayer(u),id,x,y,GetUnitFacing(u)),'BHwe',4)
                endif
            else
                for k = 1,num
                    x2 = x+GetRandomReal(-125,125)
                    y2 = y+GetRandomReal(-125,125)
                    Z103Damage(u,x2,y2,damage)

                    if  ShowEffect == true
                        UnitApplyTimedLife(CreateUnit(GetOwningPlayer(u),id,x2,y2,GetRandomReal(0,360)),'BHwe',4)
                    endif
                    
                end
            endif
        endif
        flush locals
    endfunction
endlibrary