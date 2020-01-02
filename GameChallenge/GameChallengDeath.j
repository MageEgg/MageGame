library GameChallengDeath uses GameChallenge0,GameChallenge1,GameChallenge2,GameChallenge3,GameChallenge4,GameChallenge5,GameChallenge6,GameChallenge7,GameChallenge8
    
    function GameChallengPlayerDeathEvent(unit wu)
        unit u1 = wu
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  IsPlayerInChallenge == true and PlayerInChallengeNumber > 0
            if  PlayerInChallengeNumber == 1
                GameChallenge_1Flush(pid)
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
        endif
        flush locals
    endfunction

endlibrary
