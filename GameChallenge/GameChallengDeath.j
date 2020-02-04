library GameChallengDeath uses GameChallenge0,GameChallenge1,GameChallenge2,GameChallenge3,GameChallenge4,GameChallenge5,GameChallenge6,GameChallenge7,GameChallenge8,GameChallenge9,GameChallenge10
    
    function OpenGameChallenge(int pid,int flag,int ty)
        if  GetUnitAbilityLevel(Pu[1],'AZ02') == 0 
            if  GetPlayerPlotStateByIndex(pid,flag) > 0
                if  GetPlayerPlotStateByIndex(pid,flag) == 2
                    DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[副本]：|r该副本已完成！！！")
                else
                    if  IsPlayerInChallenge == false
                        if  GetPlayerPlotStateByIndex(pid,flag) == 3
                            if  GetPlayerPlotPartNum(pid) > 0
                                if  flag == 1
                                    OpenGameChallenge_1(pid,ty)
                                    //SetPlayerPlotPartNum(pid,GetPlayerPlotPartNum(pid)-1)
                                elseif  flag == 2
                                    OpenGameChallenge_2(pid,ty)
                                    //SetPlayerPlotPartNum(pid,GetPlayerPlotPartNum(pid)-1)
                                elseif  flag == 3
                                    OpenGameChallenge_3(pid,ty)
                                    //SetPlayerPlotPartNum(pid,GetPlayerPlotPartNum(pid)-1)
                                elseif  flag == 4
                                    OpenGameChallenge_4(pid,ty)
                                    //SetPlayerPlotPartNum(pid,GetPlayerPlotPartNum(pid)-1)
                                elseif  flag == 5
                                    OpenGameChallenge_5(pid,ty)
                                    //SetPlayerPlotPartNum(pid,GetPlayerPlotPartNum(pid)-1)
                                elseif  flag == 6
                                    OpenGameChallenge_6(pid,ty)
                                    //SetPlayerPlotPartNum(pid,GetPlayerPlotPartNum(pid)-1)
                                elseif  flag == 7
                                    OpenGameChallenge_7(pid,ty)
                                    //SetPlayerPlotPartNum(pid,GetPlayerPlotPartNum(pid)-1)
                                elseif  flag == 8
                                    OpenGameChallenge_8(pid,ty)
                                    //SetPlayerPlotPartNum(pid,GetPlayerPlotPartNum(pid)-1)
                                endif
                                ClosePlotFrame(pid)
                            else
                                DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[副本]：|r您已经没有时渊入场券了！")
                            endif
                        else
                            if  flag == 1
                                OpenGameChallenge_1(pid,ty)
                                ClosePlotFrame(pid)
                            else
                                if  GetPlayerPlotStateByIndex(pid,flag-1) == 2
                                    if  flag == 2
                                        OpenGameChallenge_2(pid,ty)
                                    elseif  flag == 3
                                        OpenGameChallenge_3(pid,ty)
                                    elseif  flag == 4
                                        OpenGameChallenge_4(pid,ty)
                                    elseif  flag == 5
                                        OpenGameChallenge_5(pid,ty)
                                    elseif  flag == 6
                                        OpenGameChallenge_6(pid,ty)
                                    elseif  flag == 7
                                        OpenGameChallenge_7(pid,ty)
                                    elseif  flag == 8
                                        OpenGameChallenge_8(pid,ty)
                                    endif
                                    ClosePlotFrame(pid)
                                else
                                    DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[副本]：|r请先完成上一个副本！")
                                endif
                            endif
                            
                        endif
                    else    
                        DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[副本]：|r当前正在挑战副本！！！")
                    endif
                endif
            else    
                DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[副本]：|r该副本未解锁！！！")
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[副本]：|r当前无法进行副本传送！！！")
        endif
    endfunction

    function GameChallengPlayerDeathEvent(unit wu)
        unit u1 = wu
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  IsPlayerInChallenge == true and PlayerInChallengeNumber > 0
            GameChallengeFluahAll(pid,0)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[副本]：|r|cffff0000英雄死亡，挑战失败！！！|r")
        endif
        if  IsPlayerInTeamChallenge == true
            FlushGameTeamChallengeOfPlayer(pid,0)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000英雄死亡，挑战失败！！！|r")
            if  IsHasPlayerInTeamChalleng() == false
                FlushGameTeamChallenge()
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成挑战，团队副本失败！！！|r")
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成挑战，团队副本失败！！！|r")
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成挑战，团队副本失败！！！|r")
            endif
        endif
        flush locals
    endfunction

    function GameChallengPlayerLeaveRctEvent()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  IsPlayerInChallenge == true and PlayerInChallengeNumber > 0
                    GameChallengeFluahAll(pid,-1)
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[副本]：|r|cffff0000英雄离开副本，挑战失败！！！|r")
                endif
            endif
        endif
        flush locals
    endfunction

    function GameTeamChallengPlayerLeaveRctEvent()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  IsPlayerInTeamChallenge == true
                    FlushGameTeamChallengeOfPlayer(pid,2)
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000英雄离开团队副本，挑战失败！！！|r")
                    if  IsHasPlayerInTeamChalleng() == false
                        FlushGameTeamChallenge()
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成挑战，团队副本失败！！！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成挑战，团队副本失败！！！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成挑战，团队副本失败！！！|r")
                    endif
                else
                    if  GameChallengBool[90] == true
                        GameChallengBool[90] = false
                    endif
                endif
            endif
        endif
        flush locals
    endfunction
    
    function InitGameChallengeLeaveRctEvent()
        trigger tig = null
        region rectRegion = null

        tig = CreateTrigger() 
        rectRegion = CreateRegion()
        RegionAddRect(rectRegion,gg_rct_ChallengeRctConA)
        RegionAddRect(rectRegion,gg_rct_ChallengeRctConB)
        TriggerRegisterLeaveRegion(tig,rectRegion,null)
        TriggerAddAction(tig, function GameChallengPlayerLeaveRctEvent)

        tig = null
        rectRegion = null
    endfunction

    function InitGameTeamChallengeLeaveRctEvent()
        trigger tig = null
        region rectRegion = null

        tig = CreateTrigger() 
        rectRegion = CreateRegion()
        RegionAddRect(rectRegion,gg_rct_ChallengeRctConC)
        TriggerRegisterLeaveRegion(tig,rectRegion,null)
        TriggerAddAction(tig, function GameTeamChallengPlayerLeaveRctEvent)

        tig = null
        rectRegion = null
    endfunction

    function GameChallengDeathEvent(unit wu,unit tu)
        unit u1 = wu
        unit u2 = tu
        int uid = GetUnitTypeId(u1)
        int uid2 = GetUnitTypeId(u2)
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  uid2 == 'u020'
            GameChallenge_0_B_Death(pid)
        elseif  uid2 == 'u021'
            GameChallenge_0_C_Death(pid)
        elseif  uid2 == 'uf10'
            GameChalleng_1_XYDeath(pid,u2)
        elseif  uid2 == 'uf11'
            GameChalleng_1_JLDeath(pid,u2)
        elseif  uid2 == 'uf12'
            GameChalleng_1_LZZDeath(pid,u2)
        elseif  uid2 == 'uf13' or uid2 == 'uf14'
            GameChalleng_1_JYDeath(pid,u2)
        elseif  uid2 == 'uf20'
            GameChalleng_2_WaterDeath1(pid,u2)
        elseif  uid2 == 'uf21'
            GameChalleng_2_WaterDeath2(pid,u2)
        elseif  uid2 == 'uf22'
            GameChalleng_2_WaterDeath3(pid,u2)
        elseif  uid2 == 'uf30'
            GameChalleng_3_HTHDeath(pid,u2)
        elseif  uid2 >= 'uf31' and uid2 <= 'uf34'
            GameChalleng_3_SMJDeath(pid,u2)
        elseif  uid2 == 'uf40' or uid2 == 'uf41'
            GameChalleng_4_DeathA(pid,u2)
        elseif  uid2 == 'uf40' or uid2 == 'uf41'
            GameChalleng_4_DeathA(pid,u2)
        elseif  (uid2 >= 'uf42' and uid2 <= 'uf49') or uid2 == 'uf50'
            GameChalleng_4_Zhen_Death(pid,u2)
        elseif  uid2 >= 'uf51' and uid2 <= 'uf55'
            GameChalleng_5_WayDeath(pid,u2)
        elseif  uid2 >= 'uf60' and uid2 <= 'uf62'
            GameChallenge_6_A_Death(pid,u2)
        elseif  uid2 >= 'uf70' and uid2 <= 'uf74'
            GameChallenge_7_Death(pid,u2)
        elseif  uid2 >= 'uf80' and uid2 <= 'uf87'
            GameChallenge_8_Death(pid,u2)
        elseif  uid2 >= 'md01' and uid2 <= 'md08'
            if  GetUnitAbilityLevel(u2,'AZ20') > 0
                SetPlayerLeagueState(uid2-'md01'+1,false)
            endif
        endif
        if  uid2 >= 'ut00' and uid2 <= 'ut09'
            GameTeamChallengDeath(u2)
        endif
        //BJDebugMsg(YDWEId2S(uid2))
        flush locals
    endfunction

endlibrary
