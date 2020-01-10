scope KeyEvent initializer InitKeyBroadListener

    private bool array KeyPlayerBool[6][680]
    #define KeyBool KeyPlayerBool[pid]

    function KeyDoubleTimer(int id,int kb)
        int pid = id
        int keybool = kb
        KeyBool[keybool] = true
        TimerStart(0.25,false)
        {
            if  KeyBool[keybool] == true
                KeyBool[keybool] = false
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    func KeyEventFunc()
        int pid = GetPlayerId(DzGetTriggerKeyPlayer())
        int key = DzGetTriggerKey()
        real h = 0
        int rid = 0
        if  Pu[1] != null
            if  key == 27 //Esc
                if  GetUnitIntState(Pu[1],120) > 0
                    
                    for i =1,3
                        rid = GetUnitIntState(Pu[1],130+i)
                        if  rid > 0
                            RecoveryPrizePoolData(pid,GetTypeIdData(rid,101),rid)
                            BJDebugMsg("回收"+GetTypeIdName(rid))
                        endif
                        SetUnitIntState(Pu[1],130+i,0)
                    end
                    rid = GetUnitIntState(Pu[1],120)
                    RecoveryPrizePoolData(pid,GetTypeIdData(rid,101),rid)
                    BJDebugMsg("回收"+GetTypeIdName(rid))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r您放弃了学习技能！")
                    SetUnitIntState(Pu[1],120,0)
                    CloseReplaceFrame(pid)
                elseif  GetUnitIntState(Pu[1],131) > 0
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r您放弃了选择技能！")
                    
                    for i =1,3
                        rid = GetUnitIntState(Pu[1],130+i)
                        if  rid > 0
                            RecoveryPrizePoolData(pid,GetTypeIdData(rid,101),rid)
                            BJDebugMsg("回收"+GetTypeIdName(rid))
                        endif
                        SetUnitIntState(Pu[1],130+i,0)
                    end
                    SetUnitIntState(Pu[1],131,0)
                    SetUnitIntState(Pu[1],132,0)
                    SetUnitIntState(Pu[1],133,0)
                    CloseLearnFrame(pid)
                elseif  GetUnitIntState(Pu[1],401) > 0
                    PlayerClickPrize(pid,0)
                else
                    if  GetLocalPlayer() == Player(pid)
                        if  GetPlotFrameShow() ==  true
                            ClosePlotFrame(pid)
                        elseif  GetCollectFrameShow() == true
                            CloseCollectFrame(pid)
                        elseif  GetShowSaveFrameShow() == true
                            CloseShowSaveFrame(pid)
                        elseif  GetPassFrameShow() == true
                            ClosePassFrame(pid)
                        endif
                    endif
                endif
            elseif  key == 9 //Tab
                ClickPlotFrame(pid)
            elseif  key == 113 //F2
                if  PlayerDeathBool == false
                    HeroMoveToHome(pid)
                endif
            elseif  key == 114 //F3
                if  PlayerDeathBool == false 
                    HeroMoveToRoom(pid)
                endif
            elseif  key == 115 //F4
                ClickCollectFrame(pid)
            elseif  key == 116 //F5
                ClickShowSaveFrame(pid)
            elseif  key == 117 //F6
                ClickPassFrame(pid)
            elseif  key == 118 //F7
                
            elseif  key == 119 or key == 192//F8 ~
            elseif  key == 187 //+
                h = GetCameraField(CAMERA_FIELD_TARGET_DISTANCE) + 120
                if  Player(pid) == GetLocalPlayer()
                    if  h > 3400
                        h = 3400
                    endif
                    SetCameraField( CAMERA_FIELD_TARGET_DISTANCE, h, 0.15 )
                endif
            elseif  key == 189 //-
                h = GetCameraField(CAMERA_FIELD_TARGET_DISTANCE) - 120
                if  Player(pid) == GetLocalPlayer()
                    if  h < 1000
                        h = 1000
                    endif
                    SetCameraField( CAMERA_FIELD_TARGET_DISTANCE, h, 0.15 )
                endif
            elseif  key == 68
                SetPlayerSkillPostion( pid, 8,DzGetMouseTerrainX(),DzGetMouseTerrainY())
            elseif  key == 70
                SetPlayerSkillPostion( pid, 7,DzGetMouseTerrainX(),DzGetMouseTerrainY())
            elseif  key == 81
                SetPlayerSkillPostion( pid, 1,DzGetMouseTerrainX(),DzGetMouseTerrainY())
            elseif  key == 87
                SetPlayerSkillPostion( pid, 2,DzGetMouseTerrainX(),DzGetMouseTerrainY())
            elseif  key == 69
                SetPlayerSkillPostion( pid, 3,DzGetMouseTerrainX(),DzGetMouseTerrainY())
            elseif  key == 82
                SetPlayerSkillPostion( pid, 4,DzGetMouseTerrainX(),DzGetMouseTerrainY())
            elseif  key == 88
                if  KeyBool[key] == true
                    KeyBool[key] = false
                    if  Player(pid) == GetLocalPlayer()
                        ClearTextMessages()
                    endif
                else
                    KeyDoubleTimer(pid,key)
                endif
            elseif  key == 72 //H
                if  Pu[5] == Pu[1]
                    IssueImmediateOrderById(Pu[1], 851993 )
                endif
            elseif  key == 83 //S
                if  Pu[5] == Pu[1]
                    IssueImmediateOrderById(Pu[1], 851972 )
                endif
            endif
        endif
    end

    func KeyEventExFunc()
        int pid = GetPlayerId(DzGetTriggerKeyPlayer())
        int key = DzGetTriggerKey()
        //if  key == 9 //Tab
            //if  IsShowHeroState[pid] == true
            //    ShowAllHeroStateF(pid)
            //endif
        //endif
    end

    function InitKeyBroadListener takes nothing returns nothing
        trigger trig = null

        trig = CreateTrigger()
        DzTriggerRegisterKeyEventTrg(trig,1,27) //Esc
        DzTriggerRegisterKeyEventTrg(trig,1,9) //Tab
        DzTriggerRegisterKeyEventTrg(trig,1,66) //B
        DzTriggerRegisterKeyEventTrg(trig,1,88) //X
        DzTriggerRegisterKeyEventTrg(trig,1,68) //D
        DzTriggerRegisterKeyEventTrg(trig,1,69) //E
        DzTriggerRegisterKeyEventTrg(trig,1,70) //F
        DzTriggerRegisterKeyEventTrg(trig,1,81) //Q
        DzTriggerRegisterKeyEventTrg(trig,1,82) //R
        DzTriggerRegisterKeyEventTrg(trig,1,84) //T
        DzTriggerRegisterKeyEventTrg(trig,1,86) //V
        DzTriggerRegisterKeyEventTrg(trig,1,87) //W
        DzTriggerRegisterKeyEventTrg(trig,1,89) //Y
        
        DzTriggerRegisterKeyEventTrg(trig,1,72) //H
        DzTriggerRegisterKeyEventTrg(trig,1,83) //S
        
        DzTriggerRegisterKeyEventTrg(trig,1,113) //F2
        DzTriggerRegisterKeyEventTrg(trig,1,114) //F3
        DzTriggerRegisterKeyEventTrg(trig,1,115) //F4
        DzTriggerRegisterKeyEventTrg(trig,1,116) //F5
        DzTriggerRegisterKeyEventTrg(trig,1,117) //F6
        DzTriggerRegisterKeyEventTrg(trig,1,118) //F7
        DzTriggerRegisterKeyEventTrg(trig,1,119) //F8
        DzTriggerRegisterKeyEventTrg(trig,1,192) //F8
        
        DzTriggerRegisterKeyEventTrg(trig,1,189)//-
        DzTriggerRegisterKeyEventTrg(trig,1,187)//+
        TriggerAddAction(trig,function KeyEventFunc)
        
        ////////////////////////////上方点击 下方注册/////////////////////////////
        
        //trig = CreateTrigger()
        //DzTriggerRegisterKeyEventTrg(trig,0,9)
        //TriggerAddAction(trig,function KeyEventExFunc)
        
        trig = null
    endfunction

endscope
