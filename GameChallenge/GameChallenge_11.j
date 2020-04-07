library GameChallenge11 uses GameChallengeBase

    function OpenChallengeWM(int pid)
        SendPlayerUnit(pid,GameChallengeWM_OriginX,GameChallengeWM_OriginY)
    endfunction

    function EnterChallengeRct_WM_0()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        if  pid < 4
            if  pid != 0
                if  GetTriggerUnit() == Pu[1]
                    SendPlayerUnit(pid,AttackRoomPostion[pid][1], AttackRoomPostion[pid][2])
                else
                    SetUnitPosition(GetTriggerUnit(),AttackRoomPostion[pid][1], AttackRoomPostion[pid][2])
                endif
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r不要进入别人的万魔窟！！")
            endif
        endif
    endfunction

    function EnterChallengeRct_WM_1()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        if  pid < 4
            if  pid != 1
                if  GetTriggerUnit() == Pu[1]
                    SendPlayerUnit(pid,AttackRoomPostion[pid][1], AttackRoomPostion[pid][2])
                else
                    SetUnitPosition(GetTriggerUnit(),AttackRoomPostion[pid][1], AttackRoomPostion[pid][2])
                endif
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r不要进入别人的万魔窟！！")
            endif
        endif
    endfunction

    function EnterChallengeRct_WM_2()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        if  pid < 4
            if  pid != 2
                if  GetTriggerUnit() == Pu[1]
                    SendPlayerUnit(pid,AttackRoomPostion[pid][1], AttackRoomPostion[pid][2])
                else
                    SetUnitPosition(GetTriggerUnit(),AttackRoomPostion[pid][1], AttackRoomPostion[pid][2])
                endif
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r不要进入别人的万魔窟！！")
            endif
        endif
    endfunction

    function EnterChallengeRct_WM_3()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        if  pid < 4
            if  pid != 3
                if  GetTriggerUnit() == Pu[1]
                    SendPlayerUnit(pid,AttackRoomPostion[pid][1], AttackRoomPostion[pid][2])
                else
                    SetUnitPosition(GetTriggerUnit(),AttackRoomPostion[pid][1], AttackRoomPostion[pid][2])
                endif
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r不要进入别人的万魔窟！！")
            endif
        endif
    endfunction

    function LeaveChallengeRct_WM_0()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        if  Pu[1] == GetTriggerUnit()
            FlushWMSummonUnitGroup(pid)
        else
            pid = GetUnitAbilityLevel(GetTriggerUnit(),'AZ99')-1
            if  pid == 0
                SetUnitPosition(GetTriggerUnit(),GameChallengeWM_OriginX,GameChallengeWM_OriginY)
            endif
        endif
    endfunction
    function LeaveChallengeRct_WM_1()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        if  Pu[1] == GetTriggerUnit()
            FlushWMSummonUnitGroup(pid)
        else
            pid = GetUnitAbilityLevel(GetTriggerUnit(),'AZ99')-1
            if  pid == 1
                SetUnitPosition(GetTriggerUnit(),GameChallengeWM_OriginX,GameChallengeWM_OriginY)
            endif
        endif
    endfunction
    function LeaveChallengeRct_WM_2()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        if  Pu[1] == GetTriggerUnit()
            FlushWMSummonUnitGroup(pid)
        else
            pid = GetUnitAbilityLevel(GetTriggerUnit(),'AZ99')-1
            if  pid == 2
                SetUnitPosition(GetTriggerUnit(),GameChallengeWM_OriginX,GameChallengeWM_OriginY)
            endif
        endif
    endfunction

    function LeaveChallengeRct_WM_3()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        if  Pu[1] == GetTriggerUnit()
            FlushWMSummonUnitGroup(pid)
        else
            pid = GetUnitAbilityLevel(GetTriggerUnit(),'AZ99')-1
            if  pid == 3
                SetUnitPosition(GetTriggerUnit(),GameChallengeWM_OriginX,GameChallengeWM_OriginY)
            endif
        endif
    endfunction
    
    function InitGameChallenge_11()

        ChallengeRct_WM(0) = gg_rct_ChallengeRct_MK_0
        ChallengeRct_WM(1) = gg_rct_ChallengeRct_MK_1
        ChallengeRct_WM(2) = gg_rct_ChallengeRct_MK_2
        ChallengeRct_WM(3) = gg_rct_ChallengeRct_MK_3

        for pid = 0,3
            if  pid == 0
                GameChallengeWM_OriginX = 10496
                GameChallengeWM_OriginY = -928
                GameChallengeWM_MX = 9568
                GameChallengeWM_MY = 0
            elseif  pid == 1
                GameChallengeWM_OriginX = 13632
                GameChallengeWM_OriginY = -928	
                GameChallengeWM_MX = 12704
                GameChallengeWM_MY = 0
            elseif  pid == 2
                GameChallengeWM_OriginX = 13632
                GameChallengeWM_OriginY = -4000
                GameChallengeWM_MX = 12704
                GameChallengeWM_MY = -3072
            elseif  pid == 3
                GameChallengeWM_OriginX = 10496
                GameChallengeWM_OriginY = -4000
                GameChallengeWM_MX = 9568
                GameChallengeWM_MY = -3072
            endif
        end

        InitRctEventFunc(ChallengeRct_WM(0),true,function EnterChallengeRct_WM_0)
        InitRctEventFunc(ChallengeRct_WM(1),true,function EnterChallengeRct_WM_1)
        InitRctEventFunc(ChallengeRct_WM(2),true,function EnterChallengeRct_WM_2)
        InitRctEventFunc(ChallengeRct_WM(3),true,function EnterChallengeRct_WM_3)

        InitRctEventFunc(ChallengeRct_WM(0),false,function LeaveChallengeRct_WM_0)
        InitRctEventFunc(ChallengeRct_WM(1),false,function LeaveChallengeRct_WM_1)
        InitRctEventFunc(ChallengeRct_WM(2),false,function LeaveChallengeRct_WM_2)
        InitRctEventFunc(ChallengeRct_WM(3),false,function LeaveChallengeRct_WM_3)

    endfunction

endlibrary
