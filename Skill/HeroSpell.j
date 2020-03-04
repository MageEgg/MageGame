library HeroSpell uses HeroAbilityFunc,BossSkill,Summon
//SpellHeroSkillAction(unit wu,unit tu,real sx,real sy,int id,int lv,int index)


   function GetUnitAttackNumb(unit wu)->int //S036
        int i=1
            if  IsPlayerHasAbility(wu,'S036') == true
                i=i+1
            endif
            if  GetUnitAbilityLevel(wu,'S005') > 0
                i=i+1
            endif
            if  GetUnitAbilityLevel(wu,'S030') > 0
                i=i+1
            endif
            if  GetUnitAbilityLevel(wu,'S078') > 0
                i=i+1
            endif
        return i
    endfunction
    
    function SpellS013Attack(unit wu,unit tu)
        group gg = null
        int id = 'S013'
        real damage = 0
        int Num = LoadInteger(ht,GetHandleId(wu),id)
        Num=Num+GetUnitAttackNumb(wu)
        SaveInteger(ht,GetHandleId(wu),id,Num)
        if  Num >= 4
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
        if  Num >= 6
            damage = GetAbilityDamage(wu,id,GetHeroAbilityLevel(wu,id))
            SpellS001AttackEx(wu,tu,damage)
            SaveInteger(ht,GetHandleId(wu),id,0)
        endif
        flush locals
    endfunction

    function SpellS002(unit wu)
        SetUnitIntState(wu,'S002',1)
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

    function SpellS005(unit wu,real r1,real r2)
        unit u1 = wu
        real x = r1
        real y = r2
        int id = 'S005'
        real damage = GetAbilityDamage(u1,id,GetHeroAbilityLevel(u1,id))
        unit u2 = CreateUnit(GetOwningPlayer(u1),'eZ17',x,y,0)
        int time = 0
        UnitTimerAddSkill(wu,'S005',3)
        TimerStart(0.01,true)
        {
            group gg = null
            if  time < 200
                time = time + 1
                SetUnitFacing(u2,time*3.6)
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
        AddUnitStateExTimer(wu,73,20,6)
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
            UnitTimerAddSkill(wu,id,8)
            AddUnitStateExTimer(wu,32,20,6)
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
        for i = 1,4
            k = 'AG00' + i
            YDWESetUnitAbilityState(wu,k, 1,YDWEGetUnitAbilityState(wu, k, 1)-0.5)
        end
        AddEffectInArea(GetUnitX(tu),GetUnitY(tu),380,15,"effect2_az_coco_e2.mdl")
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
            UnitDamageTarget(wu,uu,dam,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_AXE_MEDIUM_CHOP )
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
        real damage = dam
        int num = 8
        effect tx=AddSpecialEffectTarget("effect_blue-shandian-huaban-toushewu.mdl",wu,"origin")
        SpellS006Attack(u1,x1,y1,damage)
        TimerStart(0.1,true)
        {
            num = num - 1
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
                    flush locals
                endif
            endif
            
            flush locals
        }
        flush locals
    endfunction

    function SpellS008(unit u)//催枯
        if  GetUnitAbilityLevel(u,'A008')==0
            UnitTimerAddSkill(u,'A008',4)
            flush locals
        endif
    endfunction

    function SpellS009(unit u1,unit u2,real damage)//连击
        integer lv = GetHeroAbilityLevel(u1,'S009')
        real r1 = GetTypeIdReal('S009',100+lv)
        UnitDamageTarget(u1,u2,damage, true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_AXE_MEDIUM_CHOP )
        SetAbilityCD_AC(u1,'S009',r1)
        string mdoelorigin = YDWEGetObjectPropertyString(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(u1),"file")
        unit mj=CreateTmUnit(GetOwningPlayer(u1),mdoelorigin,GetUnitX(u1),GetUnitY(u1),GetUnitFacing(u1),0,1)
        SetUnitAnimation( mj, "Attack" )
        SetUnitVertexColor( mj, 20, 20, 50, 100 )
        RemoveUnitTimer(mj,0.5)
        flush locals
    endfunction        

    function SpellS018(unit u1,real damage)//造成伤害三秒内破甲+15%
        unit u=u1
        unit uu=null
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        IndexGroup g = IndexGroup.create()
        AddUnitStateExTimer(u,13,15,3)
        DestroyEffect(AddSpecialEffect("effect_daoguang-new.mdl",x,y))
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
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
            AddUnitStateExTimer(u,19,10,3)
            GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
            UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            DestroyEffect(tx) 
            g.destroy()
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function SpellS023(unit u1,unit u2,real damage)//天罚
        real x=GetUnitX(u2)
        real y=GetUnitY(u2)

        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)

        DestroyEffect(AddSpecialEffect("effect_[dz.spell]002_blue.mdl",x,y))
        SetAbilityCD_AC(u1,'S023',0.1)

        g.destroy()
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

    function SpellS028(unit wu,real x,real y)//冥月流星落
        unit u1 = wu
        int id = 'S028'
        real damage = GetAbilityDamage(u1,id,GetHeroAbilityLevel(u1,id))
        group g = CreateGroup()
        DestroyEffect(AddSpecialEffect("effect_az_bw_lina_t1-2.mdl",x,y))
        GroupEnumUnitsInRange(g,x,y,800,GroupNormalNoStr(GetOwningPlayer(u1),"effect_AZ_PotM(1)_T1_Impact.mdl","origin",0))
        if  GetUnitAbilityLevel(u1,'S028') == 0
            UnitTimerAddSkill(u1,'S028',3)
            AddUnitStateExTimer(u1,81,6,3)
        endif
        TimerStart(0.426,false)
        {
            UnitDamageGroup(u1,g,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            DestroyGroup(g)
            g=null
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function SpellS030(unit u,real x2,real y2)//三味真火
        int id = 'S030'
        real damage = GetAbilityDamage(u,id,GetHeroAbilityLevel(u,id))
        real x1=GetUnitX(u)
        real y1=GetUnitY(u)
        CreateTmEx(u,"effect_by_wood_effect_yuzhiboyou_fire_haohuoqiu.mdx",x1,y1,x2,y2,damage+(GetUnitRealState(u,2)*6),3,12,200,800,0.03,50,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
        UnitTimerAddSkill(u,'S030',3)
    endfunction

    function SpellS031(unit u)          //魔茧
        if  GetUnitAbilityLevel(u,'A031')==0
            AddUnitStateExTimer(u,9,20,4)
            UnitTimerAddSkill(u,'A031',4)
        endif
    endfunction

    function SpellS033(unit wu) //攻速+40%
        AddUnitStateExTimer(wu,9,50,6)
    endfunction

    function SpellS035(unit u1,unit u2,real damage)//业火咒
        int Num= LoadInteger(ht,GetHandleId(u1),'S035') +GetUnitAttackNumb(u1)
        SaveInteger(ht,GetHandleId(u1),'S035',Num)
        if  Num >= 8
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
    

    function SpellS038(unit u1,unit u2,real damage)//罡风破
        int Num= LoadInteger(ht,GetHandleId(u1),'S038')+GetUnitAttackNumb(u1)
        SaveInteger(ht,GetHandleId(u1),'S038',Num)

        if  Num >= 12
            real x=GetUnitX(u2)
            real y=GetUnitY(u2)
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,x,y,800,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            DestroyEffect(AddSpecialEffect("effect_white-qiquan-juhuang.mdl",x,y))
            g.destroy()
            SaveInteger(ht,GetHandleId(u1),'S038',0)  
        endif
        flush locals
    endfunction

    function SpellS039(unit u11,unit u21,real damage1)//他山之石
        unit u1=u11
        unit u2=u21
        real damage=damage1
        int Num= LoadInteger(ht,GetHandleId(u1),'S039')+GetUnitAttackNumb(u1)
        SaveInteger(ht,GetHandleId(u1),'S039',Num)
        if  Num >= 12
            real x=GetUnitX(u2)
            real y=GetUnitY(u2)
            DestroyEffect(AddSpecialEffect("effect_zhendi-shitou.mdl",x,y))
            SaveInteger(ht,GetHandleId(u1),'S039',0)
            TimerStart(0.5,false)
            {
                IndexGroup g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,x,y,800,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                g.destroy()
                endtimer
                flush locals
            }
        endif
        flush locals
    endfunction

    function SpellS040(unit u1,unit u2,real damage)//弱水咒
        real x=GetUnitX(u2)
        real y=GetUnitY(u2)
        IndexGroup g = IndexGroup.create()
        DestroyEffect(AddSpecialEffect("effect_zhendi-water.mdl",x,y))
        GroupEnumUnitsInRange(g.ejg,x,y,800,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
        flush locals
    endfunction

    function SpellS043(unit u1,unit u2,real damage)//气流杀
        real x=GetUnitX(u2)
        real y=GetUnitY(u2)
        IndexGroup g = IndexGroup.create()
        DestroyEffect(AddSpecialEffect("effect_white-qiquan-special.mdl",x,y))
        GroupEnumUnitsInRange(g.ejg,x,y,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
        flush locals
    endfunction



    function SpellS046(unit u,real damage1)//引爆毒
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        real damage=0
        unit gu=null
        IndexGroup g = IndexGroup.create()
        DestroyEffect(AddSpecialEffect("effect_green-texiao-shandian.mdl",x,y))
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"effect_dubao-texiao.mdl","origin",0))
        loop
            gu = FirstOfGroup(g.ejg)
            exitwhen gu == null
            damage=(1+I2R(LoadInteger(ht,GetHandleId(gu),159379)))*damage1
            UnitDamageTarget(u, gu, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_POISON, WEAPON_TYPE_WHOKNOWS)
            GroupRemoveUnit(g.ejg,gu)
        endloop

        g.destroy()
        flush locals
    endfunction


    function SpellS047(unit u,real damage)//叠加毒
        poisondamage(u,damage)
        effect tx= AddSpecialEffectTargetUnitBJ( "origin", u, "effect_az_doomdragon_t.mdx" )
        TimerStart(8,false)
        {
            DestroyEffect(tx)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function SpellS048_1(unit u1)
        unit u=u1
        TimerStart(8,false)
        {
            if  GetUnitState(u,UNIT_STATE_LIFE) > 0
                if  GetUnitAbilityLevel(u,'A048')>1
                    DecUnitAbilityLevel(u,'A048')
                else
                    UnitRemoveAbility(u,'A048')
                endif
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function SpellS048(unit u1,unit u2,real damage)
        real x=GetUnitX(u2)
        real y=GetUnitY(u2)
        unit gu=null
        IndexGroup g = IndexGroup.create()
        DestroyEffect(AddSpecialEffect("effect_heartburst.mdl",x,y))
        GroupEnumUnitsInRange(g.ejg,x,y,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        loop
            gu = FirstOfGroup(g.ejg)
            exitwhen gu == null
            if GetUnitAbilityLevel(gu,'A048')>0
                if GetUnitAbilityLevel(gu,'A048')<8
                    IncUnitAbilityLevel(gu,'A048')
                endif
            else
                UnitAddAbility(gu,'A048')
            endif
            SpellS048_1(gu)
            UnitDamageTarget(u1, gu, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_POISON, WEAPON_TYPE_WHOKNOWS)
            GroupRemoveUnit(g.ejg,gu)
        endloop
        g.destroy()
        flush locals
    endfunction

    function SpellS049(unit u,real damage)//引爆魅惑
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        unit gu=null
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"effect_senbonzakurapart.mdl","origin",0))
        DestroyEffect(AddSpecialEffect("effect_shockwave_pink2.mdl",x,y))
        loop
            gu = FirstOfGroup(g.ejg)
            exitwhen gu == null
            damage=(1+I2R(GetUnitAbilityLevel(gu,'A048')))*damage
            UnitDamageTarget(u, gu, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)

            GroupRemoveUnit(g.ejg,gu)
        endloop
        g.destroy()
        flush locals
    endfunction

   function SpellS052(unit u1,unit tu,real damage1)//造成伤害减少其他技能0.5CD
        unit u=u1
        real x=GetUnitX(tu)
        real y=GetUnitY(tu)
        real damage=damage1
        integer id =0
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
        
        for i = 1,4
            id = 'AG00' + i
            YDWESetUnitAbilityState(u,id, 1,YDWEGetUnitAbilityState(u, id, 1)-0.5)
        end
        flush locals
    endfunction

    function SpellS052Attack(unit wu,unit tu)
        int id = 'S052'
        real damage = 0
        int Num = LoadInteger(ht,GetHandleId(wu),id)
        Num=Num+GetUnitAttackNumb(wu)
        SaveInteger(ht,GetHandleId(wu),id,Num)
        if  Num >= 6
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


     

    function SpellS065(unit u1,real damage)//造成伤害三秒内法穿+15%
        unit u=u1
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        IndexGroup g = IndexGroup.create()
        AddUnitStateExTimer(u,14,15,3)
        DestroyEffect(AddSpecialEffect("effect_zi-fazhen.mdl",x,y))
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
        u = null
        flush locals
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
                    UnitDamageGroup(u,g,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_AXE_MEDIUM_CHOP )
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

       //旋转中心单位，马甲，每圈时间，持续时间，经向速度,最远距离,伤害
    function AroundSystem(unit u1,unit mj1,real qtime1, real time1,real speed1,real jvli1,real damage1)
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
            IndexGroup g = IndexGroup.create()
            
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
        
                GroupEnumUnitsInRange(g.ejg,x1,y1,100,GroupHasUnitAddBuff(GetOwningPlayer(u),g1,"",'DB02',1,852095))  
                loop
                    gu=FirstOfGroup(g.ejg)
                    exitwhen gu==null
                    UnitDamageTarget(u,gu,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    GroupRemoveUnit(g.ejg,gu)
                endloop  
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

    function SpellS073(unit u)
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        real jd=0
        real ang=0
        real x1 =0
        real y1 = 0
        int id = 'S073'
        real damage = GetAbilityDamage(u,id,GetHeroAbilityLevel(u,id))
        for i=0,3
            ang=0.01745*90*i
            x1 = x+50*Cos(ang)
            y1 = y+50*Sin(ang)
            bj_lastCreatedUnit=CreateTmUnit(GetOwningPlayer(u),"effect_fense-lizi-toushewu.mdl",x1,y1,GetUnitFacing(u),100,1)                                        
            
            //旋转中心单位，马甲，每圈时间，持续时间，经向速度,最远距离,伤害
            AroundSystem(u,bj_lastCreatedUnit,1,3,20,200,damage)
        end
        flush locals
    endfunction

    function SpellS074_2(unit u,unit mj,real damage1)
        unit u1=u
        unit u2=mj
        real dam=damage1
        real ang=Uang(u2,u1)
        real dis=Udis(u2,u1)
        integer i=0
        group wg = CreateGroup()
        TimerStart(0.02,true)
        {
            i=i+1
            if i>20
                ang=Uang(u2,u1)
                dis=Udis(u2,u1)
                group gg = CreateGroup()
                if  dis>70
                    SetUnitX(u2,GetUnitX(u2)+70*Cos(ang))
                    SetUnitY(u2,GetUnitY(u2)+70*Sin(ang))
                    GroupEnumUnitsInRange(gg,GetUnitX(u2),GetUnitY(u2),200,GroupHasUnit(GetOwningPlayer(u1),wg,"")) 
                    UnitDamageGroup(u1,gg,dam,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                else
                    SetUnitX(u2,GetUnitX(u1))
                    SetUnitY(u2,GetUnitY(u1))
                    GroupEnumUnitsInRange(gg,GetUnitX(u2),GetUnitY(u2),200,GroupHasUnit(GetOwningPlayer(u1),wg,"")) 
                    UnitDamageGroup(u1,gg,dam,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    RemoveUnit(u2)
                    DestroyGroup(wg)
                    endtimer
                endif

                GroupClear(gg)
                DestroyGroup(gg)
                
            endif
            flush locals
            
        }
        flush locals    

    endfunction

    function SpellS074_1(unit u,real ang1,real damage1)
        unit u1=u
        real ang=ang1
        real dam=damage1
        integer time=18
        unit u2=CreateTmUnit(GetOwningPlayer(u1),"effect_fense-lizi-toushewu.mdl",GetUnitX(u1),GetUnitY(u1),ang/0.01745,70,1)
        group wg = CreateGroup()
        real x=0
        real y=0
        TimerStart(0.02,true)
        {
            group gg = CreateGroup()
            time = time - 1
            if  time > 0
                x = GetUnitX(u2) + 50*Cos(ang)
                y = GetUnitY(u2) + 50*Sin(ang)
                SetUnitPosition(u2,x,y)
                GroupEnumUnitsInRange(gg,x,y,200,GroupHasUnit(GetOwningPlayer(u1),wg,"")) 
                UnitDamageGroup(u1,gg,dam,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            else
                GroupClear(wg)
                DestroyGroup(wg)
                SpellS074_2(u1,u2,dam)
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction
    
    function SpellS074(unit u,real x,real y,real damage)
        real ang=Pang(GetUnitX(u),GetUnitY(u),x,y)
        ang=ang-0.31
        for i= 0,2
            SpellS074_1(u,ang+(I2R(i)*0.31),damage)
        end
        AddUnitStateExTimer(u,13,20,3)
        flush locals
    endfunction

    function SpellS076(unit wu,real x,real y)//连环刺
        unit u=wu
        int id = 'S076'
        real damage = GetAbilityDamage(wu,id,GetHeroAbilityLevel(wu,id))
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,400,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        LocAddEffectSetSize(x,y,"effect_blue-slash-more.mdl",0.5)
        if  GetUnitAbilityLevel(wu,'S076') == 0
            UnitTimerAddSkill(wu,'S076',3)
            AddUnitStateExTimer(wu,81,6,3)
        endif
        g.destroy()
        flush locals
    endfunction


    function SpellS075(unit wu,unit tu)//夺命刺
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
        UnitTimerAddSkill(u,'S078',3)
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
                    CreateTmFunc(u,mj,ang,damage,70,1500,GetRandomReal(50,300),false,false,0,4)
                    
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

    function SpellS081(unit u2,real x1,real y1,real damage1)//真空领域
        unit u1=u2
        real damage=damage1 
        real m=3
        real x=x1
        real y=y1
        integer n = 0
        real m1=m-0.5
        LocAddEffectTimer(x,y,"effect_az_blacksmoke.mdl",m)
        UnitAddAbility(u1,'S081')
        TimerStart(0.03,true)
        {
            m = m - 0.03
            if  m < m1
                n = n + 1
                if  m > 0
                    IndexGroup g = IndexGroup.create()
                    GroupEnumUnitsInRange(g.ejg,x,y,600,GroupSetToCenter(GetOwningPlayer(u1),x,y,n,""))
                    if  n == 16
                        UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                        n=0
                    endif
                    g.destroy()
                else
                    UnitRemoveAbility(u1,'S081')
                    endtimer
                endif
                
            endif
            flush locals
        }
        flush locals
    endfunction
    
    function AroundSystemlei(unit u1,unit mj1,real qtime1, real time1,real speed1,real jvli1,real damage1,int id)
        unit u=u1
        unit mj=mj1
        unit uu=null
        real time=time1
        real speed=speed1
        real jvli=jvli1
        real damage=damage1
        int sid = id
        real x1=GetUnitX(mj)
        real y1=GetUnitY(mj)
        group g1=CreateGroup()
        real qtime=qtime1
        real xzsd=360/(qtime/0.03)*0.01745
        real ang=Uang(u,mj)
        real yxtime=0
        SaveInteger(ht,GetHandleId(u),sid,1)
        TimerStart(0.02,true)    
        {
            IndexGroup g = IndexGroup.create()
            yxtime=yxtime+0.03
            time=time-0.03
            if  yxtime >= 1.2
                yxtime=0
                GroupEnumUnitsInRange(g1,x1,y1,800,GroupNormalNoStr(GetOwningPlayer(u),"","",0))  
                uu = GroupPickRandomUnit(g1)
                GroupClear(g1)
                GroupEnumUnitsInRange(g.ejg,GetUnitX(uu),GetUnitY(uu),200,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
                UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                if  uu !=null
                    Ligfunc(mj,uu,AddLightningEx("CLPB",false,GetUnitX(mj),GetUnitY(mj),GetUnitZ(mj),GetUnitX(uu),GetUnitY(uu),GetUnitZ(uu)))
                    DestroyEffect(AddSpecialEffect("effect_AZ_UrsaPsionic_E.mdl",GetUnitX(uu),GetUnitY(uu)))
                endif
                g.destroy()
            endif
            if  IsPlayerHasAbility(u,sid) == true
                if  time>=jvli/(speed/0.03)      
                    if  Udis(u,mj)<=jvli
                        ang=ang+xzsd
                        x1 = GetUnitX(u)+(Udis(u,mj)+speed)*Cos(ang)
                        y1 = GetUnitY(u)+(Udis(u,mj)+speed)*Sin(ang)
                        SetUnitX(mj,x1)
                        SetUnitY(mj,y1)
                        SetUnitFacing(mj,GetUnitFacing(u))
                    else
                        ang=ang+xzsd
                        x1 = GetUnitX(u)+jvli*Cos(ang)
                        y1 = GetUnitY(u)+jvli*Sin(ang)
                        SetUnitX(mj,x1)
                        SetUnitY(mj,y1)
                        SetUnitFacing(mj,GetUnitFacing(u))
                    endif
                else
                    if  Udis(u,mj)>50
                        ang=ang+xzsd
                        x1 = GetUnitX(u)+(Udis(u,mj)-speed)*Cos(ang)
                        y1 = GetUnitY(u)+(Udis(u,mj)-speed)*Sin(ang)
                        SetUnitX(mj,x1)
                        SetUnitY(mj,y1)
                        SetUnitFacing(mj,GetUnitFacing(u))
                    else
                        DestroyGroup(g1)
                        RemoveUnit(mj)
                        SaveInteger(ht,GetHandleId(u),sid,0)
                        endtimer
                    endif
                endif
            else
                DestroyGroup(g1)
                RemoveUnit(mj)
                SaveInteger(ht,GetHandleId(u),sid,0)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    
    function SpellS082(unit u)
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        real jd=0
        real ang=0
        real x1 =0
        real y1 = 0
        real num = 4+GetHeroSummonNum(u)
        real damage = GetUnitRealState(u,1)
        unit u2 = null
        for i = 1,num
            ang=0.01745*(360/num)*i
            x1 = x+10*Cos(ang)
            y1 = y+10*Sin(ang)
            u2 = CreateTmUnit(GetOwningPlayer(u),"effect_AZ_Storm_E.mdl",x1,y1,GetUnitFacing(u),100,1)                                        
            //旋转中心单位，马甲，每圈时间，持续时间，经向速度,最远距离,伤害
            AroundSystemlei(u,u2,1.5,86400,20,160,damage*num*0.25,'S082')
        end
        flush locals
    endfunction

    function SpellS086(unit u)
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        real jd=0
        real ang=0
        real x1 =0
        real y1 = 0
        real num = 3+GetHeroSummonNum(u)
        real damage = GetUnitRealState(u,1)
        unit u2 = null
        for i = 1,num
            ang=0.01745*(360/num)*i
            x1 = x+10*Cos(ang)
            y1 = y+10*Sin(ang)    
            u2 = CreateUnit(GetOwningPlayer(u),'eZ18',x1,y1,GetUnitFacing(u))                               
            //旋转中心单位，马甲，每圈时间，持续时间，经向速度,最远距离,伤害
            AroundSystemlei(u,u2,1.5,86400,20,200,damage*num*0.34,'S086')
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
        real qtime=qtime1
        real xzsd=360/(qtime/0.03)*0.01745
        real ang=Uang(u,mj)
        real yxtime=0
        unit gu=null
        TimerStart(0.03,true)    
        {
            IndexGroup g = IndexGroup.create()
            
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
        
                GroupEnumUnitsInRange(g.ejg,x1,y1,100,GroupHasUnit(GetOwningPlayer(u),g1,""))  
                UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                g.destroy()
            else
                if  Udis(u,mj)>50
                    ang=ang+xzsd
                    x1 = GetUnitX(u)+(Udis(u,mj)-speed)*Cos(ang)
                    y1 = GetUnitY(u)+(Udis(u,mj)-speed)*Sin(ang)
                    SetUnitX(mj,x1)
                    SetUnitY(mj,y1)
                    GroupEnumUnitsInRange(g.ejg,x1,y1,100,GroupHasUnit(GetOwningPlayer(u),g1,""))
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
            AroundSystemfeng(u,bj_lastCreatedUnit,0.75,Num*0.75,20,320,damage)
        end
        flush locals
    endfunction

    function SpellS089(unit u)
        HeroSpellSummon(u,GetUnitX(u),GetUnitY(u),'z102')
    endfunction

     function SpellS090(unit u)
        HeroSpellSummon(u,GetUnitX(u),GetUnitY(u),'z103')
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

    function SpellS097(unit wu)
        int id = 'S097'
        real damage = GetAbilityDamage(wu,id,GetHeroAbilityLevel(wu,id))
        int Num = LoadInteger(ht,GetHandleId(wu),id)
        Num = Num + GetUnitAttackNumb(wu)
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
        
    function SpellS098(unit u1,real damage)
        unit u=u1
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        IndexGroup g = IndexGroup.create()
        SetAbilityCD_AC(u,'S098',0.3)
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        DestroyEffect(AddSpecialEffect("effect_by_wood_effect_yuanbanlin_sand2.mdl",x,y))
        UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
        u = null
    endfunction
    
    function SpellS100(unit u)
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        unit gu=null
        real atk=0
        IndexGroup g = IndexGroup.create()
        DestroyEffect(AddSpecialEffect("effect_fubuglow.mdl",x,y))
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        loop
            gu=FirstOfGroup(g.ejg)
            exitwhen gu==null
            UnitAddBuff(gu,'DB01',1,852189)
            GroupRemoveUnit(g.ejg,gu)
        endloop
        g.destroy()
        u = null   
        flush locals
    endfunction
    
    function SpellS101(unit u,real x,real y,real damage)
        AddUnitStateExTimer(u,86,6,4)
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

    function SpellS104Ex(unit u)
        integer pid = GetPlayerId(GetOwningPlayer(u))
        if  PlayerDeathBool == false
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,GetUnitX(u),GetUnitY(u),400,GroupNormalNoStr(GetOwningPlayer(u),"Environment\\LargeBuildingFire\\LargeBuildingFire2.mdl","origin",0))
            UnitDamageGroup(u,g.ejg,GetUnitRealState(u,5)*0.6,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()
        endif
        flush locals
    endfunction

    function SpellS104(unit u1)
        unit u=u1
        effect tx = AddSpecialEffectTarget("effect_orboffire.mdl",u,"origin") 
        int time = 0
        UnitAddAbility(u,'S104')
        SpellS104Ex(u)
        TimerStart(1,true)
        {
            if  time < 5
                time = time + 1
                SpellS104Ex(u)
            else
                UnitRemoveAbility(u,'S104')
                DestroyEffect(tx)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction 

    function SpellS105(unit u,unit u1,real damage)   
        real x=GetUnitX(u1)
        real y=GetUnitY(u1)
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,400,GroupNormalNoStr(GetOwningPlayer(u),"","origin",0))
        UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
        u = null
        flush locals
    endfunction

    
    function SpellS106(unit u,real damage)   
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,400,GroupNormalNoStr(GetOwningPlayer(u),"","origin",0))
        UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
        u = null
        flush locals
    endfunction



    function SpellS109(unit u,unit u1)
        real x=GetUnitX(u1)
        real y=GetUnitY(u1)
        real damage = GetHeroStr(u,true)

        if  GetUnitIntState(u,'FB21') > 0
            damage = damage * 1.5
        endif
        IndexGroup g 
        if  GetUnitAbilityLevel(u,'AZ15') > 0 and ChanceEx(u,'S109',10) == true
            g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,x,y,300,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
            if  FirstOfGroup(g.ejg)!=null
                LocAddEffectSetSize(x,y,"effect_red-texiao-shandian.mdl",0.8)
                UnitDamageGroup(u,g.ejg,damage*4,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            endif
            g.destroy()
        endif


        flush locals
    endfunction

    function SpellS110(unit u1,real x1,real y1,real damage1)
        unit u=u1
        real x=x1
        real y=y1
        int Numb=R2I(GetUnitRealState(u,9)/0.3/10000)
        real t=1/I2R(Numb)
        real damage=damage1
        int time=0
        group g=CreateGroup()
        unit uu=null
        real ang=0
        real dis=0
        integer i=0
        string mdoelorigin = YDWEGetObjectPropertyString(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(u),"file")
        unit mj=CreateTmUnit(GetOwningPlayer(u),mdoelorigin,GetUnitX(u),GetUnitY(u),GetUnitFacing(u),0,1)
        SetUnitVertexColor( mj, 20, 20, 50, 100 )
        SetUnitTimeScale( mj, 4.00 )
        TimerStart(0.03,true)
        {   
            time=time+1
            i=i+1
            if  time<=33
                if i>=10-(time/(30-Numb))
                    i=0
                    ang=GetRandomReal(-3.14,3.14)
                    dis=GetRandomReal(100,300)
                    GroupEnumUnitsInRange(g,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
                    UnitDamageGroup(u,g,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    SetUnitX(mj,x+(400*Cos(ang)))
                    SetUnitY(mj,y+(400*Sin(ang)))
                    SetUnitFacing(mj,Rad2Deg(ang))
                    SetUnitAnimation( mj, "Attack")
                    LocAddEffectSetRotate(x+(dis*Cos(ang+1.57)),y+(dis*Sin(ang+1.57)),Rad2Deg(ang)+GetRandomReal(0,20),"effect_akiha claw.mdx")
                    LocAddEffectSetRotate(x,y,Rad2Deg(ang),"effect_akiha claw.mdx")
                    LocAddEffectSetRotate(x+(dis*Cos(ang-1.57)),y+(dis*Sin(ang-1.57)),Rad2Deg(ang)+GetRandomReal(0,20),"effect_akiha claw.mdx")
                endif
            else
                DestroyGroup(g)
                RemoveUnit(mj)
                u = null
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SpellS113Attack(unit u,real x1,real y1,real damage)
        unit u1 = u 
        real x = x1
        real y = y1
        real dam = damage
        real dis=0
        group wg = CreateGroup()
        real ang=Pang(GetUnitX(u1),GetUnitY(u1),x,y)
        real x0 = GetUnitX(u1)
        real y0 = GetUnitY(u1)
        unit u2=CreateTmUnit(GetOwningPlayer(u1),"effect_hero_emberspirit_n3s_f_ribbon_misslie.mdl",x0,y0,ang/0.01745,0,1)
        TimerStart(0.03,true)
        {
            group gg = CreateGroup()
            dis=Pdis(GetUnitX(u2),GetUnitY(u2),x,y)
            if  dis > 50
                x0 = GetUnitX(u2) + 50*Cos(ang)
                y0 = GetUnitY(u2) + 50*Sin(ang)
                SetUnitPosition(u2,x0,y0)
                GroupEnumUnitsInRange(gg,x0,y0,200,GroupHasUnit(GetOwningPlayer(u1),wg,""))
                UnitDamageGroup(u1,gg,dam,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            else
                GroupClear(wg)
                SetUnitPosition(u2,x,y)
                GroupEnumUnitsInRange(gg,x0,y0,400,GroupHasUnit(GetOwningPlayer(u1),wg,""))
                UnitDamageGroup(u1,gg,GetUnitRealState(u1,2)*4,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                DestroyGroup(wg)
                KillUnit(u2)
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction

    function SpellS113(unit u,real x1,real y1,real damage)
        unit u1 = u 
        real x = x1
        real y = y1
        real dam = damage
        integer i=0
        if  ChanceEx(u1,'S113',30)==true
            TimerStart(0.2,true)
            {
                i=i+1
                if  i <= 3
                    SpellS113Attack(u1,x,y,dam)
                else
                    endtimer
                endif
                flush locals
            }
        else
            SpellS113Attack(u1,x,y,dam)
        endif
        flush locals

    endfunction

    function SpellS115Atk(unit u,real x0,real y0,real ang1,real damage)
        unit u1 = u 
        real dam = damage
        real dammax=damage*2
        integer time = 33
        group wg = CreateGroup()
        real ang=ang1
        real x = 0
        real y = 0
        unit u2=CreateTmUnit(GetOwningPlayer(u1),"effect_shandianzhiqiang.mdl",x0,y0,ang/0.01745,0,1)
 
        TimerStart(0.02,true)
        {
            group gg = CreateGroup()
            time = time - 1
            if  dam<dammax
                dam=dam+(dam*0.06)
            endif
            if  time > 0
                x = GetUnitX(u2) + 50*Cos(ang)
                y = GetUnitY(u2) + 50*Sin(ang)
                SetUnitPosition(u2,x,y)
                GroupEnumUnitsInRange(gg,x,y,100,GroupHasUnit(GetOwningPlayer(u1),wg,""))
                UnitDamageGroup(u1,gg,dam,false,false,ConvertAttackType(0),ConvertDamageType(4),null)
            else
                GroupClear(wg)
                DestroyGroup(wg)
                KillUnit(u2)
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction

     
    function SpellS115(unit u,real x,real y,real damage)
        real ang=Pang(GetUnitX(u),GetUnitY(u),x,y)
        real ang1=ang-2
        real ang2=ang+2
        real x0=0
        real y0=0
        SpellS115Atk(u,GetUnitX(u),GetUnitY(u),ang,damage)
        x0=GetUnitX(u) + 200*Cos(ang1)
        y0=GetUnitY(u) + 200*Sin(ang1)
        SpellS115Atk(u,x0,y0,ang,damage)
        x0=GetUnitX(u) + 200*Cos(ang2)
        y0=GetUnitY(u) + 200*Sin(ang2)
        SpellS115Atk(u,x0,y0,ang,damage)
        flush locals
    endfunction

function SpellS116(unit u1,real damage1)
    unit u=u1
    real damage=damage1
    int Num=0
    real x=0
    real y=0
    real dis=0
    real ang=0
    TimerStart(0.5,true)
    {
        Num=Num+1
        if  Num<=8
            dis=GetRandomReal(0, 300)
            ang=GetRandomReal(-3.14, 3.14)
            x=GetUnitX(u)+(dis*Cos(ang))
            y=GetUnitY(u)+(dis*Sin(ang))
            LocAddEffect(x,y,"effect_by_wood_effect_yuzhiboyou_fire_tianzhao_fangchu_1_1.mdl")
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,x,y,200,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
            UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()
        else
            endtimer
            flush locals
        endif 
        flush locals  
    }
    flush locals
    endfunction

    function SpellS117(unit u1,unit u2,real damage)//元气破
        real x=GetUnitX(u2)
        real y=GetUnitY(u2)
        IndexGroup g = IndexGroup.create()
        DestroyEffect(AddSpecialEffect("effect2_blue-texiao-meuikandong.mdl",x,y))
        GroupEnumUnitsInRange(g.ejg,x,y,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        UnitAddMana(u1,10)
        g.destroy()
        flush locals
    endfunction

     function SpellS120(unit u1,real damage1)//憾地击
        unit u=u1
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        real damage=damage1
        group g=CreateGroup()
        DestroyEffect(AddSpecialEffect("effect_[dz.spell]001.mdl",x,y))
        GroupEnumUnitsInRange(g,x,y,400,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        UnitDamageGroup(u,g,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        if  ChanceEx(u,'S120',40)
            TimerStart(0.6,false)
            {
                LocAddEffectSetSize(x,y,"effect_by_wood_sand_yuekongji.mdl",1.2)
                GroupEnumUnitsInRange(g,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
                UnitDamageGroup(u,g,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                DestroyGroup(g)
                endtimer
                flush locals
            }
        endif
        flush locals
    endfunction 

     function SpellS121(unit u1,real damage1)//锁魂
        unit u=u1
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        real damage=damage1
        group g=CreateGroup()
        DestroyEffect(AddSpecialEffect("effect_[dz.spell]001.mdl",x,y))
        AddUnitStateExTimer(u,14,15,4)
        GroupEnumUnitsInRange(g,x,y,400,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        UnitDamageGroup(u,g,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        if   ChanceEx(u,'S121',40)
            TimerStart(0.6,false)
            {
                LocAddEffectSetSize(x,y,"effect_by_wood_sand_yuekongji.mdl",1.2)
                GroupEnumUnitsInRange(g,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
                UnitDamageGroup(u,g,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                DestroyGroup(g)
                endtimer
                flush locals
            }
        endif
        flush locals
    endfunction 

     function SpellS122(unit u1,real damage1)//破甲
        unit u=u1
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        real damage=damage1
        group g=CreateGroup()
        DestroyEffect(AddSpecialEffect("effect_longzhan.mdl",x,y))
        AddUnitStateExTimer(u,13,15,4)
        GroupEnumUnitsInRange(g,x,y,400,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        UnitDamageGroup(u,g,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        if  ChanceEx(u,'S122',40)
            TimerStart(0.6,false)
            {
                LocAddEffectSetSize(x,y,"effect_daoguang-new.mdl",1.2)
                GroupEnumUnitsInRange(g,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
                UnitDamageGroup(u,g,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                DestroyGroup(g)
                endtimer
                flush locals
            }
        endif
        flush locals
    endfunction 

    function SpellS123(unit u1,real damage1)
        unit u=u1
        real damage=damage1
        int Num=0
        real x=0
        real y=0
        real dis=0
        real ang=0
        TimerStart(0.5,true)
        {
            Num=Num+1
            if  Num<=8
                dis=GetRandomReal(0, 300)
                ang=GetRandomReal(-3.14, 3.14)
                x=GetUnitX(u)+(dis*Cos(ang))
                y=GetUnitY(u)+(dis*Sin(ang))
                LocAddEffect(x,y,"effect_hero_lich_n1s_bingdong2.mdl")
                IndexGroup g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,x,y,200,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
                UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                g.destroy()
            else
                endtimer
            endif  
            flush locals  
        }
        flush locals
    endfunction


    function SpellS124Attack(unit wu,effect tx1,unit mb1,real dam1,group g1,integer num1)//确定目标发起冲锋
        group gg = g1
        unit u=wu
        unit u1=mb1
        effect tx=tx1
        real dam=dam1
        integer num=num1
        real dis=0
        real ang=0
        TimerStart(0.03,true)
        {   
            ang=Pang(EXGetEffectX(tx),EXGetEffectY(tx),GetUnitX(u1),GetUnitY(u1))
            dis=Pdis(EXGetEffectX(tx),EXGetEffectY(tx),GetUnitX(u1),GetUnitY(u1))
            if  dis>40
                EXSetEffectXY(tx, EXGetEffectX(tx)+40*Cos(ang),EXGetEffectY(tx)+40*Sin(ang)) 
            else
                EXSetEffectXY(tx, GetUnitX(u1),GetUnitY(u1)) 
                if  u1==u
                    UnitAddMana(u,num*5)
                    DestroyEffect(tx)
                    flush locals
                    endtimer
                else
                    UnitDamageTarget(u,u1,dam,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    DestroyEffect(AddSpecialEffect("effect_youling.mdl", GetUnitX(u1),GetUnitY(u1)))
                    SpellS124mb.execute(u,tx,u1,dam,gg,num)
                    flush locals
                    endtimer
                endif
            endif
            flush locals
        }
        flush locals
    endfunction

    function SpellS124mb(unit u,effect tx,unit u2,real dam,group g2,integer num)//寻找目标
        real x = GetUnitX(u2)
        real y = GetUnitY(u2)
        real mdis = 99999
        real dis = 0
        unit u4 = null
        unit u3 = null
        group g = CreateGroup()
        if  num<6
            num=num+1
            GroupEnumUnitsInRange(g,x,y,1000,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
            loop
                u4 = FirstOfGroup(g)
                if  IsUnitInGroup(u4, g2) == false
                    exitwhen u4 == null
                    set dis = SquareRoot(Pow(x-GetUnitX(u4),2)+Pow(y-GetUnitY(u4),2))
                    if  dis < mdis  then
                        u3 = u4
                        mdis = dis
                    endif
                endif
                GroupRemoveUnit(g,u4)
            endloop
            DestroyGroup(g)
            g=null
            GroupAddUnit(g2,u3)
            if  u3 == null
                u3=u
            endif
        else
            u3=u
        endif
        SpellS124Attack(u,tx,u3,dam,g2,num)
        
        flush locals
    endfunction
    
    function SpellS124(unit wu,real dam)//收到释放技能命令
        integer num = 0
        effect tx=AddSpecialEffect("effect_youling.mdl",GetUnitX(wu),GetUnitY(wu))
        EXSetEffectZ( tx, 100 )
        group gg = CreateGroup()
        SpellS124mb(wu,tx,wu,dam,gg,num)
        flush locals
    endfunction

   

    function SpellS127(unit u1)
        unit u=u1
        integer n=0
        TimerStart(0.5,true)
        {   
            if n<10
                UnitAddLife(u,GetUnitState(u,UNIT_STATE_MAX_LIFE)*0.06)
                n=n+1
            else
                endtimer
            endif
            flush locals
        }
        flush locals

    endfunction

    function SpellS128(unit u1)
        SetAbilityCD_AC(u1,'S128',0.3)
        UnitAddLife(u1,GetUnitState(u1,UNIT_STATE_MAX_LIFE)*0.02)
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

    function SpellS230(unit wu,real r1,real r2)//兽魂1
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = r1
        real y2 = r2
        real ang = Atan2(y2-y1,x2-x1)
        real dis = Pdis(x1,y1,x2,y2)
        int id = 'S230'
        real damage = GetAbilityDamage(u1,id,GetHeroAbilityLevel(u1,id))
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        unit uu = CreateTmUnit(GetOwningPlayer(u1),"shenshou_shenshou_bian.mdl",x1,y1,0,0,3.5)
        ShowUnit(u1,false)
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

                    LocAddEffectSetSize(GetUnitX(u1),GetUnitY(u1),"effect_by_wood_effect_tianhuo_2_1.mdl",2.5)
                    gg = CreateGroup()
                    GroupEnumUnitsInRange(gg,GetUnitX(u1),GetUnitY(u1),600,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffxy,3,0))
                    UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )  
                    GroupClear(gg)                
                    DestroyGroup(gg)

                    RemoveUnit(uu)
                    ShowUnit(u1,true)

                    endtimer
                endif
            else
                SetUnitFacing(uu,ang/0.01745)
                EXSetUnitFacing(uu,ang/0.01745)
                IssueImmediateOrderById( uu, 851972 )

                LocAddEffectSetSize(GetUnitX(u1),GetUnitY(u1),"effect_by_wood_effect_tianhuo_2_1.mdl",2.5)
                gg = CreateGroup()
                GroupEnumUnitsInRange(gg,GetUnitX(u1),GetUnitY(u1),600,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffxy,3,0))
                UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS ) 
                GroupClear(gg)                
                DestroyGroup(gg)

                RemoveUnit(uu)
                ShowUnit(u1,true)

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
    
    function SpellS233(unit u)
        int id = 'S233'
        real damage = GetAbilityDamage(u,id,GetHeroAbilityLevel(u,id))
        unit uu = null
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
    
    function SpellS234(unit u,real x,real y)
        int id = 'S234'
        real damage = GetAbilityDamage(u,id,GetHeroAbilityLevel(u,id))
        unit UnitAddBuffUnit=null
        unit uu = null
        UnitAddBuffUnit=CreateUnit(GetOwningPlayer(u),'e000',x,y,0)
        UnitApplyTimedLife( UnitAddBuffUnit, 'BHwe', 1.00 )
        UnitAddAbility(UnitAddBuffUnit,'DB03')
        SetUnitAbilityLevel(UnitAddBuffUnit,'DB03',2)
        IssuePointOrderById(UnitAddBuffUnit, 852592,x,y)

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
        unit u=u1
        real b=((100-GetUnitLifePercent(u))*0.3)+5
        AddUnitRealState(u,19,b)
        UnitAddAbility(u,'A235')
        shenshou(CreateTmUnit(GetOwningPlayer(u),"shenshou_zhengning.mdl",GetUnitX(u),GetUnitY(u),GetUnitFacing(u),-200,1))
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
    
function SpellS236(unit u,unit u1,real damage)
    SetUnitX(u,GetUnitX(u1))
    SetUnitY(u,GetUnitY(u1))
    AddUnitStateExTimer(u,9,75,6)
    UnitAddEffectTimer(u,"Abilities\\Spells\\Orc\\CommandAura\\CommandAura.mdl",3)
    
    shenshou(CreateTmUnit(GetOwningPlayer(u),"shenshou_heihu.mdl",GetUnitX(u1),GetUnitY(u1),GetUnitFacing(u),0,1))
    UnitDamageTarget(u,u1,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
    LocAddEffect(GetUnitX(u1),GetUnitY(u1),"effect_zhan.mdl")
    flush locals
endfunction

function SpellS237(unit u)
    shenshou(CreateTmUnit(GetOwningPlayer(u),"shenshou_kongque.mdl",GetUnitX(u),GetUnitY(u),GetUnitFacing(u),0,1))
    AddUnitStateExTimer(u,25,100,6)
    UnitTimerAddSkill(u,'A237',6)
    flush locals
endfunction


    
    

    function SpellS250(unit u1,real damage1)
        unit u=u1
        unit mj=CreateUnit(GetOwningPlayer(u),'e000',GetUnitX(u),GetUnitY(u),0)
        SetUnitAcquireRange( mj, 2000.00 )
        real m=3+(GetUnitAttack(u)/30000)
        real x=0
        real y=0
        real damage=damage1
        unit uu=null
        TimerStart(0.75,true)
        {
            x=GetUnitX(mj)
            y=GetUnitY(mj)
            m = m - 0.75
            if  m > 0
                IndexGroup g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
                uu = GroupPickRandomUnit(g.ejg) 
                UnitDamageTarget(u,uu,damage*1.2,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                LocAddEffectSetSize(GetUnitX(uu),GetUnitY(uu),"effect_misaka light.mdl",0.5)
                UnitDamageGroup(u,g.ejg,damage*0.6,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                
                g.destroy()
        
            else
                RemoveUnit(mj)
                mj=null
                endtimer
                flush locals
            endif
            flush locals
        }
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
                LocAddEffectSetSize(GetUnitX(tu),GetUnitY(tu),"effect_misaka light.mdl",0.5)
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
            LocAddEffectSetSize(GetUnitX(tu),GetUnitY(tu),"effect_misaka light.mdl",0.5)
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
            LocAddEffectSetSize(GetUnitX(tu),GetUnitY(tu),"effect_misaka light.mdl",0.5)
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
            GroupEnumUnitsInRange(g.ejg,GetUnitX(wu),GetUnitY(wu),400,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
            
            LocAddEffectSetSize(GetUnitX(wu),GetUnitY(wu),"effect_misaka light.mdl",0.5)
            g.destroy()
        endif
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
                damage = GetAbilityDamage(Pu[1],id,lv)
            elseif  lv >= 3
                damage = GetAbilityDamage(Pu[1],id,lv)*0.7
            elseif  lv >= 3
                damage = GetAbilityDamage(Pu[1],id,lv)*0.6
            else
                damage = GetAbilityDamage(Pu[1],id,lv)*0.5
            endif
        else
            damage = GetAbilityDamage(wu,id,lv)

            if  GetUnitTypeId(wu) == 'H011'
                i1 = GetHeroAbilityLevelByIndex(wu,5)
                if  SpellS511Spell(wu,i1) == true
                    if  i1 >= 3
                        damage = damage * 2.5
                    else
                        damage = damage * 2
                    endif
                endif
            endif

        endif


        if  id >= 'S000' and id <= 'S300'
            if  id == 'S005'
                SpellS005(u1.u,sx,sy)
            elseif  id == 'S002'
                SpellS002(u1.u)
            elseif  id == 'S006'
                SpellS006(u1.u,sx,sy,damage)
            elseif  id == 'S018'
                SpellS018(u1.u,damage)
            elseif  id == 'S022'
                SpellS022(u1.u,sx,sy,damage)
            elseif  id == 'S028'
                SpellS028(u1.u,sx,sy)
            elseif  id == 'S030'
                SpellS030(u1.u,sx,sy)
            elseif  id == 'S033'
                SpellS033(u1.u)
            elseif  id == 'S046'
                SpellS046(u1.u,damage)
            elseif  id == 'S047'
                SpellS047(u1.u,damage)
            elseif  id == 'S049'
                SpellS049(u1.u,damage)
            elseif  id == 'S053'
                SpellS053(u1.u,damage)
            elseif  id == 'S065'
                SpellS065(u1.u,damage)
            elseif  id == 'S070'
                SpellS070(u1.u,sx,sy,damage)
            elseif  id == 'S074'
                SpellS074(u1.u,sx,sy,damage)
            elseif  id == 'S076'
                SpellS076(u1.u,sx,sy)
            elseif  id == 'S078'
                SpellS078(u1.u,sx,sy,damage)
            elseif  id == 'S079'
                SpellS079(u1.u,sx,sy,damage)
            elseif  id == 'S080'
                SpellS080(u1.u,sx,sy,damage)
            elseif  id == 'S081'    
                SpellS081(u1.u,sx,sy,damage)
            //elseif  id == 'S082'    
            //    SpellS082(u1.u)
            elseif  id == 'S083'    
                SpellS083(u1.u,damage)
            //elseif  id == 'S086'    
            //    SpellS086(u1.u)
            elseif  id == 'S089'    
                SpellS089(u1.u)
            elseif  id == 'S090'    
                SpellS090(u1.u)
            elseif  id == 'S100'    
                SpellS100(u1.u)
            elseif  id == 'S101'    
                SpellS101(u1.u,sx,sy,damage)   
            elseif  id == 'S104'    
                SpellS104(u1.u) 
            elseif  id == 'S110'    
                SpellS110(u1.u,sx,sy,damage)
            elseif  id == 'S113'    
               SpellS113(u1.u,sx,sy,damage)
            elseif  id == 'S115'    
               SpellS115(u1.u,sx,sy,damage)
            elseif  id == 'S116'    
                SpellS116(u1.u,damage)
            elseif  id == 'S120'    
                SpellS120(u1.u,damage)
            elseif  id == 'S121'    
                SpellS121(u1.u,damage)
            elseif  id == 'S122'    
                SpellS122(u1.u,damage)
            elseif  id == 'S123'    
                SpellS123(u1.u,damage)
            elseif  id == 'S124'    
                SpellS124(u1.u,damage)


            elseif  id == 'S127'    
                SpellS127(u1.u)
            
            elseif   id>='S230' and id<='S237'
                
                if  id == 'S230'
                        SpellS230(u1.u,sx,sy)
                    elseif  id == 'S231'
                        SpellS231(u1.u,damage)
                    elseif  id == 'S232'
                        SpellS232(u1.u)
                    elseif  id == 'S233'
                        SpellS233(u1.u)
                    elseif  id == 'S234'
                        SpellS234(u1.u,sx,sy)
                    elseif  id == 'S235'
                        SpellS235(u1.u)
                    elseif  id == 'S236'
                        SpellS236(u1.u,u2.u,damage)
                    elseif  id == 'S237'
                        SpellS237(u1.u)
                endif
            endif
         endif   

         if   id >= 'S501' and id <= 'S530'  
            if  id == 'S501'
                SpellS501(u1.u,GetPlayerSkillPostionX(pid,7),GetPlayerSkillPostionY(pid,7),damage,lv)
            elseif  id == 'S502'
                SpellS502(u1.u,u2.u,damage,lv)
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
                SpellS513(u1.u,sx,sy)
            elseif  id == 'S514'
                SpellS514(u1.u,damage,lv)
                
            elseif  id == 'S516'
                SpellS516(u1.u,lv)
            elseif  id == 'S520'
                SpellS520(u1.u,lv)
            elseif  id == 'S521'
                SpellS521(u1.u,damage,lv)
            elseif  id == 'S523'
                SpellS523(u1.u,u2.u,lv)
            elseif  id == 'S524'
                SpellS524(u1.u,sx,sy,damage,lv)
            elseif  id == 'S525'
                SpellS525(u1.u,sx,sy,damage,lv)
            elseif  id == 'S527'
                SpellS527(u1.u,u2.u,lv)
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

