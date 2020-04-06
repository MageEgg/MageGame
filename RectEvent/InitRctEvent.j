scope InitRctEvent initializer InitRctEvent

    rect array PlayerAttackRoomRect

    function InLGF_1()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        if  pid < 4
            if  pid != 0
                if  GetTriggerUnit() == Pu[1]
                    SendPlayerUnit(pid,AttackRoomPostion[pid][1], AttackRoomPostion[pid][2])
                else
                    SetUnitPosition(GetTriggerUnit(),AttackRoomPostion[pid][1], AttackRoomPostion[pid][2])
                endif
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r不要进入别人的练功房！！")
            endif
        endif
    endfunction
    function InLGF_2()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        if  pid < 4
            if  pid != 1
                if  GetTriggerUnit() == Pu[1]
                    SendPlayerUnit(pid,AttackRoomPostion[pid][1], AttackRoomPostion[pid][2])
                else
                    SetUnitPosition(GetTriggerUnit(),AttackRoomPostion[pid][1], AttackRoomPostion[pid][2])
                endif
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r不要进入别人的练功房！！")
            endif
        endif
    endfunction
    function InLGF_3()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        if  pid < 4
            if  pid != 2
                if  GetTriggerUnit() == Pu[1]
                    SendPlayerUnit(pid,AttackRoomPostion[pid][1], AttackRoomPostion[pid][2])
                else
                    SetUnitPosition(GetTriggerUnit(),AttackRoomPostion[pid][1], AttackRoomPostion[pid][2])
                endif
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r不要进入别人的练功房！！")
            endif
        endif
    endfunction
    function InLGF_4()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        if  pid < 4
            if  pid != 3
                if  GetTriggerUnit() == Pu[1]
                    SendPlayerUnit(pid,AttackRoomPostion[pid][1], AttackRoomPostion[pid][2])
                else
                    SetUnitPosition(GetTriggerUnit(),AttackRoomPostion[pid][1], AttackRoomPostion[pid][2])
                endif
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r不要进入别人的练功房！！")
            endif
        endif
    endfunction


    function OutLGF_1()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        

        if  Pu[1] == GetTriggerUnit()
            FlushAttackSummonUnitGroup(pid)
        else
            pid = GetUnitAbilityLevel(GetTriggerUnit(),'AZ99')-1
            if  pid == 0
                real x = AttackRoomPostion[pid][1]
                real y = AttackRoomPostion[pid][2]
                SetUnitPosition(GetTriggerUnit(),x,y)
            endif
            
        endif

    endfunction
    function OutLGF_2()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        
        
        if  Pu[1] == GetTriggerUnit()
            FlushAttackSummonUnitGroup(pid)
        else
            pid = GetUnitAbilityLevel(GetTriggerUnit(),'AZ99')-1

            if  pid == 1
                real x = AttackRoomPostion[pid][1]
                real y = AttackRoomPostion[pid][2]
                SetUnitPosition(GetTriggerUnit(),x,y)
            endif
            
        endif

    endfunction
    function OutLGF_3()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        
        
        if  Pu[1] == GetTriggerUnit()
            FlushAttackSummonUnitGroup(pid)
        else
            pid = GetUnitAbilityLevel(GetTriggerUnit(),'AZ99')-1
            if  pid == 2
                real x = AttackRoomPostion[pid][1]
                real y = AttackRoomPostion[pid][2]
                SetUnitPosition(GetTriggerUnit(),x,y)
            endif
            
        endif

    endfunction
    function OutLGF_4()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        
        
        if  Pu[1] == GetTriggerUnit()
            FlushAttackSummonUnitGroup(pid)
        else
            pid = GetUnitAbilityLevel(GetTriggerUnit(),'AZ99')-1
            if  pid == 3
                real x = AttackRoomPostion[pid][1]
                real y = AttackRoomPostion[pid][2]
                SetUnitPosition(GetTriggerUnit(),x,y)
            endif
            
        endif

    endfunction
    
    function InitRctEvent()

        InitRctEventFunc(gg_rct_LGF_1,false,function OutLGF_1)
        InitRctEventFunc(gg_rct_LGF_2,false,function OutLGF_2)
        InitRctEventFunc(gg_rct_LGF_3,false,function OutLGF_3)
        InitRctEventFunc(gg_rct_LGF_4,false,function OutLGF_4)

        InitRctEventFunc(gg_rct_LGF_1,true,function InLGF_1)
        InitRctEventFunc(gg_rct_LGF_2,true,function InLGF_2)
        InitRctEventFunc(gg_rct_LGF_3,true,function InLGF_3)
        InitRctEventFunc(gg_rct_LGF_4,true,function InLGF_4)

        PlayerAttackRoomRect[0] = gg_rct_LGF_1
        PlayerAttackRoomRect[1] = gg_rct_LGF_2
        PlayerAttackRoomRect[2] = gg_rct_LGF_3
        PlayerAttackRoomRect[3] = gg_rct_LGF_4
    endfunction
    
endscope
