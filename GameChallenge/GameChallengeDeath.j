library GameChallengeDeath uses GameChallenge0,GameChallenge1,GameChallenge2,GameChallenge3,GameChallenge4,GameChallenge5,GameChallenge6,GameChallenge7,GameChallenge8,GameChallenge9,GameChallenge10,GameChallenge11,GameChallenge12
    
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
        BJDebugMsg("清空挑战")
        if  IsPlayerInChallenge == true and PlayerInChallengeNumber > 0
            GameChallengeFluahAll(pid,0)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[副本]：|r|cffff0000英雄死亡，挑战失败！！！|r")
        endif
        if  IsPlayerInTeamChallenge == true
            FlushGameTeamChallengeOfPlayer(pid,0)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000英雄死亡，挑战失败！！！|r")
            if  IsHasPlayerInTeamChalleng() == false
                FlushGameTeamChallenge()
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成万仙阵挑战，团队副本失败！！！|r")
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成万仙阵挑战，团队副本失败！！！|r")
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成万仙阵挑战，团队副本失败！！！|r")
            endif
        endif
        if  IsPlayerInTeamChallenge2 == true
            FlushGameTeamChallengeOfPlayer2(pid,0)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000英雄死亡，挑战失败！！！|r")
            if  IsHasPlayerInTeamChalleng2() == false
                FlushGameTeamChallenge2()
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成虚空圣战挑战，团队副本失败！！！|r")
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成虚空圣战挑战，团队副本失败！！！|r")
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成虚空圣战挑战，团队副本失败！！！|r")
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
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000英雄离开万仙阵副本，挑战失败！！！|r")
                    if  IsHasPlayerInTeamChalleng() == false
                        FlushGameTeamChallenge()
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成万仙阵挑战，团队副本失败！！！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成万仙阵挑战，团队副本失败！！！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成万仙阵挑战，团队副本失败！！！|r")
                    endif
                else
                    if  GameChallengeBool[90] == true
                        GameChallengeBool[90] = false
                    endif
                endif
            endif
        endif
        flush locals
    endfunction

    function GameTeamChallengPlayerLeaveRctEvent2()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  IsPlayerInTeamChallenge2 == true
                    FlushGameTeamChallengeOfPlayer2(pid,2)
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000英雄离开虚空圣战副本，挑战失败！！！|r")
                    if  IsHasPlayerInTeamChalleng2() == false
                        FlushGameTeamChallenge2()
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成虚空圣战挑战，团队副本失败！！！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成虚空圣战挑战，团队副本失败！！！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未有玩家完成虚空圣战挑战，团队副本失败！！！|r")
                    endif
                else
                    if  GameChallengeBool[120] == true
                        GameChallengeBool[120] = false
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

        tig = CreateTrigger() 
        rectRegion = CreateRegion()
        RegionAddRect(rectRegion,gg_rct_ChallengeRctConF)
        TriggerRegisterLeaveRegion(tig,rectRegion,null)
        TriggerAddAction(tig, function GameTeamChallengPlayerLeaveRctEvent2)

        tig = null
        rectRegion = null
    endfunction

    function GameChallengeDeathEvent(unit wu,unit tu)
        unit u1 = wu
        unit u2 = tu
        int uid = GetUnitTypeId(u1)
        int uid2 = GetUnitTypeId(u2)
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  uid2 == 'u020'
            GameChallenge_0_B_Death(pid)
        elseif  uid2 == 'u021'
            GameChallenge_0_C_Death(pid)

            if  GetUnitTypeId(Pu[1]) == 'H008' and AttackUnitWN >= 3//彩蛋
                if  DzPlayerLv(Player(pid)) >= 4
                    if  GetPlayerTechCount(Player(pid),'RDAV',true) == 0
                        SetDzPlayerData(pid,15,22,22)
                        SetPlayerTechResearchedEx(Player(pid),'RDAV')
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000姐妹情深|r（永久存档）！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000姐妹情深|r，但可惜地图等级不够要求！")
                endif
            endif

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
        endif
        if  uid2 >= 'ut00' and uid2 <= 'ut09'
            GameTeamChallengDeath_A(u2)
        elseif  uid2 >= 'ut10' and uid2 <= 'ut19'
            GameTeamChallengDeath2_A(u2)
        elseif  uid2 >= 'ut20' and uid2 <= 'ut29'
            GameTeamChallengDeath_B(u2)
        elseif  uid2 >= 'ut30' and uid2 <= 'ut39'
            GameTeamChallengDeath_C(pid,u2)
        endif
        //BJDebugMsg(YDWEId2S(uid2))
        flush locals
    endfunction

endlibrary
