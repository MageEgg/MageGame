library BossSkill uses AbilityUI,OtherDamageTimer,BossSkill2

    private unit boss = null
    private real bossx = 0
    private real bossy = 0
    private real bossdamage = 0

    #define RAC_A_300   'e00H'
    #define RAC_A_400   'e00E'
    #define RAC_A_500   'e00F'
    #define RAC_A_600   'e00G'

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
            if  time < 5
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
        //龙王
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
        

        
        
        flush locals
    endfunction
    function BossFuncSpell25()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell26()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell27()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell28()
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
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.5,"BossFuncSpell12")
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
            BossFuncStart(u1,u2,LINE_A2,ang,damage,1.5,"BossFuncSpell22")
        elseif  id == 'AZ0W'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_300,ang,damage,1.5,"BossFuncSpell23")
        elseif  id == 'AZ0X'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.5,"BossFuncSpell15")
        elseif  id == 'AZ0Y'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,RAC_A_400,ang,damage,1.5,"BossFuncSpell15")
        ////////////////////////////分割线////////////////////////////////
        elseif  id == 'AZ1A'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ1B'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ1C'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ1D'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ1E'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ1F'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ1G'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ1H'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ1I'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ1J'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ1K'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ1L'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ1M'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ1N'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ1O'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ1P'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ1Q'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
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