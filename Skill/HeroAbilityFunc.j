library HeroAbilityFunc uses OtherDamageTimer,Summon

    function IsHasHeroType(int id)->bool
        for pid = 0,3
            if  GetUnitTypeId(Pu[1]) == id
                return true
            endif
        end
        return false
    endfunction
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

    function SpellS501_4(unit wu,real x1,real y1,real damage)
        real ang = GetRandomReal(-3.14,3.14)
        real dis = GetRandomReal(200,300)
        x1 = x1 + dis * Cos(ang)
        y1 = y1 + dis * Sin(ang)
        IndexGroup g = IndexGroup.create()
        LocAddEffectSetSize(x1,y1,"effect2_by_wood_effect2_yubanmeiqin_lightning_zhenzhengdeluolei.mdl",2)
        GroupEnumUnitsInRange(g.ejg,x1,y1,500,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))    
        UnitDamageGroup(wu,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
    endfunction
    function SpellS501_3(unit wu)
        unit u1 = wu
        real damage = GetUnitAttack(u1)*1.6
        int num = 4
        SpellS501_4(wu,GetUnitX(wu),GetUnitY(wu),damage)
        TimerStart(0.15,true)
        {
            SpellS501_4(u1,GetUnitX(u1),GetUnitY(u1),damage)
            num = num -1 
            if  num <= 0
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    function SpellS501_2(unit wu,real dam,int level)
        unit u1 = wu
        real damage = dam
        int lv = level
        int time = 3
        TimerStart(0.2,true)
        {   
            IndexGroup g = IndexGroup.create()
            real x1 = GetUnitX(u1)
            real y1 = GetUnitY(u1)
            if  time == 3
                LocAddEffectSetSize(x1,y1,"effect_shengguang.mdl",2.8)
                GroupEnumUnitsInRange(g.ejg,x1,y1,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                if  lv >= 2
                    UnitDamageGroup(u1,g.ejg,damage*2,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                else
                    UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                endif
            elseif  time == 2
                LocAddEffectSetSize(x1,y1,"effect_shengguang.mdl",2.8)
                GroupEnumUnitsInRange(g.ejg,x1,y1,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                if  lv >= 3
                    UnitDamageGroup(u1,g.ejg,damage*2,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                else
                    UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                endif
                
            elseif  time == 1
                LocAddEffectSetSize(x1,y1,"effect_shengguang.mdl",2.8)
                if  lv >= 4
                    GroupEnumUnitsInRange(g.ejg,x1,y1,400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffxy,4,0))
                else
                    GroupEnumUnitsInRange(g.ejg,x1,y1,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                endif
                UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            endif

            time = time - 1
            if  time <= 0
                if  GetUnitIntState(u1,'FB22') > 0 or GetUnitIntState(u1,'FF22') > 0
                    SpellS501_3(u1)
                endif
                endtimer
            endif
            g.destroy()
            flush locals
        }
        flush locals
    endfunction
    
    function SpellS501(unit wu,real sx,real sy,real dam,int level)
        unit u1 = wu
        real x2 = sx
        real y2 = sy
        real x1 = GetUnitX(wu)
        real y1 = GetUnitY(wu)
        real ang = Pang(x1,y1,sx,sy)
        int time = 0
        int lv = level
        real damage = dam
        EXSetUnitCollisionType( false,u1, 1 )
        SetUnitPathing( u1, false )
        
        
                
        TimerStart(0.01,true)
        {
            time = time + 1
            if  time <= 15 and GetUnitAbilityLevel(u1,'AZ98') == 0
                x1 = x1 + 30 * Cos(ang)
                y1 = y1 + 30 * Sin(ang)
                if  IsCanFlyTerrain(x1,y1) == true
                    SetUnitPosition(u1,x1,y1)
                    EXSetUnitFacing( u1, ang/0.01745 )
                    SetUnitFacing(u1,ang/0.01745)

                else
                    EXSetUnitCollisionType( true,u1, 1 )
                    SetUnitPathing( u1, true )
                    SetUnitAnimation(u1,"stand")
                    SpellS501_2(u1,damage,lv)
                    endtimer
                endif
                
            else
                EXSetUnitCollisionType( true,u1, 1 )
                SetUnitPathing( u1, true )
                SetUnitAnimation(u1,"stand")
                SpellS501_2(u1,damage,lv)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    
    
    function SpellS502_2(unit wu,real dam,int lv)
        unit u1 = wu
        real x1 = GetUnitX(wu)
        real y1 = GetUnitY(wu)
        unit u3 = CreateTmUnit(GetOwningPlayer(wu),"effect_dark-xuanfen.mdl",x1,y1,GetUnitFacing(u1),0,1.3)
        real damage = dam
        int num = 2
        int level = lv
        effect eff = AddSpecialEffect("effect_by_wood_quanhuang_bashenanzhuazi2.mdl",x1,y1)
        if  GetUnitIntState(u1,'FB06') > 0 or GetUnitIntState(u1,'FF06') > 0 
            num = num  + R2I(GetUnitRealState(u1,9)+1)/7500
        endif

        if  IsHasHeroType('H035') == true
            num = num + 2
        endif
        EXEffectMatRotateZ( eff, GetRandomReal(1,360) )
        if  lv >= 3
            damage = damage * 1.5
        endif
        DestroyEffect(eff)
        
        TimerStart(0.2,true)
        {
            x1 = GetUnitX(u1)
            y1 = GetUnitY(u1)
            num = num - 1
            if  num > 0
                eff = AddSpecialEffect("effect_by_wood_quanhuang_bashenanzhuazi2.mdl",x1,y1)
                EXEffectMatRotateZ( eff, GetRandomReal(1,360) )
                
                DestroyEffect(eff)

                IndexGroup g = IndexGroup.create()
                if  level >= 2
                    GroupEnumUnitsInRange(g.ejg,x1,y1,300,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffxy,1,0))
                else
                    GroupEnumUnitsInRange(g.ejg,x1,y1,300,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                endif
                UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                g.destroy()
                
            else
                if  level >= 4
                    AddUnitStateExTimer(u1,20,30,3)
                endif
                RemoveUnit(u3)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    function SpellS502(unit wu,real sx,real sy,real dam,int lv)
        unit u1 = wu
        int level = lv
        real damage = dam
        real x1 = GetUnitX(wu)
        real y1 = GetUnitY(wu)
        real x2 = sx
        real y2 = sy
        real ang = Pang(x1,y1,sx,sy)
        real size = YDWEGetObjectPropertyReal(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(u1),"modelScale")
        group g1 = CreateGroup()
        EXSetUnitFacing( u1, ang/0.01745 )
        SetUnitFacing(u1,ang/0.01745)
        unit u3 = CreateTmUnit(GetOwningPlayer(wu),"effect_az_chongfeng.mdl",x1,y1,GetUnitFacing(u1),0,1.3)
        SetUnitScale(u1,0.001,0.001,0.001)
        TimerStart(0.03,true)
        {
            real dis = Pdis(x1,y1,x2,y2)
            if  dis > 50 and GetUnitAbilityLevel(u1,'AZ98') == 0
                x1 = x1 + 30 * Cos(ang)
                y1 = y1 + 30 * Sin(ang)
                if  IsCanFlyTerrain(x1,y1) == true
                    SetUnitX(u1,x1)
                    SetUnitX(u3,x1)
                    SetUnitY(u1,y1)
                    SetUnitY(u3,y1)
                    SetUnitFacing(u1,ang/0.01745)
                    SetUnitFacing(u3,ang/0.01745)
                    IndexGroup g = IndexGroup.create()
                    if  level >= 2
                        GroupEnumUnitsInRange(g.ejg,x1,y1,175,GroupHasUnitAddBuff(GetOwningPlayer(u1),g1,"",Buffxy,1,0))
                    else
                        GroupEnumUnitsInRange(g.ejg,x1,y1,175,GroupHasUnit(GetOwningPlayer(u1),g1,""))
                    endif
                    UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    g.destroy()
                else
                    SpellS502_2(u1,damage,level)
                    SetUnitScale(u1,size,size,size)
                    DestroyGroup(g1)
                    RemoveUnit(u3)
                    endtimer
                endif
            else
                SpellS502_2(u1,damage,level)
                SetUnitScale(u1,size,size,size)
                DestroyGroup(g1)
                RemoveUnit(u3)
                endtimer
            endif
            
            flush locals
        }
        flush locals
    endfunction


    function SpellS503(unit wu,int lv)
        unit u1 = wu
        real damage = GetAbilityDamage(wu,'S503',1)
        real x = GetUnitX(wu)
        real y = GetUnitY(wu)
        LocAddEffectSetSize(x,y,"effect_tx_asad (24).mdl",2.6)

        
        if  lv == 2
            SetAbilityCD_AC(u1,'S503',2)
        elseif  lv== 1
            SetAbilityCD_AC(u1,'S503',4)
        endif

        TimerStart(0.5,false)
        {
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)

            LocAddEffectSetSize(x,y,"effect_tx_asad (25).mdl",2.6)

            g.destroy()
            endtimer

            flush locals
        }
        flush locals
        
    endfunction
    function SpellS503Select(real x,real y)
        real rac = 1200
        int lv = 0
        for pid = 0,3
            if  GetUnitTypeId(Pu[1]) == 'H003'
                lv = GetHeroAbilityLevel(Pu[1],'S503')
                if  lv >= 4
                    rac = 2000
                endif
                if  IsUnitInRangeXY(Pu[1], x, y, rac) == true
                    if  YDWEGetUnitAbilityState(Pu[1], 'AC05', 1) == 0
                        SpellS503(Pu[1],lv)
                    endif
                endif
            endif
        end
    endfunction
    function SpellS504_2(unit wu,real face,real dam,int level)
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real ang = face
        real damage = dam
        int time = 4
        int lv = level
        if  lv >= 4
            time = 7
        elseif  lv >= 3
            time = 5
        endif

        EXSetUnitFacing( u1, ang/0.01745 )
        SetUnitFacing(u1,ang/0.01745)
        SetUnitAnimationByIndex(u1,2)
        TimerStart(0.2,true)
        {
            real f = ang
            real r1 = 0
            x1 = GetUnitX(u1)
            y1 = GetUnitY(u1)
            time = time - 1
            if  GetUnitAbilityLevel(u1,'AZ98') != 0
                time = 0
            endif
            if  time >= 1

                f = ang + GetRandomReal(-0.5235,0.5235)
                LocAddEffectTimerOrSize(x1,y1,ang/0.01745,"effect_az_caster_Red.mdl",0,1.8)
                CreateTmFunc(u1,CreateTmUnit(GetOwningPlayer(u1),"effect_[dz.spell]004Red.mdl",x1,y1,f/0.01745,75,1),f,damage,200,600,75,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
                if  lv >= 2
                    r1 = GetUnitState(u1,UNIT_STATE_MAX_LIFE)*0.025
                    UnitAddLife(u1,r1)
                    BJDebugMsg("火尖枪回复生命"+R2S(r1))
                endif
                SetUnitAnimationByIndex(u1,2)
                if  time == 1
                    if  GetUnitIntState(u1,'FB11') == 0 and GetUnitIntState(u1,'FF11') == 0
                        time = 0
                    endif
                endif
            else
                if  GetUnitIntState(u1,'FB11') > 0 or GetUnitIntState(u1,'FF11') > 0
                    LocAddEffectSetSize(x1+50*Cos(ang),y1+50*Cos(ang),"effect_fire-boom-new.mdl",0.5)
                    CreateTmFunc(u1,CreateTmUnit(GetOwningPlayer(u1),"effect_[dz.spell]004Red.mdl",x1,y1,ang/0.01745,75,2),ang,GetUnitAttack(u1)*7.5,400,1200,75,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
                    CameraSetTargetNoiseTimer(GetPlayerId(GetOwningPlayer(u1)),8,1,0.2)
                    if  lv >= 2
                        r1 = GetUnitState(u1,UNIT_STATE_MAX_LIFE)*0.025
                        UnitAddLife(u1,r1)
                        BJDebugMsg("火尖枪回复生命"+R2S(r1))
                    endif
                endif
            endif
            SetUnitPosition(u1,x1,y1)
            EXSetUnitFacing( u1, f/0.01745 )
            SetUnitFacing(u1,f/0.01745)
            if  time <= 0
                //伤害来源,马甲,方向,伤害,伤害范围,最远距离,移动时间间隔,马甲高度,伤害类型4个
                SetUnitAnimation(u1,"stand")
                endtimer
            endif
            flush locals
        }
        flush locals

    endfunction
    function SpellS504(unit wu,real sx,real sy,real dam,int lv)
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = sx
        real y2 = sy
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"effect_red-daoguang-new.mdl",x1,y1,GetUnitFacing(u1),0,1.0)
        real ang = Pang(x1,y1,x2,y2)
        group g1 = CreateGroup()
        real damage = dam
        int level = lv
        if  Pdis(x1,y1,x2,y2) > 800
            x2 = x1 + 800 * Cos(ang)
            y2 = y1 + 800 * Sin(ang)
        endif
        EXSetUnitCollisionType( false,u1, 1 )
        SetUnitPathing( u1, false )
        EXSetUnitFacing( u1, ang/0.01745 )
        SetUnitFacing(u1,ang/0.01745)
        UnitApplyTimedLife(u2, 'BHwe', 0.5)
        TimerStart(0.02,true)
        {
            
            
            if  Pdis(x1,y1,x2,y2) > 50 and GetUnitAbilityLevel(u1,'AZ98') == 0
                
                x1 = x1 + 50 * Cos(ang)
                y1 = y1 + 50 * Sin(ang)
                if  IsCanFlyTerrain(x1,y1) == true
                    SetUnitPosition(u1,x1,y1)
                    SetUnitPosition(u2,x1+50*Cos(ang),y1+50*Sin(ang))
                    IndexGroup g = IndexGroup.create()
                    GroupEnumUnitsInRange(g.ejg,x1,y1,250,GroupHasUnit(GetOwningPlayer(u1),g1,""))
                    UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    g.destroy()
                else
                    EXSetUnitCollisionType( true,u1, 1 )
                    SetUnitPathing( u1, true )
                    SetUnitAnimation(u1,"stand")
                    DestroyGroup(g1)
                    SpellS504_2(u1,ang,damage,level)
                    endtimer
                endif
            else
                EXSetUnitCollisionType( true,u1, 1 )
                SetUnitPathing( u1, true )
                SetUnitAnimation(u1,"stand")
                DestroyGroup(g1)
                SpellS504_2(u1,ang,damage,level)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SpellS505Damage(unit wu)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        real x = GetUnitX(wu)
        real y = GetUnitY(wu)
        wu = Pu[1]
        LocAddEffectSetSize(x,y,"effect_tt (5).mdl",3)
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
        UnitDamageGroup(wu,g.ejg,GetAbilityDamage(wu,'S505',1),false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
    endfunction

    function SpellS505(unit wu,int lv)
        int num = 2
        if  lv >= 4
            num = 6
        elseif  lv >= 3
            num = 4
        elseif  lv >= 2
            num = 3
        endif
        if  GetUnitIntState(wu,'FB42') > 0
            num = num + 2
        endif
        SetUnitIntState(wu,'S505',0)
        for i = 1,num
            UnitAddBuff(wu,'AZ03',1,852274)
        end
    endfunction



    

    function SpellS508(unit wu,int lv)
        int num = 0
        real damage = 0
        int value = 0
        num = GetUnitIntState(wu,'S508')
        if  num < 6
            if  ChanceEx(wu,'S508',12) == true
                if  lv >= 3
                    value = 18
                else
                    value = 9
                endif
                AddUnitRealState(wu,9,value)
                AddUnitIntState(wu,'H508',value)
                SetUnitIntState(wu,'S508',num + 1)
                
            endif
        else
            damage = GetAbilityDamage(wu,'S508',1)
            if  lv >= 4
                damage = damage * 1.8
            elseif  lv >= 2
                damage = damage * 1.3
            endif
            AddUnitRealState(wu,9,-GetUnitIntState(wu,'H508'))
            SetUnitIntState(wu,'S508',0)
            SetUnitIntState(wu,'H508',0)
            
            IndexGroup g = IndexGroup.create()

            GroupEnumUnitsInRange(g.ejg,GetUnitX(wu),GetUnitY(wu),350,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
            UnitDamageGroup(wu,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            LocAddEffectTimerOrSize(GetUnitX(wu),GetUnitY(wu),0,"effect_az_axe_x.mdl",0.6,1.8)
            g.destroy()
        endif
        
    endfunction

    function SpellS509Func(unit wu)
        unit u1 = wu
        real x1 = GetUnitX(wu) + 200 * Cos(GetUnitFacing(wu)*0.01745)
        real y1 = GetUnitY(wu) + 200 * Sin(GetUnitFacing(wu)*0.01745)
        real ang = GetRandomReal(-3.14,3.14)
        real x2 = x1+500*Cos(ang)
        real y2 = y1+500*Sin(ang)
        ang = ang + 3.14
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),YDWEGetObjectPropertyString(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(u1),"file"),x2,y2,ang/0.01745,0,1.0)
        int time = 33
        group g1 = CreateGroup()
        real damage = GetAbilityDamage(u1,'S509',1)
        SetUnitAnimation(u2,"attack")
        LocAddEffectSetRotate(x1,y1,ang/0.01745,"effect_az_jingzi_jiansheng01_e1.mdl")
        if  GetHeroAbilityLevel(u1,'S509') >= 4
            damage = damage * 1.5
        endif
        TimerStart(0.01,true)
        {
            time = time - 1
            x2 = x2 + 30 * Cos(ang)
            y2 = y2 + 30 * Sin(ang)
            SetUnitX(u2,x2)
            SetUnitY(u2,y2)

            IndexGroup g = IndexGroup.create()
            if  GetUnitIntState(u1,'FB18') > 0 or GetUnitIntState(u1,'FF18') > 0
                GroupEnumUnitsInRange(g.ejg,x2,y2,125,GroupHasUnitAddBuff(GetOwningPlayer(u1),g1,"",'A006',1,852095))
                UnitDamageGroup(u1,g.ejg,damage*1.25,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            else
                GroupEnumUnitsInRange(g.ejg,x2,y2,125,GroupHasUnit(GetOwningPlayer(u1),g1,""))
                UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            endif
            g.destroy()

            if  time <= 0
                DestroyGroup(g1)
                RemoveUnit(u2)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SpellS509(unit wu,int level)
        unit u1 = wu   
        int lv = level
        AddUnitIntState(wu,'S509',1)
        if  lv >=2 
            AddUnitRealState(wu,10,15)
        endif
        TimerStart(3,false)
        {
            AddUnitIntState(u1,'S509',-1)
            if  lv >=2 
                AddUnitRealState(u1,10,-15)
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction
    


    function SpellS510Spell2(unit wu)

        BJDebugMsg("杨戬lv4")
        if  GetHeroAbilityLevel(wu,'S510') >= 4
            if  GetUnitIntState(wu,'S512') == 0
                BJDebugMsg("杨戬lv4damage")
                IndexGroup g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,GetUnitX(wu),GetUnitY(wu),450,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
                if  GetUnitIntState(wu,'S510') == 0
                    UnitDamageGroup(wu,g.ejg,GetHeroStr(wu,true)*8.75*1.5,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                else
                    UnitDamageGroup(wu,g.ejg,GetHeroStr(wu,true)*8.75,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                endif
                LocAddEffect(GetUnitX(wu),GetUnitY(wu),"effect_fire-boom-new.mdl")
                g.destroy()

                AddUnitIntStateTimer(wu,'S512',1,2)

            endif
        endif
    endfunction

    function SpellS510Spell1(unit wu)
        
        BJDebugMsg("杨戬lv3")
        if  GetHeroAbilityLevel(wu,'S510') >= 3
            if  GetUnitIntState(wu,'S511') == 0

                BJDebugMsg("杨戬lv3damage")
                IndexGroup g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,GetUnitX(wu),GetUnitY(wu),450,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
                UnitDamageGroup(wu,g.ejg,GetUnitAttack(wu)*3,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                LocAddEffect(GetUnitX(wu),GetUnitY(wu),"effect_green-texiao-shandian.mdl")
                g.destroy()

                if  GetUnitIntState(wu,'S510') == 2
                    AddUnitIntStateTimer(wu,'S511',1,0.2)
                else
                    AddUnitIntStateTimer(wu,'S511',1,2)
                endif

            endif
        endif
        
    endfunction

    function SpellS510(unit wu,int lv)
        int index = GetUnitIntState(wu,'S510')

        if  index == 0

            AddUnitRealState(wu,25,-25)
            AddUnitRealState(wu,19,10)
            if  lv >= 2
                AddUnitRealState(wu,9,20)
            endif
            
            
            SetUnitIntState(wu,'S510',1)
            DzSetUnitModel( wu, "Hero_yangjian_Dragon.mdl" )
            SetUnitScale(wu,0.3,0.3,0.3)

            if  GetLocalPlayer() == GetOwningPlayer(wu)
                YDWESetUnitAbilityDataString(wu, 'AG05',1, 204, "ReplaceableTextures\\CommandButtons\\BTNS510_2.blp")
            endif
            
        elseif  index == 1

            AddUnitRealState(wu,19,-10)
            AddUnitRealState(wu,9,30)
            if  lv >= 2
                AddUnitRealState(wu,9,-20)
            endif



            SetUnitIntState(wu,'S510',2)
            DzSetUnitModel( wu, "Hero_yangjian_Tiger.mdl" )
            SetUnitScale(wu,1.5,1.5,1.5)
            if  GetLocalPlayer() == GetOwningPlayer(wu)
                YDWESetUnitAbilityDataString(wu, 'AG05',1, 204, "ReplaceableTextures\\CommandButtons\\BTNS510_3.blp")
            endif
        elseif  index == 2

            AddUnitRealState(wu,9,-30)
            AddUnitRealState(wu,25,25)
  
            SetUnitIntState(wu,'S510',0)
            DzSetUnitModel( wu, "H010.mdl" )
            SetUnitScale(wu,1.0,1.0,1.0)
            if  GetLocalPlayer() == GetOwningPlayer(wu)
                YDWESetUnitAbilityDataString(wu, 'AG05',1, 204, "ReplaceableTextures\\CommandButtons\\BTNS510_1.blp")
            endif
        endif
    endfunction

    function SpellS511Spell(unit wu,int lv)->bool
        int num = 0
        int ran = 35
        if  lv >= 4
            ran = 60
        endif
        if  GetRandomInt(1,100)<= ran
            BJDebugMsg("命途多舛 成功")
            UnitAddText(wu,"|cff00ff00大成功|r",255,255,255,255,90,0.023)
            return true
        else
            UnitAddLife(wu,GetUnitState(wu,UNIT_STATE_MAX_LIFE)*0.15)
            BJDebugMsg("命途多舛 失败")
            return false
        endif
    endfunction

    function SpellS512(unit wu,real sx,real sy,real dam,int level)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        real x2 = GetUnitX(u1)
        real y2 = GetUnitY(u1)
        
        real ang = Atan2(y1-y2,x1-x2)
        if  Pow(Pow(x1-x2,2)+Pow(y1-y2,2),0.5) > 1000
            x1 = x2 + 1000 * Cos(ang)
            y1 = y2 + 1000 * Sin(ang)
        endif

        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"effect_GF2_TALOU.mdl",x1,y1,0,1500,2)
        int time = 0
        real damage = dam
        int lv = level
        if  lv >= 4
            damage = damage * 1.9
        elseif  lv >= 3
            damage = damage * 1.5
        elseif  lv >= 2
            damage = damage * 1.2
        endif
        if  GetUnitIntState(u1,'FB10') > 0
            damage = damage * 2
        endif
        LocAddEffectSetSize(x1,y1,"effect_yellow-guangzhu-new2.mdl",3)
        SetUnitFlyHeight(u2,0,5000.00)
        TimerStart(0.3,true)
        {
            time = time + 1
            if  time == 1
                IndexGroup g = IndexGroup.create()
                if  lv >= 4
                    GroupEnumUnitsInRange(g.ejg,x1,y1,280,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffxy,2,0))
                else
                    GroupEnumUnitsInRange(g.ejg,x1,y1,280,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffxy,1,0))
                endif
                UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                LocAddEffectSetSize(x1,y1,"effect_[dz.spell]002Yellow.mdl",0.8)
                
                CameraSetTargetNoiseTimer(GetPlayerId(GetOwningPlayer(u1)),8,1,0.2)
                //BJDebugMsg("damage"+R2S(damage))
                g.destroy()
            else
                RemoveUnit(u2)
                endtimer
            endif
            
            flush locals
        }
        flush locals
    endfunction
    function SpellS513Spell(unit wu)->bool
        int pid = GetPlayerId(GetOwningPlayer(wu))
        if  GetUnitTypeId(wu) == 'H013'
            if  GetUnitTypeId(Pu[63])!=0
                return true
            endif
        endif
        return false
    endfunction

    function SpellS513Timer(unit wu,int lv)
        unit u1 = wu
        int time = 12
        real x1 = GetUnitX(wu)
        real y1 = GetUnitY(wu)
        effect eff = AddSpecialEffect("GH_lshr.mdl",x1,y1)
        int level = lv
        EXSetEffectSize(eff,2)
        TimerStart(0.5,true)
        {
            
            time = time - 1
            if  GetUnitTypeId(u1) != 0
                if  level >= 2
                    for pid = 0,3
                        if  IsUnitInRangeXY(Pu[1], x1, y1, 600) == true
                            UnitAddLife(Pu[1],GetUnitState(Pu[1],UNIT_STATE_MAX_LIFE)*0.015)
                        endif
                    end
                endif
                if  time <= 0
                    DestroyEffect(eff)
                    RemoveUnit(u1)
                    endtimer
                endif
            else
                DestroyEffect(eff)
                endtimer
            endif
            
            flush locals
        }
        flush locals
    endfunction
    function SpellS513(unit wu,real sx,real sy,int lv)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        if  Pu[63] != null
            RemoveUnit(Pu[63])
        endif
        BJDebugMsg("createm")
        Pu[63] = CreateTmUnit(GetOwningPlayer(wu),YDWEGetObjectPropertyString(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(wu),"file"),sx,sy,0,0,YDWEGetObjectPropertyReal(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(wu),"modelScale"))
        SetUnitVertexColor(Pu[63],255,255,255,180)
        UnitAddEffect(Pu[63],"Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl")
        SpellS513Timer(Pu[63],lv)
    endfunction
//effect_ice23.mdl
    function SpellS514Timer(unit u1,real dam,real sx,real sy,int level)
        unit wu = u1
        real damage = dam
        real x = sx
        real y = sy
        int lv = level
        TimerStart(0.8,false)
        {
            IndexGroup g = IndexGroup.create()
            if  lv >= 2
                LocAddEffect(x,y,"effect_ice23.mdl")
                GroupEnumUnitsInRange(g.ejg,x,y,800,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
            else
                LocAddEffectSetSize(x,y,"effect_ice23.mdl",0.5)
                GroupEnumUnitsInRange(g.ejg,x,y,400,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
            endif
            UnitDamageGroup(wu,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()
            endtimer
            flush locals
        }
        flush locals
    endfunction
    function SpellS514(unit wu,real damage,int lv)
        real x = GetUnitX(wu)
        real y = GetUnitY(wu)
        
        IndexGroup g = IndexGroup.create()
        if  lv >= 2
            LocAddEffectSetSize(x,y,"effect_az_fenghuang.mdl",2)
            AddEffectInAreaSetSize(x,y,700,1.0,15,"effect_hero_lich_n1s_bingdong2.mdl")
        else
            LocAddEffectSetSize(x,y,"effect_az_fenghuang.mdl",1.2)
            AddEffectInAreaSetSize(x,y,400,1.0,10,"effect_hero_lich_n1s_bingdong2.mdl")
        endif
        
        if  lv >= 4
            GroupEnumUnitsInRange(g.ejg,x,y,800,GroupNormalNoStrAddBuff(GetOwningPlayer(wu),"",Buffdj,2,0))
            UnitDamageGroup(wu,g.ejg,damage*2.0,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        elseif  lv >= 3
            GroupEnumUnitsInRange(g.ejg,x,y,800,GroupNormalNoStrAddBuff(GetOwningPlayer(wu),"",Buffdj,1,0))
            UnitDamageGroup(wu,g.ejg,damage*1.5,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        elseif  lv >= 2
            GroupEnumUnitsInRange(g.ejg,x,y,800,GroupNormalNoStrAddBuff(GetOwningPlayer(wu),"",Buffdj,1,0))
            UnitDamageGroup(wu,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        else
            GroupEnumUnitsInRange(g.ejg,x,y,400,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
            UnitDamageGroup(wu,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        endif

        g.destroy()
        if  GetUnitIntState(wu,'FB27') > 0
            SpellS514Timer(wu,GetHeroStr(wu,true)*9.0,x,y,lv)
        endif
    endfunction


    function SpellS515_2Timer(unit wu,real sx,real sy,real dam,int id)
        unit u1 = wu
        unit u2 = null
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = sx
        real y2 = sy
        real damage = dam
        int index = id
        real face = Pang(x1,y1,x2,y2)
        int time = 0
        if  index == 0
            u2 = CreateTmUnit(GetOwningPlayer(wu),"effect_Orb_DarknessX.mdl",x1,y1,90,0,1.0)
        else
            u2 = CreateTmUnit(GetOwningPlayer(wu),"effect_Orb_LightX.mdl",x1,y1,90,0,1.0)
        endif
        SetUnitPropWindow( u2, 3.14 )
        SetUnitTurnSpeed( u2, 0.05)
        SetUnitFacing(u2,face/0.01745)
        TimerStart(0.03,true)
        {
            real dis = Pdis(x1,y1,x2,y2)
            time = time + 1
            if  dis > 50 and time < 166
                real ang = GetUnitFacing(u2)*0.01745
                face = Pang(x1,y1,x2,y2)
                x1 = x1 + 20 * Cos(ang)
                y1 = y1 + 20 * Sin(ang)
                SetUnitX(u2,x1)
                SetUnitY(u2,y1)
                SetUnitFacing(u2,face/0.01745)
            else
                IndexGroup g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,x2,y2,300,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                if  index == 0
                    LocAddEffect(x1,y1,"effect_tt (56).mdl")
                    LocAddEffect(x1,y1,"effect3_desecrateblack.mdl")
                else
                    LocAddEffectSetSize(x1,y1,"effect_shengguang.mdl",3)
                endif
                g.destroy()
                RemoveUnit(u2)
                endtimer
            endif
            flush locals
        }
        flush locals

    endfunction
    function SpellS515Timer(unit wu,real x,real y,real dam)
        unit u1 = wu
        real sx = x
        real sy = y
        real damage = dam/4
        int time = 4
        TimerStart(0.15,true)
        {
            time = time - 1
            SpellS515_2Timer(u1,sx,sy,damage,ModuloInteger(time,2))
            if  time <= 0
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    function SpellS515(unit wu,real x,real y,real damage,int lv)
        int num = GetUnitIntState(wu,'S515')
        
        if  num >= 4
            if  lv >= 4
                damage = damage * 2.3
            elseif  lv >= 2
                damage = damage * 1.5
            endif
            for i = 1,4
                UnitRemoveAbility(wu,'AZA0'+i)
            end
            SetUnitIntState(wu,'S515',0)
            SpellS515Timer(wu,x,y,damage)
        endif
        
    endfunction

    function SpellS515Spell(unit wu)
        int num = GetUnitIntState(wu,'S515') + 1
        if  num <= 4
            SetUnitIntState(wu,'S515',num)
            UnitAddAbility(wu,'AZA0'+num)
        endif

        
    endfunction
    
    function SpellS516(unit wu,int lv)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        AddUnitIntState(wu,'RDAB',1)
        if  GetUnitIntState(wu,'RDAB') == 30
            if  DzPlayerLv(Player(pid)) >= 4
                if  GameLevel >= 2
                    if  GetPlayerTechCount(Player(pid),'RDAB',true) == 0
                        SetDzPlayerData(pid,15,2,2)
                        SetPlayerTechResearchedEx(Player(pid),'RDAB')
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000我真的知错了|r（永久存档）！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000我真的知错了|r，但可惜难度不够要求！")
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000我真的知错了|r，但可惜地图等级不够要求！")
            endif
        endif

        LocAddEffect(GetUnitX(wu),GetUnitY(wu),"effect_az-leiji.mdl")
        if  lv >= 2
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,GetUnitX(wu),GetUnitY(wu),300,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
            UnitDamageGroup(wu,g.ejg,GetUnitAttack(wu)*7.5,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()
        else
            KillUnit(wu)
        endif
        for pid= 0,3
            if  IsPlaying(pid) == true
                if  PlayerDeathBool == false
                    if  lv >= 3
                        SetUnitState(Pu[1],UNIT_STATE_LIFE,GetUnitState(Pu[1],UNIT_STATE_MAX_LIFE))
                    else
                        SetUnitState(Pu[1],UNIT_STATE_LIFE,GetUnitState(Pu[1],UNIT_STATE_LIFE)+GetUnitState(Pu[1],UNIT_STATE_MAX_LIFE)*0.5)
                    endif
                endif
                if  lv >= 4
                    AddUnitStateExTimer(Pu[1],16,60,6)
                else
                    AddUnitStateExTimer(Pu[1],16,30,6)
                endif
                LocAddEffect(GetUnitX(wu),GetUnitY(wu),"effect_e_buffattack.mdl")
            endif
        end
    endfunction

    function SpellS517Timer(unit wu)
        unit u1 = wu
        AddUnitIntState(u1,'S517',1)
        TimerStart(4,false)
        {
            AddUnitIntState(u1,'S517',-1)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function SpellS517Spell(unit wu,unit tu,real damage,int lv)
        real add = 0
        if  YDWEGetUnitAbilityState(wu, 'AC05', 1) == 0
            real x1 = GetUnitX(tu)
            real y1 = GetUnitY(tu)
            if  lv >= 4
                SpellS517Timer(wu)
            endif

            if  GetUnitIntState(wu,'FB16') > 0
                add = 0.3
            endif
            if  lv >= 2
                add = 0.4
            endif

            if  add > 0
                damage = damage * (1+add)
            endif
            
            IndexGroup g = IndexGroup.create()
            AddEffectInAreaSetSize(x1,y1,250,0.5,10,"effect_hero_attack1.mdl")
            GroupEnumUnitsInRange(g.ejg,x1,y1,300,GroupNormalNoStrAddBuff(GetOwningPlayer(wu),"",Buffxy,2,0))
            UnitDamageGroup(wu,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()

            SetAbilityCD_AC(wu,'S517',8)
        endif
    endfunction

    function SpellS518Spell(unit wu)
        int lv = GetHeroAbilityLevelByIndex(wu,5)
        if  lv >= 3
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,GetUnitX(wu),GetUnitY(wu),600,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
            if  lv >= 4
                UnitDamageGroup(wu,g.ejg,(GetUnitAttack(wu)+GetHeroStr(wu,true))*6.0,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            else
                UnitDamageGroup(wu,g.ejg,(GetUnitAttack(wu)+GetHeroStr(wu,true))*3.0,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            endif
            LocAddEffectSetSize(GetUnitX(wu),GetUnitY(wu),"effect2_az_magina[2]_v.mdl",2)
            g.destroy()
        endif

    endfunction
    function SpellS518(unit wu,int id)

        SetEquipStateOfPlayer(wu,id,0.16)
        DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:太乙真人运转九转神功，额外获得16%道果属性！")

    endfunction

    function SpellS519(unit wu,real dam,int lv)
        unit u1 = wu
        real x1 = GetUnitX(wu)
        real y1 = GetUnitY(wu)
        real damage = dam
        int time = 5
        if  lv >= 4
            damage = damage * 2
        endif
        TimerStart(0.2,true)
        {
            
            real dis = GetRandomReal(0,300)
            real ang = GetRandomReal(-3.14,3.14)
            real x = x1 + dis*Cos(ang)
            real y = y1 + dis*Sin(ang)
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,x,y,200,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            LocAddEffect(x,y,"effect_yellow-guangzhu-new2.mdl")
            g.destroy()

            time = time - 1
            if  time <= 0
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SpellS520(unit wu,int lv)
        if  GetUnitIntState(wu,'H520') == 0
            AddUnitRealStateTimer(wu,18,18,6)
            AddUnitIntStateTimer(wu,'H520',1,6)
        endif
        if  lv >= 2
            AddUnitIntStateTimer(wu,'S520',1,6)
        endif

        if  GetUnitIntState(wu,'FB14') > 0 or GetUnitIntState(wu,'FF14') > 0
            UnitAddLife(wu,GetUnitState(wu,UNIT_STATE_MAX_LIFE)*0.15)
        endif


        flush locals
    endfunction

    function SpellS521Spell(unit wu,int lv)
        if  lv >= 4
            if  ChanceEx(wu,'S521',3) == true
                SetAbilityCD_AG(wu,'AG05',0)
            endif
        endif
    endfunction
    function SpellS521(unit wu,real dam,int lv)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        unit u1 = wu
        real damage = dam
        int time = 6
        if  lv >= 3
            damage = damage * 1.8
        elseif  lv >= 2
            damage = damage * 1.3
        endif
        AddUnitIntState(u1,'S521',1)
        /*if  GetUnitIntState(u1,'S521')>=6
            if  DzPlayerLv(Player(pid)) >= 6
                if  GetPlayerTechCount(Player(pid),'RDAR',true) == 0
                    SetDzPlayerData(pid,15,18,18)
                    SetPlayerTechResearchedEx(Player(pid),'RDAR')
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000今晚的月亮好圆啊|r（永久存档）！")
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000今晚的月亮好圆啊|r，但可惜地图等级不够要求！")
            endif
        endif*/
        TimerStart(1,true)
        {
            time = time - 1
            IndexGroup g = IndexGroup.create()
            LocAddEffectSetSize(GetUnitX(u1),GetUnitY(u1),"effect2_az_cocoguanyu_t2_death.mdl",1.5)
            if  GetUnitIntState(u1,'FB24') > 0 or GetUnitIntState(u1,'FF24') > 0
                GroupEnumUnitsInRange(g.ejg,GetUnitX(u1),GetUnitY(u1),600,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",'A007',1,852075))
            else
                GroupEnumUnitsInRange(g.ejg,GetUnitX(u1),GetUnitY(u1),600,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            endif
            UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()
            
            if  time <= 0
                AddUnitIntState(u1,'S521',-1)
                endtimer
            endif
            flush locals
        }
        flush locals
        
    endfunction



    function SpellS523(unit wu,int lv)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        real life = 0
        real maxlife = 0
        real add = 0
        real att = 0
        if  lv >= 2
            add = 0.4
        else
            add = 0.2
        endif
        if  lv >= 4
            att = 30
        else
            att = 15
        endif

        for pid = 0,3
            if  IsUnitInRange(Pu[1],wu,600) == true
                life = GetUnitState(Pu[1],UNIT_STATE_LIFE)
                maxlife = GetUnitState(Pu[1],UNIT_STATE_MAX_LIFE)
                SetUnitState(Pu[1],UNIT_STATE_LIFE,life + maxlife * 0.3)
                AddUnitIntStateTimer(Pu[1],'S523',1,4)
                //AddUnitStateExTimer(Pu[1],32,15,4)
                LocAddEffect(GetUnitX(Pu[1]),GetUnitY(Pu[1]),"effect_e_buffgreen2a.mdl")
            endif
        end


        if  lv >= 3
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,GetUnitX(wu),GetUnitY(wu),600,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
            UnitDamageGroup(wu,g.ejg,GetUnitAttack(wu)*10.0,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            AddEffectInAreaSetSize(GetUnitX(wu),GetUnitY(wu),550,2,15,"effect2_az_goods_blink(green).mdl")
            g.destroy()
        endif
        

        /*int uid = GetUnitTypeId(tu)
        if  uid == 'H028' or uid == 'H016' or uid == 'H027'
            if  DzPlayerLv(Player(pid)) >= 6
                if  GetPlayerTechCount(Player(pid),'RDAQ',true) == 0
                    SetDzPlayerData(pid,15,17,17)
                    SetPlayerTechResearchedEx(Player(pid),'RDAQ')
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000红颜祸水|r（永久存档）！")
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000红颜祸水|r，但可惜地图等级不够要求！")
            endif
        endif*/
    endfunction

    function SpellS524(unit wu,real sx,real sy,real dam,int level)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        real damage = dam
        int time = 3
        int lv = level
        real timeout = 1.0

        if  lv >= 3
            time = 7
            timeout = 0.5
        endif

        IndexGroup g = IndexGroup.create()
        if  lv >= 2
            GroupEnumUnitsInRange(g.ejg,x1,y1,600,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"effect_az_jugg_e2.mdl",'A003',1,852095))
        else
            GroupEnumUnitsInRange(g.ejg,x1,y1,600,GroupNormalNoStr(GetOwningPlayer(u1),"effect_az_jugg_e2.mdl","origin",0))
        endif
        UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        LocAddEffect(x1,y1,"effect_fubuglow.mdl")
        g.destroy()

        TimerStart(timeout,true)
        {
            time = time - 1

            
            IndexGroup g = IndexGroup.create()
            if  lv >= 2
                GroupEnumUnitsInRange(g.ejg,x1,y1,600,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"effect_az_jugg_e2.mdl",'A003',1,852095))
            else
                GroupEnumUnitsInRange(g.ejg,x1,y1,600,GroupNormalNoStr(GetOwningPlayer(u1),"effect_az_jugg_e2.mdl","origin",0))
            endif
            UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            LocAddEffect(x1,y1,"effect_fubuglow.mdl")
            g.destroy()

            if  time <= 0
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    

    function SpellS525_1(unit wu,real sx,real sy,real dam,real d)
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = sx
        real y2 = sy
        real damage = dam
        real ang = Pang(x1,y1,x2,y2)
        real dis = d
        real mx = x1+dis*Cos(ang+1.5705)
        real my = y1+dis*Sin(ang+1.5705)
        
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"effect_dummy_spiritarrow_byepsilon.mdl",x1,y1,ang/0.01745,0,0.1)
        group g1 = CreateGroup()
        int num = 0
        TimerStart(0.02,true)
        {
            IndexGroup  g
            real speed = num
            if  speed > 60
                speed = 60
            endif
            SetUnitScale(u2,0.3+speed/56,0.3+speed/56,0.3+speed/56)
            num = num + 1
            if  num < 36
                
                ang = ang - 0.1745
                mx = x1+dis*Cos(ang+1.5705)
                my = y1+dis*Sin(ang+1.5705)
                SetUnitFacing(u2,ang/0.01745)
                EXSetUnitFacing( u2, ang/0.01745 )
                SetUnitX(u2,mx)
                SetUnitY(u2,my)
                g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,mx,my,250,GroupHasUnit(GetOwningPlayer(u1),g1,""))
                UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                g.destroy()
                
            else
                if  Pdis(mx,my,x2,y2) > 60
                    ang = Pang(mx,my,x2,y2)
                    mx = mx + speed * Cos(ang)
                    my = my + speed * Sin(ang)
                    SetUnitFacing(u2,ang/0.01745)
                    EXSetUnitFacing( u2, ang/0.01745 )
                    SetUnitX(u2,mx)
                    SetUnitY(u2,my)
                    g = IndexGroup.create()
                    GroupEnumUnitsInRange(g.ejg,mx,my,250,GroupHasUnit(GetOwningPlayer(u1),g1,""))
                    UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    g.destroy()
                else
                    DestroyGroup(g1)
                    KillUnit(u2)
                    endtimer
                endif
            endif
            flush locals
        }
        flush locals
    endfunction
    function SpellS525_2(unit wu,real sx,real sy,real dam,real d)
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = sx
        real y2 = sy
        real damage = dam
        real ang = Pang(x1,y1,x2,y2)
        real dis = d
        real mx = x1+dis*Cos(ang-1.5705)
        real my = y1+dis*Sin(ang-1.5705)
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"effect_dummy_spiritarrow_byepsilon.mdl",x1,y1,ang/0.01745,0,0.1)
        group g1 = CreateGroup()
        int num = 0
        TimerStart(0.02,true)
        {
            IndexGroup  g
            real speed = num
            if  speed > 60
                speed = 60
            endif
            SetUnitScale(u2,0.3+speed/56,0.3+speed/56,0.3+speed/56)
            num = num + 1
            if  num < 36
                
                ang = ang + 0.1745
                mx = x1+dis*Cos(ang-1.5705)
                my = y1+dis*Sin(ang-1.5705)
                SetUnitFacing(u2,ang/0.01745)
                EXSetUnitFacing( u2, ang/0.01745 )
                SetUnitX(u2,mx)
                SetUnitY(u2,my)
                g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,mx,my,250,GroupHasUnit(GetOwningPlayer(u1),g1,""))
                UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                g.destroy()
                
            else
                if  Pdis(mx,my,x2,y2) > 60
                    ang = Pang(mx,my,x2,y2)
                    mx = mx + speed * Cos(ang)
                    my = my + speed * Sin(ang)
                    SetUnitFacing(u2,ang/0.01745)
                    EXSetUnitFacing( u2, ang/0.01745 )
                    SetUnitX(u2,mx)
                    SetUnitY(u2,my)
                    g = IndexGroup.create()
                    GroupEnumUnitsInRange(g.ejg,mx,my,250,GroupHasUnit(GetOwningPlayer(u1),g1,""))
                    UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    g.destroy()
                else
                    DestroyGroup(g1)
                    KillUnit(u2)
                    endtimer
                endif
            endif
            flush locals
        }
        flush locals
    endfunction
    
    function SpellS525(unit wu,real sx,real sy,real dam,int lv)
        unit u1 = wu
        real x2 = GetUnitX(wu) + 1000 * Cos(Pang(GetUnitX(wu),GetUnitY(wu),sx,sy))
        real y2 = GetUnitY(wu) + 1000 * Sin(Pang(GetUnitX(wu),GetUnitY(wu),sx,sy))
        real damage = dam
        int time = 2
        int dis = 150
        if  lv >= 4
            time = time + 3
        endif
        if  lv >= 2
            AddUnitStateExTimer(wu,16,15,3)
        endif
        if  GetUnitIntState(u1,'FB20') > 0
            damage = damage * 1.25
        endif

        AddUnitStateExTimer(wu,13,30,4)
        SpellS525_1(u1,x2,y2,damage,dis)
        TimerStart(0.1,true)
        {
            time = time - 1
            dis = dis + 50
            if  dis > 350
                dis = 150
            endif
            if  ModuloInteger(time,2) == 0
                SpellS525_1(u1,x2,y2,damage,dis)
            else
                SpellS525_2(u1,x2,y2,damage,dis)
            endif
            if  time <= 0
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SpellS526Timer(unit wu,real f,real dam,int level)
        unit u1 = wu
        real ang = f
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        int time = 5
        real damage = dam
        group g1 = CreateGroup()
        int lv = level
        LocAddEffectSetRotateSize(x1,y1,ang/0.01745,0.6,"effect_hero_attack5.mdl")
        TimerStart(0.05,true)
        {
            x1 = x1 + 200*Cos(ang)
            y1 = y1 + 200*Sin(ang)
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,x1,y1,250,GroupHasUnit(GetOwningPlayer(u1),g1,""))
            UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()
            LocAddEffectSetSize(x1,y1,"effect_az_tormentedsoul_t1.mdl",0.7)
            

            time = time - 1
            if  time <= 0
                DestroyGroup(g1)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    function SpellS526(unit wu,unit tu,real damage,int lv)
        if  YDWEGetUnitAbilityState(wu,'AC05', 1) == 0
            SetUnitAnimationByIndex(wu,3)
            if  lv >= 2
                YDWESetUnitAbilityDataReal( wu,'AC05', 1, 105, 4 )
                YDWESetUnitAbilityState( wu, 'AC05', 1, 3)
            else
                YDWESetUnitAbilityDataReal( wu,'AC05', 1, 105, 6 )
                YDWESetUnitAbilityState( wu, 'AC05', 1, 6)
            endif
            if  lv >= 4
                damage = damage * 1.5
            endif
            SpellS526Timer(wu,Pang(GetUnitX(wu),GetUnitY(wu),GetUnitX(tu),GetUnitY(tu)),damage,lv)
        
        endif
    endfunction
    function SpellS527(unit wu,unit tu,int lv)
        int pid = GetPlayerId(GetOwningPlayer(tu))
        real r1 = 0
        IndexGroup g
        if  wu == tu
            
            AddUnitStateExTimer(wu,1,GetUnitRealState(tu,1)*0.06,4)

            if  lv >= 2
                SetUnitState(tu,UNIT_STATE_LIFE,GetUnitState(tu,UNIT_STATE_MAX_LIFE))
                if  lv >= 4
                    AddUnitStateExTimer(tu,32,12,8)
                endif
            else
                KillUnit(tu)
            endif
            LocAddEffect(GetUnitX(tu),GetUnitY(tu),"effect_zhan.mdl")
            if  lv >=3
                g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,GetUnitX(tu),GetUnitY(tu),600,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
                UnitDamageGroup(wu,g.ejg,GetUnitAttack(wu)*12.0,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                g.destroy()
                LocAddEffectSetSize(GetUnitX(tu),GetUnitY(tu),"effect_by_wood_effect_d2_shadowfiend_shadowraze_1.mdl",3)
            endif

            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]：|r太荒唐了！"+GetPlayerName(GetOwningPlayer(wu))+"竟然自己杀自己！")
        elseif  Pu[1] == tu
            AddUnitIntState(wu,'RDAA',1)
            /*if  GetUnitIntState(wu,'RDAA') == 6
                if  DzPlayerLv(Player(pid)) >= 6
                    if  GameLevel >= 3
                        if  GetPlayerTechCount(Player(pid),'RDAA',true) == 0
                            SetDzPlayerData(pid,15,1,1)
                            SetPlayerTechResearchedEx(Player(pid),'RDAA')
                            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000果然暴君|r（永久存档）！")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000果然暴君|r，但可惜难度不够要求！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000果然暴君|r，但可惜地图等级不够要求！")
                endif
            endif*/

            AddUnitStateExTimer(wu,1,GetUnitRealState(tu,1)*0.12,8)

            if  lv >= 2
                SetUnitState(tu,UNIT_STATE_LIFE,GetUnitState(tu,UNIT_STATE_MAX_LIFE))
                if  lv >= 4
                    AddUnitStateExTimer(tu,32,24,8)
                endif
            else
                KillUnit(tu)
            endif

            LocAddEffect(GetUnitX(tu),GetUnitY(tu),"effect_zhan.mdl")

            if  lv >= 3
                g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,GetUnitX(tu),GetUnitY(tu),600,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
                UnitDamageGroup(wu,g.ejg,GetUnitAttack(wu)*12.0,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                g.destroy()
                LocAddEffectSetSize(GetUnitX(tu),GetUnitY(tu),"effect_by_wood_effect_d2_shadowfiend_shadowraze_1.mdl",3)
            endif

            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]：|r太荒唐了！"+GetPlayerName(GetOwningPlayer(wu))+"竟然斩杀了队友！")
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|CffFF0000该技能只能对队友使用。|r")
            lv = GetUnitAbilityLevel(wu,'AG05')
            UnitRemoveAbility(wu,'AG05')
            UnitAddAbility(wu,'AG05')
            SetUnitAbilityLevel(wu,'AG05',lv)
        endif
    endfunction

    function SpellS528Spell(unit wu)
        int lv = GetHeroAbilityLevel(wu,'S528')
        int ran = 50
        if  lv >= 2
            if  lv >= 4
                ran = 100
            endif
            if  GetRandomInt(1,100)<=ran
                IndexGroup g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,GetUnitX(wu),GetUnitY(wu),300,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
                UnitDamageGroup(wu,g.ejg,GetUnitAttack(wu)*12.0,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                g.destroy()
                LocAddEffectSetSize(GetUnitX(wu),GetUnitY(wu),"effect_[dz.spell]002.mdl",0.8)
            endif
        endif
    endfunction

    function SpellS529Spell(unit wu)->bool
        int lv = 0
        int cd = 0
        for pid = 0,3
            if  GetUnitTypeId(Pu[1]) == 'H029'
                if  YDWEGetUnitAbilityState(Pu[1],'AC05', 1) == 0
                    lv = GetHeroAbilityLevel(Pu[1],'S529')

                    AddUnitIntState(Pu[1],'RDAO',1)
                    if  GetUnitIntState(Pu[1],'RDAO') == 20
                        if  DzPlayerLv(Player(pid)) >= 2
                            if  GetPlayerTechCount(Player(pid),'RDAO',true) == 0
                                SetDzPlayerData(pid,15,15,15)
                                SetPlayerTechResearchedEx(Player(pid),'RDAO')
                                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000悬壶济世|r（永久存档）！")
                            endif
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000悬壶济世|r，但可惜地图等级不够要求！")
                        endif
                    endif
                    

                    ReviveHero(wu,GetUnitX(wu),GetUnitY(wu),true)
                    LocAddEffectTimer(GetUnitX(wu),GetUnitY(wu),"effect_SetItems_N4_Immortal.mdx",1.0)
                    if  lv >= 3
                        AddUnitStateExTimer(wu,9,30,5)
                        AddUnitStateExTimer(wu,19,10,5)
                    endif
                    if  lv >= 2
                        IndexGroup g = IndexGroup.create()
                        GroupEnumUnitsInRange(g.ejg,GetUnitX(Pu[1]),GetUnitY(Pu[1]),600,GroupNormalNoStr(Player(pid),"","",0))
                        UnitDamageGroup(Pu[1],g.ejg,GetUnitState(Pu[1],UNIT_STATE_MAX_LIFE)*0.6,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                        g.destroy()
                        LocAddEffectSetSize(GetUnitX(Pu[1]),GetUnitY(Pu[1]),"effect2_zhendi-yinghua.mdl",1.2)
                    endif

                    if  GetOwningPlayer(wu)==GetLocalPlayer()
                        ClearSelection()
                        SelectUnit(wu,true)
                        PanCameraToTimed(GetUnitX(wu),GetUnitY(wu),0)
                    endif
                    

                    if  lv >= 4
                        cd = 10
                    else
                        cd = 20
                    endif
                    YDWESetUnitAbilityDataReal( Pu[1],'AC05', 1, 105, cd )
                    YDWESetUnitAbilityState( Pu[1], 'AC05', 1, cd)
                    if  wu == Pu[1]
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]：|r玩家"+GetPlayerNameOfColor(pid)+"释放|cffff0000神医救世|r复活了自己！")
                    else
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]：|r玩家"+GetPlayerNameOfColor(pid)+"释放|cffff0000神医救世|r复活了队友！")
                    endif
                    return true
                endif
            endif
        end
        return false
    endfunction

    
    function SpellS531Spell(unit wu,unit tu)
        int lv = GetHeroAbilityLevel(wu,'S531')
        int jj = GetUnitIntState(wu,150)
        real damage = GetHeroStr(wu,true) * jj
        if  lv >= 4
            if  ChanceEx(wu,'S531',10) == true
                LocAddEffectSetSize(GetUnitX(tu),GetUnitY(tu),"effect_blue-guagnzhu-special.mdl",0.5)
                UnitDamageTarget(wu,tu,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            endif
        endif
    endfunction



    function SpellS532(unit wu,real damage,int lv)
        int max = 2 + GetHeroSummonNum(wu)
        real x1 = GetUnitX(wu)
        real y1 = GetUnitY(wu)

        if  lv >= 4
            max = max + 2
        endif

        for i = 1,max
            bj_lastCreatedUnit = CreateUnit(GetOwningPlayer(wu),'z104',x1,y1,0)
            
            SetUnitRealState(bj_lastCreatedUnit,3,GetUnitRealState(wu,3)*0.5)

            if  lv >= 2
                SetUnitRealState(bj_lastCreatedUnit,5,GetUnitRealState(wu,5)*3)

            else
                SetUnitRealState(bj_lastCreatedUnit,5,GetUnitRealState(wu,5))
            endif


            if  lv >= 3
                SetUnitRealState(bj_lastCreatedUnit,1,damage*1.5)
                UnitAddAbility(bj_lastCreatedUnit,'A005')
            else
                SetUnitRealState(bj_lastCreatedUnit,1,damage)
            endif
            SetUnitRealState(bj_lastCreatedUnit,15,GetUnitRealState(wu,15))
            SetUnitRealState(bj_lastCreatedUnit,17,GetUnitRealState(wu,17))
            SetUnitRealState(bj_lastCreatedUnit,19,GetUnitRealState(wu,19))
            SetUnitRealState(bj_lastCreatedUnit,20,GetUnitRealState(wu,20))

            
            if  GetUnitIntState(wu,'FB33') > 0 or GetUnitIntState(wu,'FF33') > 0
                SetUnitRealState(bj_lastCreatedUnit,18,40)
            endif
            UnitApplyTimedLife(bj_lastCreatedUnit,'BHwe',3)
            bj_lastCreatedUnit = null
        end
        
        
    endfunction

    function SpellS533Damage(unit wu,real damage,int lv)
        real x1 = GetUnitX(wu)
        real y1 = GetUnitY(wu)
        LocAddEffectSetSize(x1,y1,"effect_tx_new (3).mdl",0.5)
        IndexGroup g = IndexGroup.create()
        if  lv >= 2
            GroupEnumUnitsInRange(g.ejg,x1,y1,600,GroupNormalNoStrAddBuff(GetOwningPlayer(wu),"",Buffjs,11,0))
        else
            GroupEnumUnitsInRange(g.ejg,x1,y1,600,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
        endif
        UnitDamageGroup(wu,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
    endfunction

    function SpellS533(unit wu,real dam,int level)
        unit u1 = wu
        int lv = level
        real damage = dam
        int time = 1
        if  lv >= 4
            time = time + 2
        endif
        SpellS533Damage(u1,damage,lv)
        TimerStart(0.3,true)
        {
            
            time = time - 1
            if  time >= 0
                SpellS533Damage(u1,damage,lv)
            else
                if  GetUnitIntState(u1,'FB07') > 0
                    SpellS501_4(u1,GetUnitX(u1),GetUnitY(u1),GetUnitAttack(u1)*7)
                endif
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction


    function SpellS534Timer(unit wu,real sx,real sy,real dam,int lv)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        real damage = dam
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"units\\nightelf\\MountainGiant\\MountainGiant.mdl",x1,y1,270,0,0.3)
        int level = lv
        int time = 0
        TimerStart(0.05,true)
        {
            time = time + 1
            SetUnitScale(u2,0.3 + I2R(time)*0.04 ,0.3 + I2R(time)*0.02,0.3 + I2R(time)*0.04)
            SetUnitVertexColor(u2,255,255-time*10,255-time*10,255)

            if  time >= 20

                LocAddEffect(x1,y1,"effect_fire-boom-new.mdl")
                IndexGroup g = IndexGroup.create()
                if  level >= 3
                    GroupEnumUnitsInRange(g.ejg,x1,y1,1000,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffxy,1,0))
                else
                    GroupEnumUnitsInRange(g.ejg,x1,y1,1000,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                endif
                UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                g.destroy()

                RemoveUnit(u2)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SpellS534(unit wu,real sx,real sy,real damage,int lv)

        int max = 2 + GetHeroSummonNum(wu)
        

        if  GetUnitIntState(wu,'FB39') > 0
            max = max + 1
        endif

        if  lv >= 4
            max = max + 1
        endif

        if  lv >= 2
            damage = damage * 1.4
        endif

        real ang = 0
        real dis = 0
        for i = 1,max
            ang = GetRandomReal(-3.14,3.14)
            dis = GetRandomReal(-300,300)
            SpellS534Timer(wu,sx+dis*Cos(ang),sy+dis*Sin(ang),damage,lv)
        end
    endfunction





    function SpellS535Timer(unit wu,real a,real dam)
        unit u1 = wu
        real x1 = GetUnitX(wu)
        real y1 = GetUnitY(wu)
        real ang = a
        unit u2 = CreateTmUnit(GetOwningPlayer(u1),"effect_tx_asad (23).mdl",x1,y1,ang/0.01745,50,1.0)
        int time = 16
        group g1 = CreateGroup()
        real damage = dam
        int num = GetUnitIntState(wu,'S534')
        if  num == 6
            SetUnitIntState(wu,'S534',0)
        else
            SetUnitIntState(wu,'S534',num+1)
        endif

        TimerStart(0.03,true)
        {
            
            time = time - 1

            x1 = x1 + 50 * Cos(ang)
            y1 = y1 + 50 * Sin(ang)
            SetUnitX(u2,x1)
            SetUnitY(u2,y1)
            IndexGroup g = IndexGroup.create()
            if  num == 6
                GroupEnumUnitsInRange(g.ejg,x1,y1,150,GroupHasUnitAddBuff(GetOwningPlayer(u1),g1,"",Buffxy,1,0))
            else
                GroupEnumUnitsInRange(g.ejg,x1,y1,150,GroupHasUnit(GetOwningPlayer(u1),g1,""))
            endif
            UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()

            if  time <= 0
                KillUnit(u2)    
                GroupClear(g1)
                DestroyGroup(g1)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SpellS535Num(unit wu,unit tu,real dam,int num)
        unit u1 = wu
        unit u2 = tu
        real damage = dam
        int time = num-1
        real ang = Uang(wu,tu)
        SpellS535Timer(u1,ang,damage)
        TimerStart(0.3,true)
        {
            SpellS535Timer(u1,ang,damage)
            time = time - 1
            if  time <= 0
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    function SpellS535(unit wu,unit tu,real dam,int lv)

        int num = GetUnitIntState(wu,'S535') + GetUnitAttackNumb(wu)
        int use = 16
        int max = 1

        if  lv >= 4
            max = 4
        elseif  lv >= 3
            max = 2
        endif
        if  lv >= 2
            use = 12
        endif

        if  IsHasHeroType('H002') == true
            dam = dam * 1.25
        endif

        
        if  num >= use
            SetUnitIntState(wu,'S535',0)
            if  max > 1
                SpellS535Num(wu,tu,dam,max)
            else
                SpellS535Timer(wu,Uang(wu,tu),dam)


            endif

        else
            SetUnitIntState(wu,'S535',num)
        endif

    endfunction



    function SpellS536TimerFunc(unit wu,real sx,real sy,real face,real dam)
        real x1 = sx
        real y1 = sy
        real ang = face
        unit u1 = wu
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"effect_dummy_dawn_bird_00.mdl",x1,y1,ang/0.01745-90,60,1.2)
        int time = 20
        real damage = dam
        group g1 = CreateGroup()
        int Type = 0
        SetUnitPropWindow( u2, 6.26 )
        SetUnitTurnSpeed( u2, GetRandomReal(0.05,0.08))
        TimerStart(0.03,true)
        {
            time = time - 1

            if  Type == 1
                SetUnitFacing(u2,Uang(u2,u1)/0.01745-90)
                ang = (GetUnitFacing(u2)+90)*0.01745
            endif

            x1 = x1 + 40*Cos(ang)
            y1 = y1 + 40*Sin(ang)
            SetUnitX(u2,x1)
            SetUnitY(u2,y1)
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,x1,y1,200,GroupHasUnitAddBuff(GetOwningPlayer(u1),g1,"effect_az_goods_blink(3).mdl",Buffxy,1,0))
            UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()

            if  time <= 0
                Type = 1
            endif

            if  Type == 1 and Udis(u2,u1) < 100
                RemoveUnit(u2)
                DestroyGroup(g1)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SpellS536Timer(unit wu,real sx,real sy)
        unit u1 = wu
        real damage = (GetUnitAttack(wu) + GetHeroStr(wu,true))*3.0 / 5
        real x1 = GetUnitX(wu)
        real y1 = GetUnitY(wu)
        real ang = Pang(x1,y1,sx,sy)
        int time = 5
        

        TimerStart(0.1,true)
        {
            time = time - 1

            real dis = GetRandomReal(-200,200)
            real f = GetRandomReal(-3.14,3.14)
            SpellS536TimerFunc(u1,x1+dis*Cos(f),y1+dis*Sin(f),ang,damage)

            if  time <= 0
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction


    function SpellS536(unit wu,real sx,real sy,real damage,int lv)

        if  IsHasHeroType('H037') == true
            damage = damage * 1.3
            BJDebugMsg("伤害+30%")
        endif


        LocAddEffectSetRotateSize(sx+50,sy,0,2,"effect_193.mdx")
        LocAddEffectSetRotateSize(sx+50*Cos(2.094),sy+50*Sin(2.094),120,2,"effect_193.mdx")
        LocAddEffectSetRotateSize(sx+50*Cos(4.188),sy+50*Sin(4.188),240,2,"effect_193.mdx")

        LocAddEffect(sx,sy,"effect_AA_bwaxec.mdl")

        
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,sx,sy,500,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
        UnitDamageGroup(wu,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()

        if  lv >= 2
            AddUnitRealStateTimer(wu,13,30,3)
        endif
        if  lv >= 3
            UnitAddLife(wu,GetUnitState(wu,UNIT_STATE_MAX_LIFE)*0.06)
        endif

        AddUnitIntState(wu,'S536',1)
    endfunction


    function SpellS537Boom(unit wu,int lv)
        unit uu = null
        real damage = 0
        LocAddEffect(GetUnitX(wu),GetUnitY(wu),"effect_fire-boom-new.mdl")
        IndexGroup g = IndexGroup.create()
        if  lv >= 3
            GroupEnumUnitsInRange(g.ejg,GetUnitX(wu),GetUnitY(wu),700,GroupNormalNoStrAddBuff(GetOwningPlayer(wu),"",Buffxy,1,0))
        else
            GroupEnumUnitsInRange(g.ejg,GetUnitX(wu),GetUnitY(wu),700,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
        endif
        loop
            uu = FirstOfGroup(g.ejg)
            exitwhen uu == null
            damage = GetUnitState(uu,UNIT_STATE_LIFE)*0.05
            UnitDamageTarget(wu,uu,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNKNOWN,null)
            GroupRemoveUnit(g.ejg,uu)
        endloop
        g.destroy()
        flush locals
    endfunction

    function SpellS537(unit wu,real dam,int level)
        unit u1 = wu
        int lv = level 
        int time = 4
        int num = GetUnitIntState(wu,'S537')
        real damage = dam / 4
        real size = 1.0 + I2R(num+1) * 0.2

        if  IsHasHeroType('H036') == true
            damage = damage * 1.3
            BJDebugMsg("伤害+30%")
        endif

        if  num == 5
            SetUnitIntState(wu,'S537',0)
            SetUnitScale(wu,1,1,1)
            SpellS537Boom(wu,lv)
        else
            SetUnitIntState(wu,'S537',num+1)
            SetUnitScale(wu,size,size,size)
        endif
        
            
        hyred(CreateTmUnit(GetOwningPlayer(wu),YDWEGetObjectPropertyString(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(wu),"file"),GetUnitX(wu),GetUnitY(wu),GetUnitFacing(wu),0,1))
        

        TimerStart(1,true)

        {
            real sx = GetUnitX(u1)
            real sy = GetUnitY(u1)
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,sx,sy,700,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()

            LocAddEffect(sx+300,sy,"effect2_az_magina[2]_v.mdl")
            LocAddEffect(sx+300*Cos(1.2564),sy+300*Sin(1.2564),"effect2_az_magina[2]_v.mdl")
            LocAddEffect(sx+300*Cos(2.5128),sy+300*Sin(2.5128),"effect2_az_magina[2]_v.mdl")
            LocAddEffect(sx+300*Cos(3.7692),sy+300*Sin(3.7692),"effect2_az_magina[2]_v.mdl")
            LocAddEffect(sx+300*Cos(5.0256),sy+300*Sin(5.0256),"effect2_az_magina[2]_v.mdl")
            

            time = time - 1 

            if  time <= 0
                endtimer
            endif
            flush locals
        }
        flush locals
        

    endfunction

    function SpellS538(unit wu,real damage,int lv)
        int max = 1 + GetHeroSummonNum(wu)
        real x1 = GetUnitX(wu)
        real y1 = GetUnitY(wu)

        real add = GetUnitAttack(wu)

        for i = 1,max
            bj_lastCreatedUnit = CreateUnit(GetOwningPlayer(wu),'z107',x1,y1,0)
            
            
            SetUnitRealState(bj_lastCreatedUnit,3,GetUnitRealState(wu,3)*0.5)
            


            if  lv >= 2
                SetUnitRealState(bj_lastCreatedUnit,18,20)
            endif
   

            if  lv >= 3
                SetUnitRealState(bj_lastCreatedUnit,1,damage+add)
                UnitAddAbility(bj_lastCreatedUnit,'A00I')
            else
                SetUnitRealState(bj_lastCreatedUnit,1,damage)
            endif
            if  lv >= 4
                UnitAddAbility(bj_lastCreatedUnit,'A00J')
                SetUnitRealState(bj_lastCreatedUnit,5,GetUnitRealState(wu,5)*2)
            else
                SetUnitRealState(bj_lastCreatedUnit,5,GetUnitRealState(wu,5))
            endif

            SetUnitRealState(bj_lastCreatedUnit,15,GetUnitRealState(wu,15))
            SetUnitRealState(bj_lastCreatedUnit,17,GetUnitRealState(wu,17))
            SetUnitRealState(bj_lastCreatedUnit,19,GetUnitRealState(wu,19))
            SetUnitRealState(bj_lastCreatedUnit,20,GetUnitRealState(wu,20))

            
            if  GetUnitIntState(wu,'FB49') > 0
                SetUnitState(bj_lastCreatedUnit, ConvertUnitState(0x25), GetUnitState(bj_lastCreatedUnit, ConvertUnitState(0x25)) - 0.1)
            endif

            UnitApplyTimedLife(bj_lastCreatedUnit,'BHwe',4)
            bj_lastCreatedUnit = null
        end
        
        
    endfunction


    function SpellS539(unit wu,real damage,int lv)
        if  YDWEGetUnitAbilityState(wu,'AC05', 1) == 0
            YDWESetUnitAbilityDataReal( wu,'AC05', 1, 105, 8 )
            YDWESetUnitAbilityState( wu, 'AC05', 1, 8)

            
            if  lv >= 3
                if  GetUnitIntState(wu,'S539') == 0
                    AddUnitIntStateTimer(wu,'S539',1,6)
                endif
            endif

            if  GetUnitIntState(wu,'S539') > 0
                damage = damage * 1.4
            endif


            real sx = GetUnitX(wu)
            real sy = GetUnitY(wu)
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,sx,sy,700,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
            UnitDamageGroup(wu,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()

            LocAddEffectSetSize(sx,sy,"effect_hero_grandmagus_n1s_z_down.mdl",2.0)
            LocAddEffectSetSize(sx,sy,"effect_hero_grandmagus_n1s_z_down.mdl",2.0)
            LocAddEffectSetSize(sx,sy,"effect_hero_grandmagus_n1s_z_down.mdl",2.0)


            UnitAddLife(wu,GetUnitState(wu,UNIT_STATE_MAX_LIFE)*0.07)
        endif
    endfunction


    real S540X = 0
    real S540Y = 0
    real S540R = 0
    group S540G = null

    function SpellS540ForGroup()
        real x = GetUnitX(GetEnumUnit())
        real y = GetUnitY(GetEnumUnit())
        real dis = Pdis(S540X,S540Y,x,y)
        real ang = 0
        if  dis >= S540R
            ang = Pang(S540X,S540Y,x,y)
            real x2 = S540X+(S540R)*Cos(ang)
            real y2 = S540Y+(S540R)*Sin(ang)
            if  IsCanFlyTerrain(x2,y2) == true
                SetUnitX(GetEnumUnit(),x2)
                SetUnitY(GetEnumUnit(),y2)
            else
                GroupRemoveUnit(S540G,GetEnumUnit())
            endif
        endif
    endfunction

    function SpellS540(unit wu,real sx,real sy,real dam,int level)
        unit u1 = wu
        effect eff1 = AddSpecialEffect("effect_S540.mdl",sx,sy)
        effect eff2 = AddSpecialEffect("effect_S540.mdl",sx,sy)
        effect eff3 = AddSpecialEffect("effect_S540.mdl",sx,sy)
        real x1 = sx
        real y1 = sy
        int time = 500
        real damage = dam
        int lv = level
        group g1 = CreateGroup()
        EXEffectMatScale(eff1,1.0,1.0, 1.2 )
        EXEffectMatScale(eff2,1.0,1.0, 1.2 )
        EXEffectMatScale(eff3,1.0,1.0, 1.2 )
        LocAddEffectSetSize(x1,y1,"effect2_by_wood_effect2_war3_shuangdongxinxing.mdl",2)
        LocAddEffectSetSizeAndZ(x1,y1,200,"effect2_by_wood_effect2_war3_shuangdongxinxing.mdl",1.6)
        if  lv >= 2
            damage = damage * 1.4
        endif

        TimerStart(0.01,true)
        {
            time = time - 1
            IndexGroup g = IndexGroup.create()
            real rac = I2R(time) * 4 - 1400

            if  rac < 200
                rac = 200
            endif

            EXEffectMatReset(eff1)
            EXEffectMatScale(eff1,rac/600,rac/600, 1.2 )
            EXEffectMatReset(eff2)
            EXEffectMatScale(eff2,rac/600,rac/600, 1.2 )
            EXEffectMatReset(eff3)
            EXEffectMatScale(eff3,rac/600,rac/600, 1.2 )

            S540R = rac-50
            S540X = x1
            S540Y = y1
            
            GroupEnumUnitsInRange(g.ejg,x1,y1,rac,GroupHasUnit(GetOwningPlayer(u1),g1,""))
            GroupAddGroup(g.ejg,g1)
            S540G = g1
            ForGroup(g1,function SpellS540ForGroup)
            S540G = null
            
            if  ModuloInteger(time,30) == 0
                GroupClear(g.ejg)
                GroupAddGroup(g1,g.ejg)
                UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                
            endif
            g.destroy()

            
            
            

            if  time <= 0
                if  lv >= 3
                    g = IndexGroup.create()
                    GroupEnumUnitsInRange(g.ejg,x1,y1,600,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                    if  lv >= 4
                        UnitDamageGroup(u1,g.ejg,GetHeroStr(u1,true)*12,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    else
                        UnitDamageGroup(u1,g.ejg,GetHeroStr(u1,true)*6,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    endif
                    LocAddEffectSetSize(x1,y1,"effect2_az_magina[2]_v.mdl",2.0)
                    g.destroy()

                endif
                DestroyEffect(eff1)
                DestroyEffect(eff2)
                DestroyEffect(eff3)
                DestroyGroup(g1)
                endtimer
            else
                if  ModuloInteger(time,120) == 0
                    LocAddEffectSetSize(x1,y1,"effect2_by_wood_effect2_war3_shuangdongxinxing.mdl",0.6*(rac/200))
                    LocAddEffectSetSizeAndZ(x1,y1,200,"effect2_by_wood_effect2_war3_shuangdongxinxing.mdl",0.6*(rac/200)*0.8)
                endif
            endif
            flush locals
        }
        flush locals

    endfunction
    function SpellS541_2(unit wu)
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)

        TimerStart(0.3,false)
        {
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,x1,y1,600,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,GetUnitAttack(u1)*8,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()
            LocAddEffectSetSize(x1,y1,"effect_az_tormentedsoul_t1.mdl",2)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    //大地坠击
    function SpellS541(unit wu,real x,real y,real dam,int level)
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real ang = Atan2(y-y1,x-x1)
        real dis = Pdis(x1,y1,x,y)
        
        real sp = dis/50

        real x2 = sp*Cos(ang)
        real y2 = sp*Sin(ang)
        real time = 0
        real height = dis
        real damage = dam
        int lv = level

        int num = 0
        if  lv >= 4
            num = 3
        elseif  lv >= 2
            num = 1
        endif

        if  height < 800
            height = 800
        endif
        
        SetUnitFacing(u1,ang/0.01745)
        EXSetUnitFacing(u1,ang/0.01745)

        TimerStart(0.01,true)
        {
            unit uu = null
            int uid = 0
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
                SetUnitFlyHeight(u1,0,0)
                UnitRemoveAbility(u1,'Arav')
                SetUnitFacing(u1,ang/0.01745)
                EXSetUnitFacing(u1,ang/0.01745)
                
                LocAddEffect(GetUnitX(u1),GetUnitY(u1),"effect_fire-boom-new.mdl")
                LocAddEffect(GetUnitX(u1),GetUnitY(u1),"effect_AA_bwaxec.mdl")
                
               
                

                CameraSetTargetNoiseTimer(GetPlayerId(GetOwningPlayer(u1)),8,1,0.2)

                
                
                IndexGroup gg = IndexGroup.create()
                GroupEnumUnitsInRange(gg.ejg,GetUnitX(u1),GetUnitY(u1),600,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffxy,1,0))
                loop
                    uu = FirstOfGroup(gg.ejg)
                    exitwhen uu == null
                    uid = GetUnitTypeId(uu)
                    if  (uid >= 'm001' and uid <= 'm099') or (uid >= 'g00A' and uid <= 'g00E')
                        UnitDamageTarget(u1,uu,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    elseif  lv >= 3
                        UnitDamageTarget(u1,uu,damage,true,true,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WOOD_MEDIUM_STAB )
                    else
                        UnitDamageTarget(u1,uu,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    endif
                    
                    GroupRemoveUnit(gg.ejg,uu)
                endloop
                
                
                                   
                gg.destroy()

                if  num > 0
                    num = num - 1
                    dis = 30
                    x2 = 0
                    y2 = 0
                    time = 0
                    sp = 1
                    height = 300
                endif
                
            endif

            if  time >= dis
                if  GetUnitIntState(u1,'FB38') > 0 or GetUnitIntState(u1,'FF38') > 0
                    SpellS541_2(u1)
                endif
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction 


    


    //哔哔第一名
    function SpellS542Func(unit wu,real x,real y,real dam,int level)
        unit u1 = wu
        real x1 = x
        real y1 = y
        real damage = dam
        int time = 8
        int lv = level
        real face = GetRandomReal(1,360)
        unit u2=CreateTmUnit(GetOwningPlayer(u1),"H042.mdx",x-300*Cos(face*0.01745),y-300*Sin(face*0.01745),face,0,1.5)
        SetUnitAnimation( u2, "spell" )
        SetUnitVertexColor( u2, 20, 20, 50, 100 )
        TimerStart(0.5,true)
        {
            SetUnitAnimation( u2, "spell" )
            time = time - 1
            LocAddEffect(x1,y1,"effect2_az2_az_xiaonajia01_d.mdl")
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,x1,y1,300,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()
            if  time <= 0
                RemoveUnit(u2)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SpellS542(unit wu,real x,real y,real damage,int lv)
        real x1 = x
        real y1 = y
        int num = GetUnitIntState(wu,'S542') + GetUnitAttackNumb(wu)
        int use = 16
        real dis = 0
        real ang = 0

        if  num >= use
            SetUnitIntState(wu,'S542',0)
            
            int max = 1 + GetHeroSummonNum(wu)
            if  lv >= 3
                max = max + 1
            endif
            if  lv >= 4
                damage = damage * 2
            endif
            
            for i = 1,max
                if  max != 1
                    dis = GetRandomReal(0,300)
                    ang = GetRandomReal(-3.14,3.14)

                    x1 = x + dis * Cos(ang)
                    y1 = y + dis * Sin(ang)
                endif
                SpellS542Func(wu,x1,y1,damage,lv)
            end
            
        else
            SetUnitIntState(wu,'S542',num)
        endif

        
    endfunction



endlibrary
