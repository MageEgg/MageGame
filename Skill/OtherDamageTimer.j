library OtherDamageTimer uses SystemTimer
    private constant int    S = 60  //位移默认速度
    private constant real   L = 0.02//位移默认周期
    
    function EffectDown(unit u1,real x1,real y1,real x01,real y01,string s,real speed1,real high1,real r1,real damage1,string b1)
    //伤害来源，目标点xy，起始点xy，特效路径，速度，高度，伤害半径，伤害,落地爆炸特效
        unit u=u1
        real x=x1
        real y=y1
        real x0=x01
        real y0=y01
        real damage=damage1
        real r=r1
        real high=high1
        real long=Pdis(x,y,x0,y0)
        real speed=speed1
        string b=b1
        effect tx=AddSpecialEffect(s,x0,y0)
        EXSetEffectZ( tx, high )
        EXEffectMatRotateZ( tx, Pang(x0, y0, x,y)/0.01745 )
        //EXEffectMatRotateY( tx, Pang(x0, high,x,0)/0.01745 )
        //EXEffectMatRotateX( tx, Pang(y0, high,y,0)/0.01745)
        
        TimerStart(0.03,true)
        {   if  EXGetEffectZ(tx)>0
                EXSetEffectXY(tx, EXGetEffectX(tx)+(long/(high/speed)*Cos(Pang(x0,y0,x,y))),EXGetEffectY(tx)+(long/(high/speed)*Sin(Pang(x0,y0,x,y))) )
                EXSetEffectZ(tx, EXGetEffectZ(tx)-speed )
                if  EXGetEffectZ(tx)<speed
                    EXSetEffectZ( tx, 0 )
                endif
            else
                DestroyEffect(tx)
                IndexGroup g = IndexGroup.create()
                GroupEnumUnitsInRange(g.ejg,x,y,r,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
                UnitDamageGroup(u,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
                LocAddEffect(x,y,b)
                g.destroy()
                u=null
                endtimer
            endif
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

    function AroundSystemlei(unit u1,unit mj1,real qtime1, real time1,real speed1,real jvli1,real damage1)
        unit u=u1
        unit mj=mj1
        unit uu=null
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
        
        TimerStart(0.03,true)    
        {
            IndexGroup g = IndexGroup.create()
            yxtime=yxtime+0.03
            time=time-0.03
            if  yxtime>=0.75
                yxtime=0
                GroupEnumUnitsInRange(g1,x1,y1,800,GroupNormalNoStr(GetOwningPlayer(u),"","",0))  
                uu = GroupPickRandomUnit(g1)
                GroupClear(g1)
                GroupEnumUnitsInRange(g.ejg,GetUnitX(uu),GetUnitY(uu),200,GroupNormalNoStr(GetOwningPlayer(u),"","",0))
                UnitDamageGroup(u,g.ejg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
                if uu !=null
                    Ligfunc(mj,uu,AddLightningEx("CLPB",false,GetUnitX(mj),GetUnitY(mj),GetUnitZ(mj),GetUnitX(uu),GetUnitY(uu),GetUnitZ(uu)))
                    DestroyEffect(AddSpecialEffect("effect_AZ_UrsaPsionic_E.mdl",GetUnitX(uu),GetUnitY(uu)))
                endif
                g.destroy()
            endif
            if  time>=jvli/(speed/0.03)      
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
            else
                if  Udis(u,mj)>50
                    ang=ang+xzsd
                    x1 = GetUnitX(u)+(Udis(u,mj)-speed)*Cos(ang)
                    y1 = GetUnitY(u)+(Udis(u,mj)-speed)*Sin(ang)
                    SetUnitX(mj,x1)
                    SetUnitY(mj,y1)
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
        
    function CreateTmFuncZero(unit wu,unit m,real Ang,real rac,real dis,real t,real high)
        unit u1 = wu
        unit u2 = m 
        real x1 = GetUnitX(m)
        real y1 = GetUnitY(m)
        real x2 = S*Cos(Ang)
        real y2 = S*Sin(Ang)
        int time = R2I(dis/S)
        UnitAddAbility(m,'Amrf')
        SetUnitFlyHeight(m,high,0)
        UnitRemoveAbility(m,'Amrf')
        ////额外判断
        TimerStart(t,true)
        {
            time = time - 1
            if  time > 0
                x1 = x1 + x2
                y1 = y1 + y2
                SetUnitPosition(u2,x1,y1)
            else
                KillUnit(u2)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    //伤害来源,马甲,方向,伤害,伤害范围,最远距离,移动时间间隔,马甲高度,伤害类型4个
    function CreateTmBuffFunc(unit wu,unit m,real Ang,real dam,real rac,real dis,real high,bool b1,bool b2,int sid1,int lv1,int mid1)
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
        int sid = sid1
        int lv = lv1
        int mid = mid1
        group wg = CreateGroup()
        group ug = CreateGroup()
        int n = 0
        UnitAddAbility(m,'Amrf')
        SetUnitFlyHeight(m,high,0)
        UnitRemoveAbility(m,'Amrf')
        ////额外判断
        TimerStart(0.03,true)
        {
            group gg = CreateGroup()
            real dam2 = 0
            time = time - 1
            if  time > 0
                x1 = x1 + x2
                y1 = y1 + y2
                SetUnitPosition(u2,x1,y1)
                if  r1 > 0
                    GroupEnumUnitsInRange(gg,x1,y1,r1,GroupHasUnitAddBuff(GetOwningPlayer(u1),wg,"",sid,lv,mid))
                    UnitDamageGroup(u1,gg,damage+dam2,bool1,bool2,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                endif
            else
                //额外判断
                if  ug != null
                    GroupRemoveUnit(ug,u2)
                endif
                GroupClear(wg)
                GroupClear(ug)
                DestroyGroup(wg)
                DestroyGroup(ug)
                KillUnit(u2)
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction
                    
                    
    //伤害来源,马甲,方向,伤害,伤害范围,最远距离,移动时间间隔,马甲高度,伤害类型4个
    function CreateTmFunc(unit wu,unit m,real Ang,real dam,real rac,real dis,real high,boolean b1,boolean b2,integer attt,integer damt)
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
        group wg = CreateGroup()
        group ug = CreateGroup()
        int n = 0
        UnitAddAbility(m,'Amrf')
        SetUnitFlyHeight(m,high,0)
        UnitRemoveAbility(m,'Amrf')
        ////额外判断
        TimerStart(0.03,true)
        {
            group gg = CreateGroup()
            real dam2 = 0
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
                if  ug != null
                    GroupRemoveUnit(ug,u2)
                endif
                GroupClear(wg)
                GroupClear(ug)
                DestroyGroup(wg)
                DestroyGroup(ug)
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
    function CreateTmEx(unit wu,string model,real x1,real y1,real x2,real y2,real dam,real num,real Ang2,real rac,real dis,real time,real high,bool b1,bool b2,int attt,int damt)
        real Ang1 = Atan2(y2-y1,x2-x1)
        real r = 0
        unit u = null
        Ang2 = Ang2 * 0.01745
        Ang1 = Ang1 - (((num-1) * Ang2) / 2)
        for i = 0,num-1
            r = Ang1 + Ang2 * I2R(i)
            u = CreateTmUnit(GetOwningPlayer(wu),model,x1,y1,r/0.01745,high,1.0)
            if  u != null
                if  dam == 0
                    CreateTmFuncZero(wu,u,r,rac,dis,time,high)
                else
                    CreateTmFunc(wu,u,r,dam,rac,dis,high,b1,b2,attt,damt)
                endif
            endif
        end
        u = null
    endfunction
    //伤害来源,马甲id,x1,y1,初始角度,伤害,数量,间距角度,伤害范围,最远距离,伤害类型,移动时间间隔,马甲高度
    function CreateTm(unit wu,int id,real x1,real y1,real rng,real dam,real num,real Ang2,real rac,real dis,real time,real high,bool b1,bool b2,int attt,int damt)
        real Ang1 = rng
        real r = 0
        unit u = null
        Ang2 = Ang2 * 0.01745
        Ang1 = Ang1 - (((num-1) * Ang2) / 2)
        for i = 0,num-1
            r = Ang1 + Ang2 * I2R(i)
            u = CreateUnit(GetOwningPlayer(wu),id,x1,y1,r/0.01745)
            if  u != null
                if  dam == 0
                    CreateTmFuncZero(wu,u,r,rac,dis,time,high)
                else
                    CreateTmFunc(wu,u,r,dam,rac,dis,high,b1,b2,attt,damt)
                endif
            endif
        end
        u = null
    endfunction
    
   

    //单位投掷物 施法单位 投掷单位 投掷马甲id 伤害 范围 附加特效 移动时间间隔,马甲高度,伤害(4个)
    function CreateUnitThrowTm(unit wu,unit tu,int id,real dam,real r,string s,real t,real h,bool b1,bool b2,int attt,int damt)
        unit u1 = wu
        unit u2 = tu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        unit u3 = CreateUnit(GetOwningPlayer(u1),id,x1,y1,Uang(u1,u2)/0.01745)
        real damage = dam
        real rac = r
        string eff = s
        real high = h
        bool bool1 = b1
        bool bool2 = b2
        int atttype = attt
        int damtype = damt
        if  u3 != null
            UnitAddAbility(u3,'Amrf')
            SetUnitFlyHeight(u3,high,0)
            UnitRemoveAbility(u3,'Amrf')
            TimerStart(t,true)
            {
                group gg = CreateGroup()
                real ang = Uang(u3,u2)
                if  Udis(u3,u2) > 30
                    x1 = x1 + 35 * Cos(ang)
                    y1 = y1 + 35 * Sin(ang)
                    SetUnitXY(u3,x1,y1)
                    SetUnitFacing(u3,ang/0.01745)
                    if  eff != ""
                        UnitAddEffect(u3,eff)
                    endif
                else
                    GroupEnumUnitsInRange(gg,x1,y1,rac,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                    UnitDamageGroup(u1,gg,damage,bool1,bool2,ConvertAttackType(atttype),ConvertDamageType(damtype),WEAPON_TYPE_AXE_MEDIUM_CHOP)
                    KillUnit(u3)
                    endtimer
                endif
                GroupClear(gg)
                DestroyGroup(gg)
                flush locals
            }
        endif
        flush locals
    endfunction
    
    //单位冲锋新建单位 单位 坐标xy 伤害 伤害范围 最远距离 动作 特效 移动时间间隔 伤害4
    function CreateUnitCollideTmNewUnit(unit wu,string model,real size,real r1,real r2,real dam,real r,real d,string s1,string s2,real t,bool b1,bool b2,int attt,int damt)
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real ang = Atan2(r2-y1,r1-x1)
        real face = ang/0.01745
        real damage = dam
        real rac = r
        real dis = d
        string action = s1
        string eff = s2
        real x2 = S*Cos(ang)
        real y2 = S*Sin(ang)
        int time = R2I(dis/S)
        bool bool1 = b1
        bool bool2 = b2
        int atttype = attt
        int damtype = damt
        group wg = CreateGroup()
        unit u2 = CreateTmUnit(GetOwningPlayer(wu),model,x1,y1,r/0.01745,0,size)
        TimerStart(t,true)
        {
            group gg = CreateGroup()
            time = time - 1
            if  time > 1 
                x1 = x1 + x2
                y1 = y1 + y2
                SetUnitPosition(u2,x1,y1)
                UnitAddEffect(u2,eff)
                SetUnitAnimation(u2,action)
                SetUnitFacing(u2,face)
                GroupEnumUnitsInRange(gg,x1,y1,rac,GroupHasUnit(GetOwningPlayer(u1),wg,""))
                UnitDamageGroup(u1,gg,damage,bool1,bool2,ConvertAttackType(atttype),ConvertDamageType(damtype),WEAPON_TYPE_AXE_MEDIUM_CHOP)
            else
                GroupEnumUnitsInRange(gg,x1,y1,rac,GroupHasUnit(GetOwningPlayer(u1),wg,""))
                UnitDamageGroup(u1,gg,damage,bool1,bool2,ConvertAttackType(atttype),ConvertDamageType(damtype),WEAPON_TYPE_AXE_MEDIUM_CHOP)
                GroupClear(wg)
                DestroyGroup(wg)
                RemoveUnit(u2)
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction 
    
    //单位冲锋 单位 坐标xy 伤害 伤害范围 最远距离 动作 特效 移动时间间隔 伤害4
    function CreateUnitCollideTm(unit wu,real r1,real r2,real dam,real r,real d,string s1,string s2,real t,bool b1,bool b2,int attt,int damt)
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real ang = Atan2(r2-y1,r1-x1)
        real face = ang/0.01745
        real damage = dam
        real rac = r
        real dis = d
        string action = s1
        string eff = s2
        real x2 = S*Cos(ang)
        real y2 = S*Sin(ang)
        int time = R2I(dis/S)
        bool bool1 = b1
        bool bool2 = b2
        int atttype = attt
        int damtype = damt
        group wg = CreateGroup()
        TimerStart(t,true)
        {
            group gg = CreateGroup()
            time = time - 1
            if  time > 1 
                x1 = x1 + x2
                y1 = y1 + y2
                if  IsCanFlyTerrain(x1,y1)
                    SetUnitPosition(u1,x1,y1)
                    UnitAddEffect(u1,eff)
                    SetUnitAnimation(u1,action)
                    SetUnitFacing(u1,face)
                    GroupEnumUnitsInRange(gg,x1,y1,rac,GroupHasUnit(GetOwningPlayer(u1),wg,""))
                    UnitDamageGroup(u1,gg,damage,bool1,bool2,ConvertAttackType(atttype),ConvertDamageType(damtype),WEAPON_TYPE_AXE_MEDIUM_CHOP)
                else
                    GroupEnumUnitsInRange(gg,x1,y1,rac,GroupHasUnit(GetOwningPlayer(u1),wg,""))
                    UnitDamageGroup(u1,gg,damage,bool1,bool2,ConvertAttackType(atttype),ConvertDamageType(damtype),WEAPON_TYPE_AXE_MEDIUM_CHOP)
                    GroupClear(wg)
                    DestroyGroup(wg)
                    endtimer
                endif
            else
                GroupEnumUnitsInRange(gg,x1,y1,rac,GroupHasUnit(GetOwningPlayer(u1),wg,""))
                UnitDamageGroup(u1,gg,damage,bool1,bool2,ConvertAttackType(atttype),ConvertDamageType(damtype),WEAPON_TYPE_AXE_MEDIUM_CHOP)
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
    
    //击退单位无伤害 施法单位 目标 最远距离 动作 特效 移动时间间隔
    function CreateUnitCollideFlyTmNo(unit wu,unit tu,real d,string s1,string s2,real t)
        unit u1 = wu
        unit u2 = tu
        real x1 = GetUnitX(u2)
        real y1 = GetUnitY(u2)
        real ang = Uang(u1,u2)
        real face = GetUnitFacing(u2)
        real dis = d
        string action = s1
        string eff = s2
        real x2 = S*Cos(ang)
        real y2 = S*Sin(ang)
        int time = R2I(dis/S)
        TimerStart(t,true)
        {
            time = time - 1
            if  time > 1 and GetUnitState(u2,UNIT_STATE_LIFE) > 0
                x1 = x1 + x2
                y1 = y1 + y2
                if  IsCanFlyTerrain(x1,y1)
                    SetUnitPosition(u2,x1,y1)
                    UnitAddEffect(u2,eff)
                    SetUnitAnimation(u2,action)
                    SetUnitFacing(u2,face)
                else
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction 
    
    //击退单位沿途伤害 施法单位 目标 伤害 伤害范围 最远距离 动作 特效 移动时间间隔 伤害4
    function CreateUnitCollideFlyTm(unit wu,unit tu,real dam,real r,real d,string s1,string s2,real t,bool b1,bool b2,int attt,int damt)
        unit u1 = wu
        unit u2 = tu
        real x1 = GetUnitX(u2)
        real y1 = GetUnitY(u2)
        real ang = Uang(u1,u2)
        real face = GetUnitFacing(u2)
        real damage = dam
        real rac = r
        real dis = d
        string action = s1
        string eff = s2
        real x2 = S*Cos(ang)
        real y2 = S*Sin(ang)
        int time = R2I(dis/S)
        bool bool1 = b1
        bool bool2 = b2
        int atttype = attt
        int damtype = damt
        group wg = CreateGroup()
        TimerStart(t,true)
        {
            group gg = CreateGroup()
            time = time - 1
            if  time > 1 and GetUnitState(u2,UNIT_STATE_LIFE) > 0
                x1 = x1 + x2
                y1 = y1 + y2
                if  IsCanFlyTerrain(x1,y1)
                    SetUnitPosition(u2,x1,y1)
                    UnitAddEffect(u2,eff)
                    SetUnitAnimation(u2,action)
                    SetUnitFacing(u2,face)
                    GroupEnumUnitsInRange(gg,x1,y1,rac,GroupHasUnit(GetOwningPlayer(u1),wg,""))
                    UnitDamageGroup(u1,gg,damage,bool1,bool2,ConvertAttackType(atttype),ConvertDamageType(damtype),WEAPON_TYPE_AXE_MEDIUM_CHOP)
                else
                    GroupClear(wg)
                    DestroyGroup(wg)
                    endtimer
                endif
            else
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
    
    //击退单位沿途伤害传角度 施法单位 目标 角度 伤害 伤害范围 最远距离 动作 特效 移动时间间隔 伤害4
    function CreateUnitCollideFlyTmAng(unit wu,unit tu,real Ang,real dam,real r,real d,string s1,string s2,real t,bool b1,bool b2,int attt,int damt)
        unit u1 = wu
        unit u2 = tu
        real x1 = GetUnitX(u2)
        real y1 = GetUnitY(u2)
        real ang = Ang
        real face = GetUnitFacing(u2)
        real damage = dam
        real rac = r
        real dis = d
        string action = s1
        string eff = s2
        real x2 = S*Cos(ang)
        real y2 = S*Sin(ang)
        int time = R2I(dis/S)
        bool bool1 = b1
        bool bool2 = b2
        int atttype = attt
        int damtype = damt
        group wg = CreateGroup()
        TimerStart(t,true)
        {
            group gg = CreateGroup()
            time = time - 1
            if  time > 1 and GetUnitState(u2,UNIT_STATE_LIFE) > 0
                x1 = x1 + x2
                y1 = y1 + y2
                if  IsCanFlyTerrain(x1,y1)
                    SetUnitPosition(u2,x1,y1)
                    UnitAddEffect(u2,eff)
                    SetUnitAnimation(u2,action)
                    SetUnitFacing(u2,face)
                    GroupEnumUnitsInRange(gg,x1,y1,rac,GroupHasUnit(GetOwningPlayer(u1),wg,""))
                    UnitDamageGroup(u1,gg,damage,bool1,bool2,ConvertAttackType(atttype),ConvertDamageType(damtype),WEAPON_TYPE_AXE_MEDIUM_CHOP)
                else
                    GroupClear(wg)
                    DestroyGroup(wg)
                    endtimer
                endif
            else
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
    
    //延迟伤害 伤害来源 延迟时间 坐标x y 伤害 伤害范围 伤害类型4个 选取特效 buffId buff等级 buff命令
    function UnitGroupAddDamageTimerAddBuff(unit tu,real time,real r1,real r2,real dam,real r,bool b1,bool b2,int attt,int damt,string s,int i1,int i2,int i3)
        unit u1 = tu
        real x = r1
        real y = r2
        real damage = dam
        real rac = r
        bool bool1 = b1
        bool bool2 = b2
        int atttype = attt
        int damtype = damt
        string eff = s
        int buffskill = i1
        int bufflv = i2
        int bufforder = i3
        group gg = CreateGroup()
        if  buffskill == 0
            GroupEnumUnitsInRange(gg,x,y,rac,GroupNormalNoStr(GetOwningPlayer(u1),"origin",eff,0))
        else
            GroupEnumUnitsInRange(gg,x,y,rac,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),eff,buffskill,bufflv,bufforder))
        endif
        TimerStart(time,false)
        {
            unit uu = null
            loop
                uu = FirstOfGroup(gg)
                exitwhen uu == null
                UnitDamageTarget(u1,uu,damage,bool1,bool2,ConvertAttackType(atttype),ConvertDamageType(damtype),WEAPON_TYPE_AXE_MEDIUM_CHOP)
                GroupRemoveUnit(gg,uu)
            endloop
            GroupClear(gg)
            DestroyGroup(gg)
            endtimer
            flush locals
        }
        flush locals
    endfunction
    

    
endlibrary

