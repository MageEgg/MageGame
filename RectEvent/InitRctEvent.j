scope InitRctEvent initializer InitRctEvent
    
    
    
    
    function InLGF1()
        int pid = 0
        if  GetUnitTypeId(GetTriggerUnit())=='zs00' and Pu[2]!=GetTriggerUnit()
            SetPlayerUnitPostionSelectUnit(GetTriggerUnit(),11460,12792,GetTriggerUnit())
            DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,5,"|cffffcc00[系统]|r:这不是你的练功房！")
        endif
    endfunction
    function InLGF2()
        int pid = 1
        if  GetUnitTypeId(GetTriggerUnit())=='zs00' and Pu[2]!=GetTriggerUnit()
            SetPlayerUnitPostionSelectUnit(GetTriggerUnit(),11460,12792,GetTriggerUnit())
            DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,5,"|cffffcc00[系统]|r:这不是你的练功房！")
        endif
    endfunction
    function InLGF3()
        int pid = 2
        if  GetUnitTypeId(GetTriggerUnit())=='zs00' and Pu[2]!=GetTriggerUnit()
            SetPlayerUnitPostionSelectUnit(GetTriggerUnit(),11460,12792,GetTriggerUnit())
            DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,5,"|cffffcc00[系统]|r:这不是你的练功房！")
        endif
    endfunction
    function InLGF4()
        int pid = 3
        if  GetUnitTypeId(GetTriggerUnit())=='zs00' and Pu[2]!=GetTriggerUnit()
            SetPlayerUnitPostionSelectUnit(GetTriggerUnit(),11460,12792,GetTriggerUnit())
            DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,5,"|cffffcc00[系统]|r:这不是你的练功房！")
        endif
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
        region rectRegion = null
        trigger trig = null
        

        //InitRctEventFunc(gg_rct_GameRect,true,function InGameRect)
        //InitRctEventFunc(gg_rct_GameRect,false,function OutGameRect)
        
        /*
        trig = CreateTrigger()
        rectRegion = CreateRegion()
        RegionAddRect(rectRegion, gg_rct_LGF_1)
        TriggerRegisterEnterRegion(trig, rectRegion, null)
        TriggerAddAction(trig, function InLGF1)
        
        trig = CreateTrigger()
        rectRegion = CreateRegion()
        RegionAddRect(rectRegion, gg_rct_LGF_2)
        TriggerRegisterEnterRegion(trig, rectRegion, null)
        TriggerAddAction(trig, function InLGF2)
        
        trig = CreateTrigger()
        rectRegion = CreateRegion()
        RegionAddRect(rectRegion, gg_rct_LGF_3)
        TriggerRegisterEnterRegion(trig, rectRegion, null)
        TriggerAddAction(trig, function InLGF3)
        
        trig = CreateTrigger()
        rectRegion = CreateRegion()
        RegionAddRect(rectRegion, gg_rct_LGF_4)
        TriggerRegisterEnterRegion(trig, rectRegion, null)
        TriggerAddAction(trig, function InLGF4)
        
        */
        
        trig = null
        rectRegion = null
    endfunction
    
endscope
