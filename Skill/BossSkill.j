library BossSkill uses AbilityUI,OtherDamageTimer,BossSkill2

    private unit boss = null
    private real bossx = 0
    private real bossy = 0
    private real bossdamage = 0

    #define RAC_A_200   'eZ13'
    #define RAC_A_300   'e00H'
    #define RAC_A_400   'e00E'
    #define RAC_A_500   'e00F'
    #define RAC_A_600   'e00G'

    #define RAC_B_200   'eZ12'
    #define RAC_B_300   'e00L'
    #define RAC_B_400   'e00I'
    #define RAC_B_500   'e00J'
    #define RAC_B_600   'e00K'

    #define LINE_A      'e00M'
    #define LINE_A2     'e00N'
    #define LINE_B      'e00O'

    function SetBoss(unit u,real x,real y,real damage)
        boss = u
        bossx = x
        bossy = y
        bossdamage = damage
    endfunction

    function FlushBoss()
        boss = null
        bossx = 0
        bossy = 0
        bossdamage = 0
    endfunction
    
    //释放单位 目标 预警id 预警角度（冲击波类） 伤害 预警时间 释放的技能函数
    function BossFuncStart(unit wu,unit tu,int uid,real ang,real dam,real time,string s)
        unit u1 = wu
        unit u2 = tu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = GetUnitX(u2)
        real y2 = GetUnitY(u2)
        unit u3 = null
        real damage = dam
        string funcstring = s
        if  s == "BossFuncSpell5"
            x1 = x1+250*Cos(Atan2(y2-y1,x2-x1))
            y1 = y1+250*Sin(Atan2(y2-y1,x2-x1))
            u3 = CreateUnit(GetOwningPlayer(u1),uid,x1,y1,Atan2(y2-y1,x2-x1)/0.01745)
        elseif  uid == LINE_A or uid == LINE_A2 or uid == LINE_B
            u3 = CreateUnit(GetOwningPlayer(u1),uid,x1,y1,ang)
        else
            u3 = CreateUnit(GetOwningPlayer(u1),uid,x2,y2,ang)
        endif
        TimerStart(time,false)
        {
            RemoveUnit(u3)
            SetBoss(u1,x2,y2,damage)
            ExecuteFunc(funcstring)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    piece BossSpell
        unit u1 = boss
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = bossx
        real y2 = bossy
        real ang = Atan2(y2-y1,x2-x1)
        real damage = bossdamage
        FlushBoss()
    endpiece

    //////////////////////////模版////////////////////////////
    //////////////////////////模版////////////////////////////
    //////////////////////////模版////////////////////////////

    //false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa

    function BossFuncStartTemplate()
        insert BossSpell
        

        flush locals
    endfunction
    //////////////////////////模版////////////////////////////
    //////////////////////////模版////////////////////////////
    //////////////////////////模版////////////////////////////


    function BossFuncSpell1()
        insert BossSpell
        int time = 0
        damage = damage / 2
        //伤害来源,马甲id,x1,y1,初始角度,伤害,数量,间距角度,伤害范围,最远距离,伤害类型,移动时间间隔,马甲高度
        CreateTm(u1,'e00P',x1,y1,ang,damage,1,0,210,1500,0,50,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
        TimerStart(0.4,true)
        {
            time = time + 1
            if  time <= 2
                CreateTm(u1,'e00P',x1,y1,ang,damage,1,0,210,1500,0,50,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell2()
        insert BossSpell
        damage = damage / 2
        //伤害来源,马甲id,x1,y1,初始角度,伤害,数量,间距角度,伤害范围,最远距离,伤害类型,移动时间间隔,马甲高度
        CreateTm(u1,'e00Q',x1,y1,ang,damage,3,15,220,1200,0,50,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
        flush locals
    endfunction

    function BossFuncSpell3()
        insert BossSpell
        AddEffectInArea(x2,y2,370,7,"effect_tx_new (2).mdx")
        //延迟伤害 伤害来源 延迟时间 坐标x y 伤害 伤害范围 伤害类型4个 选取特效 buffId buff等级 buff命令
        UnitGroupAddDamageTimerAddBuff(u1,0.3,x2,y2,damage,400,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa,"",0,0,0)
        flush locals
    endfunction

    function BossFuncSpell4()
        insert BossSpell
        group gg = CreateGroup()
        AddEffectInArea(x2,y2,390,25,"effect2_az_nevermore_r2(1).mdl")
        LocAddEffect(x2,y2,"effect3_desecrategreen.mdl")
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function BossFuncSpell5()
        insert BossSpell
        real newx = 0
        real newy = 0
        int time = 0
        newx = x1+250*Cos(ang)
        newy = y1+250*Sin(ang)
        damage = damage / 3
        TimerStart(0.4,true)
        {
            group gg = CreateGroup()
            unit uu = null
            time = time + 1
            if  time <= 3
                uu = CreateUnit(GetOwningPlayer(u1),'e00S',x1,y1,ang/0.01745)
                RemoveUnitTimer(uu,1)
                GroupEnumUnitsInRange(gg,newx,newy,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
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

    function BossFuncSpell6()
        insert BossSpell
        group gg = CreateGroup()
        AddEffectInArea(x2,y2,380,15,"effect2_az_coco_e2.mdl")
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function BossFuncSpell7()
        insert BossSpell
        unit u2 = CreateUnit(GetOwningPlayer(u1),'e00R',x2,y2,0)
        int time = 0
        damage = damage / 5
        TimerStart(0.3,true)
        {
            group gg = CreateGroup()
            time = time + 1
            if  time <= 5
                AddEffectInArea(x2,y2,390,5,"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
                GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            else
                RemoveUnit(u2)
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell8()
        insert BossSpell
        unit u2 = CreateUnit(GetOwningPlayer(u1),'e00T',x1-100*Cos(ang),y1-100*Cos(ang),ang/0.01745)
        RemoveUnitTimer(u2,1.3)
        u2 = CreateUnit(GetOwningPlayer(u1),'e000',x1,y1,ang/0.01745)
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        int time = R2I(2000/30)
        group wg = CreateGroup()
        group ug = CreateGroup()
        GroupAddUnit(ug,u2)
        TimerStart(0.002,true)
        {
            group gg = CreateGroup()
            time = time - 1
            if  time > 0
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitXY(u2,x1,y1)
                if  ModuloInteger(time,6) == 0
                    LocAddEffectSetSize(x1,y1,"effect_tx_asad (24).mdl",1)
                endif
                GroupEnumUnitsInRange(gg,x1,y1,280,GroupHasUnit(GetOwningPlayer(u1),wg,""))
                UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            else
                RemoveUnit(u2)
                GroupClear(wg)
                GroupClear(ug)
                DestroyGroup(wg)
                DestroyGroup(ug)
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell9()
        insert BossSpell
        damage = damage / 3.5
        CreateTm(u1,'e00U',x1,y1,ang,damage,5,10,220,1200,0,50,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
        flush locals
    endfunction

    function BossFuncSpell10()
        insert BossSpell
        damage = damage / 3.5
        CreateTm(u1,'e00V',x1,y1,ang,damage,5,10,220,1200,0,50,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
        flush locals
    endfunction

    function BossFuncSpell11()
        insert BossSpell
        int time = 0
        damage = damage / 10
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

    function BossFuncSpell12()
        insert BossSpell
        int time = 0
        damage = damage / 9
        TimerStart(0.2,true)
        {
            group gg = CreateGroup()
            time = time + 1
            real newx = 0
            real newy = 0
            if  time <= 9
                if  time == 1 or time == 4 or time == 7
                    newx = x2
                    newy = y2
                    LocAddEffectSetSize(newx,newy,"effect3_az_heiseguangzhu.mdl",1)
                    LocAddEffectSetSize(newx,newy,"effect2_az_FallSword_ice_Black.mdl",1.2)
                    UnitGroupAddDamageTimerAddBuff(u1,0.24,x2,y2,damage,150,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa,"",0,0,0)
                elseif  time == 2 or time == 5 or time == 8
                    for num = 1,6
                        newx = x2+150*Cos(60*num*0.01745)
                        newy = y2+150*Sin(60*num*0.01745)
                        LocAddEffectSetSize(newx,newy,"effect3_az_heiseguangzhu.mdl",1)
                        LocAddEffectSetSize(newx,newy,"effect2_az_FallSword_ice_Black.mdl",1.2)
                    end
                    UnitGroupAddDamageTimerAddBuff(u1,0.24,x2,y2,damage,300,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa,"",0,0,0)
                elseif  time == 3 or time == 6 or time == 9
                    for num = 1,8
                        newx = x2+300*Cos(45*num*0.01745)
                        newy = y2+300*Sin(45*num*0.01745)
                        LocAddEffectSetSize(newx,newy,"effect3_az_heiseguangzhu.mdl",1)
                        LocAddEffectSetSize(newx,newy,"effect2_az_FallSword_ice_Black.mdl",1.2)
                    end
                    UnitGroupAddDamageTimerAddBuff(u1,0.24,x2,y2,damage,450,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa,"",0,0,0)
                endif
            else    
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell13()
        insert BossSpell
        unit u2 = CreateUnit(GetOwningPlayer(u1),'e000',x1,y1,ang/0.01745)
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        int time = R2I(2000/30)
        group wg = CreateGroup()
        group ug = CreateGroup()
        GroupAddUnit(ug,u2)
        TimerStart(0.002,true)
        {
            group gg = CreateGroup()
            time = time - 1
            if  time > 0
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitXY(u2,x1,y1)
                if  ModuloInteger(time,6) == 0
                    LocAddEffectSetSize(x1,y1,"effect2_az_goods_force staff(3).mdl",4)
                    LocAddEffectSetSize(x1,y1,"effect2_by_wood_effect2_yubanmeiqin_lightning_luolei.mdl",1.2)
                endif
                GroupEnumUnitsInRange(gg,x1,y1,280,GroupHasUnit(GetOwningPlayer(u1),wg,""))
                UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                GroupClear(gg)
                DestroyGroup(gg)
            else
                RemoveUnit(u2)
                GroupClear(wg)
                GroupClear(ug)
                DestroyGroup(wg)
                DestroyGroup(ug)
                endtimer
            endif
           
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell14()
        insert BossSpell
        group gg = CreateGroup()
        AddEffectInArea(x2,y2,380,15,"effect2_by_wood_effect2_yubanmeiqin_lightning_luolei.mdl")
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function BossFuncSpell15()
        insert BossSpell
        group gg = CreateGroup()
        LocAddEffectSetSize(x2,y2,"effect2_by_wood_leitingyiji.mdl",1.2)
        LocAddEffectSetSize(x2,y2,"effect2_by_wood_effect2_yubanmeiqin_lightning_luolei.mdl",2)
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function BossFuncSpell16()
        insert BossSpell
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        int time = R2I(Pdis(x1,y1,x2,y2)/30)
        int uid = GetUnitTypeId(u1)
        SetUnitAnimation(u1,"attack")
        TimerStart(0.02,true)
        {
            group gg = null
            time = time - 1
            if  time > 0 and GetUnitTypeId(u1) == uid
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitXY(u1,x1,y1)
                if  ModuloInteger(time,6) == 0
                    LocAddEffectSetSize(x1,y1,"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl",2)
                endif
            else
                if  GetUnitTypeId(u1) == uid
                    SetUnitXY(u1,x1,y1)
                    SetUnitAnimation(u1,"attack")
                    gg = CreateGroup()
                    LocAddEffectSetSize(x2,y2,"effect2_zhendi-qiquan-boom.mdl",2.5)
                    LocAddEffectSetSize(x2,y2,"effect2_by_wood_gongchengsipai_6.mdl",1.8)
                    GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                    UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                    GroupClear(gg)
                    DestroyGroup(gg)
                endif
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell17()
        insert BossSpell
        CreateTm(u1,'e00Z',x1,y1,ang,damage,1,0,210,1500,0,50,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
        flush locals
    endfunction

    function BossFuncSpell18()
        insert BossSpell
        int time = 0
        damage = damage / 6
        //伤害来源,马甲id,x1,y1,初始角度,伤害,数量,间距角度,伤害范围,最远距离,伤害类型,移动时间间隔,马甲高度
        CreateTm(u1,'e00X',x1,y1,ang,damage,3,15,220,1200,0,50,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
        TimerStart(0.4,true)
        {
            time = time + 1
            if  time <= 2
                CreateTm(u1,'e00X',x1,y1,ang,damage,3,15,220,1200,0,50,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell19()
        insert BossSpell
        damage = damage / 8
        CreateTm(u1,'e00X',x2,y2,ang,damage,10,36,220,500,0,50,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
        flush locals
    endfunction

    function BossFuncSpell20()
        insert BossSpell
        group gg = CreateGroup()
        LocAddEffectSetSize(x2,y2,"effect_[dz.spell]001.mdl",0.8)
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function BossFuncSpell21()
        insert BossSpell
        group gg = CreateGroup()
        LocAddEffectSetSize(x2,y2,"effect_AA_bwaxec.mdl",1.1)
        AddEffectInArea(x2,y2,380,10,"effect2_zhendi-qiquan-boom.mdl")
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function BossFuncSpell22()
        insert BossSpell
        int time = 0
        damage = damage / 20
        TimerStart(0.2,true)
        {
            time = time + 1
            if  time < 10
                for num = 1,3
                    CreateTm(u1,'e00V',GetUnitX(u1)+GetRandomReal(-160,160),GetUnitY(u1)+GetRandomReal(-160,160),ang,damage,1,0,220,1200,0,50,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
                end
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell23()
        insert BossSpell
        unit u2 = CreateUnit(GetOwningPlayer(u1),'e00Y',x1,y1,ang/0.0175)
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        int time = R2I(Pdis(x1,y1,x2,y2)/30)
        real size = GetUnitScaleSize(u1)
        int uid = GetUnitTypeId(u1)
        LocAddEffectSetSize(x1,y1,"effect2_az_goods_blink(green).mdl",1.8)
        SetUnitScale(u1,0.01,0.01,0.01)
        TimerStart(0.02,true)
        {
            time = time - 1
            if  time > 0 and GetUnitTypeId(u1) == uid
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitXY(u1,x1,y1)
                SetUnitXY(u2,x1,y1)
            else
                RemoveUnit(u2)
                if  GetUnitTypeId(u1) == uid
                    SetUnitXY(u1,x1,y1)
                    SetUnitScale(u1,size,size,size)
                    SetUnitAnimation(u1,"attack")
                    LocAddEffectSetSize(x1,y1,"effect2_az_goods_blink(green).mdl",1.8)
                    AddEffectInAreaSetSizeTimer(x1,y1,290,1.5,6,"effect3_impalehittarget.mdl",0.8)
                    UnitGroupAddDamageTimerAddBuff(u1,0.24,x2,y2,damage,300,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa,"",0,0,0)
                endif
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell24()
        insert BossSpell
        unit u2 = CreateUnit(GetOwningPlayer(u1),'e000',x1,y1,ang/0.01745)
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        int time = R2I(2000/30)
        group wg = CreateGroup()
        group ug = CreateGroup()
        GroupAddUnit(ug,u2)
        TimerStart(0.002,true)
        {
            group gg = CreateGroup()
            time = time - 1
            if  time > 0
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitXY(u2,x1,y1)
                if  ModuloInteger(time,6) == 0
                    LocAddEffectTimerOrSize(x1,y1,GetRandomReal(0,360),"effect3_impalehittarget.mdl",0.8,1.5)
                endif
                GroupEnumUnitsInRange(gg,x1,y1,280,GroupHasUnit(GetOwningPlayer(u1),wg,""))
                UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            else
                RemoveUnit(u2)
                GroupClear(wg)
                GroupClear(ug)
                DestroyGroup(wg)
                DestroyGroup(ug)
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell25()
        insert BossSpell
        unit u2 = CreateUnit(GetOwningPlayer(u1),'eZ11',x2,y2,0)
        int time = 0
        damage = damage / 5
        TimerStart(0.3,true)
        {
            group gg = CreateGroup()
            time = time + 1
            if  time <= 5
                AddEffectInArea(x2,y2,240,15,"Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl")
                GroupEnumUnitsInRange(gg,x2,y2,250,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            else
                RemoveUnit(u2)
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell26()
        insert BossSpell
        int time = 0
        damage = damage / 2
        //伤害来源,马甲id,x1,y1,初始角度,伤害,数量,间距角度,伤害范围,最远距离,伤害类型,移动时间间隔,马甲高度
        CreateTm(u1,'eZ14',x1,y1,ang,damage,1,0,210,1000,0,50,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
        TimerStart(0.3,true)
        {
            time = time + 1
            if  time <= 2
                CreateTm(u1,'eZ14',x1,y1,ang,damage,1,0,210,1000,0,50,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell27()
        insert BossSpell
        int time = 0
        damage = damage / 4
        TimerStart(0.25,true)
        {
            group gg = CreateGroup()
            real ran = 0
            time = time + 1
            if  time <= 4
                for num = 1,2
                    ran = GetRandomReal(0,360)
                    RemoveUnitTimer(CreateUnit(GetOwningPlayer(u1),'eZ15',x2,y2,ran),1)
                    RemoveUnitTimer(CreateUnit(GetOwningPlayer(u1),'eZ15',x2,y2,ran+90),1)
                end
                LocAddEffectSetSize(x2,y2,"effect2_az_cocoguanyu_t2_death.mdl",1)
                GroupEnumUnitsInRange(gg,x2,y2,250,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
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

    function BossFuncSpell28()
        insert BossSpell
        group gg = CreateGroup()
        LocAddEffectSetSize(x2,y2,"effect_shengguang.mdl",3)
        GroupEnumUnitsInRange(gg,x2,y2,250,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function BossFuncSpell29Ex(unit wu,real dam)
        unit u1 = wu
        real x1 = GetUnitX(wu)
        real y1 = GetUnitY(wu)
        unit u3 = CreateTmUnit(GetOwningPlayer(wu),"effect_dark-xuanfen.mdl",x1,y1,GetUnitFacing(u1),0,1.3)
        real damage = dam
        int time = 0
        effect eff = AddSpecialEffect("effect_by_wood_quanhuang_bashenanzhuazi2.mdl",x1,y1)
        EXSetEffectSize(eff,1.5)
        EXEffectMatRotateZ( eff, GetRandomReal(1,360) )
        DestroyEffect(eff)
        TimerStart(0.2,true)
        {
            group gg = CreateGroup()
            x1 = GetUnitX(u1)
            y1 = GetUnitY(u1)
            time = time + 1
            if  time <= 3
                eff = AddSpecialEffect("effect_by_wood_quanhuang_bashenanzhuazi2.mdl",x1,y1)
                EXEffectMatRotateZ( eff, GetRandomReal(1,360) )
                DestroyEffect(eff)
                GroupEnumUnitsInRange(gg,x1,y1,400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffxy,2,0))
                UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            else
                RemoveUnit(u3)
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell29()
        insert BossSpell
        unit u2 = CreateTmUnit(GetOwningPlayer(u1),"effect_az_chongfeng.mdl",x1,y1,GetUnitFacing(u1),0,1.3)
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        int time = R2I(Pdis(x1,y1,x2,y2)/30)
        real size = GetUnitScaleSize(u1)
        int uid = GetUnitTypeId(u1)
        LocAddEffectSetSize(x1,y1,"effect2_az_goods_blink(green).mdl",1.8)
        SetUnitScale(u1,0.01,0.01,0.01)
        damage = damage /3
        TimerStart(0.02,true)
        {
            time = time - 1
            if  time > 0 and GetUnitTypeId(u1) == uid
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitXY(u1,x1,y1)
                SetUnitXY(u2,x1,y1)
            else
                RemoveUnit(u2)
                if  GetUnitTypeId(u1) == uid
                    SetUnitXY(u1,x1,y1)
                    SetUnitScale(u1,size,size,size)
                    SetUnitAnimation(u1,"attack")
                    LocAddEffectSetSize(x1,y1,"effect2_az_goods_blink(green).mdl",1.8)
                    BossFuncSpell29Ex(u1,damage)
                endif
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell30()
        insert BossSpell
        group gg = CreateGroup()
        real newx = 0
        real newy = 0
        LocAddEffect(x2,y2,"effect3_desecrateblack.mdl")
        for num = 1,12
            newx = x2+400*Cos(30*num*0.01745)
            newy = y2+400*Sin(30*num*0.01745)
            LocAddEffect(newx,newy,"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
        end
        for num = 1,8
            newx = x2+200*Cos(45*num*0.01745)
            newy = y2+200*Sin(45*num*0.01745)
            LocAddEffect(newx,newy,"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
        end
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction
    
    function BossFuncSpellFlyOfBird(unit wu,real r1,real r2)
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = r1 
        real y2 = r2
        real ang = Atan2(y2-y1,x2-x1)
        unit u2 = CreateTmUnit(GetOwningPlayer(u1),"effect_dummy_dawn_bird_00.mdl",x1,y1,Atan2(y1-y2,x1-x2)/0.01745,50,1.8)
        real xx = 50*Cos(ang)
        real yy = 50*Sin(ang)
        int time = R2I(Pdis(x1,y1,x2,y2)/50)
        real size = GetUnitScaleSize(u1)
        int uid = GetUnitTypeId(u1)
        LocAddEffectSetSize(x1,y1,"effect_az_pafeathermoon_b.mdl",2)
        SetUnitScale(u1,0.01,0.01,0.01)
        TimerStart(0.007,true)
        {
            time = time - 1
            if  time > 0 and GetUnitTypeId(u1) == uid
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitXY(u1,x1,y1)
                SetUnitXY(u2,x1,y1)
                SetUnitFacing(u1,ang/0.01745)
                SetUnitFacing(u2,Atan2(y1-y2,x1-x2)/0.01745)
                if  ModuloInteger(time,4) == 0
                    LocAddEffectSetSize(x1,y1,"effect_az_pafeathermoon_b.mdl",2)
                endif
            else
                RemoveUnit(u2)
                if  GetUnitTypeId(u1) == uid
                    SetUnitXY(u1,x1,y1)
                    SetUnitScale(u1,size,size,size)
                    SetUnitAnimation(u1,"attack")
                    LocAddEffectSetSize(x1,y1,"effect_az_pafeathermoon_b.mdl",2)
                endif
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell31Ex(unit wu,real r1,real r2,real dam)
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = r1
        real y2 = r2
        real damage = dam
        int time = 0
        PauseUnit(u1,true)
        SetUnitInvulnerable(u1,true)
        BossFuncSpellFlyOfBird(u1,x2 + 400*Cos(18*0.01745),y2 + 400*Sin(18*0.01745))
        TimerStart(0.18,true)
        {
            group gg = null
            time = time + 1   
            if  time <= 4
                if  time == 1
                    BossFuncSpellFlyOfBird(u1,x2 + 400*Cos(234*0.01745),y2 + 400*Sin(234*0.01745))
                elseif  time == 2
                    BossFuncSpellFlyOfBird(u1,x2 + 400*Cos(90*0.01745),y2 + 400*Sin(90*0.01745))
                elseif  time == 3
                    BossFuncSpellFlyOfBird(u1,x2 + 400*Cos(306*0.01745),y2 + 400*Sin(306*0.01745))
                elseif  time == 4
                    BossFuncSpellFlyOfBird(u1,x2 + 400*Cos(162*0.01745),y2 + 400*Sin(162*0.01745))
                endif
            else
                SetUnitAnimation(u1,"attack")
                gg = CreateGroup()
                UnitAddEffect(u1,"effect_az_goods_lvlup(3).mdl")
                SetUnitXY(u1,x2,y2)
                LocAddEffect(x2,y2,"effect_effect_az_goods_tp_target_effect(4).mdl")
                LocAddEffectSetSize(x2,y2,"effect2_by_wood_effect2_war3_shuangdongxinxing.mdl",1.7)
                GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffdj,2,0))
                UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                GroupClear(gg)
                DestroyGroup(gg)
                PauseUnit(u1,false)
                SetUnitInvulnerable(u1,false)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell31()
        insert BossSpell
        real newx = x2 + 400*Cos(162*0.01745)
        real newy = y2 + 400*Sin(162*0.01745)
        UnitAddEffect(u1,"effect_az_goods_lvlup(3).mdl")
        SetUnitXY(u1,newx,newy)
        LocAddEffect(newx,newy,"effect_effect_az_goods_tp_target_effect(4).mdl")
        TimerStart(0.01,false)
        {
            BossFuncSpell31Ex(u1,x2,y2,damage)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell32()
        insert BossSpell
        unit u3 = CreateUnit(GetOwningPlayer(u1),'eZ16',x1,y1,ang/0.01745)
        real size = 1
        real xx = 35*Cos(ang)
        real yy = 35*Sin(ang)
        int time = R2I(Pdis(x1,y1,x2,y2)/35)
        int mod = time/200
        SetUnitAnimation(u3,"walk" )
        UnitAddEffectSetSize(u3,"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl",1)
        TimerStart(0.02,true)
        {
            group gg = CreateGroup()
            time = time - 1
            if  time > 0
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitXY(u3,x1,y1)
                SetUnitFacing(u3,ang/0.01745)
                if  mod > 0
                    if  ModuloInteger(time,mod) ==  0
                        size = size + 0.01
                        if  size > 3
                            size = 3
                        endif
                        SetUnitScale(u3,size,size,size)
                    endif
                else
                    size = size + 0.2
                    if  size > 3
                        size = 3
                    endif
                    SetUnitScale(u3,size,size,size)
                endif
            else
                SetUnitAnimation(u3,"attack")
                LocAddEffectSetSize(x1,y1,"effect_az_cwdullahan_d1target.mdx",3)
                GroupEnumUnitsInRange(gg,x1,y1,500,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffxy,2,0))
                UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
                RemoveUnitTimer(u3,0.5)
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell33()
        insert BossSpell
        int time = 0
        damage = damage / 5
        TimerStart(0.2,true)
        {
            time = time + 1
            if  time <= 5
                AddEffectInArea(x2,y2,370,12,"effect2_az_FallSword_ice.mdl")
                UnitGroupAddDamageTimerAddBuff(u1,0.24,x2,y2,damage,400,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa,"",Buffdj,1,0)
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell34()
        insert BossSpell
        AddEffectInArea(x2,y2,370,22,"effect2_az_FallSword_ice_Black.mdl")
        UnitGroupAddDamageTimerAddBuff(u1,0.24,x2,y2,damage,400,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa,"",Buffdj,2,0)
        flush locals
    endfunction

    function BossFuncSpell35()
        insert BossSpell
        AddEffectInArea(x2,y2,370,22,"effect2_az_FallSword_ice_green.mdl")
        UnitGroupAddDamageTimerAddBuff(u1,0.24,x2,y2,damage,400,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa,"",Buffdj,2,0)
        flush locals
    endfunction

    function BossFuncSpell36()
        insert BossSpell
        AddEffectInArea(x2,y2,370,22,"effect2_az_FallSword_ice_yellow.mdl")
        UnitGroupAddDamageTimerAddBuff(u1,0.24,x2,y2,damage,400,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa,"",Buffdj,2,0)
        flush locals
    endfunction

    function BossFuncSpell37()
        insert BossSpell
        AddEffectInArea(x2,y2,370,22,"effect2_az_FallSword_ice_red.mdl")
        UnitGroupAddDamageTimerAddBuff(u1,0.24,x2,y2,damage,400,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa,"",Buffdj,2,0)
        flush locals
    endfunction

    function BossFuncSpell38()
        insert BossSpell
        int time = 0
        damage = damage / 3
        TimerStart(0.3,true)
        {
            group gg = CreateGroup()
            time = time + 1
            if  time <= 3
                LocAddEffectSetSize(x2,y2,"effect2_blue-texiao-meuikandong.mdl",1)
                LocAddEffectSetSize(x2,y2,"effect2_by_wood_gongchengsipai_6.mdl",1.6)
                LocAddEffectSetSize(x2,y2,"effect_az_tormentedsoul_t1.mdl",1.4)
                GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffxy,3,0))
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

    function BossFuncSpell39()
        insert BossSpell
        int time = 0
        damage = damage / 10
        TimerStart(0.1,true)
        {
            group gg = CreateGroup()
            time = time + 1
            if  time <= 10
                AddEffectInArea(x2,y2,390,3,"effect2_az_nevermoreice_x1.mdl")
                GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffdj,2,0))
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

    function BossFuncSpell40()
        insert BossSpell
        group gg = CreateGroup()
        AddEffectInArea(x2,y2,280,10,"effect2_az_magina[2]_v.mdl")
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffcm,4,0))
        UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function BossFuncSpell41()
        insert BossSpell
        group gg = CreateGroup()
        LocAddEffectSetSize(x2,y2,"effect_az_earthshaker_a.mdl",1)
        AddEffectInAreaSetSizeTimer(x2,y2,380,1.5,15,"effect3_impalemisstarget.mdl",0.8)
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffxy,3,0))
        UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function BossFuncSpell42()
        insert BossSpell
        int time = 0
        damage = damage / 3
        TimerStart(0.8,true)
        {
            group gg = CreateGroup()
            time = time + 1
            if  time <= 3
                AddEffectInAreaSetSizeTimer(x2,y2,240,3,5,"effect2_entanglingrootstarget.mdl",1)
                GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffcr,1,0))
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

    function BossFuncSpell43()
        insert BossSpell
        int time = 0
        damage = damage / 20
        TimerStart(0.2,true)
        {
            time = time + 1
            if  time < 10
                for num = 1,3
                    CreateTm(u1,'eZ19',GetUnitX(u1)+GetRandomReal(-160,160),GetUnitY(u1)+GetRandomReal(-160,160),ang,damage,1,0,220,1200,0,50,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
                end
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell44()
        insert BossSpell
        unit uu = null
        real ran = GetRandomReal(0,360)
        for num = 1,4
            uu = CreateUnit(GetOwningPlayer(u1),'e01A',x2,y2,ran+90*num)
            RemoveUnitTimer(uu,1)
        end
        UnitGroupAddDamageTimerAddBuff(u1,0.3,x2,y2,damage,400,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa,"",Buffxy,3,0)
        flush locals
    endfunction

    function BossFuncSpell45()
        insert BossSpell
        unit uu = null
        real ran = GetRandomReal(0,360)
        for num = 1,4
            uu = CreateUnit(GetOwningPlayer(u1),'e01A',x2,y2,ran+90*num)
            RemoveUnitTimer(uu,1)
        end
        UnitGroupAddDamageTimerAddBuff(u1,0.3,x2,y2,damage,400,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa,"",Buffxy,5,0)
        flush locals
    endfunction

    function BossFuncSpell46()
        insert BossSpell
        unit u2 = CreateUnit(GetOwningPlayer(u1),'e01C',x2,y2,0)
        int time = 0
        damage = damage / 10
        TimerStart(0.15,true)
        {
            group gg = CreateGroup()
            time = time + 1
            if  time <= 10
                LocAddEffect(x2,y2,"effect_zhendi-water.mdl")
                GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffjs,5,0))
                UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            else
                RemoveUnit(u2)
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell47()
        insert BossSpell
        unit u2 = CreateUnit(GetOwningPlayer(u1),'e000',x1,y1,ang/0.01745)
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        int time = R2I(2000/30)
        group wg = CreateGroup()
        group ug = CreateGroup()
        GroupAddUnit(ug,u2)
        TimerStart(0.002,true)
        {
            group gg = CreateGroup()
            time = time - 1
            if  time > 0
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitXY(u2,x1,y1)
                if  ModuloInteger(time,6) == 0
                    LocAddEffectSetSize(x1,y1,"effect3_az_heiseguangzhu.mdl",1)
                    LocAddEffectSetSize(x1,y1,"effect3_red-zhendi.mdl",1)
                    LocAddEffectSetSize(x1,y1,"effect_az-leiji.mdl",1.5)
                endif
                GroupEnumUnitsInRange(gg,x1,y1,280,GroupHasUnit(GetOwningPlayer(u1),wg,""))
                UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            else
                RemoveUnit(u2)
                GroupClear(wg)
                GroupClear(ug)
                DestroyGroup(wg)
                DestroyGroup(ug)
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell48()
        insert BossSpell
        int time = 0
        damage = damage / 3
        TimerStart(0.3,true)
        {
            group gg = CreateGroup()
            time = time + 1
            if  time <= 3
                AddEffectInArea(x2,y2,380,6,"effect3_red-zhendi.mdl")
                AddEffectInArea(x2,y2,380,6,"effect2_zhendi-qiquan-boom.mdl")
                LocAddEffectSetSize(x2,y2,"effect_AA_bwaxec.mdl",1.2)
                GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Bufflh,4,0))
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

    function BossFuncSpell49()
        insert BossSpell
        AddEffectInAreaSetSizeTimer(x2,y2,250,0.5,9,"effect2_lueshizhe.mdl",1)
        UnitGroupAddDamageTimerAddBuff(u1,0.3,x2,y2,damage,400,false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa,"",Buffxy,5,0)
        flush locals
    endfunction

    function BossFuncSpell50()
        insert BossSpell
        damage = damage / 8
        CreateEffectArea(u1,x2,y2,400,damage,9,0.3,25,0.4,"effect2_az_potm(1)_t1_impact.mdl",false,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_MAGICa)
        flush locals
    endfunction

    function BossFuncSpell51()
        insert BossSpell
        group gg = CreateGroup()
        LocAddEffectSetSize(x2,y2,"effect2_zhendi-yinghua.mdl",1.5)
        LocAddEffectSetSize(x2,y2,"effect_AA_bwaxec.mdl",1.0)
        LocAddEffectSetSize(x2,y2,"effect2_blue-blink-lizi-start.mdl",1.1)
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"effect2_az_goods_force staff(3).mdl","origin",0))
        UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function BossFuncSpell52()
        insert BossSpell
        unit u2 = CreateTmUnit(GetOwningPlayer(u1),"effect2_green-fulan.mdl",x2,y2,0,20,2.0)
        unit u3 = CreateTmUnit(GetOwningPlayer(u1),"effect2_green-fulan.mdl",x2,y2,0,20,1.0)
        unit u4 = CreateTmUnit(GetOwningPlayer(u1),"effect2_zise-buff-guangzhu.mdl",x2,y2,0,20,1.2)
        int time = 0
        damage = damage / 10
        TimerStart(0.3,true)
        {
            group gg = CreateGroup()
            time = time + 1
            if  time <= 10
                GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffcf,2,0))
                UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
            else
                RemoveUnit(u2)
                RemoveUnit(u3)
                RemoveUnit(u4)
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell53()
        insert BossSpell
        UnitTimerAddSkill(u1,'AZ08',1)
        UnitTimerAddSkill(u1,'Avul',1)
        flush locals
    endfunction

    function BossFuncSpell54()
        insert BossSpell
        group gg = CreateGroup()
        AddEffectInArea(x2,y2,380,8,"Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl")
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","origin",0))
        UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function BossFuncSpell55()
        insert BossSpell
        group gg = CreateGroup()
        Ligfunc(u1,null,AddLightningEx("CLPB",false,GetUnitX(u1),GetUnitY(u1),GetUnitZ(u1),x2,y2,0))
        AddEffectInArea(x2,y2,280,4,"effect_AZ_UrsaPsionic_E.mdl")
        GroupEnumUnitsInRange(gg,x2,y2,300,GroupNormalNoStr(GetOwningPlayer(u1),"","origin",0))
        UnitDamageGroup(u1,gg,damage,false,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_MAGIC,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function BossFuncSpell56()
        insert BossSpell
        unit u2 = null
        group gg = CreateGroup()
        GroupEnumUnitsInRange(gg,x1,y1,1000,null)
        loop
            u2 = FirstOfGroup(gg)
            exitwhen u2 == null
            if  GetUnitState(u2,UNIT_STATE_LIFE) > 0 and IsUnitEnemy(u2,GetOwningPlayer(u1)) == false and IsUnitType(u2, UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(GetFilterUnit(), 'Avul') == 0
                UnitAddLife(u2,GetUnitState(u2,UNIT_STATE_MAX_LIFE)*0.1)
                UnitAddEffect(u2,"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
            endif
            GroupRemoveUnit(gg,u2)
        endloop
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function BossFuncSpell57()
        insert BossSpell
        unit u2 = null
        int time = 0
        for num = 1,6
            u2 = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'e000',x1+900*Cos(60*num*0.01745),y1+900*Sin(60*num*0.01745),270)
            RemoveUnitTimer(u2,1)
            BossFuncSpell.execute(u1,u2,'AZ1G')
        end
        TimerStart(2,true)
        {
            time = time + 1
            if  time == 1
                for num = 1,5
                    u2 = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'e000',x1+600*Cos(72*num*0.01745),y1+600*Sin(72*num*0.01745),270)
                    RemoveUnitTimer(u2,1)
                    BossFuncSpell.execute(u1,u2,'AZ1G')
                end
            elseif  time == 2
                u2 = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'e000',x1,y1,270)
                RemoveUnitTimer(u2,1)
                BossFuncSpell.execute(u1,u2,'AZ0O')
                BossFuncSpell.execute(u1,u2,'AZ0S')
            elseif  time == 3
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell(unit wu,unit tu,int id)
        unit u1 = wu
        unit u2 = tu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = GetUnitX(u2)
        real y2 = GetUnitY(u2)
        real ang = Atan2(y2-y1,x2-x1)/0.01745
        int uid = 0
        real damage = 0
        real attack = GetUnitState(u1,ConvertUnitState(0x12))+GetUnitState(u1,ConvertUnitState(0x13))
        BJDebugMsg("BossFuncSpell"+YDWEId2S(id))
        if  id == 'AZ0A'
            damage = attack*12
            BossFuncStart(u1,u2,LINE_A,ang,damage,2,"BossFuncSpell1")
        elseif  id == 'AZ0B'
            damage = attack*12
            BossFuncStart(u1,u2,LINE_A2,ang,damage,2,"BossFuncSpell2")
        elseif  id == 'AZ0C'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell3")
        elseif  id == 'AZ0D'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell4")
        elseif  id == 'AZ0E'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.6,"BossFuncSpell5")
        elseif  id == 'AZ0F'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell6")
        elseif  id == 'AZ0G'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.7,"BossFuncSpell7")
        elseif  id == 'AZ0H'
            damage = attack*12
            BossFuncStart(u1,u2,LINE_B,ang,damage,2,"BossFuncSpell8")
        elseif  id == 'AZ0I'
            damage = attack*12
            BossFuncStart(u1,u2,LINE_A2,ang,damage,2,"BossFuncSpell9")
        elseif  id == 'AZ0J'
            damage = attack*12
            BossFuncStart(u1,u2,LINE_A2,ang,damage,2,"BossFuncSpell10")
        elseif  id == 'AZ0K'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell11")
        elseif  id == 'AZ0L'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.3,"BossFuncSpell12")
        elseif  id == 'AZ0M'
            damage = attack*12
            BossFuncStart(u1,u2,LINE_B,ang,damage,2,"BossFuncSpell13")
        elseif  id == 'AZ0N'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell14")
        elseif  id == 'AZ0O'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell15")
        elseif  id == 'AZ0P'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell16")
        elseif  id == 'AZ0Q'
            damage = attack*12
            BossFuncStart(u1,u2,LINE_B,ang,damage,2,"BossFuncSpell17")
        elseif  id == 'AZ0R'
            damage = attack*12
            BossFuncStart(u1,u2,LINE_A2,ang,damage,2,"BossFuncSpell18")
        elseif  id == 'AZ0S'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_500,ang,damage,2,"BossFuncSpell19")
        elseif  id == 'AZ0T'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell20")
        elseif  id == 'AZ0U'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell21")
        elseif  id == 'AZ0V'
            damage = attack*12
            BossFuncStart(u1,u2,LINE_A2,ang,damage,1.8,"BossFuncSpell22")
        elseif  id == 'AZ0W'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_300,ang,damage,2,"BossFuncSpell23")
        elseif  id == 'AZ0X'
            damage = attack*12
            BossFuncStart(u1,u2,LINE_B,ang,damage,2,"BossFuncSpell24")
        elseif  id == 'AZ0Y'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_200,ang,damage,1.7,"BossFuncSpell25")
        elseif  id == 'AZ0Z'
            damage = attack*12
            BossFuncStart(u1,u2,LINE_B,ang,damage,2,"BossFuncSpell26")
        ////////////////////////////分割线////////////////////////////////
        elseif  id == 'AZ1A'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_200,ang,damage,1.8,"BossFuncSpell27")
        elseif  id == 'AZ1B'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_200,ang,damage,2,"BossFuncSpell28")
        elseif  id == 'AZ1C'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.7,"BossFuncSpell29")
        elseif  id == 'AZ1D'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell30")
        elseif  id == 'AZ1E'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.3,"BossFuncSpell31")
        elseif  id == 'AZ1F'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell32")
        elseif  id == 'AZ1G'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.8,"BossFuncSpell33")
        elseif  id == 'AZ1H'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell34")
        elseif  id == 'AZ1I'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell35")
        elseif  id == 'AZ1J'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell36")
        elseif  id == 'AZ1K'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell37")
        elseif  id == 'AZ1L'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.7,"BossFuncSpell38")
        elseif  id == 'AZ1M'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.9,"BossFuncSpell39")
        elseif  id == 'AZ1N'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell40")
        elseif  id == 'AZ1O'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell41")
        elseif  id == 'AZ1P'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.3,"BossFuncSpell42")
        elseif  id == 'AZ1Q'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.8,"BossFuncSpell43")
        elseif  id == 'AZ1R'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell44")
        elseif  id == 'AZ1S'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell45")
        elseif  id == 'AZ1T'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.9,"BossFuncSpell46")
        elseif  id == 'AZ1U'
            damage = attack*12
            BossFuncStart(u1,u2,LINE_B,ang,damage,2,"BossFuncSpell47")
        elseif  id == 'AZ1V'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.7,"BossFuncSpell48")
        elseif  id == 'AZ1W'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell49")
        elseif  id == 'AZ1X'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.7,"BossFuncSpell50")
        elseif  id == 'AZ1Y'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell51")
        elseif  id == 'AZ1Z'
            damage = attack*12
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.7,"BossFuncSpell52")

        
        elseif  id == 'AZ3A'
            damage = attack*6
            BossFuncStart(u1,u2,'e000',ang,damage,0.1,"BossFuncSpell53")
        elseif  id == 'AZ3B'
            damage = attack*6
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,2,"BossFuncSpell54")
        elseif  id == 'AZ3C'
            damage = attack*6
            BossFuncStart(u1,u2,RAC_A_300,ang,damage,2,"BossFuncSpell55")
        elseif  id == 'AZ3D'
            damage = attack*6
            BossFuncStart(u1,u2,'e000',ang,damage,0.1,"BossFuncSpell56")


        elseif  id == 'AZ3E'
            damage = attack*12
            BossFuncStart(u1,u2,'e000',ang,damage,0.1,"BossFuncSpell57")
        

        ////////////////////////////分割线////////////////////////////////

        elseif  id >= 'AZ2A' and id <= 'AZ2Z'
            if  id == 'AZ2B'
                JJFuncSpell02(u1,x2,y2)
            elseif  id == 'AZ2C'
                JJFuncSpell03(u1,x2,y2)
            elseif  id == 'AZ2D'
                JJFuncSpell04(u1,x2,y2)
            elseif  id == 'AZ2E'
                JJFuncSpell05(u1,x2,y2)
            elseif  id == 'AZ2H'
                JJFuncSpell08(u1,x2,y2)
            elseif  id == 'AZ2I'
                JJFuncSpell09(u1,x2,y2)
            elseif  id == 'AZ2J'
                JJFuncSpell10(u1,x2,y2)
            endif
        endif
        flush locals
    endfunction


endlibrary
