library TipsTool uses GameUIInit
    integer array UI_TipsFrame[5][100]
    integer UI_TipsName = 0
    integer UI_TipsTool = 0
    integer UI_TipsHead = 0
    integer UI_TipsFoot = 0

    int UI_LongLast = 0
    string array UI_TipsStr[5][100]
    
    int UI_TipsPlayerTypeid = 0
    bool UI_TipsShow = false
    
    #define TipsSize 0.15
    #define TipsIconSize 0.035
    
    //
    
    #define UI_TipsBACK UI_TipsFrame[0]
    #define UI_TipsTEXT UI_TipsFrame[1]
    #define UI_TipsFRAM UI_TipsFrame[2]

    
    #define UI_TipsTexture UI_TipsStr[0]
    #define UI_TipsString UI_TipsStr[1]

    
    
    func SetTipsData(int dataid,string btn,string str)
        UI_TipsTexture[dataid]=btn
        UI_TipsString[dataid]=str
    end

    function ShowNewDzFrameTooltip(real high)
        DzFrameSetSize(UI_TipsHead,0.215,high)
        DzFrameClearAllPoints(UI_TipsHead)
        DzFrameSetPoint(UI_TipsHead, 8, GameUI, 2, 0,-0.435 )

        DzFrameSetSize(UI_TipsFoot,0.215,high)
        DzFrameClearAllPoints(UI_TipsFoot)
        DzFrameSetPoint(UI_TipsFoot, 8, GameUI, 2, 0,-0.435 )
    endfunction

    function SetOriginDzFrameTooltip()
        DzFrameSetPoint( DzFrameGetTooltip(), 8, GameUI, 2, 0, -0.44 )
        DzFrameSetSize( UI_TipsHead, TipsSize, 0.01)
        DzFrameSetSize( UI_TipsFoot, TipsSize, 0.01)
    endfunction
    

    function SetTiptoolPosition(real r1,real r2)

        real x = DzGetMouseXRelative()
        real x2 = I2R(DzGetWindowWidth())
        real y = DzGetMouseYRelative()
        real y2 = I2R(DzGetWindowHeight())
        int ma = 0
        int last = UI_LongLast

        if  last > 0
            if x2 == 0
                x2 = 0.001
            endif
            if y2 == 0
                y2 = 0.001
            endif
            x = x/x2
            y = y/y2



            DzFrameClearAllPoints( UI_TipsFoot )
            DzFrameSetPoint( UI_TipsFoot , 7,UI_TipsTEXT[last],7 , 0.0,0.0)

            DzFrameClearAllPoints( UI_TipsHead)

            if  y > 0.5
                if  x > 0.5
                    DzFrameSetPoint( UI_TipsHead , 2, DzGetGameUI(), 0, x*.8-0.01+r1, -y*.6+r2)
                else
                    DzFrameSetPoint( UI_TipsHead , 0, DzGetGameUI(), 0, x*.8+0.025+r1, -y*.6+r2)
                endif
            else
                if  x > 0.5
                    DzFrameSetPoint( UI_TipsHead , 2, DzGetGameUI(), 0, x*.8-0.01+r1, -y*.6+r2)
                else
                    DzFrameSetPoint( UI_TipsHead , 0, DzGetGameUI(), 0, x*.8+0.025+r1, -y*.6+r2)
                endif
            endif
            
            
        endif

    endfunction
    func ShowTipsUISetPosition(real r1,real r2)
        int last = 10

        DzFrameSetText(UI_TipsName ,UI_TipsString[1])

        for i = 2,5
            if  UI_TipsTexture[i] != ""
                DzFrameSetSize( UI_TipsBACK[i], 0.011, 0.011)
                DzFrameSetTexture(UI_TipsBACK[i] ,UI_TipsTexture[i], 0)
            else
                DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.011)
                DzFrameSetTexture(UI_TipsBACK[i] ,"war3mapImported\\alpha.tga", 0)        
            endif
            
            
            if  UI_TipsString[i] != ""
                if  UI_TipsTexture[i] != ""
                    DzFrameSetSize( UI_TipsBACK[i], 0.011,0.011)
                else
                    DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.011)
                    DzFrameSetTexture(UI_TipsBACK[i] ,"war3mapImported\\alpha.tga", 0)        
                endif
            else
                DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.011)
                DzFrameSetTexture(UI_TipsBACK[i] ,"war3mapImported\\alpha.tga", 0)        
            endif
            
            DzFrameSetText(UI_TipsTEXT[i] ,UI_TipsString[i])
        end
        
        
        for i = 10,50
            
            if  UI_TipsTexture[i] != ""
                DzFrameSetSize( UI_TipsBACK[i], 0.011, 0.011)
                DzFrameSetTexture(UI_TipsBACK[i] ,UI_TipsTexture[i], 0)
                last = i
            else

                if  UI_TipsString[i] == ""
                    DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.0001)
                    DzFrameSetTexture(UI_TipsBACK[i] ,"war3mapImported\\alpha.tga", 0)
                else
                    DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.011)
                    DzFrameSetTexture(UI_TipsBACK[i] ,"war3mapImported\\alpha.tga", 0)       
                    last = i   
                endif
                
            endif
            
            DzFrameSetText(UI_TipsTEXT[i] ,UI_TipsString[i])
        end

        for i = 0,50
            UI_TipsTexture[i]=""
            UI_TipsString[i]=""
        end

        
        UI_LongLast = last

        SetTiptoolPosition(r1,r2)
    end


    function SetTiptoolPostionAsMouse()
        real x = DzGetMouseXRelative()
        real x2 = I2R(DzGetWindowWidth())
        real y = DzGetMouseYRelative()
        real y2 = I2R(DzGetWindowHeight())
        int ma = 0
        int last = UI_LongLast

        if  last > 0
            if x2 == 0
                x2 = 0.001
            endif
            if y2 == 0
                y2 = 0.001
            endif
            x = x/x2
            y = y/y2



            DzFrameClearAllPoints( UI_TipsFoot )
            DzFrameSetPoint( UI_TipsFoot , 7,UI_TipsTEXT[last],7 , 0.0,0.0)

            DzFrameClearAllPoints( UI_TipsHead)

            if  y > 0.5
                if  x > 0.5
                    DzFrameSetPoint( UI_TipsHead , 2, DzGetGameUI(), 0, x*.8-0.01, -y*.6)
                else
                    DzFrameSetPoint( UI_TipsHead , 0, DzGetGameUI(), 0, x*.8+0.025, -y*.6)
                endif
            else
                if  x > 0.5
                    DzFrameSetPoint( UI_TipsHead , 2, DzGetGameUI(), 0, x*.8-0.01, -y*.6)
                else
                    DzFrameSetPoint( UI_TipsHead , 0, DzGetGameUI(), 0, x*.8+0.025, -y*.6)
                endif
            endif
        endif


    endfunction

    

    func ShowTipsUI()
        int last = 10

        DzFrameSetText(UI_TipsName ,UI_TipsString[1])

        for i = 2,5
            if  UI_TipsTexture[i] != ""
                DzFrameSetSize( UI_TipsBACK[i], 0.011, 0.011)
                DzFrameSetTexture(UI_TipsBACK[i] ,UI_TipsTexture[i], 0)
            else
                DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.011)
                DzFrameSetTexture(UI_TipsBACK[i] ,"war3mapImported\\alpha.tga", 0)        
            endif
            
            
            if  UI_TipsString[i] != ""
                if  UI_TipsTexture[i] != ""
                    DzFrameSetSize( UI_TipsBACK[i], 0.011,0.011)
                else
                    DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.011)
                    DzFrameSetTexture(UI_TipsBACK[i] ,"war3mapImported\\alpha.tga", 0)        
                endif
            else
                DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.011)
                DzFrameSetTexture(UI_TipsBACK[i] ,"war3mapImported\\alpha.tga", 0)        
            endif
            
            DzFrameSetText(UI_TipsTEXT[i] ,UI_TipsString[i])
        end
        
        
        for i = 10,50
            
            if  UI_TipsTexture[i] != ""
                DzFrameSetSize( UI_TipsBACK[i], 0.011, 0.011)
                DzFrameSetTexture(UI_TipsBACK[i] ,UI_TipsTexture[i], 0)
                last = i
            else

                if  UI_TipsString[i] == ""
                    DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.0001)
                    DzFrameSetTexture(UI_TipsBACK[i] ,"war3mapImported\\alpha.tga", 0)
                else
                    DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.011)
                    DzFrameSetTexture(UI_TipsBACK[i] ,"war3mapImported\\alpha.tga", 0)       
                    last = i   
                endif
                
            endif
            
            DzFrameSetText(UI_TipsTEXT[i] ,UI_TipsString[i])
        end

        for i = 0,50
            UI_TipsTexture[i]=""
            UI_TipsString[i]=""
        end

        
        UI_LongLast = last

        SetTiptoolPostionAsMouse()
    end
    

  

    func TipsToolInit()

        UI_TipsHead = DzCreateFrameByTagName("BACKDROP","UI_TipsHead",DzGetGameUI(),"template",0)
        UI_TipsFoot = DzCreateFrameByTagName("BACKDROP","UI_TipsFoot",UI_TipsHead ,"template",0)

        DzFrameSetTexture(UI_TipsHead,"war3mapImported\\alpha.tga", 0)    
        DzFrameSetTexture(UI_TipsFoot,"war3mapImported\\alpha.tga", 0)   

        DzFrameSetPoint( UI_TipsHead , 0,DzGetGameUI(), 4, 0.0,0.0)
        DzFrameSetSize( UI_TipsHead, TipsSize, 0.01)

        DzFrameSetPoint( UI_TipsFoot , 0,DzGetGameUI(), 4, 0.0,-0.05)
        DzFrameSetSize( UI_TipsFoot, TipsSize, 0.01)



        UI_TipsTool = DzCreateFrame("tiptools2",UI_TipsHead, 1)
        DzFrameSetPoint( UI_TipsTool , 0,UI_TipsHead, 0, -0.005,0.005)
        DzFrameSetPoint( UI_TipsTool , 8,UI_TipsFoot, 8, 0.005,-0.005)
        DzFrameSetAlpha( UI_TipsTool,250)

        UI_TipsName = DzCreateFrame("text015",UI_TipsHead, 1)
        
        DzFrameSetPoint( UI_TipsName , 0,UI_TipsHead,0, 0.0, 0.0)

        
        
    
        
        
        for i = 2,5
            UI_TipsBACK[i]= DzCreateFrameByTagName("BACKDROP","TipsBACK", UI_TipsHead,"template",i)
            DzFrameSetTexture(UI_TipsBACK[i] ,"war3mapImported\\alpha.tga", 0)       
            if  i == 2
                DzFrameSetPoint( UI_TipsBACK[2] ,0, UI_TipsName,6, 0.0, -0.003)
            else
                DzFrameSetPoint( UI_TipsBACK[i] ,0, UI_TipsTEXT[i-1],2, 0.0, 0.0)
            endif
            DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.011)
            
            UI_TipsTEXT[i]= DzCreateFrame("text010",UI_TipsHead, i)
            
            DzFrameSetPoint( UI_TipsTEXT[i] ,0, UI_TipsBACK[i],2, 0.0, 0.0)
            
            
        end

        
        
        //10-50为详细说明
        for i = 10,50

            UI_TipsBACK[i]=DzCreateFrameByTagName("BACKDROP","TipsBACK", UI_TipsHead,"template",i)
            DzFrameSetTexture(UI_TipsBACK[i] ,"war3mapImported\\alpha.tga", 0)       

            UI_TipsFRAM[i]=DzCreateFrameByTagName("BACKDROP","UI_TipsFRAM", UI_TipsHead,"template",i)
            DzFrameSetTexture(UI_TipsFRAM[i] ,"war3mapImported\\alpha.tga", 0)       

            UI_TipsTEXT[i]=  DzCreateFrame("text010",UI_TipsHead, i)
            DzFrameSetSize( UI_TipsBACK[i], 0.0001, 0.0011)
            DzFrameSetSize( UI_TipsTEXT[i],TipsSize, 0.0)
            if  i == 10
                
                DzFrameSetPoint( UI_TipsBACK[i] ,0, UI_TipsName,6, 0.0, -0.003)
                DzFrameSetPoint( UI_TipsTEXT[i] ,0, UI_TipsBACK[i],2, 0.0, 0.0)

                DzFrameSetPoint( UI_TipsFRAM[i] ,0, UI_TipsBACK[i],0, 0.0, 0.0)
                DzFrameSetPoint( UI_TipsFRAM[i] ,8, UI_TipsTEXT[i],6, 0.0, 0.0)
            else
                
                DzFrameSetPoint( UI_TipsBACK[i] ,0, UI_TipsFRAM[i-1],6, 0.0,-0.003)
                DzFrameSetPoint( UI_TipsTEXT[i] ,0, UI_TipsBACK[i],2, 0.0, 0.0)

                DzFrameSetPoint( UI_TipsFRAM[i] ,0, UI_TipsFRAM[i-1],6, 0.0, 0.0)
                DzFrameSetPoint( UI_TipsFRAM[i] ,8, UI_TipsTEXT[i],6, 0.0, 0.0)
            endif
            
        end
        
        for i = 0,50
            UI_TipsTexture[i]=""
            UI_TipsString[i]=""
        end
        

        DzFrameShow(UI_TipsHead, false)
        
    end
endlibrary