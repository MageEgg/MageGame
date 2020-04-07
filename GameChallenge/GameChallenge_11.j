library GameChallenge11 uses GameChallengeBase

    real array GameChallengeWMArrayReal[40][200]

    #define GameChallengeWM_Life            GameChallengeWMArrayReal[1]
    #define GameChallengeWM_Attack          GameChallengeWMArrayReal[2]
    #define GameChallengeWM_PrizeA          GameChallengeWMArrayReal[3]
    #define GameChallengeWM_PrizeB          GameChallengeWMArrayReal[4]
    #define GameChallengeWM_PrizeC          GameChallengeWMArrayReal[5]

    function InitGameChallengeWM_MDate(int num,real life,real attack,real prizea,real prizeb,real prizec)
        GameChallengeWM_Life[num] = life
        GameChallengeWM_Attack[num] = attack
        GameChallengeWM_PrizeA[num] = prizea
        GameChallengeWM_PrizeB[num] = prizeb
        GameChallengeWM_PrizeC[num] = prizec
    endfunction

    function InitGameChallengeWM_M()
        InitGameChallengeWM_MDate(1,1,1,2,28,6)
        InitGameChallengeWM_MDate(2,1.19,1.09,2,28,6)
        InitGameChallengeWM_MDate(3,1.42,1.2,2,28,6)
        InitGameChallengeWM_MDate(4,1.69,1.31,2,28,6)
        InitGameChallengeWM_MDate(5,3.1,1.93,5,28,6)
        InitGameChallengeWM_MDate(6,3.63,2.14,2,28,6)
        InitGameChallengeWM_MDate(7,4.3,2.42,2,28,6)
        InitGameChallengeWM_MDate(8,4.7,2.63,2,28,6)
        InitGameChallengeWM_MDate(9,5.62,3.11,2,28,6)
        InitGameChallengeWM_MDate(10,10.12,4.93,5,100,50)
        InitGameChallengeWM_MDate(11,12.51,5.5,2,28,6)
        InitGameChallengeWM_MDate(12,15.48,6.15,2,28,6)
        InitGameChallengeWM_MDate(13,19.14,6.86,2,28,6)
        InitGameChallengeWM_MDate(14,24.33,7.78,2,28,6)
        InitGameChallengeWM_MDate(15,44.1,10.53,5,28,6)
        InitGameChallengeWM_MDate(16,51.87,11.43,2,28,6)
        InitGameChallengeWM_MDate(17,63.53,12.75,2,28,6)
        InitGameChallengeWM_MDate(18,76.97,14.19,2,28,6)
        InitGameChallengeWM_MDate(19,93.24,15.8,2,28,6)
        InitGameChallengeWM_MDate(20,175.21,22.15,5,100,50)
        InitGameChallengeWM_MDate(21,197.36,23.42,2,30,10)
        InitGameChallengeWM_MDate(22,222.3,24.77,2,30,10)
        InitGameChallengeWM_MDate(23,250.4,26.2,2,30,10)
        InitGameChallengeWM_MDate(24,283.33,27.8,2,30,10)
        InitGameChallengeWM_MDate(25,389.43,32.65,5,100,50)
        InitGameChallengeWM_MDate(26,429.48,34.31,2,30,10)
        InitGameChallengeWM_MDate(27,463.29,35.5,2,30,10)
        InitGameChallengeWM_MDate(28,499.77,36.74,2,30,10)
        InitGameChallengeWM_MDate(29,539.13,38.02,2,30,10)
        InitGameChallengeWM_MDate(30,798.16,51.52,5,100,50)
        InitGameChallengeWM_MDate(31,916.84,59.18,2,30,10)
        InitGameChallengeWM_MDate(32,1053.17,67.98,2,30,10)
        InitGameChallengeWM_MDate(33,1209.78,78.09,2,30,10)
        InitGameChallengeWM_MDate(34,1389.67,89.7,2,30,10)
        InitGameChallengeWM_MDate(35,2310.29,149.13,5,100,50)
        InitGameChallengeWM_MDate(36,2653.83,171.31,2,30,10)
        InitGameChallengeWM_MDate(37,3048.45,196.78,2,30,10)
        InitGameChallengeWM_MDate(38,3501.75,226.04,2,30,10)
        InitGameChallengeWM_MDate(39,4022.45,259.65,2,30,10)
        InitGameChallengeWM_MDate(40,6687.23,431.67,5,100,50)
    endfunction

    function SetChallengeWMState(int pid,unit u,int num,int boss)
        int lv = PlayerChallengeWMCos+1
        real life = 0
        real attack = 0
        if  lv > 40
            life = GameChallengeWM_Life[40]
            attack = GameChallengeWM_Attack[40]
            life = life*Pow(1.1,lv-40)
            attack = attack*Pow(1.1,lv-40)
        else
            life = GameChallengeWM_Life[lv]
            attack = GameChallengeWM_Attack[lv]
        endif
        if  boss == 1
            SetUnitRealStateOfOtherId(u,'uK1A'+num)
        else
            SetUnitRealStateOfOtherId(u,'uK0A'+num)
        endif
        BJDebugMsg(GetUnitName(u)+"生命"+R2S(GetUnitRealState(u,5)))
        BJDebugMsg(GetUnitName(u)+"攻击"+R2S(GetUnitRealState(u,1)))
        SetUnitRealState(u,1,GetUnitRealState(u,1)*life)
        SetUnitRealState(u,5,GetUnitRealState(u,5)*attack)
        BJDebugMsg(GetUnitName(u)+"生命"+R2S(GetUnitRealState(u,5)))
        BJDebugMsg(GetUnitName(u)+"攻击"+R2S(GetUnitRealState(u,1)))
    endfunction 

    function CreateChallengeWM(int pid)
        real x = GameChallengeWM_MX
        real y = GameChallengeWM_MY
        unit u = null
        int bosstype = GetRandomInt(0,7) //8种
        int unitnum = GetRandomInt(9,18) //数量
        int unitype = 0 
        u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut30'+bosstype,x,y,270)
        SetChallengeWMState(pid,u,bosstype,1)
        UnitAddAbility(u,'AZ99')
        SetUnitAbilityLevel(u,'AZ99',pid+1)
        AddWMSummonUnit(pid,u)
        IssuePointOrderById(u,851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))

        for num = 1,unitnum
            unitype = GetRandomInt(0,7)
            u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut40'+unitype,x,y,270)
            SetChallengeWMState(pid,u,unitype,0)
            if  num <= 3
                SetUnitRealState(u,1,GetUnitRealState(u,1)*5)
                SetUnitRealState(u,5,GetUnitRealState(u,5)*15)
                SetUnitVertexColor(u,255,100,100,100)
                BJDebugMsg(GetUnitName(u)+"生命"+R2S(GetUnitRealState(u,5)))
                BJDebugMsg(GetUnitName(u)+"攻击"+R2S(GetUnitRealState(u,1)))
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
            DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[万魔窟]：|r当前挑战|cffffcc00万魔窟第"+I2S(PlayerChallengeWMCos)+"层|r！")
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
        int lv = 0
        int uid = GetUnitTypeId(u2)
        FlushWMSummonUnitGroup(pid)
        PlayerChallengeWMCos = PlayerChallengeWMCos + 1
        lv = PlayerChallengeWMCos
        if  lv > 40
            lv = 40
        endif
        AddUnitRealState(Pu[1],17,GameChallengeWM_PrizeA[lv])
        DropGemItem(u2,GameChallengeWM_PrizeB[lv],GameChallengeWM_PrizeC[lv])
        UnitAddEffectSetSize(Pu[1],"effect_e_buffattack.mdl",5)
        CreateChallengeWMEx(pid)
        DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[万魔窟]：|r成功击杀"+GetUnitName(u2)+"，|cffffff80万魔窟层数升级为第"+I2S(PlayerChallengeWMCos)+"层，奖励"+I2S(R2I(GameChallengeWM_PrizeA[lv]))+"%伤害加成！|r")
        if  PlayerChallengeWMCos == 1 or ModuloInteger(PlayerChallengeWMCos,10) == 0
            ReGemFrame(pid)
        endif
        SetBoardText(6,pid+2,"第"+I2S(PlayerChallengeWMCos)+"层")
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
        InitGameChallengeWM_M()
        ChallengeRct_WM(0) = gg_rct_ChallengeRct_MK_0
        ChallengeRct_WM(1) = gg_rct_ChallengeRct_MK_1
        ChallengeRct_WM(2) = gg_rct_ChallengeRct_MK_2
        ChallengeRct_WM(3) = gg_rct_ChallengeRct_MK_3

        for pid = 0,3
            if  IsPlaying(pid) == true
                WMSummonUnitGroup[pid] = CreateGroup()
                SetBoardText(6,pid+2,"第"+I2S(PlayerChallengeWMCos)+"层")
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
