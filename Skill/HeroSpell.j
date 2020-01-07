library HeroSpell uses HeroAbilityFunc,BossSkill,Summon
//SpellHeroSkillAction(unit wu,unit tu,real sx,real sy,int id,int lv,int index)


   function GetUnitAttackNumb(unit wu)->int //S036
        int i=1
            if  IsPlayerHasAbility(wu,'S036') == true
                i=i+1
            endif
        return i
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
            
            UnitDamageTarget(wu,uu,dam,true,true,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)

            DestroyGroup(gg)
            gg = null
            return true
        else
            DestroyGroup(gg)
            gg = null
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
                endif
            endif
            
            flush locals
        }
        flush locals
    endfunction

    function SpellS008(unit u)//催枯
        if  GetUnitAbilityLevel(u,'A008')==0
            AddUnitStateExTimer(u,18,-30,4)
            UnitTimerAddSkill(u,'A008',4)
            flush locals
        endif
    endfunction

    function SpellS009(unit u1,unit u2,real damage)//连击
        UnitDamageTarget(u1,u2,damage, true, true, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL,WEAPON_TYPE_AXE_MEDIUM_CHOP )
        SetAbilityCD_AC(u1,'S009',2)
        string mdoelorigin = YDWEGetObjectPropertyString(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(u1),"file")
        unit mj=CreateTmUnit(GetOwningPlayer(u1),mdoelorigin,GetUnitX(u1),GetUnitY(u1),GetUnitFacing(u1),0,1)
        SetUnitAnimation( mj, "Attack" )
        SetUnitVertexColor( mj, 20, 20, 50, 100 )
        RemoveUnitTimer(mj,0.5)
        flush locals
    endfunction        

    function SpellS018(unit u1,real damage)//造成伤害三秒内破甲+15%
        unit u=u1
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        IndexGroup g = IndexGroup.create()
        AddUnitStateExTimer(u,13,15,3)
        DestroyEffect(AddSpecialEffect("effect_daoguang-new.mdl",x,y))
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        UnitDamageGroup(u,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
        g.destroy()
        u = null
    endfunction

    function SpellS022(unit u1,real x,real y,real damage)//造成伤害三秒内暴击+10%
        unit u=u1
        IndexGroup g = IndexGroup.create()
        DestroyEffect(AddSpecialEffect("effect_by_wood_sand_yuekongji.mdl",x,y)) 
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        AddUnitStateExTimer(u,19,10,3)
        UnitDamageGroup(u,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
        g.destroy()
        flush locals
    endfunction

    function SpellS023(unit u1,unit u2,real damage)//天罚
        real x=GetUnitX(u2)
        real y=GetUnitY(u2)
        IndexGroup g = IndexGroup.create()
        DestroyEffect(AddSpecialEffect("effect_[dz.spell]002_blue.mdl",x,y))
        GroupEnumUnitsInRange(g.ejg,x,y,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
        g.destroy()
        flush locals
    endfunction

    function SpellS027(unit u,unit u1,real damage)//九天御雷击
        real x=GetUnitX(u1)
        real y=GetUnitY(u1)
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,400,GroupNormalNoStr(GetOwningPlayer(u),"effect_az-leiji.mdl","origin",0))
        UnitDamageGroup(u,g.ejg,damage,true,false,ConvertAttackType(1),ConvertDamageType(0),null)
        g.destroy()
        flush locals
    endfunction

    function SpellS028(unit u0,unit u10,real damage1)//冥月流星落
        unit u=u0
        unit u1=u10
        real damage=damage1
        real x=GetUnitX(u1)
        real y=GetUnitY(u1)
        group g = CreateGroup()
        DestroyEffect(AddSpecialEffect("effect_az_bw_lina_t1-2.mdl",x,y))
        GroupEnumUnitsInRange(g,x,y,800,GroupNormalNoStr(GetOwningPlayer(u),"effect_AZ_PotM(1)_T1_Impact.mdl","origin",0))
        TimerStart(0.426,false)
        {
            UnitDamageGroup(u,g,damage,false,false,ConvertAttackType(1),ConvertDamageType(0),null)
            g=null
            flush locals
        }
        flush locals
    endfunction

    function SpellS030(unit u,unit u1,real damage)//三味真火
        int Num= LoadInteger(ht,GetHandleId(u),'S030')
        Num=Num+GetUnitAttackNumb(u)
        SaveInteger(ht,GetHandleId(u),'S030',Num)
        if Num >= 8
            real x1=GetUnitX(u)
            real y1=GetUnitY(u)
            real x2=GetUnitX(u1)
            real y2=GetUnitY(u1)
            
            
            CreateTmEx(u,"effect_by_wood_effect_yuzhiboyou_fire_haohuoqiu.mdx",x1,y1,x2,y2,damage,3,12,200,800,0.03,50,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
            SaveInteger(ht,GetHandleId(u),'S030',0)
        endif
    flush locals
     //伤害来源,马甲id,马甲创建位置x,y,创建初始角度,伤害,数量,间距角度,伤害范围,最远距离
    endfunction

    function SpellS031(unit u)          //魔茧
        if  GetUnitAbilityLevel(u,'A031')==0
            AddUnitStateExTimer(u,9,110,4)
            UnitTimerAddSkill(u,'A031',4)
        endif
        flush locals
    endfunction

    function SpellS033(unit u1) //攻速+40%
        unit u=u1
        AddUnitStateExTimer(u,9,40,4)
        flush locals
    endfunction

    function SpellS035(unit u1,unit u2,real damage)//业火咒
        int Num= LoadInteger(ht,GetHandleId(u1),'S035')
        Num=Num+GetUnitAttackNumb(u1)
        SaveInteger(ht,GetHandleId(u1),'S035',Num)
        if Num >= 8
            real x=GetUnitX(u2)
            real y=GetUnitY(u2)
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,x,y,800,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            DestroyEffect(AddSpecialEffect("effect_fire-boom-new.mdl",x,y))
            g.destroy()
            SaveInteger(ht,GetHandleId(u1),'S035',0)
        endif
        flush locals
    endfunction
    

    function SpellS038(unit u1,unit u2,real damage)//罡风破
    int Num= LoadInteger(ht,GetHandleId(u1),'S038')
        Num=Num+GetUnitAttackNumb(u1)
        SaveInteger(ht,GetHandleId(u1),'S038',Num)
    if Num >= 12
        real x=GetUnitX(u2)
        real y=GetUnitY(u2)
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,800,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
        DestroyEffect(AddSpecialEffect("effect_white-qiquan-juhuang.mdl",x,y))
        g.destroy()
        SaveInteger(ht,GetHandleId(u1),'S038',0)
        flush locals
    endif
    endfunction

    function SpellS039(unit u11,unit u21,real damage1)//他山之石
    unit u1=u11
    unit u2=u21
    real damage=damage1
    int Num= LoadInteger(ht,GetHandleId(u1),'S039')
        Num= Num+GetUnitAttackNumb(u1)
        SaveInteger(ht,GetHandleId(u1),'S039',Num)
    if Num >= 12
        real x=GetUnitX(u2)
        real y=GetUnitY(u2)
        DestroyEffect(AddSpecialEffect("effect_zhendi-shitou.mdl",x,y))
        SaveInteger(ht,GetHandleId(u1),'S039',0)
        TimerStart(0.5,false)
        {
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,800,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
        endtimer
        }
        
        flush locals
    endif
    endfunction

    function SpellS040(unit u1,unit u2,real damage)//弱水咒
        real x=GetUnitX(u2)
        real y=GetUnitY(u2)
        IndexGroup g = IndexGroup.create()
        DestroyEffect(AddSpecialEffect("effect_zhendi-water.mdl",x,y))
        GroupEnumUnitsInRange(g.ejg,x,y,800,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
        flush locals
    endfunction

    function SpellS043(unit u1,unit u2,real damage)//气流杀
        real x=GetUnitX(u2)
        real y=GetUnitY(u2)
        IndexGroup g = IndexGroup.create()
        DestroyEffect(AddSpecialEffect("effect_white-qiquan-special.mdl",x,y))
        GroupEnumUnitsInRange(g.ejg,x,y,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
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
                                if  I2R(LoadInteger(ht,GetHandleId(gu),159379))>0
                                    damage=I2R(LoadInteger(ht,GetHandleId(gu),159379))*damage1
                                    UnitDamageTarget(u, gu, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_POISON, WEAPON_TYPE_WHOKNOWS)
                                endif
                        GroupRemoveUnit(g.ejg,gu)
                    endloop
        gu=null
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
        }
        flush locals
    endfunction

    function SpellS049(unit u,real damage1)//引爆魅惑
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        real damage=I2R(LoadInteger(ht,GetHandleId(u),'S049'))*damage1
       IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"effect_senbonzakurapart.mdl","origin",0))
        DestroyEffect(AddSpecialEffect("effect_shockwave_pink2.mdl",x,y))
        UnitDamageGroup(u,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
        flush locals
    endfunction

   function SpellS052(unit u1,real x1,real y1,real damage1)//造成伤害减少其他技能0.5CD
    unit u=u1
    real x=x1
    real y=y1
    real damage=damage1
    integer id =0
    DestroyEffect(AddSpecialEffect("effect_az_earthshaker_a.mdl",GetUnitX(u),GetUnitY(u)))
    string mdoelorigin = YDWEGetObjectPropertyString(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(u),"file")
    unit mj=CreateTmUnit(GetOwningPlayer(u),mdoelorigin,GetUnitX(u),GetUnitY(u),GetUnitFacing(u),0,1)
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
    }
    
    for i = 1,4
        id = 'AG00' + i
        YDWESetUnitAbilityState(u,id, 1,YDWEGetUnitAbilityState(u, id, 1)-0.5)
    end
        flush locals
    endfunction

    function SpellS053(unit u,real damage)//概率造成双倍伤害
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,800,GroupNormalNoStr(GetOwningPlayer(u),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl","origin",0))
        if GetRandomInt(1, 2) == 1
            DestroyEffect(AddSpecialEffect("effect_dark-shousuo.mdl",x,y))
            damage=damage*2
        else
            DestroyEffect(AddSpecialEffect("effect_dark-shousuo.mdl",x,y))
        endif
        
        UnitDamageGroup(u,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
        flush locals
    endfunction

    function SpellS056(unit u)
        RefreshUnitSkill(u)
        flush locals
    endfunction


     function SpellS057(unit u)
     int Num= LoadInteger(ht,GetHandleId(u),'S057')
        Num=Num+GetUnitAttackNumb(u)
        SaveInteger(ht,GetHandleId(u),'S057',Num)
        if Num >= 24
            RefreshUnitSkill(u)
            SaveInteger(ht,GetHandleId(u),'S057',0)
        endif
        flush locals
    endfunction

    function SpellS065(unit u1,real x,real y,real damage)//造成伤害三秒内法穿+15%
        unit u=u1
        IndexGroup g = IndexGroup.create()
        AddUnitStateExTimer(u,14,15,3)
        DestroyEffect(AddSpecialEffect("effect_zi-fazhen.mdl",x,y))
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        UnitDamageGroup(u,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
        u = null
    endfunction

    function SpellS070(unit u1,real x1,real y1,real damage1)
        unit u=u1
        real x=x1
        real y=y1
        int Numb=R2I(GetUnitRealState(u,9)/0.3/10000)
        real t=1/I2R(Numb)
        real damage=damage1
        int time=0
        effect e=AddSpecialEffect("effect_jianzhen.mdl",x,y)
        EXSetEffectSize(e,2)
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

            else
                if  time<=133
                   
                     if i>=10-(time/(30-Numb))
                        i=0
                        ang=GetRandomReal(-3.14,3.14)
                        dis=GetRandomReal(100,300)
                        GroupEnumUnitsInRange(g,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
                        UnitDamageGroup(u,g,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
            endif
            flush locals
        }
        flush locals
    endfunction

    function SpellS073(unit u,real damage)
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        real jd=0
        real ang=0
        real x1 =0
        real y1 = 0

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

    function SpellS076(unit wu,unit u1,real damage)//连环刺
        unit u=wu
        real x=GetUnitX(u1)
        real y=GetUnitY(u1)
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,400,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        UnitDamageGroup(u,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
        LocAddEffectSetSize(x,y,"effect_blue-slash-more.mdl",0.5)
        g.destroy()
        SaveInteger(ht,GetHandleId(u),'S075',LoadInteger(ht,GetHandleId(u),'S075')+10)
        TimerStart(2,false)
        {
            SaveInteger(ht,GetHandleId(u),'S075',LoadInteger(ht,GetHandleId(u),'S075')-10)
            u = null
            endtimer
        }
        flush locals
    endfunction


    function SpellS075(unit u,unit u1,real damage)//夺命刺
        UnitDamageTarget(u,u1,damage, true, true, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL,WEAPON_TYPE_AXE_MEDIUM_CHOP )
        LocAddEffectSetRotateSize(GetUnitX(u),GetUnitY(u),GetUnitFacing(u),2,"effect_zzmxcl_tuci.mdl")
        if IsPlayerHasAbility(u,'S076') == true
            SpellS076(u,u1,damage/8*3)
        endif
    endfunction
    

    function SpellS078(unit u2,real x1,real y1,real damage1)
        unit u=u2
        real damage=damage1 
        real m=3+(GetUnitAttack(u)/30000)
        real x=x1
        real y=y1
        real x0=GetUnitX(u)
        real y0=GetUnitY(u)
        LocAddEffectTimer(x,y,"effect_az_axe_x.mdl",m)
    //伤害来源，目标点xy，起始点xy，模型路径，速度，高度，伤害半径，伤害
        TimerStart(m,false)
        {   
            EffectDown(u,x,y,x0,y0,"effect_txab0a (3).mdl",35,1000,600,damage*m,"effect_az_tormentedsoul_t1.mdl")
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
        real m=3+(GetUnitRealState(u,1)/30000)
        effect tx=AddSpecialEffect("effect_gate.mdl",xu,yu)
        EXEffectMatRotateZ(tx,ang/0.01745)
        EXSetEffectSpeed(tx,9)
        TimerStart(0.1,true)
        {   
            time=time+0.1
         if     time<1
         else   
            if  time<m
                jl=GetRandomReal(-200,200)
                x0 = xu+jl*Cos(ang+1.57)
                y0 = yu+jl*Sin(ang+1.57)
                mj=CreateTmUnit(GetOwningPlayer(u),"effect_shandianzhiqiang.mdl",x0,y0,ang/0.01745,0,1)
                CreateTmFunc(u,mj,ang,damage,70,1500,GetRandomReal(50,300),true,false,0,4)
                
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
        real m=3+(GetUnitRealState(u1,2)/30000)
        real x=x1
        real y=y1
        integer n = 0
        LocAddEffectTimer(x,y,"effect_az_blacksmoke.mdl",m)
        TimerStart(0.03,true)
        {
            m = m - 0.03
            n = n + 1
            if  m > 0
                IndexGroup g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,x,y,600,GroupSetToCenter(GetOwningPlayer(u1),x,y,n,""))
                if  n == 16
                    UnitDamageGroup(u1,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    n=0
                endif
                g.destroy()
            else
                u1 = null
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    
    
    
     function SpellS082(unit u,real damage)
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        real jd=0
        real ang=0
        real x1 =0
        real y1 = 0
        real Num = 3+(GetUnitRealState(u,2)/30000)
        for i=0,3
            ang=0.01745*90*i
            x1 = x+10*Cos(ang)
            y1 = y+10*Sin(ang)
            bj_lastCreatedUnit=CreateTmUnit(GetOwningPlayer(u),"effect_AZ_Storm_E.mdl",x1,y1,GetUnitFacing(u),100,1)                                        
            //旋转中心单位，马甲，每圈时间，持续时间，经向速度,最远距离,伤害
            AroundSystemlei(u,bj_lastCreatedUnit,1.5,Num,20,100,damage/4)
        end
        flush locals
   
     endfunction

    function SpellS083(unit u,real damage)
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        real jd=0
        real ang=0
        real x1 =0
        real y1 = 0
        real Num = 3+(GetUnitRealState(u,2)/30000)
        for i=0,1
            ang=0.01745*180*i
            x1 = x+50*Cos(ang)
            y1 = y+50*Sin(ang)
            bj_lastCreatedUnit=CreateTmUnit(GetOwningPlayer(u),"effect_az_kaer_x1.mdl",x1,y1,GetUnitFacing(u),100,1)                                        
            UnitAddEffectTimer(u,"effect_az_goods_tp_target(3).mdl",Num*0.75)
            //旋转中心单位，马甲，每圈时间，持续时间，经向速度,最远距离,伤害
            AroundSystem(u,bj_lastCreatedUnit,0.75,Num*0.75,20,320,damage)
        end
        flush locals
    endfunction

    function SpellS086(unit u)
        Summon(u,GetUnitX(u),GetUnitY(u),'z100')
    endfunction

    function SpellS087(unit u)
        Summon(u,GetUnitX(u),GetUnitY(u),'z100')
    endfunction


    function SpellS089(unit u)
        Summon(u,GetUnitX(u),GetUnitY(u),'z102')
    endfunction

    function SpellS090(unit u)
        Summon(u,GetUnitX(u),GetUnitY(u),'z103')
    endfunction


    function SpellS094(unit u1,real damage)
        unit u=u1
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        DestroyEffect(AddSpecialEffect("effect_hero_grandmagus_n1s_z_down.mdl",x,y))
        UnitDamageGroup(u,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
        g.destroy()
        u = null
    endfunction

    function SpellS095(unit u1,real damage)
        unit u=u1
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        IndexGroup g = IndexGroup.create()
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
        DestroyEffect(AddSpecialEffect("effect_blue-daoguang-new.mdl",x,y))
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        UnitDamageGroup(u,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
        g.destroy()
        u = null
    endfunction

    function SpellS097(unit u1,real damage)
        unit u=u1
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        int Num= LoadInteger(ht,GetHandleId(u),'S097')
        Num=Num+GetUnitAttackNumb(u1)
        SaveInteger(ht,GetHandleId(u),'S097',Num)
        if Num >= 8
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
            UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            LocAddEffectSetRotate(x,y,GetUnitFacing(u),"effect_red-yumao-zhendi-paoxiao.mdl")
            g.destroy()
            SaveInteger(ht,GetHandleId(u),'S097',0)
            u = null
        endif
        
    endfunction
        
    function SpellS098(unit u1,real damage)
        unit u=u1
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        DestroyEffect(AddSpecialEffect("effect_by_wood_effect_yuanbanlin_sand2.mdl",x,y))
        UnitDamageGroup(u,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
        
    endfunction
    
    function SpellS101(unit u,real x,real y,real damage)
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u),"effect_az_zeusking_impact-black.mdl","origin",0))
        LocAddEffect(x,y,"effect_white-shandian-qiquan.mdl")
        UnitDamageGroup(u,g.ejg,damage+(GetUnitRealState(u,5)*1.3),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
        g.destroy()
        u = null
    endfunction    
    
     function SpellS102(unit u,real damage)
        real x=GetUnitX(u)
        real y=GetUnitY(u)

    endfunction  

    function SpellS104(unit u1)
        unit u=u1
        real x=GetUnitX(u)
        real y=GetUnitY(u)
        
        effect tx = AddSpecialEffectTarget("effect_orboffire.mdl",u,"chest") 
        TimerStart(0.8,true)
        {
        if  IsPlayerHasAbility(u,'S104') == true
            x=GetUnitX(u)
            y=GetUnitY(u)
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,x,y,400,GroupNormalNoStr(GetOwningPlayer(u),"Environment\\LargeBuildingFire\\LargeBuildingFire2.mdl","origin",0))
            UnitDamageGroup(u,g.ejg,GetUnitRealState(u,5)*0.3,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()
           
        else
            u = null
            DestroyEffect(tx)
            endtimer
        endif
        }

    endfunction    



 function SpellS109(unit u,unit u1)
    real x=GetUnitX(u1)
    real y=GetUnitY(u1)
    real damage=10
    IndexGroup g = IndexGroup.create()
    GroupEnumUnitsInRange(g.ejg,x,y,200,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
    LocAddEffect(x,y,"effect_by_wood_gongchengsipai_2.mdl")
    if GetUnitRealState(u,1)>GetUnitRealState(u,2)
        damage=GetUnitRealState(u,1)*12
        GroupRemoveUnit(g.ejg,u1)
        UnitDamageGroup(u,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
    else
        damage=GetUnitRealState(u,2)*12
        UnitDamageGroup(u,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
    endif
    g.destroy()
    u = null
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
                        UnitDamageGroup(u,g,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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




    function SpellS111(unit u)
        Summon(u,GetUnitX(u),GetUnitY(u),'z104')
    endfunction

    function SpellS112(unit u,real x,real y)
        Summon(u,x,y,'z105')
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
        endif    
    }
    endfunction

    function SpellS117(unit u1,unit u2,real damage)//元气破
        real x=GetUnitX(u2)
        real y=GetUnitY(u2)
        IndexGroup g = IndexGroup.create()
        DestroyEffect(AddSpecialEffect("effect2_blue-texiao-meuikandong.mdl",x,y))
        GroupEnumUnitsInRange(g.ejg,x,y,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        UnitAddMana(u1,10)
        g.destroy()
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
    }
    endfunction

    function SpellS123(unit u1)
        unit u=u1
        integer n=0
        TimerStart(0.5,true)
        {   
            n=n+1
            if n<10
                UnitAddLife(u,GetUnitState(whichunit,UNIT_STATE_MAX_LIFE)*0.06)
            else
                endtimer
            endif
        }

    endfunction

    function SpellS230(unit wu,real r1,real r2,real dam)//兽魂1
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real ang = Atan2(r2-y1,r1-x1)
        real dis = Pdis(x1,y1,r1,r2)
        real damage = dam
        real sp = dis/50
        real x2 = sp*Cos(ang)
        real y2 = sp*Sin(ang)
        real time = 0
        real height = dis
        string mdoelorigin = YDWEGetObjectPropertyString(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(u1),"file")
        DzSetUnitModel( u1,"effect_hero_xingxing.mdx")
        SetUnitAnimation( u1,"spell" )
        if  height < 500
            height = 500
        endif
        
        SetUnitFacing(u1,ang/0.01745)
        EXSetUnitFacing(u1,ang/0.01745)
        TimerStart(0.01,true)
        {
            time = time + sp
            x1 = GetUnitX(u1) + x2
            y1 = GetUnitY(u1) + y2
            if  IsCanFlyTerrain(x1,y1) == true
                SetUnitX(u1,x1)
                SetUnitY(u1,y1)
                UnitAddAbility(u1,'Arav')
                SetUnitFlyHeight(u1,Sin(time/dis*3.1415926)*height,0)
                UnitRemoveAbility(u1,'Arav')
                SetUnitFacing(u1,ang/0.01745)
                EXSetUnitFacing(u1,ang/0.01745)
                
            else
                time = dis+1
            endif
            if  time >= dis
                UnitAddAbility(u1,'Arav')
                SetUnitFlyHeight(u1,GetUnitDefaultFlyHeight(u1),0)
                UnitRemoveAbility(u1,'Arav')
                SetUnitFacing(u1,ang/0.01745)
                EXSetUnitFacing(u1,ang/0.01745)
                IssueImmediateOrderById( u1, 851972 )
                LocAddEffectSetSize(GetUnitX(u1),GetUnitY(u1),"effect_by_wood_effect_tianhuo_2_1.mdl",2)
                
                IndexGroup gg = IndexGroup.create()
                GroupEnumUnitsInRange(gg.ejg,GetUnitX(u1),GetUnitY(u1),400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",'A000',4,852095))
                UnitDamageGroup(u1,gg.ejg,damage,true, false,ATTACK_TYPE_HERO,DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS )
                DzSetUnitModel( u1,mdoelorigin)                   
                gg.destroy()
                
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    
    function SpellS231(unit u1,real damage1)//兽魂2
    unit u=u1
    real m=12+(GetUnitAttack(u)/15000)
    real damage=damage1
    int Num=0
    real x=0
    real y=0
    real dis=0
    real ang=0
    TimerStart(3/(m+1),true)
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
    }
    endfunction
    

    function SpellS232(unit u1)
        unit u=u1
        unit uu=null
        AddUnitStateExTimer(u,18,20,3)
        UnitTimerAddSkill(u,'A232',3)  //添加判断Buff
        IndexGroup g = IndexGroup.create()
        LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_blue-dao-mofa.mdl")
        GroupEnumUnitsInRange(g.ejg,GetUnitX(u),GetUnitY(u),800,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
        loop
            uu = FirstOfGroup(g.ejg)
            exitwhen uu == null
            IssueTargetOrder(uu, "attack",u)
            GroupRemoveUnit(g.ejg,uu)
        endloop
        g.destroy()
        u=null
    endfunction
    
    function SpellS233(unit u1)
        unit u=u1
        unit uu=null
        TimerStart(2,false)
        {
            IndexGroup g = IndexGroup.create()
            LocAddEffect(GetUnitX(u),GetUnitY(u),"effect_az-ice-qiquan.mdl")
            GroupEnumUnitsInRange(g.ejg,GetUnitX(u),GetUnitY(u),800,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
            loop
                uu = FirstOfGroup(g.ejg)
                exitwhen uu == null
                UnitAddBuff(uu,'DB02',3,852095)
                GroupRemoveUnit(g.ejg,uu)
            endloop
            
        }    
    endfunction
    
    function SpellS234(unit u,unit u1,real damage)
        UnitDamageTarget(u,u1,damage, false,false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL,WEAPON_TYPE_AXE_MEDIUM_CHOP )
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,GetUnitX(u),GetUnitY(u),800,GroupAddBuffEx(GetOwningPlayer(u),"",'DB02',5,852095,100))
        g.destroy()
    endfunction
    
    function SpellS235(unit u1)
        unit u=u1
        real b=((100-GetUnitLifePercent(u))*0.3)+5
        AddUnitRealState(u,19,b)
        UnitAddAbility(u,'A235')
        TimerStart(5,false)
        {
            RemoveUnitStateEx(u,19,b)
            RemoveUnitStateEx(u,20,LoadReal(ht,GetHandleId(u),'A235'))
            UnitRemoveAbility(u,'A235')
            SaveReal(ht,GetHandleId(u),'A235',0)
            endtimer
        }
        flush locals
    endfunction
    
function SpellS236(unit u,unit u1)
     real damage=0
     SetUnitX(u,GetUnitX(u1))
     SetUnitY(u,GetUnitY(u1))
     AddUnitStateExTimer(u,9,220,3)
    if GetUnitRealState(u,1)>GetUnitRealState(u,2)
        damage=GetUnitRealState(u,1)*12
        UnitDamageTarget(u,u1,damage, true,true, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL,WEAPON_TYPE_AXE_MEDIUM_CHOP )
    else
        damage=GetUnitRealState(u,2)*12
        UnitDamageTarget(u,u1,damage, false,false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL,WEAPON_TYPE_AXE_MEDIUM_CHOP )
    endif
endfunction

function SpellS237(unit u)
    AddUnitStateExTimer(u,25,40,5)
     UnitTimerAddSkill(u,'A237',5)
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
                UnitDamageTarget(u,uu,damage*1.2,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                LocAddEffectSetSize(GetUnitX(uu),GetUnitY(uu),"effect_misaka light.mdl",0.5)
                UnitDamageGroup(u,g.ejg,damage*0.6,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                
                g.destroy()
        
            else
                RemoveUnit(mj)
                mj=null
                endtimer
                flush locals
            endif
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
        
        real damage = 0

        if GetUnitAbilityLevel(u1.u, 'A237')>0 
            AddUnitStateExTimer(u1.u,17,10,5)
        endif 

        //BJDebugMsg("释放技能"+I2S(id)+"等级"+I2S(lv))
        if  wu == Pu[63]
            damage = GetAbilityDamage(Pu[1],id,lv) * 0.5
        else
            damage = GetAbilityDamage(wu,id,lv)
        endif

        if  id >= 'S000' and id <= 'S300'
            if  id== 'S006'
                SpellS006(u1.u,sx,sy,damage)
            elseif  id== 'S018'
                SpellS018(u1.u,damage)
            elseif  id== 'S022'
                SpellS022(u1.u,sx,sy,damage)
            elseif  id== 'S033'
                SpellS033(u1.u)
            elseif  id== 'S046'
                SpellS046(u1.u,damage)
            elseif  id== 'S047'
                SpellS047(u1.u,damage)
            elseif  id== 'S049'
                SpellS049(u1.u,damage)
            elseif  id== 'S052'
                SpellS052(u1.u,sx,sy,damage)
            elseif  id== 'S053'
                SpellS053(u1.u,damage)
            elseif  id== 'S065'
                SpellS065(u1.u,sx,sy,damage)
            elseif  id== 'S070'
                SpellS070(u1.u,sx,sy,damage)
            elseif  id== 'S073'
                SpellS073(u1.u,damage)
            elseif  id== 'S078'
                SpellS078(u1.u,sx,sy,damage)
            elseif  id== 'S080'
                SpellS080(u1.u,sx,sy,damage)
            elseif  id== 'S081'    
                SpellS081(u1.u,sx,sy,damage)
            elseif  id== 'S082'    
                SpellS082(u1.u,damage)
            elseif  id== 'S083'    
                SpellS083(u1.u,damage)
            elseif  id== 'S086'    
                SpellS086(u1.u)
            elseif  id== 'S087'    
                SpellS087(u1.u)
            elseif  id== 'S089'    
                SpellS089(u1.u)
            elseif  id== 'S090'    
                SpellS090(u1.u)
            elseif  id== 'S100'    
                SpellS100(u1.u)
            elseif  id== 'S101'    
                SpellS101(u1.u,sx,sy,damage)
            elseif  id== 'S110'    
                SpellS110(u1.u,sx,sy,damage)
            elseif  id== 'S111'    
                SpellS111(u1.u)
             elseif  id== 'S112'    
                SpellS112(u1.u,sx,sy)
            elseif  id== 'S116'    
                SpellS116(u1.u,damage)

             elseif  id== 'S123'    
                SpellS123(u1.u,damage)
            
            elseif  id== 'S230'
                SpellS230(u1.u,sx,sy,damage)
            elseif  id== 'S231'
                SpellS231(u1.u,damage)
            elseif  id== 'S232'
                SpellS232(u1.u)
            elseif  id== 'S233'
                SpellS233(u1.u)
            elseif  id== 'S235'
                SpellS235(u1.u)
            endif
        elseif  id == 'S501'
            SpellS501(u1.u,GetPlayerSkillPostionX(pid,7),GetPlayerSkillPostionY(pid,7),damage)
        elseif  id == 'S502'
            SpellS502(u1.u,u2.u,damage)
        elseif  id == 'S504'
            SpellS504(u1.u,GetPlayerSkillPostionX(pid,7),GetPlayerSkillPostionY(pid,7),damage)
        elseif  id == 'S505'
            SpellS505(u1.u)
        elseif  id == 'S510'
            SpellS510(u1.u)
        elseif  id == 'S512'
            SpellS512(u1.u,GetPlayerSkillPostionX(pid,7),GetPlayerSkillPostionY(pid,7),damage)
        elseif  id == 'S513'
            SpellS513(u1.u,GetPlayerSkillPostionX(pid,7),GetPlayerSkillPostionY(pid,7))
        elseif  id == 'S514'
            SpellS514(u1.u,damage)
            
        elseif  id == 'S516'
            SpellS516(u1.u)
        elseif  id == 'S523'
            SpellS523(u1.u,u2.u)
        elseif  id == 'S524'
            SpellS524(u1.u,u2.u)
        elseif  id == 'S525'
            SpellS525(u1.u,GetPlayerSkillPostionX(pid,7),GetPlayerSkillPostionY(pid,7),damage)
        elseif  id == 'S527'
            SpellS527(u1.u,u2.u)
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

