library GameChallengDeath uses GameChallenge0,GameChallenge1,GameChallenge2,GameChallenge3,GameChallenge4,GameChallenge5,GameChallenge6,GameChallenge7,GameChallenge8
    

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
        endif
        flush locals
    endfunction

endlibrary
