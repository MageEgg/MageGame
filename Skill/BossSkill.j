library BossSkill uses AbilityUI,OtherDamageTimer,BossSkill2

    private unit boss = null
    private real bossx = 0
    private real bossy = 0
    private real bossdamage = 0

    #define RAC_A_200   'e013'
    #define RAC_A_300   'e00H'
    #define RAC_A_400   'e00E'
    #define RAC_A_500   'e00F'
    #define RAC_A_600   'e00G'

    #define RAC_B_200   'e012'
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

    //true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa

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
        CreateTm(u1,'e00P',x1,y1,ang,damage,1,0,210,1500,0,50,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
        TimerStart(0.4,true)
        {
            time = time + 1
            if  time <= 2
                CreateTm(u1,'e00P',x1,y1,ang,damage,1,0,210,1500,0,50,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
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
        CreateTm(u1,'e00Q',x1,y1,ang,damage,3,15,220,1200,0,50,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
        flush locals
    endfunction

    function BossFuncSpell3()
        insert BossSpell
        AddEffectInArea(x2,y2,370,7,"effect_tx_new (2).mdx")
        //延迟伤害 伤害来源 延迟时间 坐标x y 伤害 伤害范围 伤害类型4个 选取特效 buffId buff等级 buff命令
        UnitGroupAddDamageTimerAddBuff(u1,0.3,x2,y2,damage,400,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa,"",0,0,0)
        flush locals
    endfunction

    function BossFuncSpell4()
        insert BossSpell
        group gg = CreateGroup()
        AddEffectInArea(x2,y2,390,25,"effect2_az_nevermore_r2(1).mdl")
        LocAddEffect(x2,y2,"effect3_desecrategreen.mdl")
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
        damage = damage / 2
        TimerStart(0.4,true)
        {
            group gg = CreateGroup()
            unit uu = null
            time = time + 1
            if  time <= 3
                uu = CreateUnit(GetOwningPlayer(u1),'e00S',x1,y1,ang/0.01745)
                RemoveUnitTimer(uu,1)
                GroupEnumUnitsInRange(gg,newx,newy,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
        UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
                UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
                UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
        CreateTm(u1,'e00U',x1,y1,ang,damage,5,10,220,1200,0,50,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
        flush locals
    endfunction

    function BossFuncSpell10()
        insert BossSpell
        damage = damage / 3.5
        CreateTm(u1,'e00V',x1,y1,ang,damage,5,10,220,1200,0,50,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
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
                UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
            unit uu = null
            real newx = 0
            real newy = 0
            if  time <= 9
                if  time == 1 or time == 4 or time == 7
                    newx = x2
                    newy = y2
                    uu = CreateUnit(GetOwningPlayer(u1),'e00W',newx,newy,0)
                    RemoveUnitTimer(uu,0.8)
                    UnitGroupAddDamageTimerAddBuff(u1,0.24,x2,y2,damage,150,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa,"",0,0,0)
                elseif  time == 2 or time == 5 or time == 8
                    for num = 1,6
                        newx = x2+150*Cos(60*num*0.01745)
                        newy = y2+150*Sin(60*num*0.01745)
                        uu = CreateUnit(GetOwningPlayer(u1),'e00W',newx,newy,0)
                        RemoveUnitTimer(uu,0.8)
                    end
                    UnitGroupAddDamageTimerAddBuff(u1,0.24,x2,y2,damage,300,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa,"",0,0,0)
                elseif  time == 3 or time == 6 or time == 9
                    for num = 1,8
                        newx = x2+300*Cos(45*num*0.01745)
                        newy = y2+300*Sin(45*num*0.01745)
                        uu = CreateUnit(GetOwningPlayer(u1),'e00W',newx,newy,0)
                        RemoveUnitTimer(uu,0.8)
                    end
                    UnitGroupAddDamageTimerAddBuff(u1,0.24,x2,y2,damage,450,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa,"",0,0,0)
                endif
            else    
                endtimer
            endif
            GroupClear(gg)
            DestroyGroup(gg)
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
                UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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

    function BossFuncSpell14()
        insert BossSpell
        group gg = CreateGroup()
        AddEffectInArea(x2,y2,380,15,"effect2_by_wood_effect2_yubanmeiqin_lightning_luolei.mdl")
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
        UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function BossFuncSpell16()
        insert BossSpell
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        int time = R2I(Pdis(x1,y1,x2,y2)/30)
        SetUnitAnimation(u1,"attack")
        TimerStart(0.02,true)
        {
            group gg = null
            time = time - 1
            if  time > 0
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitXY(u1,x1,y1)
                if  ModuloInteger(time,6) == 0
                    LocAddEffectSetSize(x1,y1,"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl",2)
                endif
            else
                SetUnitXY(u1,x1,y1)
                SetUnitAnimation(u1,"attack")
                gg = CreateGroup()
                LocAddEffectSetSize(x2,y2,"effect2_zhendi-qiquan-boom.mdl",2.5)
                LocAddEffectSetSize(x2,y2,"effect2_by_wood_gongchengsipai_6.mdl",1.8)
                GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
                GroupClear(gg)
                DestroyGroup(gg)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell17()
        insert BossSpell
        CreateTm(u1,'e00Z',x1,y1,ang,damage,1,0,210,1500,0,50,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
        flush locals
    endfunction

    function BossFuncSpell18()
        insert BossSpell
        int time = 0
        damage = damage / 6
        //伤害来源,马甲id,x1,y1,初始角度,伤害,数量,间距角度,伤害范围,最远距离,伤害类型,移动时间间隔,马甲高度
        CreateTm(u1,'e00X',x1,y1,ang,damage,3,15,220,1200,0,50,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
        TimerStart(0.4,true)
        {
            time = time + 1
            if  time <= 2
                CreateTm(u1,'e00X',x1,y1,ang,damage,3,15,220,1200,0,50,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
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
        CreateTm(u1,'e00X',x2,y2,ang,damage,10,36,220,500,0,50,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
        flush locals
    endfunction

    function BossFuncSpell20()
        insert BossSpell
        group gg = CreateGroup()
        LocAddEffectSetSize(x2,y2,"effect_[dz.spell]001.mdl",0.8)
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
        UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
                    CreateTm(u1,'e00V',GetUnitX(u1)+GetRandomReal(-160,160),GetUnitY(u1)+GetRandomReal(-160,160),ang,damage,1,0,220,1200,0,50,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
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
        LocAddEffectSetSize(x1,y1,"effect2_az_goods_blink(green).mdl",1.8)
        SetUnitScale(u1,0.01,0.01,0.01)
        TimerStart(0.02,true)
        {
            time = time - 1
            if  time > 0
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitXY(u1,x1,y1)
                SetUnitXY(u2,x1,y1)
            else
                RemoveUnit(u2)
                SetUnitXY(u1,x1,y1)
                SetUnitScale(u1,size,size,size)
                SetUnitAnimation(u1,"attack")
                LocAddEffectSetSize(x1,y1,"effect2_az_goods_blink(green).mdl",1.8)
                AddEffectInAreaOfUnitAndAnimation(x1,y1,290,5,'e010',"stand",1,0.8)
                UnitGroupAddDamageTimerAddBuff(u1,0.24,x2,y2,damage,300,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa,"",0,0,0)
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
                    RemoveUnitTimer(CreateUnit(GetOwningPlayer(u1),'e010',x1,y1,GetRandomReal(0,360)),0.8)
                endif
                GroupEnumUnitsInRange(gg,x1,y1,280,GroupHasUnit(GetOwningPlayer(u1),wg,""))
                UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
        unit u2 = CreateUnit(GetOwningPlayer(u1),'e011',x2,y2,0)
        int time = 0
        damage = damage / 5
        TimerStart(0.3,true)
        {
            group gg = CreateGroup()
            time = time + 1
            if  time <= 5
                AddEffectInArea(x2,y2,200,8,"Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl")
                GroupEnumUnitsInRange(gg,x2,y2,200,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
        CreateTm(u1,'e014',x1,y1,ang,damage,1,0,210,1000,0,50,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
        TimerStart(0.3,true)
        {
            time = time + 1
            if  time <= 2
                CreateTm(u1,'e014',x1,y1,ang,damage,1,0,210,1000,0,50,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
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
                    RemoveUnitTimer(CreateUnit(GetOwningPlayer(u1),'e015',x2,y2,ran),1)
                    RemoveUnitTimer(CreateUnit(GetOwningPlayer(u1),'e015',x2,y2,ran+90),1)
                end
                LocAddEffectSetSize(x2,y2,"effect2_az_cocoguanyu_t2_death.mdl",1)
                GroupEnumUnitsInRange(gg,x2,y2,200,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
                UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
        LocAddEffectSetSize(x2,y2,"effect_shengguang.mdl",2.4)
        GroupEnumUnitsInRange(gg,x2,y2,200,GroupNormalNoStr(GetOwningPlayer(u1),"","",0))
        UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
                UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
        LocAddEffectSetSize(x1,y1,"effect2_az_goods_blink(green).mdl",1.8)
        SetUnitScale(u1,0.01,0.01,0.01)
        damage = damage /3
        TimerStart(0.02,true)
        {
            time = time - 1
            if  time > 0
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitXY(u1,x1,y1)
                SetUnitXY(u2,x1,y1)
            else
                RemoveUnit(u2)
                SetUnitXY(u1,x1,y1)
                SetUnitScale(u1,size,size,size)
                SetUnitAnimation(u1,"attack")
                LocAddEffectSetSize(x1,y1,"effect2_az_goods_blink(green).mdl",1.8)
                BossFuncSpell29Ex(u1,damage)
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
        UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
        LocAddEffectSetSize(x1,y1,"effect_az_pafeathermoon_b.mdl",2)
        SetUnitScale(u1,0.01,0.01,0.01)
        TimerStart(0.007,true)
        {
            time = time - 1
            if  time > 0
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
                SetUnitXY(u1,x1,y1)
                SetUnitScale(u1,size,size,size)
                SetUnitAnimation(u1,"attack")
                LocAddEffectSetSize(x1,y1,"effect_az_pafeathermoon_b.mdl",2)
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
        SetUnitInvulnerable(u1,false)
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
                UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
                GroupClear(gg)
                DestroyGroup(gg)
                PauseUnit(u1,false)
                SetUnitInvulnerable(u1,true)
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
        unit u3 = CreateUnit(GetOwningPlayer(u1),'e016',x1,y1,ang/0.01745)
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
                UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
        

        
        
        flush locals
    endfunction

    function BossFuncSpell34()
        insert BossSpell
        

        
        
        flush locals
    endfunction

    function BossFuncSpell35()
        insert BossSpell
        

        
        
        flush locals
    endfunction

    function BossFuncSpell36()
        insert BossSpell
        

        
        
        flush locals
    endfunction

    function BossFuncSpell37()
        insert BossSpell
        

        
        
        flush locals
    endfunction

    function BossFuncSpell38()
        insert BossSpell
        int time = 0
        damage = damage / 3
        TimerStart(0.3,false)
        {
            group gg = CreateGroup()
            time = time + 1
            if  time <= 3
                AddEffectInArea(x2,y2,380,6,"effect3_red-zhendi.mdl")
                AddEffectInArea(x2,y2,380,6,"effect2_zhendi-qiquan-boom.mdl")
                LocAddEffectSetSize(x2,y2,"effect_AA_bwaxec.mdl",1.2)
                GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Bufflh,4,0))
                UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
        TimerStart(0.1,false)
        {
            group gg = CreateGroup()
            time = time + 1
            if  time <= 10
                AddEffectInArea(x2,y2,390,3,"effect2_az_nevermoreice_x1.mdl")
                GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffdj,2,0))
                UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
        AddEffectInArea(x2,y2,280,4,"effect2_az_magina[2]_v.mdl")
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffcm,4,0))
        UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function BossFuncSpell41()
        insert BossSpell
        group gg = CreateGroup()
        LocAddEffectSetSize(x2,y2,"effect_az_earthshaker_a.mdl",1)
        AddEffectInAreaOfUnitAndAnimation(x1,y1,380,8,'e017',"birth",1,0.8)
        GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffxy,3,0))
        UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
        GroupClear(gg)
        DestroyGroup(gg)
        flush locals
    endfunction

    function BossFuncSpell42()
        insert BossSpell
        int time = 0
        damage = damage / 3
        TimerStart(1,false)
        {
            group gg = CreateGroup()
            time = time + 1
            if  time <= 3
                AddEffectInAreaOfUnitAndAnimation(x1,y1,380,8,'e018',"birth",1,1)
                GroupEnumUnitsInRange(gg,x2,y2,400,GroupNormalNoStrAddBuff(GetOwningPlayer(u1),"",Buffcr,1,0))
                UnitDamageGroup(u1,gg,damage,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL,null)
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
                    CreateTm(u1,'e019',GetUnitX(u1)+GetRandomReal(-160,160),GetUnitY(u1)+GetRandomReal(-160,160),ang,damage,1,0,220,1200,0,50,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
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
        unit uu = CreateUnit(GetOwningPlayer(u1),'e01A',x2,y2,215)
        RemoveUnitTimer(uu,1)
        UnitGroupAddDamageTimerAddBuff(u1,0.3,x2,y2,damage,400,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa,"",Buffxy,3,0)
        flush locals
    endfunction

    function BossFuncSpell45()
        insert BossSpell
        unit uu = CreateUnit(GetOwningPlayer(u1),'e01A',x2,y2,215)
        RemoveUnitTimer(uu,1)
        UnitGroupAddDamageTimerAddBuff(u1,0.3,x2,y2,damage,400,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa,"",Buffxy,5,0)
        flush locals
    endfunction

    function BossFuncSpell46()
        insert BossSpell

        flush locals
    endfunction

    function BossFuncSpell47()
        insert BossSpell

        flush locals
    endfunction

    function BossFuncSpell48()
        insert BossSpell

        flush locals
    endfunction

    function BossFuncSpell49()
        insert BossSpell

        flush locals
    endfunction

    function BossFuncSpell50()
        insert BossSpell

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
        BJDebugMsg("BossFuncSpell"+YDWEId2S(id))
        if  id == 'AZ0A'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,LINE_A,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0B'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,LINE_A2,ang,damage,1.5,"BossFuncSpell2")
        elseif  id == 'AZ0C'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.5,"BossFuncSpell3")
        elseif  id == 'AZ0D'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.5,"BossFuncSpell4")
        elseif  id == 'AZ0E'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.1,"BossFuncSpell5")
        elseif  id == 'AZ0F'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.5,"BossFuncSpell6")
        elseif  id == 'AZ0G'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.2,"BossFuncSpell7")
        elseif  id == 'AZ0H'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,LINE_B,ang,damage,1.5,"BossFuncSpell8")
        elseif  id == 'AZ0I'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,LINE_A2,ang,damage,1.5,"BossFuncSpell9")
        elseif  id == 'AZ0J'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,LINE_A2,ang,damage,1.5,"BossFuncSpell10")
        elseif  id == 'AZ0K'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.5,"BossFuncSpell11")
        elseif  id == 'AZ0L'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.3,"BossFuncSpell12")
        elseif  id == 'AZ0M'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,LINE_B,ang,damage,1.5,"BossFuncSpell13")
        elseif  id == 'AZ0N'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.5,"BossFuncSpell14")
        elseif  id == 'AZ0O'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.5,"BossFuncSpell15")
        elseif  id == 'AZ0P'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.5,"BossFuncSpell16")
        elseif  id == 'AZ0Q'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,LINE_B,ang,damage,1.5,"BossFuncSpell17")
        elseif  id == 'AZ0R'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,LINE_A2,ang,damage,1.5,"BossFuncSpell18")
        elseif  id == 'AZ0S'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_500,ang,damage,1.5,"BossFuncSpell19")
        elseif  id == 'AZ0T'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.5,"BossFuncSpell20")
        elseif  id == 'AZ0U'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.5,"BossFuncSpell21")
        elseif  id == 'AZ0V'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,LINE_A2,ang,damage,1.3,"BossFuncSpell22")
        elseif  id == 'AZ0W'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_300,ang,damage,1.5,"BossFuncSpell23")
        elseif  id == 'AZ0X'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,LINE_B,ang,damage,1.5,"BossFuncSpell24")
        elseif  id == 'AZ0Y'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_200,ang,damage,1.2,"BossFuncSpell25")
        elseif  id == 'AZ0Z'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,LINE_B,ang,damage,1.2,"BossFuncSpell26")
        ////////////////////////////分割线////////////////////////////////
        elseif  id == 'AZ1A'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_200,ang,damage,1.2,"BossFuncSpell27")
        elseif  id == 'AZ1B'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_200,ang,damage,1.5,"BossFuncSpell28")
        elseif  id == 'AZ1C'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.2,"BossFuncSpell29")
        elseif  id == 'AZ1D'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.5,"BossFuncSpell30")
        elseif  id == 'AZ1E'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.5,"BossFuncSpell31")
        elseif  id == 'AZ1F'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.3,"BossFuncSpell32")
        elseif  id == 'AZ1G'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.2,"BossFuncSpell33")
        elseif  id == 'AZ1H'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.2,"BossFuncSpell34")
        elseif  id == 'AZ1I'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.2,"BossFuncSpell35")
        elseif  id == 'AZ1J'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.2,"BossFuncSpell36")
        elseif  id == 'AZ1K'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.2,"BossFuncSpell37")
        elseif  id == 'AZ1L'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.2,"BossFuncSpell38")

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
