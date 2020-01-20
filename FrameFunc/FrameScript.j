
    
    
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
        BJDebugMsg( R2S(GetPostionAsMouseX())+","+R2S(GetPostionAsMouseY()))
        DzFrameShow(UI_TipsHead, false)
    endfunction
    
    function BoxShowResources(int pid,int id)
        DzFrameShow(UI_TipsHead, true)
        if  id == 309
            SetTipsData(1,"","时渊碎片x"+I2S(GetPlayerPlotPartNum(pid)))
            SetTipsData(10,"","进入时渊副本消耗时渊碎片")
        elseif  id == 310
            int num = GetPlayerPlotReNum(pid)+1
            int use = num
            SetTipsData(1,"","需要 - 玄铁x"+I2S(use))
            SetTipsData(10,"","点击刷新时渊副本奖励")
        elseif  id == 21
            SetTipsData(10,"","|CffCCCCCC重铸法宝：|n|r|Cfff0f0f0消耗|r|Cffffd24d1|r|Cfff0f0f0个|r|Cffffd24d补天石|r|Cfff0f0f0，可重置为|r|Cffffd24d同品质|r|Cfff0f0f0的|r|Cffffd24d随机法宝|r|Cfff0f0f0。|r|n|n|Cff00ff7f操作提示：点击指定法宝，再点击【重铸按钮】。|r")
        elseif  id == 22
            SetTipsData(10,"","|CffCCCCCC锻造法宝：|n|r|Cfff0f0f0消耗|r|Cffffd24d1|r|Cfff0f0f0个|r|Cffff0000鸿蒙结晶|r|Cfff0f0f0，可重置为|r|Cffffd24d高一品质|r|Cfff0f0f0的|r|Cffffd24d随机法宝|r|Cfff0f0f0。|r|n|n|Cff00ff7f操作提示：点击指定法宝，再点击【锻造按钮】。|r")
        elseif  id == 23
            SetTipsData(10,"","|CffF0F0F0用来|r|Cffffd24d重铸法宝|r|Cfff0f0f0的材料。|r")
        elseif  id == 24
            SetTipsData(10,"","|CffF0F0F0用来|r|Cffff0000锻造法宝|r|Cfff0f0f0的材料。|r")
        elseif  id == 652 or id == 653
            int exp = GetDzPlayerData(pid,4,1)
            int lv = exp / 8
            exp = exp - lv * 8
            if  id == 652 //通行证
                SetTipsData(1,"","普通通行证.Lv"+I2S(lv)+"(|cffff0000"+I2S(exp)+"8|r)")
            elseif  id == 653 //商城通行证
                SetTipsData(1,"","|cffffcc00封神通行证|r.Lv"+I2S(lv)+"(|cffff0000"+I2S(exp)+"/8|r)")
            endif
            SetTipsData(10,"","距离升级还差|cffff0000"+I2S(8-exp)+"|r经验")
            SetTipsData(11,"","|cffcc99ff输入CX完成每日任务可以获得通行证经验|r")
            SetTipsData(12,"","|cffcc99ff封神通行证与普通通行证等级同步|r")
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
        elseif  id >= 'IJ01' and id <= 'IJ15'
            DzFrameShow(UI_TipsHead, true)
            SetTipsData(1,"",GetTypeIdName(id))

            SetTipsData(10,"",GetTypeIdStateTips(id))
            ShowTipsUI()
         
        elseif  id > 0
            DzFrameShow(UI_TipsHead, true)
            SetTipsData(1,"",GetTypeIdName(id))
            
            SetTipsData(10,"",GetTypeIdStateTips(id))
            SetTipsData(11,"",GetTypeIdTips(id))
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
                    elseif  id == 21 or id == 22
                        BoxShowResources(pid, id)
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
                    elseif  id == 652 or id == 653
                        BoxShowResources(pid,id)
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


