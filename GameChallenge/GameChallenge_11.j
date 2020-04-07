library GameChallenge11 uses GameChallengeBase

    function CreateChallengeWM(int pid)
        int lv = PlayerChallengeWMCos
        real x = GameChallengeWM_MX
        real y = GameChallengeWM_MY
        unit u = null
        int bosstype = GetRandomInt(0,7) //8种
        int unitnum = GetRandomInt(9,18) //数量
        u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut30'+bosstype,x,y,270)
        UnitAddAbility(u,'AZ99')
        SetUnitAbilityLevel(u,'AZ99',pid+1)
        AddWMSummonUnit(pid,u)
        IssuePointOrderById(u,851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))

        for num = 1,unitnum
            u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut40'+GetRandomInt(0,7),x,y,270)
            if  num <= 3
                SetUnitRealState(u,1,GetUnitRealState(u,1)*5)
                SetUnitRealState(u,5,GetUnitRealState(u,5)*15)
                SetUnitVertexColor(u,255,100,100,100)
            endif
            UnitAddAbility(u,'AZ99')
            SetUnitAbilityLevel(u,'AZ99',pid+1)
            AddWMSummonUnit(pid,u)
            IssuePointOrderById(u,851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
        end
    endfunction

    function SetChallengeWMCS(int id)
        int pid = id
        int time = 1
        SetUnitIntState(Pu[1],'WMCS',time)
        TimerStart(1,true)
        {
            if  time < 30
                time = time + 1
                SetUnitIntState(Pu[1],'WMCS',time)
                if  time == 30
                    SetUnitIntState(Pu[1],'WMCS',0)
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function OpenChallengeWM(int pid)
        if  GetUnitIntState(Pu[1],'WMCS') == 0
            SetChallengeWMCS(pid)
            SendPlayerUnit(pid,GameChallengeWM_OriginX,GameChallengeWM_OriginY)
            CreateChallengeWM(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[万魔窟]：|r当前挑战|cffffcc00万魔窟第"+I2S(PlayerChallengeWMCos+1)+"层|r！")
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[万魔窟]：|r传送冷却中，剩余"+I2S(30-GetUnitIntState(Pu[1],'WMCS'))+"秒！") 
        endif
    endfunction

    function CreateChallengeWMEx(int id)
        int pid = id
        TimerStart(1,false)
        {
            if  IsLocInRect(ChallengeRct_WM(pid),GetUnitX(Pu[1]),GetUnitY(Pu[1])) == true
                CreateChallengeWM(pid)
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[万魔窟]：|r|cffff8000自动为您召唤下一层BOSS！|r")
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function GameTeamChallengDeath_C(int pid,unit u2)
        int uid = GetUnitTypeId(u2)
        FlushWMSummonUnitGroup(pid)
        PlayerChallengeWMCos = PlayerChallengeWMCos + 1
        UnitAddEffectSetSize(Pu[1],"effect_e_buffattack.mdl",3.2)
        CreateChallengeWMEx(pid)
        DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[万魔窟]：|r成功击杀"+GetUnitName(u2)+"，|cffffff80万魔窟层数升级为第"+I2S(PlayerChallengeWMCos+1)+"层|r！")
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
            WMSummonUnitGroup[pid] = CreateGroup()
            if  pid == 0
                GameChallengeWM_OriginX = 10496
                GameChallengeWM_OriginY = -928
                GameChallengeWM_MX = 9632
                GameChallengeWM_MY = -64
            elseif  pid == 1
                GameChallengeWM_OriginX = 13632
                GameChallengeWM_OriginY = -928	
                GameChallengeWM_MX = 12768
                GameChallengeWM_MY = -64
            elseif  pid == 2
                GameChallengeWM_OriginX = 13632
                GameChallengeWM_OriginY = -4000
                GameChallengeWM_MX = 12768
                GameChallengeWM_MY = -3136
            elseif  pid == 3
                GameChallengeWM_OriginX = 10496
                GameChallengeWM_OriginY = -4000
                GameChallengeWM_MX = 9632
                GameChallengeWM_MY = -3136
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
