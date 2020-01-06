library BossSkill uses AbilityUI,OtherDamageTimer

    private unit boss = null
    private real bossx = 0
    private real bossy = 0
    private real bossdamage = 0

    #define RAC_A_300   'e00E'
    #define RAC_A_400   'e00F'
    #define RAC_A_500   'e00G'
    #define RAC_A_600   'e00H'

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
        real x1 = GetUnitX(u2)
        real y1 = GetUnitY(u2)
        unit u3 = CreateUnit(GetOwningPlayer(u1),uid,x1,y1,ang)
        real damage = dam
        string funcstring = s
        TimerStart(time,false)
        {
            RemoveUnit(u3)
            SetBoss(u1,x1,y1,damage)
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
        damage = damage / 2
        //伤害来源,马甲id,x1,y1,初始角度,伤害,数量,间距角度,伤害范围,最远距离,伤害类型,移动时间间隔,马甲高度
        CreateTm(u1,'e00P',x1,y1,ang,damage,1,0,210,1200,0,50,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
        TimerStart(0.4,false)
        {
            CreateTm(u1,'e00P',x1,y1,ang,damage,1,0,210,1200,0,50,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function BossFuncSpell2()
        insert BossSpell
        damage = damage / 2
        //伤害来源,马甲id,x1,y1,初始角度,伤害,数量,间距角度,伤害范围,最远距离,伤害类型,移动时间间隔,马甲高度
        CreateTm(u1,'e00Q',x1,y1,ang,damage,3,15,220,1000,0,50,true,false,ATTACK_TYPE_CHAOSa,DAMAGE_TYPE_NORMALa)
        flush locals
    endfunction
    function BossFuncSpell3()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell4()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell5()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell6()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell7()
        insert BossSpell
        

        
        
        flush locals
    endfunction

    function BossFuncSpell8()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell9()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell10()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell11()
        insert BossSpell
        

        
        
        flush locals
    endfunction

    function BossFuncSpell12()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell13()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell14()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell15()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell16()
        insert BossSpell
        

        
        
        flush locals
    endfunction

    function BossFuncSpell17()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell18()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell19()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell20()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell21()
        insert BossSpell
        

        
        
        flush locals
    endfunction

    function BossFuncSpell22()
        insert BossSpell
        

        
        
        flush locals
    endfunction
    function BossFuncSpell23()
        insert BossSpell
        

        
        
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
        int uid = 0
        real ang = 0
        real damage = 0
        if  id == 'AZ0A'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,LINE_A,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0B'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0C'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0D'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0E'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0F'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0G'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0H'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0I'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0J'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0K'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0L'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0M'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0N'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0O'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0P'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        elseif  id == 'AZ0Q'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
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
        endif
        flush locals
    endfunction


endlibrary
