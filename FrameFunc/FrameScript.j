
    
    
    function UI_ScriptOut(int frame)
        int Type = GetFrameType(frame)
        int id = Frame2Id(frame)
        
        //BJDebugMsg("out"+I2S(frame))
        if  Type == TYPE_BUTTON
            if  id >= 581 and id <= 600
                DzFrameSetTexture(BUTTON_Back[id][3] , "war3mapImported\\alpha.tga", 0)
            else
                DzFrameSetTexture(BUTTON_Back[id][4] , "war3mapImported\\alpha.tga", 0)
            endif
        elseif  Type == TYPE_FUNC
            if  id == 160
                ShowHeroFrame(GetPlayerId(GetLocalPlayer()),false)
            endif
        endif
        
        DzFrameShow(UI_TipsHead, false)
    endfunction
    
    function BoxShowResources(int pid,int id)
        DzFrameShow(UI_TipsHead, true)
        if  id == 309
            SetTipsData(1,"","时渊碎片x"+I2S(GetPlayerPlotPartNum(pid)))
            SetTipsData(10,"","进入时渊副本消耗时渊碎片")
        elseif  id == 310
            int num = GetPlayerPlotReNum(pid)+1
            int use = num * 500
            SetTipsData(1,"","需要 - 杀敌数x"+I2S(use))
            SetTipsData(10,"","点击刷新时渊副本奖励")
        endif
        ShowTipsUI()
    endfunction
    
    
    
    function BoxShowAbility(int id)
        string tip = ""
        if  id > 0  
            DzFrameShow(UI_TipsHead, true)
            SetTipsData(1,"",GetSkillName(id))
            
            real cd = GetTypeIdReal(id,100)//技能CD
            if  cd > 0
                tip = tip + "|cffdddddd冷却："+R2S2(cd)+"s|r"
            endif
            SetTipsData(10,"",GetTypeIdTips(id)+tip)
            ShowTipsUI()
        endif
    endfunction
    
    function BoxShowTips(int pid,int id)
        //BJDebugMsg("show"+YDWEId2S(id))
        if  id >= 'FB01' and id <= 'FB99'
            BoxShowMagicItemPublic(pid,id)
        elseif  id >= 'S001' and id <= 'S999'
            BoxShowAbility(id)
        elseif  id > 0
            DzFrameShow(UI_TipsHead, true)
            SetTipsData(1,"",GetTypeIdName(id))
            SetTipsData(10,"",GetTypeIdTips(id))
            ShowTipsUI()
        endif
    endfunction
    function UIDebugShowIndex(int id)
        
        if  id > 0
            DzFrameShow(UI_TipsHead, true)
            

            SetTipsData(1,"","FrameId:"+I2S(id))
            DzFrameSetAlpha(BUTTON_Back[id][4],255)
            ShowTipsUI()
        endif
    endfunction
    
    function UIShowHeroExp(int pid)
        int last = 0
        if  GetHeroLevel(Pu[1]) == 1
            last = 0
        else
            last = DzGetUnitNeededXP(Pu[1],GetHeroLevel(Pu[1])-1)
        endif
        
        int now = GetHeroXP(Pu[1])-last
        int use = DzGetUnitNeededXP(Pu[1],GetHeroLevel(Pu[1]))-last
        DzFrameShow(UI_TipsHead, true)
        SetTipsData(1,"",I2S(now)+"/"+I2S(use))
        ShowTipsUI()
    endfunction
    
    function UI_ScriptIn()
        int frame =  DzGetMouseFocus()
        int Type = GetFrameType(frame)
        int id = Frame2Id(frame)
        int pid = GetPlayerId(GetLocalPlayer())
        int boxid = 0
        
        
        if  Pu[1] != null
            
            if  LastFrame != frame
                //BJDebugMsg("in"+I2S(frame))
                UI_ScriptOut(LastFrame)
            
                
                if  Type == TYPE_FUNC
                    
                    if  id == 160
                        ShowHeroFrame(pid,true)
                    elseif  id == 150
                        UIShowHeroExp(pid)
                    else
                        //UIDebugShowIndex(id)
                    endif
                    
                elseif  Type == TYPE_BUTTON
                    if  id >= 1 and id <= 20
                        BoxShowMagicItem(pid,id)
                        DzFrameSetTexture(BUTTON_Back[id][4] , "war3mapImported\\UI_BUTTON_High.blp", 0)
                    elseif  id >= 31 and id <= 38
                        BoxShowMagicItem(pid,id-30)
                        DzFrameSetTexture(BUTTON_Back[id][4] , "war3mapImported\\UI_BUTTON_High.blp", 0)
                    elseif  id >= 51 and id <= 80
                        boxid = GetMagicFrameStateIndex(pid,id-50)
                        BJDebugMsg(I2S(boxid))
                        if  boxid > 0
                            BoxShowMagicCollect(pid,boxid)
                            DzFrameSetTexture(BUTTON_Back[id][4] , "war3mapImported\\UI_BUTTON_High.blp", 0)
                        endif
                    elseif  id >= 101 and id <= 104
                        boxid = GetUnitIntState(Pu[1],id+30)
                        BoxShowAbility(boxid)
                    elseif  id >= 111 and id <= 114
                        boxid = GetUnitIntState(Pu[1],id+20)
                        BoxShowAbility(boxid)
                    elseif  id == 120
                        boxid = GetUnitIntState(Pu[1],120)
                        BoxShowAbility(boxid)
                    elseif  id >= 121 and id <= 124
                        boxid = GetHeroAbilityID(Pu[1],id-120)
                        BoxShowAbility(boxid)
                    elseif  id >= 131 and id <= 134
                        boxid = GetHeroAbilityID(Pu[1],id-130)
                        BoxShowAbility(boxid)
                    elseif  id >= 150 and id <= 160
                        boxid = GetUnitIntState(Pu[1],id)
                        if  boxid > 0
                            BoxShowTips(pid,boxid)
                            DzFrameSetTexture(BUTTON_Back[id][4] , "war3mapImported\\UI_BUTTON_High.blp", 0)
                        endif
                    elseif  id == 309//时渊碎片
                        BoxShowResources(pid,id)
                    elseif  id == 310//刷新时渊奖励
                        BoxShowResources(pid,id)
                    elseif  id >= 321 and id <= 328
                        boxid = GetPlayerPlotPrizeId(pid,id-320,1)
                        if  boxid > 0
                            BoxShowTips(pid,boxid)
                        endif
                    elseif  id >= 331 and id <= 338
                        boxid = GetPlayerPlotPrizeId(pid,id-330,2)
                        if  boxid > 0
                            BoxShowTips(pid,boxid)
                        endif
                    elseif  id == 401 or id == 402
                        boxid = GetUnitIntState(Pu[1],id)
                        if  boxid > 0
                            BoxShowTips(pid,boxid)
                        endif
                    elseif  id >= 411 and id <= 413
                        boxid = GetUnitIntState(Pu[1],id-410+402)
                        if  boxid > 0
                            BoxShowTips(pid,boxid)
                        endif
                    elseif  id >= 421 and id <= 423
                        boxid = GetUnitIntState(Pu[1],id-420+402)
                        if  boxid > 0
                            BoxShowTips(pid,boxid)
                        endif
                    elseif  id >= 501 and id <= 516
                        BoxShowSaveFrame(pid,id-500)
                    elseif  id >= 581 and id <= 600
                        DzFrameSetTexture(BUTTON_Back[id][3] , "war3mapImported\\UI_Save_Color0.blp", 0)
                        //DzFrameSetAlpha(BUTTON_Back[id][4],120)
                    elseif  id >= 621 and id <= 630
                        boxid = GetPassCheckPrizeId(id-620,1)
                        if  boxid > 0
                            BoxShowTips(pid,boxid)
                            DzFrameSetTexture(BUTTON_Back[id][4] , "war3mapImported\\UI_BUTTON_High.blp", 0)
                        endif
                    elseif  id >= 631 and id <= 640
                        boxid = GetPassCheckPrizeId(id-630,2)
                        if  boxid > 0
                            BoxShowTips(pid,boxid)
                            DzFrameSetTexture(BUTTON_Back[id][4] , "war3mapImported\\UI_BUTTON_High.blp", 0)
                        endif
                    else
                        //UIDebugShowIndex(id)
                        DzFrameSetTexture(BUTTON_Back[id][4] , "war3mapImported\\UI_BUTTON_High.blp", 0)
                    endif
                endif
            elseif  Type == TYPE_BUTTON
                SetTiptoolPostionAsMouse()
            elseif  Type == TYPE_FUNC

            elseif  Type == TYPE_CLOSE
            endif
        endif
        LastFrame  = frame
    endfunction


    function UI_ScriptWheel()
        int frame =  DzGetMouseFocus()
        int Type = GetFrameType(frame)
        int id = Frame2Id(frame)
        int pid = GetPlayerId(GetLocalPlayer())
        int whell = DzGetWheelDelta()
        if  Pu[1] != null
            if  id >= 501 and id <= 600
                PlayerWheelShowSaveFrame(pid,whell)
            endif
        endif
    endfunction