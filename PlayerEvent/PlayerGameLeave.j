scope PlayerGameLeave initializer InitPlayerGameLeave

    func PlayerGameLeaveActions()
        int pid = GetPlayerId(GetTriggerPlayer())
        
        if  Pu[1] != null
            RemoveUnit(Pu[1])
            Pu[1] = null
        endif
        if  Pu[2] != null
            RemoveUnit(Pu[2])
            Pu[2] = null
        endif
        if  Pu[3] != null
            RemoveUnit(Pu[3])
            Pu[3] = null
        endif
        
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]|r:"+GetPN(pid)+"离开了游戏！")
    end

    func InitPlayerGameLeave()
        trigger trg = CreateTrigger()
        for pid = 0,3
            TriggerRegisterPlayerEvent(trg, Player(pid), EVENT_PLAYER_LEAVE)
        end
        TriggerAddAction(trg,function PlayerGameLeaveActions)
        trg = null
    end

endscope

