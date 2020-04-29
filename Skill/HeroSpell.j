library HeroSpell uses HeroAbilityFunc,BossSkill,Summon

    
    
    function CreateSurroundOfUnitEnd(unit wu,int i1)
        unit u1 = wu
        int id = i1
        TimerStart(0.1,false)
        {  
            if  id == 'S082'
                SpellS082.execute(u1)
            elseif  id == 'S086'
                SpellS086.execute(u1)
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    //单位 环绕马甲 初始角度 环绕半径 角速度 线速度 环绕总时间 ||技能id 当前数量 初始数量 马甲顺序（辅助参数）
    function CreateSurroundOfUnit(unit wu,unit tu,real r1,real r2,real r3,real r4,real r5,int i1,int i2,int i3,int i4,string s)
        unit u1 = wu
        unit u2 = tu
        real orang = r1
        real r = r2
        real angspeed = r3
        real time = r4
        real overtime = r5
        int tt = R2I(overtime/time)
        real ound = (360/angspeed)*time
        int id = i1
        int ornum = i2
        int num = i3
        int order = i4
        string lig = s
        real xx = 0
        real yy = 0
        //BJDebugMsg("总时间"+I2S(tt))
        BJDebugMsg("一圈时间为"+R2S(ound))
        //BJDebugMsg("半径"+R2S(r))
        xx = GetUnitX(u1) + r*Cos(orang*0.01745)
        yy = GetUnitY(u1) + r*Sin(orang*0.01745)
        SetUnitXY(u2,xx,yy)
        SetUnitFacing(u2,orang)
        TimerStart(time,true)
        {
            real damage = 0
            group gg = null
            unit uu = null
            int pid = GetPlayerId(GetOwningPlayer(u1))
            if  tt > 0 and IsPlayerHasAbility(u1,id) == true
                tt = tt - 1
                if  PlayerDeathBool == false
                    orang = orang + angspeed
                    xx = GetUnitX(u1) + r*Cos(orang*0.01745)
                    yy = GetUnitY(u1) + r*Sin(orang*0.01745)
                    SetUnitXY(u2,xx,yy)
                    SetUnitFacing(u2,orang)
                    if  ModuloInteger(tt,R2I(ound/time)/2) == 0
                        gg = CreateGroup()
                        GroupEnumUnitsInRange(gg,GetUnitX(u1),GetUnitY(u1),600+r,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))  
                        uu = FirstOfGroup(gg)
                        //GroupClear(gg)
                        if  GetUnitTypeId(uu) != 0
                            damage = GetAbilityDamage(u1,id,GetHeroAbilityLevel(u1,id))
                            //GroupEnumUnitsInRange(gg,GetUnitX(uu),GetUnitY(uu),200,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                            Ligfunc(u2,uu,AddLightningEx(lig,false,GetUnitX(u2),GetUnitY(u2),GetUnitZ(u2),GetUnitX(uu),GetUnitY(uu),GetUnitZ(uu)))
                            DestroyEffect(AddSpecialEffect("effect_AZ_UrsaPsionic_E.mdl",GetUnitX(uu),GetUnitY(uu)))
                            //UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                            UnitDamageTarget(u1,uu,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                        endif
                        GroupClear(gg)
                        DestroyGroup(gg)
                    endif
                endif
                if  ornum != num+GetHeroSummonNum(u1)
                    RemoveUnit(u2)
                    if  order == ornum
                        CreateSurroundOfUnitEnd(u1,id)
                    endif
                    endtimer
                endif
            else
                RemoveUnit(u2)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function CreateSurroundOfUnitEx(unit wu,unit tu,real r1,real r2,real r3,real r4,real r5,real dam)
        unit u1 = wu
        unit u2 = tu
        real orang = r1
        real r = r2
        real angspeed = r3
        real time = r4
        real overtime = r5
        int tt = R2I(overtime/time)
        real ound = (360/angspeed)*time
        real xx = 0
        real yy = 0
        real damage = dam
        //BJDebugMsg("总时间"+I2S(tt))
        BJDebugMsg("一圈时间为"+R2S(ound))
        //BJDebugMsg("半径"+R2S(r))
        xx = GetUnitX(u1) + r*Cos(orang*0.01745)
        yy = GetUnitY(u1) + r*Sin(orang*0.01745)
        SetUnitXY(u2,xx,yy)
        SetUnitFacing(u2,orang)
        TimerStart(time,true)
        {
            group gg = null
            int pid = GetPlayerId(GetOwningPlayer(u1))
            if  tt > 0
                tt = tt - 1
                if  PlayerDeathBool == false
                    orang = orang + angspeed
                    xx = GetUnitX(u1) + r*Cos(orang*0.01745)
                    yy = GetUnitY(u1) + r*Sin(orang*0.01745)
                    SetUnitXY(u2,xx,yy)
                    SetUnitFacing(u2,orang)
                    if  ModuloInteger(tt,R2I(ound/time)) == 0
                        BJDebugMsg("伤害"+R2S(damage))
                        gg = CreateGroup()
                        GroupEnumUnitsInRange(gg,GetUnitX(u2),GetUnitY(u2),350,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                        UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                        GroupClear(gg)
                        DestroyGroup(gg)
                    endif
                endif
            else
                RemoveUnit(u2)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    

    function GetUnitBeAttackedNumb(unit wu)->int //被攻击
        int i = 1
        return i
    endfunction


    function SpellS013Attack(unit wu,unit tu)
        group gg = null
        int id = 'S013'
        real damage = 0
        int Num = LoadInteger(ht,GetHandleId(wu),id)
        Num=Num+GetUnitAttackNumb(wu)
        SaveInteger(ht,GetHandleId(wu),id,Num)
        if  Num >= 24
            gg = CreateGroup()
            damage = GetAbilityDamage(wu,id,GetHeroAbilityLevel(wu,id))
            GroupEnumUnitsInRange(gg,GetUnitX(tu),GetUnitY(tu),500,GroupNormalNoStrAddBuff(GetOwningPlayer(wu),"",Buffxy,1,0))
            UnitDamageGroup(wu,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            LocAddEffectSetSize(GetUnitX(tu),GetUnitY(tu),"effect2_az_goods_blink(green).mdl",1.4)
            LocAddEffectSetSize(GetUnitX(tu),GetUnitY(tu),"effect_white-qiquan-juhuang.mdl",1.4)
            LocAddEffectSetSize(GetUnitX(tu),GetUnitY(tu),"effect_az_earthshaker_a.mdl",1.4)
            GroupClear(gg)
            DestroyGroup(gg)
            SaveInteger(ht,GetHandleId(wu),id,0)
        endif
        flush locals
    endfunction

    function SpellS001AttackEx(unit wu,unit tu,real dam)
        unit u1 = wu
        unit u2 = tu
        real x2 = GetUnitX(u2)
        real y2 = GetUnitY(u2)
        int time = 0
        real damage = dam / 3
        TimerStart(0.1,true)
        {
            group gg = CreateGroup()
            time = time + 1
            if  time <= 3
                AddEffectInArea(x2,y2,380,6,"effect3_red-zhendi.mdl")
                AddEffectInArea(x2,y2,380,6,"effect2_zhendi-qiquan-boom.mdl")
                LocAddEffectSetSize(x2,y2,"effect_AA_bwaxec.mdl",1.2)
                GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            else
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction

    function SpellS001Attack(unit wu,unit tu)
        int id = 'S001'
        real damage = 0
        int Num = LoadInteger(ht,GetHandleId(wu),id)
        Num=Num+GetUnitAttackNumb(wu)
        SaveInteger(ht,GetHandleId(wu),id,Num)
        if  Num >= 16
            damage = GetAbilityDamage(wu,id,GetHeroAbilityLevel(wu,id))
            SpellS001AttackEx(wu,tu,damage)
            SaveInteger(ht,GetHandleId(wu),id,0)
        endif
        flush locals
    endfunction

    function SpellS002(unit wu)
        SetUnitIntState(wu,'S002',1)
        UnitAddEffectSetSize(wu,"effect_blue-dao-mofa.mdl",1)
    endfunction

    function SpellS014Attack(unit wu)
        group gg = CreateGroup()
        int id = 'S014'
        real damage = GetAbilityDamage(wu,id,GetHeroAbilityLevel(wu,id))
        BJDebugMsg("s014")
        GroupEnumUnitsInRange(gg,GetUnitX(wu),GetUnitY(wu),500,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
        UnitDamageGroup(wu,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        LocAddEffect(GetUnitX(wu),GetUnitY(wu),"effect3_az_lcdark_w1.mdl")
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function SpellS096Attack(unit wu)
        group gg = CreateGroup()
        int id = 'S096'
        real damage = GetAbilityDamage(wu,id,GetHeroAbilityLevel(wu,id))
        real x = 0
        real y = 0
        GroupEnumUnitsInRange(gg,GetUnitX(wu),GetUnitY(wu),500,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
        UnitDamageGroup(wu,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        for num = 0,15
            x = GetUnitX(wu) + 100*Cos(22.5*num*0.01745)
            y = GetUnitY(wu) + 100*Sin(22.5*num*0.01745)
            RemoveUnitTimer(CreateUnit(GetOwningPlayer(wu),'eZ15',x,y,22.5*num),1)
        end
        flush locals
    endfunction

    function SpellS015Attack(unit wu)
        group gg = CreateGroup()
        int id = 'S015'
        real damage = GetAbilityDamage(wu,id,GetHeroAbilityLevel(wu,id))
        SetAbilityCD_AC(wu,id,0.3)
        GroupEnumUnitsInRange(gg,GetUnitX(wu),GetUnitY(wu),500,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
        UnitDamageGroup(wu,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        LocAddEffectSetSize(GetUnitX(wu),GetUnitY(wu),"effect2_by_wood_gongchengsipai_6.mdl",1.6)
        LocAddEffectSetSize(GetUnitX(wu),GetUnitY(wu),"effect_az-ice-zhendi.mdl",1.1)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function SpellS005(unit wu,real r1,real r2,real dam)
        unit u1 = wu
        real x = r1
        real y = r2
        unit u2 = CreateUnit(GetOwningPlayer(u1),'eZ17',x,y,0)
        real damage = dam
        int time = 0
        UnitTimerAddSkill(wu,'S005',4.5)
        TimerStart(0.01,true)
        {
            group gg = null
            if  time < 200
                time = time + 1
                if  time == 1
                    gg = CreateGroup()
                    GroupEnumUnitsInRange(gg,x,y,500,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                    UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    LocAddEffectSetSize(x,y,"effect3_desecrategreen.mdl",0.85)
                    GroupClear(gg)
                    DestroyGroup(gg)
                endif
            else
                RemoveUnit(u2)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SpellS007Attack(unit wu,unit tu)
        int id = 'S007'
        real damage = GetAbilityDamage(wu,id,GetHeroAbilityLevel(wu,id))
        real x2 = GetUnitX(tu)
        real y2 = GetUnitY(tu)
        unit u1 = wu
        int time = 0
        damage = damage / 10
        AddUnitStateExTimer(wu,72,20,6)
        TimerStart(0.03,true)
        {
            group gg = CreateGroup()
            time = time + 1
            if  time <= 10
                GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                AddEffectInArea(x2,y2,350,1,"effect_tx_asad (24).mdl")
                LocAddEffectSetSize(x2,y2,"effect_az_pafeathermoon_b.mdx",3.6)
            else    
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction

    function SpellS010Attack(unit wu,unit tu)
        int id = 'S010'
        real damage = GetAbilityDamage(wu,id,GetHeroAbilityLevel(wu,id))
        real x2 = GetUnitX(tu)
        real y2 = GetUnitY(tu)
        unit u1 = wu
        group gg = CreateGroup()
        if  GetUnitAbilityLevel(wu,id) == 0
            UnitTimerAddSkill(wu,id,4.5)
            AddUnitStateExTimer(wu,32,20,4.5)
        endif
        LocAddEffectSetSize(x2,y2,"effect2_by_wood_leitingyiji.mdl",1.2)
        LocAddEffectSetSize(x2,y2,"effect2_by_wood_effect2_yubanmeiqin_lightning_luolei.mdl",2)
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function SpellS011Attack(unit wu,unit tu)
        int id = 'S011'
        real damage = GetAbilityDamage(wu,id,GetHeroAbilityLevel(wu,id))
        group gg = CreateGroup()
        int k = 0
        int k2 = 0
        for i = 1,5
            k = 'AG00' + i
            k2 ='AC00' + i
            YDWESetUnitAbilityState(wu,k, 1,YDWEGetUnitAbilityState(wu, k, 1)-0.5)
            YDWESetUnitAbilityState(wu,k2, 1,YDWEGetUnitAbilityState(wu, k2, 1)-0.5)
        end
        AddEffectInArea(GetUnitX(tu),GetUnitY(tu),350,9,"effect2_az_coco_e2.mdl")
        GroupEnumUnitsInRange(gg,GetUnitX(tu),GetUnitY(tu),400,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
        UnitDamageGroup(wu,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function SpellS012Attack(unit wu,unit tu)
        int id = 'S012'
        real damage = GetAbilityDamage(wu,id,GetHeroAbilityLevel(wu,id))
        real x2 = GetUnitX(tu)
        real y2 = GetUnitY(tu)
        unit u1 = wu
        group gg = CreateGroup()
        if  GetUnitAbilityLevel(wu,id) == 0
            UnitTimerAddSkill(wu,id,8)
            AddUnitStateExTimer(wu,33,20,6)
        endif
        LocAddEffectSetSize(x2,y2,"effect2_zhendi-yinghua.mdl",1.5)
        LocAddEffectSetSize(x2,y2,"effect_AA_bwaxec.mdl",1.0)
        LocAddEffectSetSize(x2,y2,"effect2_blue-blink-lizi-start.mdl",1.1)
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"effect2_az_goods_force staff(3).mdl","origin",0))
        UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction
    


    function SpellS006Attack(unit wu,real sx,real sy,real dam)->bool
        group gg = CreateGroup()
        unit uu = null
        real face = GetRandomReal(-3.14,3.14)
        GroupEnumUnitsInRange(gg,sx,sy,600,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
        uu = GroupPickRandomUnit(gg)
        if  uu != null
            real ang = Uang(wu,uu)
            SetUnitX(wu,GetUnitX(uu)+70*Cos(ang))
            SetUnitY(wu,GetUnitY(uu)+70*Sin(ang))
            UnitDamageTarget(wu,uu,dam,true,true,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WOOD_MEDIUM_STAB )
            DestroyGroup(gg)
            gg = null
            uu = null
            return true
        else
            DestroyGroup(gg)
            gg = null
            uu = null
            return false
        endif
    endfunction
    
    function SpellS006(unit wu,real x,real y,real dam)
        unit u1 = wu
        real ux = GetUnitX(wu)
        real uy = GetUnitY(wu)
        real x1 = x
        real y1 = y
        real damage = dam/5
        int num = 5
        effect tx=AddSpecialEffectTarget("effect_blue-shandian-huaban-toushewu.mdl",wu,"origin")
        SpellS006Attack(u1,x1,y1,damage)
        TimerStart(0.07,true)
        {
            num = num - 1
            if  GetUnitAbilityLevel(u1,'AZ98') == 0 
                if  num <= 0
                    SetUnitX(u1,ux)
                    SetUnitY(u1,uy)
                    DestroyEffect(tx)
                    endtimer
                else
                    if  SpellS006Attack(u1,x1,y1,damage) == false
                        SetUnitX(u1,ux)
                        SetUnitY(u1,uy)
                        DestroyEffect(tx)
                        endtimer
                    endif
                endif
            else
                DestroyEffect(tx)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SpellS009(unit u1,unit u2,real damage)//连击
        integer lv = GetHeroAbilityLevel(u1,'S009')
        real r1 = GetTypeIdReal('S009',100+lv)
        UnitDamageTarget(u1,u2,damage, true,true,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WOOD_MEDIUM_STAB )
        SetAbilityCD_AC(u1,'S009',r1)
        string mdoelorigin = YDWEGetObjectPropertyString(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(u1),"file")
        unit mj=CreateTmUnit(GetOwningPlayer(u1),mdoelorigin,GetUnitX(u1),GetUnitY(u1),GetUnitFacing(u1),0,1)
        SetUnitAnimation( mj, "Attack" )
        SetUnitVertexColor( mj, 20, 20, 50, 100 )
        RemoveUnitTimer(mj,0.5)
        flush locals
    endfunction        

    function SpellS022(unit u1,real x1,real y1,real damage1)//造成伤害三秒内暴击+10%
        unit u=u1
        real x=x1 
        real y=y1
        real damage=damage1
       
        effect tx=AddSpecialEffect("effect_AZ_CJXX01_LH_1.MDX",x,y)
        TimerStart(0.3,false)
        {
            IndexGroup g = IndexGroup.create()
            AddUnitStateExTimer(u,19,10,4.5)
            GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
            UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            DestroyEffect(tx) 
            g.destroy()
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function SpellS027(unit u,unit u1,real damage)//九天御雷击
        real x=GetUnitX(u1)
        real y=GetUnitY(u1)
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,400,GroupNormalNoStr(GetOwningPlayer(u),"effect_az-leiji.mdl","origin",0))
        UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()

        flush locals
    endfunction

    function SpellS028(unit u1,real x,real y,real damage)//冥月流星落
        if  GetUnitAbilityLevel(u1,'S028') == 0
            UnitTimerAddSkill(u1,'S028',4.5)
            AddUnitStateExTimer(u1,81,6,4.5)
        endif
        damage = damage / 4
        CreateEffectArea(u1,x,y,400,damage,5,0.2,25,0.4,"effect2_az_potm(1)_t1_impact.mdl",false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
    endfunction

    function SpellS030(unit u,real x2,real y2,real dam)//三味真火
        unit u1 = u
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real ang = Atan2(y2-y1,x2-x1)
        int time = 0
        real damage = dam/3
        UnitTimerAddSkill(u,'S030',4.5)
        CreateTm(u1,'eZ21',x1,y1,ang,damage,1,0,250,900,0,250,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
        TimerStart(0.2,true)
        {
            if  time < 2
                time = time + 1
                CreateTm(u1,'eZ21',x1,y1,ang,damage,1,0,250,900,0,250,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SpellS035(unit u1,unit u2,real damage)//业火咒
        int Num= LoadInteger(ht,GetHandleId(u1),'S035') +GetUnitAttackNumb(u1)
        SaveInteger(ht,GetHandleId(u1),'S035',Num)
        if  Num >= 16
            real x=GetUnitX(u2)
            real y=GetUnitY(u2)
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,x,y,800,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            DestroyEffect(AddSpecialEffect("effect_fire-boom-new.mdl",x,y))
            g.destroy()
            SaveInteger(ht,GetHandleId(u1),'S035',0)
        endif
        flush locals
    endfunction

   function SpellS052(unit u1,unit tu,real damage1)//造成伤害减少其他技能0.5CD
        unit u=u1
        real x=GetUnitX(tu)
        real y=GetUnitY(tu)
        real damage=damage1
        
        string mdoelorigin = YDWEGetObjectPropertyString(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(u),"file")
        unit mj=CreateTmUnit(GetOwningPlayer(u),mdoelorigin,GetUnitX(u),GetUnitY(u),GetUnitFacing(u),0,1)
        DestroyEffect(AddSpecialEffect("effect_az_earthshaker_a.mdl",GetUnitX(u),GetUnitY(u)))
        SetUnitVertexColor( mj, 20, 20, 50, 100 )
        TimerStart(0.03,true)
        {
            if  GetUnitFlyHeight(mj)<500
                UnitAddAbility(mj,'Amrf')
                SetUnitFlyHeight(mj,GetUnitFlyHeight(mj)+50,0)
                UnitRemoveAbility(mj,'Amrf')
                
            else
                SetUnitAnimation( mj, "Attack" )
                RemoveUnitTimer(mj,0.7)
                EffectDown(u,x,y,GetUnitX(u),GetUnitY(u),"effect_az_herosbfire_c.mdl",50,500,400,damage,"effect_AA_bwaxec.mdl")
                //伤害来源，目标点xy，起始点xy，特效路径，速度，高度，伤害半径，伤害,落地爆炸特效
                endtimer
            endif
            flush locals
        }
        
        int id = 0
        int id2 = 0
        for i = 1,5
            id = 'AG00' + i
            id2 = 'AC00'+ i
            YDWESetUnitAbilityState(u,id, 1,YDWEGetUnitAbilityState(u, id, 1)-0.5)
            YDWESetUnitAbilityState(u,id2, 1,YDWEGetUnitAbilityState(u, id2, 1)-0.5)
        end
        flush locals
    endfunction

    function SpellS052Attack(unit wu,unit tu)
        int id = 'S052'
        real damage = 0
        int Num = LoadInteger(ht,GetHandleId(wu),id)
        Num=Num+GetUnitAttackNumb(wu)
        SaveInteger(ht,GetHandleId(wu),id,Num)
        if  Num >= 16
            damage = GetAbilityDamage(wu,id,GetHeroAbilityLevel(wu,id))
            SpellS052(wu,tu,damage)
            SaveInteger(ht,GetHandleId(wu),id,0)
        endif
        flush locals
    endfunction

    function SpellS053(unit u,real damage)//概率造成双倍伤害
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,800,GroupNormalNoStr(GetOwningPlayer(u),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl","origin",0))
        if GetRandomInt(1, 2) == 1
            DestroyEffect(AddSpecialEffect("effect3_desecrateblack.mdl",x,y))
            damage=damage*2
        else
            DestroyEffect(AddSpecialEffect("effect3_desecrategreen.mdl",x,y))
        endif
        
        UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
        flush locals
    endfunction

    function SpellS056(unit u)
        RefreshUnitSkill(u)
    endfunction

    function SpellS070(unit u1,real x1,real y1,real damage1)
        unit u=u1
        real x=x1
        real y=y1
        real damage=damage1
        int time=0
        effect e=AddSpecialEffect("effect_jianzhen.mdl",x,y)
        EXSetEffectSize(e,2)
        group g=CreateGroup()
        unit uu=null
        real ang=0
        real dis=0
        integer i=0
        integer cs=0
        string mdoelorigin = YDWEGetObjectPropertyString(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(u),"file")
        unit mj=CreateTmUnit(GetOwningPlayer(u),mdoelorigin,GetUnitX(u),GetUnitY(u),GetUnitFacing(u),0,1)
        SetUnitVertexColor( mj, 20, 20, 50, 100 )
        SetUnitTimeScale( mj, 4.00 )
        TimerStart(0.01,true)
        {   
            time = time + 1
            if  time <= 100

            elseif  time <= 380
                if  ModuloInteger(time,20) == 0
                    ang=GetRandomReal(-3.14,3.14)
                    dis=GetRandomReal(100,300)
                    GroupEnumUnitsInRange(g,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
                    UnitDamageGroup(u,g,damage,true,true,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_AXE_MEDIUM_CHOP )
                    SetUnitX(mj,x+(400*Cos(ang)))
                    SetUnitY(mj,y+(400*Sin(ang))) 
                    SetUnitFacing(mj,Rad2Deg(ang))
                    SetUnitAnimation( mj, "Attack" )
                    LocAddEffectSetRotate(x+(dis*Cos(ang+1.57)),y+(dis*Sin(ang+1.57)),Rad2Deg(ang)+GetRandomReal(0,20),"effect_akiha claw.mdx")
                    LocAddEffectSetRotate(x,y,Rad2Deg(ang),"effect_akiha claw.mdl")
                    LocAddEffectSetRotate(x+(dis*Cos(ang-1.57)),y+(dis*Sin(ang-1.57)),Rad2Deg(ang)+GetRandomReal(0,20),"effect_akiha claw.mdx")
                endif
            else
                DestroyEffect(e)
                DestroyGroup(g)
                RemoveUnit(mj)
                u = null
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SpellS073Attack(unit u)
        int id = 'S073'
        real damage = GetAbilityDamage(u,id,GetHeroAbilityLevel(u,id))
        real x = GetUnitX(u)
        real y = GetUnitY(u)
        real ang = 0
        int num = 4
        unit u2 = null
        damage = damage/num
        for i = 1,num
            ang = 360/num
            u2 = CreateTmUnit(GetOwningPlayer(u),"effect_fense-lizi-toushewu.mdl",x,y,i*ang,50,2)  
            //单位 环绕马甲 初始角度 环绕半径 角速度 线速度 环绕总时间 ||技能id 当前数量 初始数量 马甲顺序（辅助参数）
            CreateSurroundOfUnitEx(u,u2,i*ang,200,14.4,0.02,2,damage/4)
        end
        flush locals
    endfunction

    //伤害来源,马甲,方向,伤害,伤害范围,最远距离,移动时间间隔,马甲高度,伤害类型4个,马甲序号，最大马甲引索
    function CreateTmPublicFunc(unit wu,unit m,real Ang,real dam,real rac,real dis,real tt,real high,boolean b1,boolean b2,integer attt,integer damt,group usegroup,int i1,int i2,int i3)
        real S = 30
        unit u1 = wu
        unit u2 = m 
        real r1 = rac
        real x1 = GetUnitX(m)
        real y1 = GetUnitY(m)
        real x2 = S*Cos(Ang)
        real y2 = S*Sin(Ang)
        real damage = dam
        int time = R2I(dis/S)
        bool bool1 = b1
        bool bool2 = b2
        int atttype = attt
        int damtype = damt
        group wg = usegroup
        int tmorder = i1
        int maxtm = i2
        int id = i3
        int n = 0
        UnitAddAbility(m,'Amrf')
        SetUnitFlyHeight(m,high,0)
        UnitRemoveAbility(m,'Amrf')
        ////额外判断
        TimerStart(tt,true)
        {
            group gg = CreateGroup()
            real dam2 = 0
            unit uu = null 
            time = time - 1
            if  time > 0
                x1 = x1 + x2
                y1 = y1 + y2
                SetUnitPosition(u2,x1,y1)
                if  r1 > 0
                    //GroupEnumUnitsInRange(gg,x1,y1,r1,GroupHasUnitSetXY(GetOwningPlayer(u1),wg,x1,y1,""))
                    //GroupEnumUnitsInRange(gg,x1,y1,r1,GroupHasUnitAddBuff(GetOwningPlayer(u1),wg,"",0,0,0))
                    
                    GroupEnumUnitsInRange(gg,x1,y1,r1,GroupHasUnit(GetOwningPlayer(u1),wg,""))
                    UnitDamageGroup(u1,gg,damage+dam2,bool1,bool2,ConvertAttackType(atttype),ConvertDamageType(damtype),null)
                endif
            else
                //额外判断
                if  id == 'S074'
                    GroupClear(wg)
                    BJDebugMsg("清除wg")
                    uu = CreateTmUnit(GetOwningPlayer(u1),"effect_fense-lizi-toushewu.mdl",x1,y1,Atan2(GetUnitY(u1)-y1,GetUnitX(u1)-x1)/0.01745,70,1.0)
                    CreateTmPublicFunc.execute(u1,uu,Atan2(GetUnitY(u1)-y1,GetUnitX(u1)-x1),damage,r1,900,0.025,70,bool1,bool2,atttype,damtype,wg,tmorder,maxtm,0)
                else
                    if  tmorder == maxtm
                        GroupClear(wg)
                        DestroyGroup(wg)
                        BJDebugMsg("删除wg")
                    endif
                endif
                KillUnit(u2)
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction

    //伤害来源,马甲id,x1,y1,x2,y2,伤害,数量,间距角度,伤害范围,最远距离,伤害类型,移动时间间隔,马甲高度
    function CreateTmPublic(unit wu,string model,real x1,real y1,real x2,real y2,real dam,int num,real Ang2,real rac,real dis,real time,real high,bool b1,bool b2,int attt,int damt,int id)
        real Ang1 = Atan2(y2-y1,x2-x1)
        real r = 0
        unit u = null
        group gg = CreateGroup()
        Ang2 = Ang2 * 0.01745
        Ang1 = Ang1 - (((num-1) * Ang2) / 2)
        for i = 0,num-1
            r = Ang1 + Ang2 * I2R(i)
            u = CreateTmUnit(GetOwningPlayer(wu),model,x1,y1,r/0.01745,high,1.0)
            if  u != null
                if  dam == 0
                    CreateTmFuncZero(wu,u,r,rac,dis,time,high)
                else
                    CreateTmPublicFunc(wu,u,r,dam,rac,dis,time,high,b1,b2,attt,damt,gg,i,num-1,id)
                endif
            endif
        end
        u = null
        gg = null
    endfunction
    
    function SpellS074(unit u1,real x2,real y2,real damage)
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real ang = Atan2(y2-y1,x2-x1)
        CreateTmPublic(u1,"effect_fense-lizi-toushewu.mdl",x1,y1,x2,y2,damage,3,15,210,900,0.025,70,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa,'S074')
        AddUnitStateExTimer(u1,16,10,4.5)
        flush locals
    endfunction

    function SpellS076(unit wu,real x,real y,real damage)//连环刺
        AddEffectInArea(x,y,370,22,"effect2_az_FallSword_ice.mdl")
        UnitGroupAddDamageTimerAddBuff(wu,0.24,x,y,damage,400,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa,"",0,0,0)
        if  GetUnitAbilityLevel(wu,'S076') == 0
            UnitTimerAddSkill(wu,'S076',4.5)
            AddUnitStateExTimer(wu,81,6,4.5)
        endif
        flush locals
    endfunction


    function SpellS075Attack(unit wu,unit tu)//夺命刺
        group gg = CreateGroup()
        int id = 'S075'
        real damage = GetAbilityDamage(wu,id,GetHeroAbilityLevel(wu,id))
        real x = 0
        real y = 0
        GroupEnumUnitsInRange(gg,GetUnitX(tu),GetUnitY(tu),500,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
        UnitDamageGroup(wu,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        for num = 0,11
            x = GetUnitX(tu) + 100*Cos(30*num*0.01745)
            y = GetUnitY(tu) + 100*Sin(30*num*0.01745)
            RemoveUnitTimer(CreateUnit(GetOwningPlayer(wu),'eZ20',x,y,30*num),1)
        end
        flush locals
    endfunction
    

    function SpellS078(unit u2,real x1,real y1,real damage1)
        unit u=u2
        real damage=damage1 
        real x=x1
        real y=y1
        real x0=GetUnitX(u)
        real y0=GetUnitY(u)
        
    //伤害来源，目标点xy，起始点xy，模型路径，速度，高度，伤害半径，伤害
        effect tx=AddSpecialEffect("effect_az_axe_x.mdl",x,y)
        UnitTimerAddSkill(u,'S078',4.5)
        TimerStart(1.5,false)
        {   
            DestroyEffect(tx)
            EffectDown(u,x,y,x0,y0,"effect_txab0a (3).mdl",35,1000,600,damage,"effect_az_tormentedsoul_t1.mdl")
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function SpellS079Attack(unit u2,unit mj1,real x1,real y1,real damage1)
        unit u=u2
        unit mj=mj1
        real damage=damage1 
        real x=GetUnitX(mj)
        real y=GetUnitY(mj)
        real ang=Pang(x,y,x1,y1)
        group g=CreateGroup()
        group wg=CreateGroup()
        real t=0

        TimerStart(0.1,true)
        {
            t=t+1
            if  t<=3
                x=x+(300*Cos(ang))
                y=y+(300*Sin(ang))
                GroupEnumUnitsInRange(g,x,y,300,GroupHasUnit(GetOwningPlayer(u),wg,""))
                UnitDamageGroup(u,g,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                DestroyEffect(AddSpecialEffect("effect_az_kaer_t1.mdl",x,y))
            else
                RemoveUnit(mj)
                DestroyGroup(g)
                DestroyGroup(wg)
                endtimer
                flush locals
            endif
        }
        flush locals
    endfunction

    function SpellS079(unit u2,real x1,real y1,real damage1)
        unit u=u2
        real damage=damage1 
        real x=x1
        real y=y1
        real x0=GetUnitX(u)
        real y0=GetUnitY(u)
        string mdoelorigin = YDWEGetObjectPropertyString(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(u),"file")
        unit mj=CreateTmUnit(GetOwningPlayer(u),mdoelorigin,GetUnitX(u),GetUnitY(u),Pang(x0, y0, x,y)/0.01745,0,1)
        effect tx=AddSpecialEffect("A_yujing_boss_linegreen.mdx",x0,y0)
        EXEffectMatRotateZ( tx, Pang(x0, y0, x,y)/0.01745 )
        SetUnitVertexColor( mj, 20, 20, 50, 100 )
        TimerStart(2,false)
        {   
            SpellS079Attack(u,mj,x,y,damage)
            SetUnitAnimation( mj, "Attack" )
            DestroyEffect(tx)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function SpellS080(unit u2,real x1,real y1,real damage1)
        unit u=u2
        real damage=damage1 
        unit mj=null
        real xu=GetUnitX(u)
        real yu=GetUnitY(u)
        real x0=0
        real y0=0
        real jl=0
        real ang=Pang(GetUnitX(u),GetUnitY(u),x1,y1)
        real time=0
        real m=3
        effect tx=AddSpecialEffect("effect_gate.mdl",xu,yu)
        EXEffectMatRotateZ(tx,ang/0.01745)
        EXSetEffectSpeed(tx,9)
        TimerStart(0.1,true)
        {   
            time=time+0.1

            if  time>= 1
                if  time < m
                    jl=GetRandomReal(-200,200)
                    x0 = xu+jl*Cos(ang+1.57)
                    y0 = yu+jl*Sin(ang+1.57)
                    mj=CreateTmUnit(GetOwningPlayer(u),"effect_shandianzhiqiang.mdl",x0,y0,ang/0.01745,0,1)
                    CreateTmFunc(u,mj,ang,damage,150,1500,GetRandomReal(50,300),false,false,0,4)
                    
                    //伤害来源,马甲,方向,伤害,伤害范围,最远距离,移动时间间隔,马甲高度,伤害类型4个
                else
                    DestroyEffect(tx)
                    endtimer
                endif
                flush locals
            endif
        }
        flush locals
    endfunction

    function SpellS081(unit wu,real r1,real r2,real dam)//真空领域
        unit u1 = wu
        unit u2 = null
        int pid = GetPlayerId(GetOwningPlayer(u1))
        real damage = dam/8
        real x1 = r1
        real y1 = r2
        int time = 130
        unit uu = CreateTmUnit(GetOwningPlayer(u1),"effect_az_blacksmoke.mdl",x1,y1,0,50,1.0)
        UnitAddAbility(u1,'S081')
        TimerStart(0.03,true)
        {
            group gg = CreateGroup()
            real x2 = 0
            real y2 = 0
            real ang = 0
            real dx = 0
            real dy = 0
            time = time - 1

            GroupEnumUnitsInRange(gg,x1,y1,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            loop
                u2 = FirstOfGroup(gg)
                exitwhen u2 == null
                if  u2 != Pu[1] and GetUnitAbilityLevel(u2,'AZ01') == 0 and GetUnitAbilityLevel(u2,'AZ92') == 0 
                    x2 = GetUnitX(u2)
                    y2 = GetUnitY(u2)
                    ang = Atan2(y1-y2,x1-x2)
                    dx = 8*Cos(ang)
                    dy = 8*Sin(ang)
                    SetUnitX(u2,x2+dx)
                    SetUnitY(u2,y2+dy)
                endif
                if  ModuloInteger(time,17) == 0
                    UnitDamageTarget(u1,u2,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                endif
                GroupRemoveUnit(gg,u2)
            endloop

            if  time <= 0
                RemoveUnit(uu)
                UnitRemoveAbility(u1,'S081')
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction
    
    function SpellS082(unit u)
        real x = GetUnitX(u)
        real y = GetUnitY(u)
        real ang = 0
        int num = 3+GetHeroSummonNum(u)
        unit u2 = null
        for i = 1,num
            ang = 360/num
            u2 = CreateTmUnit(GetOwningPlayer(u),"effect_AZ_Storm_E.mdl",x,y,i*ang,50,1)  
            //单位 环绕马甲 初始角度 环绕半径 角速度 线速度 环绕总时间 ||技能id 当前数量 初始数量 马甲顺序（辅助参数）
            CreateSurroundOfUnit(u,u2,i*ang,160,7.2,0.02,86400,'S082',num,3,i,"CLPB")
        end
        flush locals
    endfunction

    function SpellS086(unit u)
        real x = GetUnitX(u)
        real y = GetUnitY(u)
        real ang = 0
        int num = 3+GetHeroSummonNum(u)
        unit u2 = null
        for i = 1,num
            ang = 360/num
            u2 = CreateUnit(GetOwningPlayer(u),'eZ18',x,y,i*ang)  
            //单位 环绕马甲 初始角度 环绕半径 角速度 线速度 环绕总时间 ||技能id 当前数量 初始数量 马甲顺序（辅助参数）
            CreateSurroundOfUnit(u,u2,i*ang,160,7.2,0.02,86400,'S086',num,3,i,"CLPB")
        end
        flush locals
    endfunction
    function AroundSystemfeng(unit u1,unit mj1,real qtime1, real time1,real speed1,real jvli1,real damage1)
        unit u=u1
        unit mj=mj1
        real time=time1
        real speed=speed1
        real jvli=jvli1
        real damage=damage1
        real x1=GetUnitX(mj)
        real y1=GetUnitY(mj)
        group g1=CreateGroup()
        real xzsd=360/(qtime1/0.03)*0.01745
        real ang=Uang(u,mj)
        real yxtime=0
        TimerStart(0.03,true)    
        {
            IndexGroup g = 0
            yxtime=yxtime+0.03
            time=time-0.03
            if  yxtime>=1
                yxtime=0
                GroupClear(g1)
            endif
            if  time>=jvli/(speed/0.03)
                ang=ang+xzsd
                x1 = GetUnitX(u)+jvli*Cos(ang)
                y1 = GetUnitY(u)+jvli*Sin(ang)
                SetUnitX(mj,x1)
                SetUnitY(mj,y1)
                g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,x1,y1,250,GroupHasUnit(GetOwningPlayer(u),g1,""))  
                UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                g.destroy()
            else
                DestroyGroup(g1)
                RemoveUnit(mj)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    /*
    function AroundSystemfeng(unit u1,unit mj1,real qtime1, real time1,real speed1,real jvli1,real damage1)
        unit u=u1
        unit mj=mj1
        real time=time1
        real speed=speed1
        real jvli=jvli1
        real damage=damage1
        real x1=GetUnitX(mj)
        real y1=GetUnitY(mj)
        group g1=CreateGroup()
        real qtime=qtime1
        real xzsd=360/(qtime/0.03)*0.01745
        real ang=Uang(u,mj)
        real yxtime=0
        unit gu=null
        TimerStart(0.03,true)    
        {
            IndexGroup g = 0
            
            yxtime=yxtime+0.03
            time=time-0.03
            if  yxtime>=1
                yxtime=0
                GroupClear(g1)
            endif
            if   time>=jvli/(speed/0.03)      
                if  Udis(u,mj)<=jvli
                    ang=ang+xzsd
                    x1 = GetUnitX(u)+(Udis(u,mj)+speed)*Cos(ang)
                    y1 = GetUnitY(u)+(Udis(u,mj)+speed)*Sin(ang)
                    SetUnitX(mj,x1)
                    SetUnitY(mj,y1)
                else
                    ang=ang+xzsd
                    x1 = GetUnitX(u)+jvli*Cos(ang)
                    y1 = GetUnitY(u)+jvli*Sin(ang)
                    SetUnitX(mj,x1)
                    SetUnitY(mj,y1)
                endif
                g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,x1,y1,225,GroupHasUnit(GetOwningPlayer(u),g1,""))  
                UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                g.destroy()
            else
                if  Udis(u,mj)>50
                    ang=ang+xzsd
                    x1 = GetUnitX(u)+(Udis(u,mj)-speed)*Cos(ang)
                    y1 = GetUnitY(u)+(Udis(u,mj)-speed)*Sin(ang)
                    SetUnitX(mj,x1)
                    SetUnitY(mj,y1)
                    g = IndexGroup.create()
                    GroupEnumUnitsInRange(g.ejg,x1,y1,225,GroupHasUnit(GetOwningPlayer(u),g1,""))
                    UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    g.destroy()
                else
                    DestroyGroup(g1)
                    RemoveUnit(mj)
                    endtimer
                endif
        endif
        flush locals
        }
        flush locals
    endfunction
    */

    function SpellS083(unit u,real damage)
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        real jd=0
        real ang=0
        real x1 =0
        real y1 = 0
        real Num = 3
        if  GetUnitAbilityLevel(u,'S083') == 0
            UnitTimerAddSkill(u,'S083',4)
            AddUnitStateExTimer(u,10,15,4)
        endif
        for i=0,1
            ang=0.01745*180*i
            x1 = x+50*Cos(ang)
            y1 = y+50*Sin(ang)
            bj_lastCreatedUnit=CreateTmUnit(GetOwningPlayer(u),"effect_az_kaer_x1.mdl",x1,y1,GetUnitFacing(u),100,1)                                        
            UnitAddEffectTimer(u,"effect_az_goods_tp_target(3).mdl",Num*0.75)
            //旋转中心单位，马甲，每圈时间，持续时间，经向速度,最远距离,伤害
            AroundSystemfeng(u,bj_lastCreatedUnit,0.75,Num*0.75,20,320,damage/2)
        end
        flush locals
    endfunction

    function SpellS089(unit u,real damage )
        HeroSpellSummon(u,GetUnitX(u),GetUnitY(u),'z102',damage)
    endfunction

     function SpellS090(unit u,real x,real y,real damage)
        HeroSpellSummon(u,x,y,'z103',damage)
    endfunction

    function SpellS094(unit u1,real damage)
        unit u=u1
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        IndexGroup g = IndexGroup.create()
        SetAbilityCD_AC(u,'S094',0.3)
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        DestroyEffect(AddSpecialEffect("effect_hero_grandmagus_n1s_z_down.mdl",x,y))
        UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
        u = null
    endfunction

    function SpellS095(unit u1,real damage)
        unit u=u1
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        IndexGroup g = IndexGroup.create()
        SetAbilityCD_AC(u,'S095',0.3)
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        DestroyEffect(AddSpecialEffect("effect_az_monkeykingbattle_w1_impact.mdl",x,y))
        g.destroy()
        u = null
    endfunction

    function SpellS096(unit u1,real damage)
        unit u=u1
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        IndexGroup g = IndexGroup.create()
        SetAbilityCD_AC(u,'S096',0.3)
        DestroyEffect(AddSpecialEffect("effect_blue-daoguang-new.mdl",x,y))
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
        u = null
        flush locals
    endfunction

    function SpellS097Attack(unit wu)
        int id = 'S097'
        real damage = GetAbilityDamage(wu,id,GetHeroAbilityLevel(wu,id))
        
        int Num = LoadInteger(ht,GetHandleId(wu),id) + 1
        
        SaveInteger(ht,GetHandleId(wu),id,Num)
        if  Num >= 16
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,GetUnitX(wu),GetUnitY(wu),600,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
            UnitDamageGroup(wu,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            LocAddEffectSetRotate(GetUnitX(wu),GetUnitY(wu),GetUnitFacing(wu),"effect_red-yumao-zhendi-paoxiao.mdl")
            g.destroy()
            SaveInteger(ht,GetHandleId(wu),id,0)
        endif
        flush locals
    endfunction
    
    function SpellS101(unit u,real x,real y,real damage)
        AddUnitStateExTimer(u,84,6,4.5)
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"effect_az_zeusking_impact-black.mdl","origin",0))
        LocAddEffect(x,y,"effect_white-shandian-qiquan.mdl")
        UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
        u = null
        flush locals
    endfunction 

    function SpellS102_1(unit u1,unit mj1)
        unit u=u1
        unit mj=mj1
        real Mang=GetRandomReal(0,360)
        real x=0
        real y=0 
        real speed=40
        group g=CreateGroup()
        group g1=CreateGroup()
        TimerStart(0.03,true)
        {
           if   IsPlayerHasAbility(u,'S102') == true 
                if GetUnitFacing(mj) == Mang
                    GroupClear(g1)
                    if  Udis(mj,u)>500
                        Mang=(Rad2Deg(Uang(mj,u)))
                        if  Udis(mj,u)>2000
                            speed=speed+2
                        else
                            if  speed>40
                                speed=speed-2
                            endif
                        endif
                    else
                        Mang=GetRandomReal(0,360)
                    endif
                else
                    if  Udis(mj,u)>500
                        Mang=(Rad2Deg(Uang(mj,u)))
                    endif
                    SetUnitFacing(mj,Mang)
                    if  speed>=44
                        speed=speed-4
                    endif
                endif
                x=GetUnitX(mj)+(speed*Cos(Deg2Rad(GetUnitFacing(mj))))
                y=GetUnitY(mj)+(speed*Sin(Deg2Rad(GetUnitFacing(mj))))

                if  Udis(mj,u)<3000
                    GroupEnumUnitsInRange(g,x,y,300,GroupHasUnit(GetOwningPlayer(u),g1,""))
                    UnitDamageGroup(u,g,GetAbilityDamage(u,'S102',GetHeroAbilityLevel(u,'S102')),false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                endif
                SetUnitXY(mj,x,y)
            else
                KillUnit(mj)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction 

    function SpellS102(unit u,real damage)
        real dis=(GetRandomReal(0,500))
        real ang=GetRandomReal(-3.14,3.14)
        real x=0
        real y=0
        unit mj=null
        for i=1,1
            x=GetUnitX(u)+(dis*Cos(ang))
            y=GetUnitY(u)+(dis*Sin(ang))
            mj=CreateTmUnit(GetOwningPlayer(u),"effect_BlackworksDragonHead3.mdl",x,y,GetRandomReal(-3.14,3.14),10,1)
            SpellS102_1(u,mj)
        end
        flush locals
    endfunction  

    function SpellS104Ex(unit u,real damage)
        integer pid = GetPlayerId(GetOwningPlayer(u))
        if  PlayerDeathBool == false
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,GetUnitX(u),GetUnitY(u),400,GroupNormalNoStr(GetOwningPlayer(u),"Abilities\\Spells\\Items\\AIfb\\AIfbSpecialArt.mdl","origin",0))
            UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()
        endif
        flush locals
    endfunction

    function SpellS104(unit u1,real dam)
        unit u=u1
        effect tx = AddSpecialEffectTarget("effect_orboffire.mdl",u,"origin") 
        int time = 0
        real damage = dam
        UnitAddAbility(u,'S104')
        SpellS104Ex(u,damage)
        TimerStart(1,true)
        {
            if  time < 5
                time = time + 1
                SpellS104Ex(u,damage)
            else
                UnitRemoveAbility(u,'S104')
                DestroyEffect(tx)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction 

    function SpellS109(unit u,unit u1)
        real x=GetUnitX(u1)
        real y=GetUnitY(u1)
        real damage = GetHeroStr(u,true)
        real add = 0
        real gl = 10

        
        
        if  GetPlayerTechCount(GetOwningPlayer(u),'RM1J',true) > 0
            gl = gl + 10
        endif
        if  GetPlayerTechCount(GetOwningPlayer(u),'RM1E',true) > 0
            add = add + 0.5
        endif
        if  GetUnitAbilityLevel(u,'A009') > 0
            add = add + 0.5
        endif
        
        damage = damage * (1+add)

        IndexGroup g  
        if  GetUnitAbilityLevel(u,'AZ15') > 0 and ChanceEx(u,'S109',gl) == true
            g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,x,y,300,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
            if  FirstOfGroup(g.ejg)!=null

                if  GetUnitAbilityLevel(u,'A009') > 0
                    LocAddEffectSetSize(x,y,"effect_by_wood_effect_d2_shadowfiend_shadowraze_1.mdl",0.8)
                else
                    LocAddEffectSetSize(x,y,"effect_red-texiao-shandian.mdl",0.8)
                endif
                
                UnitDamageGroup(u,g.ejg,damage*4,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            endif
            g.destroy()
        endif
        flush locals
    endfunction

    function shenshou(unit u1) 
        unit u=u1
        integer i=0
        TimerStart(0.02,true)
        {
            i=i+1
            if  i <=25
                SetUnitScale(u, 1+(i*0.2), 1+(i*0.2), 1+(i*0.2))
                SetUnitVertexColor(u,255, 255, 255, 255-(R2I(I2R(i)*10.2)))
            else
                KillUnit(u)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction  

    function SpellS230(unit wu,real r1,real r2,real dam)//兽魂1
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = r1
        real y2 = r2
        real ang = Atan2(y2-y1,x2-x1)
        real dis = Pdis(x1,y1,x2,y2)
        real damage = dam
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        unit uu = CreateTmUnit(GetOwningPlayer(u1),"shenshou_shenshou_bian.mdl",x1,y1,0,0,3.5)
        SetUnitAnimation(u1,"spell" )
        SetUnitFacing(u1,ang/0.01745)
        EXSetUnitFacing(u1,ang/0.01745)

        SetUnitAnimation(uu,"spell" )
        SetUnitFacing(uu,ang/0.01745)
        EXSetUnitFacing(uu,ang/0.01745)

        TimerStart(0.02,true)
        {
            group gg = null
            if  GetUnitAbilityLevel(u1,'AZ98') == 0
                x1 = x1 + xx
                y1 = y1 + yy
                if  IsCanFlyTerrain(x1,y1) == true and Pdis(x1,y1,x2,y2) >= 30
                    SetUnitX(u1,x1)
                    SetUnitY(u1,y1)

                    SetUnitX(uu,x1)
                    SetUnitY(uu,y1)
                    SetUnitFacing(uu,ang/0.01745)
                    EXSetUnitFacing(uu,ang/0.01745)
                else
                    SetUnitFacing(uu,ang/0.01745)
                    EXSetUnitFacing(uu,ang/0.01745)
                    IssueImmediateOrderById( uu, 851972 )
                    CameraSetTargetNoiseTimer(GetPlayerId(GetOwningPlayer(u1)),12,1,0.8)
                    LocAddEffectSetSize(GetUnitX(u1),GetUnitY(u1),"effect_by_wood_effect_tianhuo_2_1.mdl",2.5)
                    gg = CreateGroup()
                    GroupEnumUnitsInRange(gg,GetUnitX(u1),GetUnitY(u1),600,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffxy,3,0))
                    UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )  
                    GroupClear(gg)                
                    DestroyGroup(gg)
                    RemoveUnit(uu)
                    endtimer
                endif
            else
                SetUnitFacing(uu,ang/0.01745)
                EXSetUnitFacing(uu,ang/0.01745)
                IssueImmediateOrderById( uu, 851972 )
                CameraSetTargetNoiseTimer(GetPlayerId(GetOwningPlayer(u1)),12,1,0.8)
                LocAddEffectSetSize(GetUnitX(u1),GetUnitY(u1),"effect_by_wood_effect_tianhuo_2_1.mdl",2.5)
                gg = CreateGroup()
                GroupEnumUnitsInRange(gg,GetUnitX(u1),GetUnitY(u1),600,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffxy,3,0))
                UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS ) 
                GroupClear(gg)                
                DestroyGroup(gg)
                RemoveUnit(uu)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    
    function SpellS231(unit u1,real damage1)//兽魂2
        unit u=u1
        real m=12
        real damage=damage1
        int Num=0
        real x=0
        real y=0
        real dis=0
        real ang=0
        
        shenshou(CreateTmUnit(GetOwningPlayer(u),"shenshou_qiuniu.mdl",GetUnitX(u),GetUnitY(u),GetUnitFacing(u),0,1))
        TimerStart(0.23,true)
        {
            Num=Num+1
            if  Num<=m
                dis=GetRandomReal(0, 400)
                ang=GetRandomReal(-3.14, 3.14)
                x=GetUnitX(u)+(dis*Cos(ang))
                y=GetUnitY(u)+(dis*Sin(ang))
                LocAddEffectTimer(x,y,"effect_shenshoushentong.mdx",1)
                IndexGroup g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,GetUnitX(u),GetUnitY(u),600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
                UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                CameraSetTargetNoiseTimer(GetPlayerId(GetOwningPlayer(u)),8,1,0.2)
                g.destroy()
            else
                endtimer
            endif
            flush locals    
        }
        flush locals
    endfunction
    

    function SpellS232(unit u1)
        unit u=u1
        unit uu=null
        AddUnitStateExTimer(u,18,20,6)
        UnitTimerAddSkill(u,'A232',6)  //添加判断Buff
        shenshou(CreateTmUnit(GetOwningPlayer(u),"shenshou_qilin.mdl",GetUnitX(u),GetUnitY(u),GetUnitFacing(u),0,1))
        IndexGroup g = IndexGroup.create()
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect2_az_cocoguanyu_t2_death.mdl")
        GroupEnumUnitsInRange(g.ejg,GetUnitX(u),GetUnitY(u),800,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        loop
            uu = FirstOfGroup(g.ejg)
            exitwhen uu == null
            IssueTargetOrder(uu, "attack",u)
            GroupRemoveUnit(g.ejg,uu)
        endloop
        g.destroy()
        flush locals
    endfunction

    function SpellS232Attack(unit wu,unit tu)
        int id = 'S232'
        real damage = GetAbilityDamage(wu,id,GetHeroAbilityLevel(wu,id))
        UnitDamageTarget(wu,tu,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        UnitAddEffect(tu,"Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl")
        flush locals
    endfunction

    function SpellS233ice(unit u1)
        unit uu=u1
        TimerStart(3,false)
        {
            UnitAddBuff(uu,'DB02',3,852095)
            endtimer
            flush locals
        }
        flush locals

    endfunction
    
    function SpellS233(unit u,real dam)
        real damage = dam
        unit uu = null
        CameraSetTargetNoiseTimer(GetPlayerId(GetOwningPlayer(u)),12,1,0.8)
        IndexGroup g = IndexGroup.create()
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_az-ice-qiquan.mdl")
        shenshou(CreateTmUnit(GetOwningPlayer(u),"shenshou_suanni.mdl",GetUnitX(u),GetUnitY(u),GetUnitFacing(u),0,1))
        UnitTimerAddSkill(u,'A233',3)
        GroupEnumUnitsInRange(g.ejg,GetUnitX(u),GetUnitY(u),800,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        loop
            uu = FirstOfGroup(g.ejg)
            exitwhen uu == null
            UnitDamageTarget(u,uu,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            SpellS233ice(uu)
            GroupRemoveUnit(g.ejg,uu)
        endloop
        g.destroy()
       
        flush locals  
    endfunction
    
    function SpellS234(unit u,real x,real y,real dam)
        real damage = dam
        unit UnitAddBuffUnit=null
        unit uu = null
        UnitAddBuffUnit=CreateUnit(GetOwningPlayer(u),'e000',x,y,0)
        UnitApplyTimedLife( UnitAddBuffUnit, 'BHwe', 1.00 )
        UnitAddAbility(UnitAddBuffUnit,'DB03')
        SetUnitAbilityLevel(UnitAddBuffUnit,'DB03',2)
        IssuePointOrderById(UnitAddBuffUnit, 852592,x,y)

        CameraSetTargetNoiseTimer(GetPlayerId(GetOwningPlayer(u)),12,1,0.5)
        shenshou(CreateTmUnit(GetOwningPlayer(u),"shenshou_qingluan.mdl",x,y,GetUnitFacing(u),-50,1))
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        loop
            uu = FirstOfGroup(g.ejg)
            exitwhen uu == null
            UnitDamageTarget(u,uu,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            AddUnitStateExTimer(uu,1,-GetUnitRealState(uu,1)*0.7,6)
            GroupRemoveUnit(g.ejg,uu)
        endloop
        g.destroy()
        flush locals
    endfunction
    
    function SpellS235(unit u1)
        unit u = u1
        real b = (0.05+(GetUnitState(u1,UNIT_STATE_MAX_LIFE)-GetUnitState(u1,UNIT_STATE_LIFE))/GetUnitState(u1,UNIT_STATE_MAX_LIFE)*0.2)*100
        AddUnitRealState(u,19,b)    
        UnitAddAbility(u,'A235')
        shenshou(CreateTmUnit(GetOwningPlayer(u),"shenshou_zhengning.mdl",GetUnitX(u),GetUnitY(u),GetUnitFacing(u),-200,1))
        CameraSetTargetNoiseTimer(GetPlayerId(GetOwningPlayer(u1)),12,1,0.5)
        TimerStart(4,false)
        {
            RemoveUnitStateEx(u,19,b)
            RemoveUnitStateEx(u,20,LoadReal(ht,GetHandleId(u),'A235'))
            UnitRemoveAbility(u,'A235')
            SaveReal(ht,GetHandleId(u),'A235',0)
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    function SpellS236(unit wu,real r1,real r2,real dam)
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = r1
        real y2 = r2
        real ang = Atan2(y2-y1,x2-x1)
        real damage = dam/2
        unit u2 = CreateUnit(GetOwningPlayer(u1),'eZ2H',x1,y1,ang/0.0175)
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        int time = R2I(Pdis(x1,y1,x2,y2)/30)
        real size = GetUnitScaleSize(u1)
        group wg = CreateGroup()
        LocAddEffectSetSize(x1,y1,"effect2_az_goods_blink(green).mdl",1.8)
        SetUnitScale(u1,0.01,0.01,0.01)
        AddUnitStateExTimer(u1,9,75,6)
        shenshou(CreateTmUnit(GetOwningPlayer(u1),"shenshou_heihu.mdl",GetUnitX(u1),GetUnitY(u1),GetUnitFacing(u1),0,1))
        TimerStart(0.01,true)
        {
            group gg = CreateGroup()
            time = time - 1
            x1 = x1 + xx
            y1 = y1 + yy
            if  time > 0 and GetUnitAbilityLevel(u1,'AZ98') == 0 and IsCanFlyTerrain(x1,y1) == true
                SetUnitXY(u1,x1,y1)
                SetUnitXY(u2,x1,y1)
                GroupEnumUnitsInRange(gg,x1,y1,300,GroupHasUnitAddBuff(GetOwningPlayer(u1),wg,"",Buffxy,1,0))
                UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            else
                RemoveUnit(u2)
                if  GetUnitIntState(u1,'S510') == 1
                    SetUnitScale(u1,0.3,0.3,0.3)
                elseif GetUnitIntState(u1,'S510') == 2
                    SetUnitScale(u1,0.3,0.3,0.3)
                else
                    SetUnitScale(u1,size,size,size)
                endif
                SetUnitAnimation(u1,"attack")
                CameraSetTargetNoiseTimer(GetPlayerId(GetOwningPlayer(u1)),12,1,0.8)
                LocAddEffectSetSize(x1,y1,"effect2_az_goods_blink(green).mdl",2.5)
                AddEffectInAreaSetSizeTimer(x1,y1,400,1.5,12,"effect3_impalehittarget.mdl",0.8)
                LocAddEffectSetSize(x1,y1,"effect3_az_heiseguangzhu.mdl",3)
                LocAddEffectSetSize(x1,y1,"effect3_red-zhendi.mdl",3)
                LocAddEffectSetSize(x1,y1,"effect_az-leiji.mdl",4)
                UnitGroupAddDamageTimerAddBuff(u1,0.24,x2,y2,damage,450,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa,"",Buffxy,1,0)
                GroupClear(wg)
                DestroyGroup(wg)
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction

    function SpellS237(unit u)
        shenshou(CreateTmUnit(GetOwningPlayer(u),"shenshou_kongque.mdl",GetUnitX(u),GetUnitY(u),GetUnitFacing(u),0,1))
        CameraSetTargetNoiseTimer(GetPlayerId(GetOwningPlayer(u)),12,1,0.5)
        AddUnitStateExTimer(u,25,100,6)
        AddUnitStateExTimer(u,17,10,6)
        UnitTimerAddSkill(u,'A237',6)
        flush locals
    endfunction

    //法宝
    function SpellFB16(unit wu)
        int num = GetUnitIntState(wu,'FC16')+GetUnitAttackNumb(wu)
        SetUnitIntState(wu,'FC16',num)
                
        if  num >= 24
            RefreshUnitSkill(wu)
            SetUnitIntState(wu,'FC16',0)
        endif
        flush locals
    endfunction
    //暴击后，下一次攻击造成8倍致命一击，内置冷却4秒。
    function SpellFB18(unit wu)
        if  GetUnitIntState(wu,'FC18') == 0
            AddUnitIntStateTimer(wu,'FC18',1,4)
            SetUnitIntState(wu,'FD18',1)
        endif
    endfunction
    //攻击暴击时，10%几率造成400码范围的750%业力的群体伤害。每8秒只能触发1次
    function SpellFB23(unit wu,unit tu)
        if  GetUnitIntState(wu,'FC23') == 0
            if  Chance(wu,10) == true
                IndexGroup g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,GetUnitX(tu),GetUnitY(tu),400,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
                UnitDamageGroup(wu,g.ejg,GetUnitRealState(wu,2)*7.5,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                LocAddEffect(GetUnitX(tu),GetUnitY(tu),"effect4_effect_red-dark-qiquan.mdx")
                g.destroy()
                AddUnitIntStateTimer(wu,'FC23',1,8)
            endif
        endif

    endfunction

    //攻击有4%几率，对目标及周围400码范围内的敌人造成 业力*400%的伤害
    function SpellFB38(unit wu,unit tu)
        if  Chance(wu,4) == true
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,GetUnitX(tu),GetUnitY(tu),400,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
            UnitDamageGroup(wu,g.ejg,GetUnitRealState(wu,2)*4.0,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            LocAddEffectSetSize(GetUnitX(tu),GetUnitY(tu),"effect4_kuosan2_blue.mdl",1.3)
            g.destroy()
        endif
    endfunction
    //每击杀1个单位，下一次攻击的伤害增加50%，此效果最多持续5秒且不会叠加
    function SpellFB39(unit wu,unit tu)
        if  GetUnitIntState(wu,'FC39') == 0
            AddUnitIntStateTimer(wu,'FC39',1,5)
        endif
    endfunction
    //攻击有6%几率，对目标及周围400码敌人造成最大生命*20%的范围伤害
    function SpellFB40(unit wu,unit tu)
        if  Chance(wu,6) == true
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,GetUnitX(tu),GetUnitY(tu),400,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
            UnitDamageGroup(wu,g.ejg,GetUnitRealState(wu,5)*0.2,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            LocAddEffectSetSize(GetUnitX(tu),GetUnitY(tu),"effect4_chushou_by_wood_effect_ice.mdx",2)
            g.destroy()
        endif
    endfunction
    //受到攻击时，5%几率对攻击者造成攻击力*700%的伤害
    function SpellFB45(unit wu,unit tu)
        if  Chance(wu,5) == true
            LocAddEffectSetRotateSize(GetUnitX(wu),GetUnitY(wu),GetUnitFacing(wu),1.5,"effect_az_caster_Red.mdl")
            UnitDamageTarget(wu,tu,GetUnitAttack(wu)*7,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        endif
    endfunction
    //攻击有4%几率，造成目标及周围400码 业力*500%的伤害
    function SpellFB46(unit wu,unit tu)
        if  Chance(wu,4) == true
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,GetUnitX(tu),GetUnitY(tu),400,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
            UnitDamageGroup(wu,g.ejg,GetUnitRealState(wu,2)*5.0,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            LocAddEffectSetSize(GetUnitX(tu),GetUnitY(tu),"effect_misaka light.mdl",0.5)
            g.destroy()
        endif
    endfunction

    //释放主动技能时，对自身周围400码敌人造成1秒眩晕,并减低护甲20点，持续3秒
    function SpellFB47(unit wu)
        if  Chance(wu,4) == true
            IndexGroup g = IndexGroup.create()

            GroupEnumUnitsInRange(g.ejg,GetUnitX(wu),GetUnitY(wu),400,GroupNormalNoStrAddBuff(GetOwningPlayer(wu),"",'A002',1,852149))
            GroupClear(g.ejg)
            GroupEnumUnitsInRange(g.ejg,GetUnitX(wu),GetUnitY(wu),400,GroupNormalNoStrAddBuff(GetOwningPlayer(wu),"",Buffxy,1,0))
            
            LocAddEffectSetSize(GetUnitX(wu),GetUnitY(wu),"effect_misaka light.mdl",0.5)
            g.destroy()
        endif
    endfunction


    //受到暴击伤害时，5秒内恢复50%生命，冷却时间40秒。
    function SpellFM2C(unit wu)
        unit u1 = wu
        int time = 5
        TimerStart(1,true)
        {
            time = time - 1
            UnitAddLife(u1,GetUnitState(u1,UNIT_STATE_MAX_LIFE)*0.1)
            UnitAddEffect(u1,"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
            if  time <= 0
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    

    function SpellAG07(unit wu)
        unit u1 = wu
        real time = 10
        AddUnitRealState(wu,3,100)
        UnitAddAbility(wu,'A00C')
        SetUnitState(wu, ConvertUnitState(0x25), GetUnitState(wu, ConvertUnitState(0x25)) - 0.1)
        
        CameraSetTargetNoiseTimer(GetPlayerId(GetOwningPlayer(wu)),8,1,0.2)

        if  GetPlayerTechCount(GetOwningPlayer(wu),'RM6J',true) > 0
            time = time + 3
        endif


        TimerStart(time,false)
        {
            AddUnitRealState(u1,3,-100)
            UnitRemoveAbility(u1,'A00C')
            SetUnitState(u1, ConvertUnitState(0x25), GetUnitState(u1, ConvertUnitState(0x25)) + 0.1)
            endtimer
            flush locals
        }
        flush locals
    endfunction



    //-----------------------------------------------------------------------------
    function SpellHeroSkillAction(unit wu,unit tu,real sx,real sy,int id,int lv)
        unitex u1 = unitex.create()
        unitex u2 = unitex.create()
        u1.u = wu
        u2.u = tu
    
        int pid = GetPlayerId(GetOwningPlayer(u1.u))
        
        int i1 = 0
        real damage = 0

        if GetUnitAbilityLevel(u1.u, 'A237')>0 
            AddUnitStateExTimer(u1.u,16,10,10)
            string s=YDWEGetObjectPropertyString(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(u1.u),"file")
            unit mj=CreateTmUnit(GetOwningPlayer(u1.u),s,GetUnitX(u1.u),GetUnitY(u1.u),GetUnitFacing(u1.u),0,1)
            shenshou(mj)
        endif 

        BJDebugMsg("释放技能"+I2S(id)+"等级"+I2S(lv))
        if  wu == Pu[63]
            i1 = GetHeroAbilityLevelByIndex(Pu[1],5)
            if  lv >= 4
                damage = GetAbilityDamage(Pu[1],id,lv)*1.2
            elseif  lv >= 3
                damage = GetAbilityDamage(Pu[1],id,lv)*0.9
            else
                damage = GetAbilityDamage(Pu[1],id,lv)*0.7
            endif
        else
            damage = GetAbilityDamage(wu,id,lv)

            if  GetUnitTypeId(wu) == 'H011'
                i1 = GetHeroAbilityLevelByIndex(wu,5)
                if  SpellS511Spell(wu,i1) == true
                    if  i1 >= 3
                        damage = damage * 2.8
                    else
                        damage = damage * 2
                    endif
                endif
            endif

        endif


        if  id >= 'S000' and id <= 'S300'
            if  id == 'S005'
                SpellS005(u1.u,sx,sy,damage)
            elseif  id == 'S002'
                SpellS002(u1.u)
            elseif  id == 'S006'
                SpellS006(u1.u,sx,sy,damage)
            elseif  id == 'S022'
                SpellS022(u1.u,sx,sy,damage)
            elseif  id == 'S028'
                SpellS028(u1.u,sx,sy,damage)
            elseif  id == 'S030'
                SpellS030(u1.u,sx,sy,damage)
            elseif  id == 'S053'
                SpellS053(u1.u,damage)
            elseif  id == 'S070'
                SpellS070(u1.u,sx,sy,damage)
            elseif  id == 'S074'
                SpellS074(u1.u,sx,sy,damage)
            elseif  id == 'S076'
                SpellS076(u1.u,sx,sy,damage)
            elseif  id == 'S078'
                SpellS078(u1.u,sx,sy,damage)
            elseif  id == 'S079'
                SpellS079(u1.u,sx,sy,damage)
            elseif  id == 'S080'
                SpellS080(u1.u,sx,sy,damage)
            elseif  id == 'S081'    
                SpellS081(u1.u,sx,sy,damage)
            elseif  id == 'S083'    
                SpellS083(u1.u,damage)
            elseif  id == 'S089'    
                SpellS089(u1.u,damage)
            elseif  id == 'S090'    
                SpellS090(u1.u,sx,sy,damage)
            elseif  id == 'S101'    
                SpellS101(u1.u,sx,sy,damage)   
            elseif  id == 'S104'    
                SpellS104(u1.u,damage) 
            
            elseif   id>='S230' and id<='S237'
                
                if  id == 'S230'
                        SpellS230(u1.u,sx,sy,damage)
                    elseif  id == 'S231'
                        SpellS231(u1.u,damage)
                    elseif  id == 'S232'
                        SpellS232(u1.u)
                    elseif  id == 'S233'
                        SpellS233(u1.u,damage)
                    elseif  id == 'S234'
                        SpellS234(u1.u,sx,sy,damage)
                    elseif  id == 'S235'
                        SpellS235(u1.u)
                    elseif  id == 'S236'
                        SpellS236(u1.u,sx,sy,damage)
                    elseif  id == 'S237'
                        SpellS237(u1.u)
                endif
            endif
         endif   

         if   id >= 'S501' and id <= 'S540'  
            if  id == 'S501'
                SpellS501(u1.u,sx,sy,damage,lv)
            elseif  id == 'S502'
                SpellS502(u1.u,sx,sy,damage,lv)
            elseif  id == 'S504'
                SpellS504(u1.u,sx,sy,damage,lv)
            elseif  id == 'S505'
                SpellS505(u1.u,lv)
            elseif  id == 'S509'
                SpellS509(u1.u,lv)
            elseif  id == 'S510'
                SpellS510(u1.u,lv)
            elseif  id == 'S512'
                SpellS512(u1.u,sx,sy,damage,lv)
            elseif  id == 'S513'
                SpellS513(u1.u,u1.x+100*Cos(u1.face*0.01745),u1.y+100*Sin(u1.face*0.01745),lv)
            elseif  id == 'S514'
                SpellS514(u1.u,damage,lv)
                
            elseif  id == 'S516'
                SpellS516(u1.u,lv)
            elseif  id == 'S520'
                SpellS520(u1.u,lv)
            elseif  id == 'S521'
                SpellS521(u1.u,damage,lv)
            elseif  id == 'S523'
                SpellS523(u1.u,lv)
            elseif  id == 'S524'
                SpellS524(u1.u,sx,sy,damage,lv)
            elseif  id == 'S525'
                SpellS525(u1.u,sx,sy,damage,lv)
            elseif  id == 'S527'
                SpellS527(u1.u,u2.u,lv)
            elseif  id == 'S536'
                SpellS536(u1.u,sx,sy,damage,lv)
            elseif  id == 'S537'
                SpellS537(u1.u,damage,lv)
            endif
        endif
       

        u1.destroy()
        u2.destroy()
        flush locals
        
    endfunction
    
    function SpellHeroSkillActionTimer(unit wu,unit tu,real sx,real sy,int id,int lv,real time)
        unit u1 = wu
        unit u2 = tu
        real x = sx
        real y = sy
        int i1 = id
        int i2 = lv
        TimerStart(time,false)
        {
            
            SpellHeroSkillAction(u1,u2,x,y,i1,i2)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function SpellHeroSkillActionTimerNum(unit wu,unit tu,real sx,real sy,int id,int lv,real time,int num)
        unit u1 = wu
        unit u2 = tu
        real x = sx
        real y = sy
        int i1 = id
        int i2 = lv
        int n = num
        TimerStart(time,true)
        {
            LocAddNewDamageTextEffect(GetUnitX(u1),GetUnitY(u1),0,"多重施法",1.5)
            SpellHeroSkillAction(u1,u2,x,y,i1,i2)
            n = n - 1
            if  n <= 0
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    
endlibrary

