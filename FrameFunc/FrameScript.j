
    

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
        if  frame == 8000 or frame == 8001 or frame == 8002
            SetOriginDzFrameTooltip()
        endif
        //BJDebugMsg( R2S(GetPostionAsMouseX())+","+R2S(GetPostionAsMouseY()))
        DzFrameShow(UI_TipsHead, false)
    endfunction

    function ShowUIUnitDefense(int pid)
        real r1 = 0
        if  Pu[5] != null
            DzFrameSetPoint( DzFrameGetTooltip(), 8, GameUI, 2, -1,-1 )
            if  GetUnitRealState(Pu[5],3) > 0 and GetUnitAbilityLevel(Pu[5],'Avul') == 0
                DzFrameShow(UI_TipsHead, true)
                SetTipsData(10,"","|cffffcc00防御显示：|r")
                SetTipsData(11,"","防御："+I2S(R2I(GetUnitRealState(Pu[5],3))))
                r1 = GetUnitRealState(Pu[5],3)
                if  r1 < 0
                    r1 = -1 * r1
                    r1 = -(r1*0.01)/(r1*0.01+1)*100
                else
                    r1 = (r1*0.01)/(r1*0.01+1)*100
                endif
                SetTipsData(12,"","|cff808080伤害减少："+R2SI(r1)+"%|r")
                //SetTipsData(13,""," ")
                //SetTipsData(14,"","物理抵抗："+R2SI(GetUnitRealState(Pu[5],18))+"%|r")
                //SetTipsData(15,"","法术抵抗："+R2SI(GetUnitRealState(Pu[5],4))+"%|r")
                //SetTipsData(16,""," ")
                ShowTipsUI()
                ShowNewDzFrameTooltip(0.049)//(0.055)-0.006
            endif
        endif
    endfunction

    function ShowUIUnitAttack(int pid)
        real r1 = 0
        if  Pu[5] != null
            DzFrameSetPoint( DzFrameGetTooltip(), 8, GameUI, 2, -1,-1 )
            if  GetUnitState(Pu[5],ConvertUnitState(0x12)) > 0 and GetUnitAbilityLevel(Pu[5],'Avul') == 0 
                DzFrameShow(UI_TipsHead, true)
                SetTipsData(10,"","|cffffcc00攻击显示：|r")
                if  GetUnitState(Pu[5],ConvertUnitState(0x13)) > 0
                    SetTipsData(11,"","攻击："+GetPlayerBossDamageShow(1+R2I(GetUnitState(Pu[5],ConvertUnitState(0x12))))+" |cff00ff00+"+GetPlayerBossDamageShow(R2I(GetUnitState(Pu[5],ConvertUnitState(0x13))))+"|r")
                elseif  GetUnitState(Pu[5],ConvertUnitState(0x13)) < 0
                    SetTipsData(11,"","攻击："+GetPlayerBossDamageShow(1+R2I(GetUnitState(Pu[5],ConvertUnitState(0x12))))+" |cffff0000-"+GetPlayerBossDamageShow(-1*R2I(GetUnitState(Pu[5],ConvertUnitState(0x13))))+"|r")
                elseif  GetUnitState(Pu[5],ConvertUnitState(0x13)) == 0
                    SetTipsData(11,"","攻击："+GetPlayerBossDamageShow(1+R2I(GetUnitState(Pu[5],ConvertUnitState(0x12)))))
                endif
                SetTipsData(12,"","|cff808080攻击距离："+R2SI(GetUnitState(Pu[5],ConvertUnitState(0x16))))
                SetTipsData(13,""," ")
                SetTipsData(14,"","攻击伤害："+R2SI(GetUnitRealState(Pu[5],15))+"%|r")
                SetTipsData(15,"","技能伤害："+R2SI(GetUnitRealState(Pu[5],16))+"%|r")
                //SetTipsData(16,""," ")
                //SetTipsData(15,"","物理穿透："+R2SI(GetUnitRealState(Pu[5],13))+"%|r")
                
                //SetTipsData(17,"","法术穿透："+R2SI(GetUnitRealState(Pu[5],14))+"%|r")
                
                ShowTipsUI()
                ShowNewDzFrameTooltip(0.082)//(0.088)-0.006  一个字0.011
            endif
        endif
    endfunction

    function ShowUIUnitOriginState(int pid)
        if  Pu[5] != null
            DzFrameSetPoint( DzFrameGetTooltip(), 8, GameUI, 2, -1,-1 )
            if  GetHeroStr(Pu[5],false) > 0 or GetHeroAgi(Pu[5],false) > 0 or GetHeroInt(Pu[5],false) > 0 
                DzFrameShow(UI_TipsHead, true)
                SetTipsData(10,"","|cffffcc00英雄属性：|r")
                SetTipsData(11,"","业力：")
                SetTipsData(12,""," - 业力会增加某些技能伤害")
                SetTipsData(13,"","攻速：")
                SetTipsData(14,""," - 每点增加1%攻击速度")
                SetTipsData(15,""," - 最高增加400%")
                SetTipsData(16,"","冷却：")
                SetTipsData(17,""," - 每点降低主动技能冷却时间")
                SetTipsData(18,""," - 冷却时间最小值为1秒")
                SetTipsData(19,""," ")
                ShowTipsUI()
                ShowNewDzFrameTooltip(0.121)
            endif
        endif
    endfunction

    function BoxShowResources(int pid,int id)
        DzFrameShow(UI_TipsHead, true)
        if  id == 309
            SetTipsData(1,"","时渊入场券x"+I2S(GetPlayerPlotPartNum(pid)))
            SetTipsData(10,"","完成时渊副本消耗时渊入场券")
        elseif  id == 310
            int num = GetPlayerPlotReNum(pid)+1
            int use = num*5
            SetTipsData(1,"","需要 - 玄铁x15")
            SetTipsData(10,"","点击刷新时渊副本奖励")
        elseif  id == 21
            SetTipsData(10,"","|cffcccccc重铸法宝：|n|r|cfff0f0f0消耗|r|cffffd24d1|r|cfff0f0f0个|r|cffffd24d补天石|r|cfff0f0f0，可重置为|r|cffffd24d同品质|r|cfff0f0f0的|r|cffffd24d随机法宝|r|cfff0f0f0。|n消耗|r|cffffc9263|r个|cffffc926补天石|r，可使法宝品质晋升为|cffffc926造化至宝|r。|n|n|cff00ff7f操作提示：点击指定法宝，再点击【重铸按钮】。|r")
        elseif  id == 22
            SetTipsData(10,"","|CffCCCCCC锻造法宝：|n|r|Cfff0f0f0消耗|r|Cffffd24d1|r|Cfff0f0f0个|r|Cffff0000鸿蒙结晶|r|Cfff0f0f0，可重置为|r|Cffffd24d高一品质|r|Cfff0f0f0的|r|Cffffd24d随机法宝|r|Cfff0f0f0。|r|n|n|Cff00ff7f操作提示：点击指定法宝，再点击【锻造按钮】。|r")
        elseif  id == 23
            SetTipsData(1,"","|CffFFD24D补天石|r")
            SetTipsData(10,"","用来|Cffffc926重铸|r或|Cffffc926点金|r的材料")
        elseif  id == 24
            SetTipsData(1,"","|CffFF0000鸿蒙结晶|r")
            SetTipsData(10,"","|CffF0F0F0用来|r|Cffff0000锻造法宝|r|Cfff0f0f0的材料。|r")
        elseif  id == 25
            SetTipsData(10,"","|CffF0F0F0出售法宝，获得|r|Cffffd24d2|r|Cfff0f0f0玄铁。|n|n|r|Cff00ff7f操作提示：点击指定法宝，再点击出售按钮。|r")
            DzFrameSetTexture(BUTTON_Back[id][4] , "war3mapImported\\UI_MagicItem_Sale0.tga",0)
            
        elseif  id == 652 or id == 653
            int step = GetPassCheckStep()
            int exp = GetDzPlayerData(pid,4,1+step)
            if  step == 0
                exp = exp + 7
            elseif  step == 1
                exp = exp + 6
            endif
            int lv = exp / 6
            exp = exp - lv * 6
            if  id == 652 //通行证
                if  step == 0
                    SetTipsData(10,"","第"+I2S(step+1)+"赛季通行证.Lv"+I2S(lv)+"(|cffff0000"+I2S(exp)+"/6|r)")
                    SetTipsData(11,"","距离升级还差|cffff0000"+I2S(6-exp)+"|r经验")
                elseif  step == 1
                    if  MissionDay > 20
                        SetTipsData(10,"","第"+I2S(step+1)+"赛季通行证.Lv"+I2S(lv)+"(|cffff0000"+I2S(exp)+"/6|r)")
                        SetTipsData(11,"","距离升级还差|cffff0000"+I2S(6-exp)+"|r经验")
                    else
                        SetTipsData(10,"","第"+I2S(step+1)+"赛季通行证.Lv0")
                        SetTipsData(11,"","距离第2赛季还剩|cffff0000"+I2S(21-MissionDay)+"|r天")
                    endif
                endif
            elseif  id == 653 //商城通行证
                if  step == 0
                    if  DzShop(Player(pid),"RWK") == false
                        SetTipsData(10,"","|cffffcc00封神通行证|r|cffff0000(商城购买后激活)|r")
                    else
                        if  lv >= 20
                            SetTipsData(10,"","|cffffcc00封神通行证|r.Lv"+I2S(lv)+"(|cff00ff00已满级)")
                        else
                            SetTipsData(10,"","|cffffcc00封神通行证|r.Lv"+I2S(lv)+"(|cffff0000"+I2S(exp)+"/6|r)")
                            SetTipsData(11,"","距离升级还差|cffff0000"+I2S(6-exp)+"|r经验")
                        endif
                    endif
                    
                elseif  step == 1
                    if  DzShop(Player(pid),"RWK2") == false
                        SetTipsData(10,"","|cffffcc00荣耀通行证|r|cffff0000(商城购买后激活)|r")
                    else
                        if  lv >= 20
                            SetTipsData(10,"","|cffffcc00荣耀通行证|r.Lv"+I2S(lv)+"(|cff00ff00已满级)")
                        else
                            SetTipsData(10,"","|cffffcc00荣耀通行证|r.Lv"+I2S(lv)+"(|cffff0000"+I2S(exp)+"/6|r)")
                            SetTipsData(11,"","距离升级还差|cffff0000"+I2S(6-exp)+"|r经验")
                        endif
                    endif
                endif
            endif
            SetTipsData(12,""," ")
            SetTipsData(13,"","|cffcc99ff输入CX完成每日任务可以获得通行证经验|r")
            SetTipsData(14,"","|cffcc99ff该通行证与普通通行证等级同步|r")
            
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
        elseif  id >= 'FY01' and id <= 'FY08'
            int lv = GetUnitIntState(Pu[1],id)
            DzFrameShow(UI_TipsHead, true)
                
            if  lv > 0
                SetTipsData(1,"","|cffff0000"+GetTypeIdName(id)+"|rx"+I2S(lv))
            else
                SetTipsData(1,"","|cffff0000"+GetTypeIdName(id)+"|cff808080(未拥有)")
            endif
            
            SetTipsData(10,"",GetTypeIdTips(id))
            
            if  lv >= 3
                SetTipsData(11,"","\n|cff00ff00"+GetTypeIdName(id)+"x3\n"+GetTypeIdString(id,131))
            else
                SetTipsData(11,"","\n|cff808080"+GetTypeIdName(id)+"x3\n"+GetTypeIdString(id,131))
            endif

            if  lv >= 6
                SetTipsData(12,"","\n|cff00ff00"+GetTypeIdName(id)+"x6\n"+GetTypeIdString(id,132))
            else
                SetTipsData(12,"","\n|cff808080"+GetTypeIdName(id)+"x6\n"+GetTypeIdString(id,132))
            endif


            if  GetTypeIdString(id,133)!=""
                SetTipsData(13,"","\n|cff808080"+GetTypeIdString(id,133))
            endif
            ShowTipsUI()
        elseif  id > 0
            if  id < 500
                DzFrameShow(UI_TipsHead, true)
                SetTipsData(1,"","玄铁")
                SetTipsData(10,"","玄铁+"+I2S(id))
                ShowTipsUI()
            elseif  id < 1000000
                DzFrameShow(UI_TipsHead, true)
                SetTipsData(1,"","金币")
                SetTipsData(10,"","金币+"+I2S(id))
                ShowTipsUI()
            else
                BJDebugMsg(YDWEId2S(id))
                DzFrameShow(UI_TipsHead, true)
                SetTipsData(1,"",GetTypeIdName(id))
                
                SetTipsData(10,"",GetTypeIdStateTips(id))
                SetTipsData(11,"",GetTypeIdTips(id))
                ShowTipsUI()
            endif
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
        
        int lv = GetHeroLevel(Pu[1])
        int now = GetHeroXP(Pu[1])-last
        int use = DzGetUnitNeededXP(Pu[1],lv)-last
        DzFrameShow(UI_TipsHead, true)
        SetTipsData(10,"","|cffffcc00当前境界：|r"+I2S(lv-1))
        SetTipsData(11,"","|cffffcc00境界经验：|r"+I2S(now+1)+"/"+I2S(use))
        SetTipsData(12,"","|cffffcc00储存经验：|r"+I2S(HeroExExp)+"(最大值："+I2S(GetExExpMax(pid))+")")
        
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
                    elseif  id >= 21 and id <= 25
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
                        int num = GetUnitIntState(Pu[1],150)
                        if  num > 10
                            if  id == 151
                                boxid = GetUnitIntState(Pu[1],161)
                            else
                                boxid = GetUnitIntState(Pu[1],id)
                            endif
                        else
                            boxid = GetUnitIntState(Pu[1],id)
                        endif
                        
                        if  boxid > 0
                            BoxShowTips(pid,boxid)
                            DzFrameSetTexture(BUTTON_Back[id][4] , "war3mapImported\\UI_BUTTON_High.blp", 0)
                        endif
                    elseif  id == 309//时渊入场券
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
                        //BJDebugMsg("boxid"+I2S(boxid))
                        if  boxid > 0
                            BoxShowTips(pid,boxid)
                            DzFrameSetTexture(BUTTON_Back[id][4] , "war3mapImported\\UI_BUTTON_High.blp", 0)
                        endif
                    elseif  id >= 631 and id <= 640
                        boxid = GetPassCheckPrizeId(id-630,2)
                        //BJDebugMsg("boxid"+I2S(boxid))
                        if  boxid > 0
                            BoxShowTips(pid,boxid)
                            DzFrameSetTexture(BUTTON_Back[id][4] , "war3mapImported\\UI_BUTTON_High.blp", 0)
                        endif
                    elseif  id == 652 or id == 653
                        BoxShowResources(pid,id)
                    elseif  id >= 751 and id <= 756
                        BoxShowGem(pid,id-750)
                    elseif  id >= 901 and id <= 908
                        BoxShowRuneFrame(pid,id-900)
                    elseif  id >= 911 and id <= 913
                        boxid = GetUnitIntState(Pu[1],id)
                        if  boxid > 0
                            BoxShowTips(pid,boxid)
                        endif
                    elseif  id >= 921 and id <= 923
                        boxid = GetUnitIntState(Pu[1],id-10)
                        if  boxid > 0
                            BoxShowTips(pid,boxid)
                        endif

                    else
                        //UIDebugShowIndex(id)
                        DzFrameSetTexture(BUTTON_Back[id][4] , "war3mapImported\\UI_BUTTON_High.blp", 0)
                    endif
                endif
            elseif  Type == TYPE_BUTTON
                if  id >= 901 and id <= 908
                    SetTiptoolPosition(0.0,0.1)
                else
                    SetTiptoolPostionAsMouse()
                endif
            elseif  Type == TYPE_FUNC

            elseif  Type == TYPE_CLOSE
            endif
        endif
        if  GetPostionAsMouseX() >= 0.362 and GetPostionAsMouseX() <= 0.404 
            if  GetPostionAsMouseY() >= 0.878 and GetPostionAsMouseY() <= 0.935
                ShowUIUnitDefense(pid)
                frame = 8000
            elseif  GetPostionAsMouseY() >= 0.824 and GetPostionAsMouseY() <= 0.878
                ShowUIUnitAttack(pid)
                frame = 8001
            endif
        elseif  GetPostionAsMouseX() >= 0.504 and GetPostionAsMouseX() <= 0.531 and GetPostionAsMouseY() >= 0.825 and GetPostionAsMouseY() <= 0.9245
            ShowUIUnitOriginState(pid)
            frame = 8002
        endif
        LastFrame  = frame
    endfunction


