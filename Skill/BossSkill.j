library BossSkill uses AbilityUI,OtherDamageTimer

    private unit boss = null
    private real bossx = 0
    private real bossy = 0
    private real bossdamage = 0

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
        real x = bossx
        real y = bossy
        real damage = bossdamage
    endpiece

    //////////////////////////模版////////////////////////////
    //////////////////////////模版////////////////////////////
    //////////////////////////模版////////////////////////////
    function BossFuncStartTemplate()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    //////////////////////////模版////////////////////////////
    //////////////////////////模版////////////////////////////
    //////////////////////////模版////////////////////////////


    function BossFuncSpell1()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction

    function BossFuncSpell2()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell3()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell4()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell5()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell6()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell7()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction

    function BossFuncSpell8()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell9()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell10()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell11()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction

    function BossFuncSpell12()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell13()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell14()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell15()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell16()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction

    function BossFuncSpell17()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell18()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell19()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell20()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell21()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction

    function BossFuncSpell22()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell23()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell24()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell25()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell26()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell27()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction
    function BossFuncSpell28()
        insert BossSpell
        

        
        FlushBoss()
        flush locals
    endfunction

    function BossFuncSpell(unit wu,unit tu,int id)
        unit u1 = wu
        unit u2 = tu
        int uid = 0
        real ang = 0
        real damage = 0
        if  id == 'AZA0'
            damage = GetUnitRealState(u1,1)
            BossFuncStart(u1,u2,uid,ang,damage,1.5,"BossFuncSpell1")
        endif
        flush locals
    endfunction


endlibrary
