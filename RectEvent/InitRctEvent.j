scope InitRctEvent initializer InitRctEvent
    
    function OutLGF_1()
        int pid = 0
        real x = AttackRoomPostion[pid][1]
        real y = AttackRoomPostion[pid][2]

    endfunction
    

    function InGameRect()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        if  Pu[1] == GetTriggerUnit()
            if  GetLocalPlayer() == Player(pid)
                SetPlayerCameraBoundsToRect(gg_rct_GameRect)
            endif
        endif
    endfunction
    function OutGameRect()
        int pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        if  Pu[1] == GetTriggerUnit()
            if  GetLocalPlayer() == Player(pid)
                SetPlayerCameraBoundsToRect(bj_mapInitialPlayableArea)
            endif
        endif
    endfunction
    
    
    function InitRctEventFunc(rect rec,bool in,code cod)
        trigger trig = CreateTrigger()
        region rectRegion = CreateRegion()
        RegionAddRect(rectRegion, rec)
        if  in == true
            TriggerRegisterEnterRegion(trig, rectRegion, null)
        else
            TriggerRegisterLeaveRegion(trig, rectRegion, null)
        endif
        TriggerAddAction(trig, cod)
        flush locals
    endfunction

    function InitRctEvent()

        //InitRctEventFunc(gg_rct_GameRect,true,function InGameRect)
        //InitRctEventFunc(gg_rct_GameRect,false,function OutGameRect)
        

        InitRctEventFunc(gg_rct_LGF_1,false,function OutLGF_1)

      
    endfunction
    
endscope
