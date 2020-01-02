library GameChallengDeath uses GameChallenge0,GameChallenge1,GameChallenge2,GameChallenge3,GameChallenge4,GameChallenge5,GameChallenge6,GameChallenge7,GameChallenge8
    
    function OpenGameChallenge(int pid,int flag,int ty)
        if  GetPlayerPlotStateByIndex(pid,flag) > 0
            if  GetPlayerPlotStateByIndex(pid,flag) == 2
                DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[副本]：|r该副本已完成！！！")
            else
                if  IsPlayerInChallenge == false
                    if  flag == 1
                        OpenGameChallenge_1(pid,ty)
                    elseif  flag == 2
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
                    DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[副本]：|r当前正在挑战副本！！！")
                endif
            endif
        else    
            DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[副本]：|r该副本未解锁！！！")
        endif
    endfunction

    function GameChallengPlayerDeathEvent(unit wu)
        unit u1 = wu
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  IsPlayerInChallenge == true and PlayerInChallengeNumber > 0
            if  PlayerInChallengeNumber == 1
                GameChallenge_1Flush(pid)
            elseif  PlayerInChallengeNumber == 2
                GameChallenge_2Flush(pid)
            elseif  PlayerInChallengeNumber == 3
                GameChallenge_3Flush(pid)
            elseif  PlayerInChallengeNumber == 4
                GameChallenge_4Flush(pid)
            elseif  PlayerInChallengeNumber == 5
                GameChallenge_5Flush(pid)
            elseif  PlayerInChallengeNumber == 6
                GameChallenge_6Flush(pid)
            elseif  PlayerInChallengeNumber == 7
                GameChallenge_7Flush(pid)
            elseif  PlayerInChallengeNumber == 8
                GameChallenge_8Flush(pid)
            endif
        endif
        flush locals
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
        endif
        flush locals
    endfunction

endlibrary
