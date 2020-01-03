library HeroAbilityFunc2 uses OtherDamageTimer
    
    function SpellS501_0(unit u1,real sx,real sy,real dam)
        
        unit wu = u1
        real x1 = GetUnitX(wu)
        real y1 = GetUnitY(wu)
        real ang = Pang(x1,y1,sx,sy)
        real damage = dam
        
        EXSetUnitFacing( wu, ang/0.01745 )
        SetUnitFacing(wu,ang/0.01745)
        
        TimerStart(0.2,false)
        {
            IndexGroup g = IndexGroup.create()
            x1 = x1 + 50*Cos(ang)
            y1 = y1 + 50*Sin(ang)
            LocAddEffectSetSize(x1,y1,"effect_az_pafeathermoon_b.mdl",4)
            GroupEnumUnitsInRange(g.ejg,x1,y1,400,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
            UnitDamageGroup(wu,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()
            flush locals
        }
        flush locals
    endfunction
    function SpellS501_1(unit u1,real sx,real sy,real dam)
        unit wu = u1
        real x1 = GetUnitX(wu)
        real y1 = GetUnitY(wu)
        real ang = Pang(x1,y1,sx,sy)
        real damage = dam
        
        EXSetUnitFacing( wu, ang/0.01745 )
        SetUnitFacing(wu,ang/0.01745)
        
        TimerStart(0.2,false)
        {
            IndexGroup g = IndexGroup.create()
            LocAddEffectSetSize(x1,y1,"effect_shengguang.mdl",4)
            
            GroupEnumUnitsInRange(g.ejg,x1,y1,400,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
            UnitDamageGroup(wu,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            g.destroy()
            flush locals
        }
        flush locals
    endfunction
    function SpellS501_3(unit wu,real sx,real sy,real sa)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        real x2 = GetUnitX(u1)
        real y2 = GetUnitY(u1)
        real ang = sa
        int alpha = 200
        SetUnitVertexColor(u1,255,255,255,200)
        SetUnitAnimationByIndex(wu,3)
        TimerStart(0.03,true)
        {
            real dis = Pow(Pow(x1-x2,2)+Pow(y1-y2,2),0.5)
            alpha = alpha - 25
            
            
            if  alpha > 0 and dis > 30
                x2 = x2 + 8 * Cos(ang)
                y2 = y2 + 8 * Sin(ang)
                SetUnitVertexColor(u1,255,255,255,alpha)
                SetUnitX(u1,x2)
                SetUnitY(u1,y2)
            else
                RemoveUnit(u1)
                endtimer
            endif
            
            flush locals
        }
        flush locals
    endfunction
    function SpellS501_2(unit wu,real sx,real sy,real damage)
        unit u1 = wu
        real x2 = sx
        real y2 = sy
        real x1 = GetUnitX(wu)
        real y1 = GetUnitY(wu)
        real ang = Pang(x1,y1,sx,sy)
        int time = 0
        EXSetUnitCollisionType( false,u1, 1 )
        SetUnitPathing( u1, false )
        
        SetUnitPosition(u1,x1,y1)
        
        TimerStart(0.03,true)
        {
            time = time + 1
            if  time <= 15
                if  time - (time / 4) * 4 == 0
                    real size = YDWEGetObjectPropertyReal(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(u1),"modelScale")
                    SpellS501_3(CreateTmUnit(GetOwningPlayer(u1), YDWEGetObjectPropertyString(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(u1),"file"),x1,y1,GetUnitFacing(u1),0,size),x1+120*Cos(ang),y1+120*Sin(ang),ang)
                    
                endif
                x1 = x1 + 30 * Cos(ang)
                y1 = y1 + 30 * Sin(ang)
                SetUnitPosition(u1,x1,y1)
                EXSetUnitFacing( u1, ang/0.01745 )
                SetUnitFacing(u1,ang/0.01745)
                
            else
                EXSetUnitCollisionType( true,u1, 1 )
                SetUnitPathing( u1, true )
                SetUnitAnimation(u1,"stand")
                endtimer
            endif
            flush locals
        }
        flush locals
        
    endfunction
    function SpellS501(unit wu,real x,real y,real dam)
        
        real x1 = x
        real y1 = y
        real damage = dam
        int index = GetUnitIntState(wu,'S501')
        
        SetUnitPosition(wu,GetUnitX(wu),GetUnitY(wu))
        if  index == 0
            SpellS501_2(wu,x1,y1,damage)
            SetUnitIntState(wu,'S501',index+1)
            SetAbilityCD_AG(wu,'AG05',0.5 )
            SetUnitAnimationByIndex(wu,3)
        elseif  index == 1
            SpellS501_0(wu,x1,y1,damage)
            SetUnitIntState(wu,'S501',index+1)
            SetAbilityCD_AG(wu,'AG05',0.2)
            SetUnitAnimationByIndex(wu,4)
        elseif  index == 2
            SpellS501_1(wu,x1,y1,damage)
            SetUnitIntState(wu,'S501',0)
            SetUnitAnimationByIndex(wu,8)
            SetAbilityCD_AG(wu,'AG05',10)
        endif

        flush locals
    endfunction
    
    
    function SpellS502_2(unit wu,unit tu,real dam)
        unit u1 = wu
        unit u2 = tu
        real x1 = GetUnitX(wu)
        real y1 = GetUnitY(wu)
        unit u3 = CreateTmUnit(GetOwningPlayer(wu),"effect_dark-xuanfen.mdl",x1,y1,GetUnitFacing(u1),0,1.3)
        real damage = dam
        int num = 2 + R2I(GetUnitRealState(u1,9)+1)/10000
        
        effect eff = AddSpecialEffect("effect_by_wood_quanhuang_bashenanzhuazi2.mdl",x1,y1)
        EXEffectMatRotateZ( eff, GetRandomReal(1,360) )
        
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
                
                
            else
                RemoveUnit(u3)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    function SpellS502(unit wu,unit tu,real dam)
        unit u1 = wu
        unit u2 = tu
        real damage = dam
        real x1 = GetUnitX(wu)
        real y1 = GetUnitY(wu)
        real ang = Uang(u1,u2)
        real size = YDWEGetObjectPropertyReal(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(u1),"modelScale")
        EXSetUnitFacing( u1, ang/0.01745 )
        SetUnitFacing(u1,ang/0.01745)
        unit u3 = CreateTmUnit(GetOwningPlayer(wu),"effect_az_chongfeng.mdl",x1,y1,GetUnitFacing(u1),0,1.3)
        SetUnitScale(u1,0.001,0.001,0.001)
        TimerStart(0.03,true)
        {
            real dis = Udis(u1,u2)
            ang = Uang(u1,u2)
            if  dis > 50
                x1 = x1 + 30 * Cos(ang)
                y1 = y1 + 30 * Sin(ang)
                SetUnitX(u1,x1)
                SetUnitX(u3,x1)
                SetUnitY(u1,y1)
                SetUnitY(u3,y1)
                SetUnitFacing(u1,ang/0.01745)
                SetUnitFacing(u3,ang/0.01745)
            else
                SpellS502_2(u1,u2,damage)
                SetUnitScale(u1,size,size,size)
                RemoveUnit(u3)
                endtimer
            endif
            
            flush locals
        }
        flush locals
    endfunction


    function SpellS503(unit wu)
        unit u1 = wu
        real damage = GetAbilityDamage(wu,'S503',1)
        real x = GetUnitX(wu)
        real y = GetUnitY(wu)
        LocAddEffectSetSize(x,y,"effect_tx_asad (24).mdl",1.8)
        TimerStart(0.5,false)
        {
            IndexGroup g = IndexGroup.create()
            GroupEnumUnitsInRange(g.ejg,x,y,600,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
            UnitDamageGroup(u1,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)

            LocAddEffectSetSize(x,y,"effect_tx_asad (25).mdl",1.8)

            g.destroy()
            endtimer

            flush locals
        }
        flush locals
        
    endfunction
    function SpellS503Select(real x,real y)
        for pid = 0,3
            if  GetUnitTypeId(Pu[1]) == 'H003'
                if  IsUnitInRangeXY(Pu[1], x, y, 600) == true
                    SpellS503(Pu[1])
                endif
            endif
        end
    endfunction
    function SpellS504_2(unit wu,real x,real y,real face,real dam)
        unit u1 = wu
        real x1 = x
        real y1 = y
        real ang = face-0.4
        real damage = dam
        int time = 4
        EXSetUnitFacing( u1, ang/0.01745 )
        SetUnitFacing(u1,ang/0.01745)
        SetUnitAnimationByIndex(u1,2)
        TimerStart(0.2,true)
        {
            
            time = time - 1
            if  time >= 1

                LocAddEffectTimerOrSize(x1,y1,ang/0.01745,"effect_az_caster_Red.mdl",0,1.8)
                CreateTmFunc(u1,CreateTmUnit(GetOwningPlayer(u1),"effect_[dz.spell]004Red.mdl",x1,y1,ang/0.01745,75,1),ang,damage,200,600,75,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
                SetUnitAnimationByIndex(u1,2)
                if  time == 1
                    if  GetUnitBjState(u1)<30
                        time = 0
                    endif
                endif
            else
                
                ang = ang - 0.8
                CreateTmFunc(u1,CreateTmUnit(GetOwningPlayer(u1),"effect_[dz.spell]004Red.mdl",x1,y1,ang/0.01745,75,1.5),ang,damage*4,300,900,75,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
            endif
            SetUnitPosition(u1,x1,y1)
            EXSetUnitFacing( u1, ang/0.01745 )
            SetUnitFacing(u1,ang/0.01745)
            ang = ang + 0.4
            if  time <= 0
                //伤害来源,马甲,方向,伤害,伤害范围,最远距离,移动时间间隔,马甲高度,伤害类型4个
                SetUnitAnimation(u1,"stand")
                endtimer
            endif
            flush locals
        }
        flush locals

    endfunction
    function SpellS504(unit wu,real sx,real sy,real dam)
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = sx
        real y2 = sy
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"effect_red-daoguang-new.mdl",x1,y1,GetUnitFacing(u1),0,1.0)
        real ang = Pang(x1,y1,x2,y2)
        group g1 = CreateGroup()
        real damage = dam
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
            
            
            if  Pdis(x1,y1,x2,y2) > 50
                x1 = x1 + 50 * Cos(ang)
                y1 = y1 + 50 * Sin(ang)
                SetUnitPosition(u1,x1,y1)
                SetUnitPosition(u2,x1+50*Cos(ang),y1+50*Sin(ang))
                IndexGroup g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,x1,y1,250,GroupHasUnit(GetOwningPlayer(u1),g1,""))
                UnitDamageGroup(u1,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
                g.destroy()
            else
                EXSetUnitCollisionType( true,u1, 1 )
                SetUnitPathing( u1, true )
                SetUnitAnimation(u1,"stand")
                DestroyGroup(g1)
                SpellS504_2(u1,x1,y1,ang,damage)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SpellS506(unit wu,unit tu)
        if  GetUnitState(tu,UNIT_STATE_LIFE)/GetUnitState(tu,UNIT_STATE_MAX_LIFE) <= 0.15
            LocAddEffectTimerOrSize(GetUnitX(tu),GetUnitY(tu),Uang(wu,tu)/0.01745+20,"effect_hero_attack2.mdl",0,0.7)
            LocAddEffect(GetUnitX(tu),GetUnitY(tu),"effect_zhan.mdl")
            BJDebugMsg(GetUnitName(tu)+R2S(GetUnitState(tu,UNIT_STATE_LIFE)))
            UnitDamageTarget(wu,tu,99999999,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,null)
            
        endif
    endfunction

    function SpellS508(unit wu)
        int num = 0
        real damage = 0
        if  GetUnitTypeId(wu) == 'H008'
            num = GetUnitIntState(wu,'S508')
            if  num < 7
                AddUnitRealState(wu,9,10)
                SetUnitIntState(wu,'S508',num + 1)
            else
                damage = GetAbilityDamage(wu,'S508',1)
                AddUnitRealState(wu,9,-60)
                SetUnitIntState(wu,'S508',0)
                
                IndexGroup g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,GetUnitX(wu),GetUnitY(wu),350,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
                UnitDamageGroup(wu,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
                LocAddEffect(GetUnitX(wu),GetUnitY(wu),"effect_az_earthshaker_a.mdl")
                g.destroy()
            endif
        endif
    endfunction

    function SpellS511Spell(unit wu)->bool
        int num = 0
        if  GetUnitTypeId(wu) == 'H011'
            if  GetRandomInt(1,100)<= 50
                num = GetUnitIntState(wu,'S511')
                if  num < 75
                    AddUnitRealState(wu,15,2)
                    AddUnitRealState(wu,16,2)
                    SetUnitIntState(wu,'S511',num+1)
                endif
                BJDebugMsg("命途多舛 成功")
                return true
            else
                BJDebugMsg("命途多舛 失败")
                return false
            endif
        else
            return true
        endif
    endfunction
    function SpellS512(unit wu,real sx,real sy,real dam)
        unit u1 = wu
        real x1 = sx
        real y1 = sy
        real damage = dam
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),"effect_GF2_TALOU.mdl",x1,y1,0,1500,2)
        int time = 0
        if  GetUnitBjState(u1)>=30
            damage = damage * 2
        endif
        LocAddEffectSetSize(x1,y1,"effect_yellow-guangzhu-new2.mdl",3)
        SetUnitFlyHeight(u2,0,5000.00)
        TimerStart(0.3,true)
        {
            time = time + 1
            if  time == 1
                IndexGroup g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,x1,y1,280,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                UnitDamageGroup(u1,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
                BJDebugMsg("damage"+R2S(damage))
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
            if  Pu[63] != null
                return true
            endif
        endif
        return false
    endfunction
    function SpellS513(unit wu,real sx,real sy)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        if  Pu[63] != null
            RemoveUnit(Pu[63])
        endif
        BJDebugMsg("createm")
        Pu[63] = CreateTmUnit(GetOwningPlayer(wu),YDWEGetObjectPropertyString(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(wu),"file"),sx,sy,0,0,YDWEGetObjectPropertyReal(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(wu),"modelScale"))
        SetUnitVertexColor(Pu[63],255,255,255,180)
        UnitAddEffect(Pu[63],"Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl")
        UnitApplyTimedLife(Pu[63], 'BHwe', 6 )
    endfunction

    function SpellS514(unit wu,real damage)
        real x = GetUnitX(wu)
        real y = GetUnitY(wu)
        LocAddEffectSetSize(x,y,"effect_az-ice-zhendi.mdl",2.0)
        AddEffectInAreaSetSize(x,y,500,1.0,10,"effect_hero_lich_n1s_bingdong2.mdl")
        IndexGroup g = IndexGroup.create()
        GroupEnumUnitsInRange(g.ejg,x,y,500,GroupNormalNoStr(GetOwningPlayer(wu),"","",0))
        UnitDamageGroup(wu,g.ejg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        g.destroy()
    endfunction

    function SpellS517(unit wu)
        int num = GetUnitIntState(wu,'S517')
        SetUnitIntState(wu,'S517',num+1)
        AddUnitRealState(wu,2,100)
        UnitAddEffect(wu,"effect_e_buffblue2.mdl")
    endfunction

    function SpellS516(unit wu)
        int num = GetUnitIntState(wu,'S511')
        SetUnitIntState(wu,'S511',num+1)
        if  num + 1 == 30
            AddUnitRealState(wu,1,GetUnitRealState(wu,1)*0.6)
        endif
        LocAddEffect(GetUnitX(wu),GetUnitY(wu),"effect_az-leiji.mdl")
        KillUnit(wu)
        BJDebugMsg("自杀了")
        for pid= 0,3
            if  IsPlaying(pid) == true
                if  PlayerDeathBool == false
                    SetUnitState(Pu[1],UNIT_STATE_LIFE,GetUnitState(Pu[1],UNIT_STATE_MAX_LIFE))
                endif
                AddUnitStateExTimer(Pu[1],15,15,6)
                AddUnitStateExTimer(Pu[1],16,15,6)
                LocAddEffect(GetUnitX(wu),GetUnitY(wu),"effect_e_buffattack.mdl")
            endif
        end
    endfunction

    function SpellS518(unit wu,int id)
        real value = 0
        if  GetUnitTypeId(wu) == 'H018'
            if  GetRandomInt(1,100) <= 50
                for i = 1,70
                    value = GetTypeIdReal(id,i)
                    if  value != 0
                        AddUnitRealState(wu,i,value*0.5)
                    endif
                end
                LocAddEffect(GetUnitX(wu),GetUnitY(wu),"effect_blue-dao-mofa.mdl")
            endif
        endif
    endfunction

    function SpellS523(unit wu,unit tu)
        real life = GetUnitState(tu,UNIT_STATE_LIFE)
        real maxlife = GetUnitState(tu,UNIT_STATE_MAX_LIFE)
        SetUnitState(tu,UNIT_STATE_LIFE,life + maxlife * 0.3)
        AddUnitStateExTimer(tu,1,GetUnitRealState(tu,1)*0.1,4)
        AddUnitStateExTimer(tu,2,GetUnitRealState(tu,2)*0.1,4)
        LocAddEffect(GetUnitX(wu),GetUnitY(wu),"effect_e_buffgreen2a.mdl")
    endfunction
    function SpellS526(unit wu,unit tu)
        
    endfunction

    function SpellS529Spell(unit wu)->bool
        for pid = 0,3
            if  GetUnitTypeId(Pu[1]) == 'H029'
                if  YDWEGetUnitAbilityState(Pu[1],'AC05', 1) == 0
                    
                    ReviveHero(wu,GetUnitX(wu),GetUnitY(wu),true)
                    LocAddEffectTimer(GetUnitX(wu),GetUnitY(wu),"effect_SetItems_N4_Immortal.mdx",1.0)
                    
                    if  GetOwningPlayer(wu)==GetLocalPlayer()
                        ClearSelection()
                        SelectUnit(wu,true)
                        PanCameraToTimed(GetUnitX(wu),GetUnitY(wu),0)
                    endif
                    YDWESetUnitAbilityDataReal( Pu[1],'AC05', 1, 105, 15 )
                    YDWESetUnitAbilityState( Pu[1], 'AC05', 1, 15)
                    return true
                endif
            endif
        end
        return false
    endfunction
    


endlibrary