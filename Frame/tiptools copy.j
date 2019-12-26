library TipsTool uses GameUIInit
    integer array UI_TipsFrame[5][100]
    integer UI_TipsUI = 0
    string array UI_TipsStr[5][100]
    
    int UI_TipsPlayerTypeid = 0
    bool UI_TipsShow = false
    
    real TipsSizeX = 0
    real TipsSizeY = 0
    int TipsAlpha = 255
    #define TipsSize 0.18
    #define TipsIconSize 0.035
    

    
    #define UI_TipsBACK UI_TipsFrame[0]
    #define UI_TipsTEXT UI_TipsFrame[1]
    #define UI_TipsTEXT1 UI_TipsFrame[2]
    #define UI_TipsTEXT2 UI_TipsFrame[3]
    #define UI_TipsTEXT3 UI_TipsFrame[4]
    
    #define UI_TipsTexture UI_TipsStr[0]
    #define UI_TipsString UI_TipsStr[1]

    
    
    func SetTipsData(int dataid,string btn,string str)
        UI_TipsTexture[dataid]=btn
        UI_TipsString[dataid]=str
    end
    
    func ShowTipsUI()
        real l = 0
        real al =0
        real sl = 0

        if  UI_TipsTexture[0]!= ""
            DzFrameSetTexture(UI_TipsBACK[0] ,UI_TipsTexture[0], 0)
            DzFrameSetText(UI_TipsTEXT[0] ,UI_TipsString[0])
            DzFrameSetSize(UI_TipsBACK[0], TipsIconSize, TipsIconSize)
        else
            DzFrameSetSize(UI_TipsBACK[0], 0.00001, 0.00001)
        endif
        
        if  UI_TipsTexture[1] != ""
            DzFrameSetSize( UI_TipsBACK[1], 0.011, 0.011)
            DzFrameSetTexture(UI_TipsBACK[1] ,UI_TipsTexture[1], 0)
        else
            DzFrameSetSize( UI_TipsBACK[1], 0.0001, 0.011)
            DzFrameSetTexture(UI_TipsBACK[1] ,"UI\\Widgets\\ToolTips\\Human\\human-tooltip-background.blp", 0)        
        endif

        DzFrameSetText(UI_TipsTEXT[1] ,UI_TipsString[1])

        
        for i = 2,5
            if  UI_TipsTexture[i] != ""
                DzFrameSetSize( UI_TipsBACK[i], 0.011, 0.011)
                DzFrameSetTexture(UI_TipsBACK[i] ,UI_TipsTexture[i], 0)
            else
                DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.011)
                DzFrameSetTexture(UI_TipsBACK[i] ,"UI\\Widgets\\ToolTips\\Human\\human-tooltip-background.blp", 0)        
            endif
            
            
            if  UI_TipsString[i] != ""
                l = I2R(StringLength(UI_TipsString[i]))
                al = al + 0.011+l*0.005
                //DzFrameSetSize( UI_TipsTEXT[i], l*0.005,0.011)
                if  UI_TipsTexture[i] != ""
                    DzFrameSetSize( UI_TipsBACK[i], 0.011,0.011)
                else
                    DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.011)
                    DzFrameSetTexture(UI_TipsBACK[i] ,"UI\\Widgets\\ToolTips\\Human\\human-tooltip-background.blp", 0)        
                endif
            else
                DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.011)
                DzFrameSetTexture(UI_TipsBACK[i] ,"UI\\Widgets\\ToolTips\\Human\\human-tooltip-background.blp", 0)        
            endif
            
            DzFrameSetText(UI_TipsTEXT[i] ,UI_TipsString[i])
        end
        
        l = 0
        for i = 9,50
            sl = StringLength(UI_TipsString[i])
            
            if  UI_TipsTexture[i] != ""
                if  StringLength(UI_TipsTexture[i]) <=6
                    DzFrameSetSize( UI_TipsBACK[i], 0.0001, S2R(UI_TipsTexture[i]))
                    DzFrameSetTexture(UI_TipsBACK[i] ,"UI\\Widgets\\ToolTips\\Human\\human-tooltip-background.blp", 0)          
                    l = l + S2R(UI_TipsTexture[i])+0.001
                else
                    DzFrameSetSize( UI_TipsBACK[i], 0.011, 0.011)
                    DzFrameSetTexture(UI_TipsBACK[i] ,UI_TipsTexture[i], 0)
                    l = l + 0.013
                endif
                
            else
                if  UI_TipsString[i] == ""
                    DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.0001)
                    DzFrameSetTexture(UI_TipsBACK[i] ,"UI\\Widgets\\ToolTips\\Human\\human-tooltip-background.blp", 0)
                
                else
                    DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.011)
                    DzFrameSetTexture(UI_TipsBACK[i] ,"UI\\Widgets\\ToolTips\\Human\\human-tooltip-background.blp", 0)          
                    l = l + 0.013
                endif
                
            endif
            
            DzFrameSetText(UI_TipsTEXT[i] ,UI_TipsString[i])
        end
        
        
        al = 0.056+al
        if  al < 0.18
            al = 0.18
        endif
        
        TipsSizeX = al
        TipsSizeY = 0.06+l
        call DzFrameSetSize( UI_TipsUI, al,0.06+l)
        
        
        SetFramePostionAsMouse(UI_TipsUI)
        for i = 0,50
            UI_TipsTexture[i]=""
            UI_TipsString[i]=""
        end
    end
    
    

    /*
        以下内容为测试内容
        可以复制到自己的控件中直接使用
        目前序号是0-50
        0   主图标
        1   装备名称
        2-5 装备需求 支持4种
        9   等级要求
        10-50 属性
        
    */
    
    
    
    
    
    func TipsToolInit()
        UI_TipsUI = DzCreateFrame("tiptools2",DzGetGameUI(), 1)
        //DzCreateFrameByTagName("BACKDROP","TipsUI", DzGetGameUI(),"template",0)
        //DzFrameSetTexture(UI_TipsUI, "war3mapImported\\EquipTip.tga", 0)
        DzFrameSetSize( UI_TipsUI, TipsSize, 0.06)
        DzFrameSetAlpha( UI_TipsUI,250)
        
        
        //主图标 跟随主窗口 大小0.035
        UI_TipsBACK[0] = DzCreateFrameByTagName("BACKDROP","TipsBACK", UI_TipsUI,"template",0)
        DzFrameSetTexture( UI_TipsBACK[0], "war3mapImported\\EquipTip.tga", 0)
        DzFrameSetPoint(UI_TipsBACK[0] , 0, UI_TipsUI, 0, 0.013, -0.01)
        DzFrameSetSize(UI_TipsBACK[0], TipsIconSize, TipsIconSize)
        
        
        //主图标的文字 左上锚点
        UI_TipsTEXT[0]= DzCreateFrameByTagName("TEXT","TipsTEXT",UI_TipsUI,"template",0)
        DzFrameSetPoint(UI_TipsTEXT[0] , 8, UI_TipsBACK[0], 8, 0.00, 0.00)
        //DzFrameSetSize( UI_TipsTEXT[0], 0.011, 0.011)
        
        
        //装备名称 跟随主图标
        UI_TipsBACK[1]= DzCreateFrameByTagName("BACKDROP","TipsBACK", UI_TipsUI,"template",1)
        
        DzFrameSetPoint( UI_TipsBACK[1] ,0, UI_TipsBACK[0],2, 0.005, 0.0)
        DzFrameSetSize( UI_TipsBACK[1], 0.0001, 0.011)
        UI_TipsTEXT[1]= DzCreateFrame("text012",UI_TipsUI, 1)
        DzFrameSetPoint( UI_TipsTEXT[1] ,0, UI_TipsBACK[1],2, 0.0, 0.0)
        
        
        
        for i = 2,5
            UI_TipsBACK[i]= DzCreateFrameByTagName("BACKDROP","TipsBACK", UI_TipsUI,"template",i)
            if  i == 2
                DzFrameSetPoint( UI_TipsBACK[2] ,0, UI_TipsBACK[1],6, 0.0, -0.002)
            else
                DzFrameSetPoint( UI_TipsBACK[i] ,0, UI_TipsTEXT[i-1],2, 0.0, 0.0)
            endif
            DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.011)
            
            UI_TipsTEXT[i]= DzCreateFrame("text010",UI_TipsUI, i)
            
            DzFrameSetPoint( UI_TipsTEXT[i] ,0, UI_TipsBACK[i],2, 0.0, 0.0)
            
            
        end
        
        UI_TipsBACK[9]= DzCreateFrameByTagName("BACKDROP","TipsBACK", UI_TipsUI,"template",9)
        DzFrameSetPoint( UI_TipsBACK[9] ,0, UI_TipsBACK[2],6, 0.00, -0.002)
        DzFrameSetSize( UI_TipsBACK[9], 0.0001, 0.011)
        UI_TipsTEXT[9]= DzCreateFrame("text010",UI_TipsUI, 9)
        
        DzFrameSetPoint( UI_TipsTEXT[9] ,0, UI_TipsBACK[9],2, 0.0, 0.0)
        
        
        //10-50为详细说明
        for i = 10,50
            UI_TipsBACK[i]=DzCreateFrameByTagName("BACKDROP","TipsBACK", UI_TipsUI,"template",i)
            if  i == 10
                DzFrameSetPoint( UI_TipsBACK[i] ,0, UI_TipsBACK[0],6, 0.0, -0.01)
            else
                DzFrameSetPoint( UI_TipsBACK[i] ,0, UI_TipsBACK[i-1],6, 0.0,-0.002)
            endif
            
            DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.0011)
            
            UI_TipsTEXT[i]=  DzCreateFrame("EquipTips",UI_TipsUI, i)
            DzFrameSetPoint( UI_TipsTEXT[i] ,0, UI_TipsBACK[i],2, 0.0, 0.0)
            
            
        end
        
        for i = 0,50
            UI_TipsTexture[i]=""
            UI_TipsString[i]=""
        end
        

        DzFrameShow(UI_TipsUI, false)
        
    end
endlibrary