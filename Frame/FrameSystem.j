library GameUIInit initializer init uses OriginGameFrame
    int PlayerFrame = 0
    int LastFrame = 0
    hashtable uiht = InitHashtable()
    int array FrameId
    real WindowFix = 0
    int GameUI = 0
    function  GetFrameType(int a) ->int
        return LoadInteger(uiht,a,2)
    endfunction

    function InitFrame(int frame,int id,int Type)
        SaveInteger(uiht,frame,1,id)
        SaveInteger(uiht,frame,2,Type)
        FrameId[id]=frame
    endfunction
    
    function Id2Frame(int id)->int
        return FrameId[id]
    endfunction
    function Frame2Id(int frame)->int
        return LoadInteger(uiht,frame,1)
    endfunction

    function GetPostionAsMouseX()->real
        real x = DzGetMouseXRelative()
        real x2 = I2R(DzGetWindowWidth())
        real y = DzGetMouseYRelative()
        real y2 = I2R(DzGetWindowHeight())
        int ma = 0
        if  x2 == 0
            x2 = 0.001
        endif
        if  y2 == 0
            y2 = 0.001
        endif
        x = x/x2
        y = y/y2
        if  y > 0.66
            if  x > 0.5
                ma = Frame_BottomRight
            else
                ma = Frame_BottomLeft
            endif
            
        elseif  y > 0.33
            if  x > 0.5
                ma = Frame_Right
            else
                ma = Frame_Left
            endif
        else
            if  x > 0.5
                ma = Frame_TopRight
            else
                ma = Frame_TopLeft
            endif
        endif
       return x
    endfunction

    function GetPostionAsMouseY()->real
        real x = DzGetMouseXRelative()
        real x2 = I2R(DzGetWindowWidth())
        real y = DzGetMouseYRelative()
        real y2 = I2R(DzGetWindowHeight())
        int ma = 0
        if  x2 == 0
            x2 = 0.001
        endif
        if  y2 == 0
            y2 = 0.001
        endif
        x = x/x2
        y = y/y2
        if  y > 0.66
            if  x > 0.5
                ma = Frame_BottomRight
            else
                ma = Frame_BottomLeft
            endif
            
        elseif  y > 0.33
            if  x > 0.5
                ma = Frame_Right
            else
                ma = Frame_Left
            endif
        else
            if  x > 0.5
                ma = Frame_TopRight
            else
                ma = Frame_TopLeft
            endif
        endif
       return y
    endfunction

    function SetFramePostionAsMouse(int frameid)
        real x = DzGetMouseXRelative()
        real x2 = I2R(DzGetWindowWidth())
        real y = DzGetMouseYRelative()
        real y2 = I2R(DzGetWindowHeight())
        int ma = 0
        if x2 == 0
            x2 = 0.001
        endif
        if y2 == 0
            y2 = 0.001
        endif
        x = x/x2
        y = y/y2
        if y > 0.66
            if x > 0.5
                ma = 8
            else
                ma = 6
            endif
            
        elseif y > 0.33
            if x > 0.5
                ma = 5
            else
                ma = 3
            endif
        else
            if x > 0.5
                ma = 2
            else
                ma = 0
            endif
        endif
        DzFrameClearAllPoints( frameid )
        if x > 0.5
            DzFrameSetPoint( frameid , ma, DzGetGameUI(), 0, x*.8-0.01, -y*.6)
        else
            DzFrameSetPoint( frameid , ma, DzGetGameUI(), 0, x*.8+0.01, -y*.6)
        endif
    endfunction

    function SetFramePoint takes nothing returns nothing
        GameUI = DzGetGameUI()
        WindowFix = I2R(DzGetWindowHeight()) / I2R(DzGetWindowWidth())
        //DzFrameEditBlackBorders( 0, 0 )
        DzFrameClearAllPoints( DzFrameGetTooltip() )
        DzFrameSetPoint( DzFrameGetTooltip(), 8, GameUI, 2, 0, -0.45 )
        DzTriggerRegisterMouseMoveEvent(null, false, "UI_ScriptIn")
        //DzTriggerRegisterMouseWheelEvent(null,false, "UI_ScriptWheel")
         
        for i = 0,5
            DzFrameSetSize( DzFrameGetItemBarButton(i), 0.03,0.03 )
        end
        

        

        for x = 0,3
            for y = 0,2
                call DzFrameClearAllPoints(DzFrameGetCommandBarButton(y,x))
                call DzFrameSetSize(DzFrameGetCommandBarButton(y,x),.033,.033)
            end
        end
        
        call DzFrameSetPoint(DzFrameGetCommandBarButton(0,3),8,DzGetGameUI(),5,-.0121,-.218)
        call DzFrameSetPoint(DzFrameGetCommandBarButton(1,3),8,DzGetGameUI(),5,-.0121,-.218-.039)
        call DzFrameSetPoint(DzFrameGetCommandBarButton(2,3),8,DzGetGameUI(),5,-.0121,-.218-.078)
        call DzFrameSetPoint(DzFrameGetCommandBarButton(0,2),5,DzFrameGetCommandBarButton(0,3),3,-.0052,0)
        call DzFrameSetPoint(DzFrameGetCommandBarButton(0,1),5,DzFrameGetCommandBarButton(0,2),3,-.0052,0)
        call DzFrameSetPoint(DzFrameGetCommandBarButton(0,0),5,DzFrameGetCommandBarButton(0,1),3,-.0052,0)
        call DzFrameSetPoint(DzFrameGetCommandBarButton(1,2),5,DzFrameGetCommandBarButton(1,3),3,-.0052,0)
        call DzFrameSetPoint(DzFrameGetCommandBarButton(1,1),5,DzFrameGetCommandBarButton(1,2),3,-.0052,0)
        call DzFrameSetPoint(DzFrameGetCommandBarButton(1,0),5,DzFrameGetCommandBarButton(1,1),3,-.0052,0)
        
        call DzFrameSetPoint(DzFrameGetCommandBarButton(2,2),5,DzFrameGetCommandBarButton(2,3),3,-.0052,0)
        call DzFrameSetPoint(DzFrameGetCommandBarButton(2,1),5,DzFrameGetCommandBarButton(2,2),3,-.0052,0)
        call DzFrameSetPoint(DzFrameGetCommandBarButton(2,0),5,DzFrameGetCommandBarButton(2,1),3,-.0052,0)
        

        call DzFrameClearAllPoints(DzFrameGetMinimapButton(0))
        call DzFrameSetPoint(DzFrameGetMinimapButton(0),0,DzFrameGetMinimap(),2,-0.003,-1)
        
        for n = 1,4
            call DzFrameClearAllPoints(DzFrameGetMinimapButton(n))
            call DzFrameClearAllPoints(DzFrameGetUpperButtonBarButton(n-1))
            if  n == 2
                call DzFrameSetPoint(DzFrameGetMinimapButton(n),6,GameUI,6,0.005,0.13)
                call DzFrameSetSize(DzFrameGetMinimapButton(n),0.03,0.03)
            else
                call DzFrameSetPoint(DzFrameGetMinimapButton(n),1,DzFrameGetMinimapButton(n-1),7,0,-1)
            endif

        end

        
        for w = 0,5 
            DzFrameClearAllPoints(DzFrameGetItemBarButton(w))
        end
        DzFrameSetPoint( DzFrameGetItemBarButton(0), 4, DzGetGameUI(), 7, 0.1312, 0.096 )
        DzFrameSetPoint( DzFrameGetItemBarButton(1), 4, DzGetGameUI(), 7, 0.1687, 0.096 )
        DzFrameSetPoint( DzFrameGetItemBarButton(2), 4, DzGetGameUI(), 7, 0.1312, 0.0594 )
        DzFrameSetPoint( DzFrameGetItemBarButton(3), 4, DzGetGameUI(), 7, 0.1687, 0.0594 )
        DzFrameSetPoint( DzFrameGetItemBarButton(4), 4, DzGetGameUI(), 7, 0.1312, 0.0235 )
        DzFrameSetPoint( DzFrameGetItemBarButton(5), 4, DzGetGameUI(), 7, 0.1687, 0.0235 )


        
        DzFrameClearAllPoints( DzFrameGetTooltip() )
        DzFrameSetPoint( DzFrameGetTooltip(), 8, GameUI, 2, 0, -0.45 )
        
    endfunction
    func GameUIInitFunction()
        
        
        SetFramePoint()
        
        DzLoadToc("uitoc.toc" )
        
        ExecuteFunc("InitAbilityFrame")
        
        //ExecuteFunc("RankingListUIInit")
        
        ExecuteFunc("LoadTimer")
        
        ExecuteFunc("BossDamageFrameInit")
        ExecuteFunc("InitPlayerTaskUI")

        ExecuteFunc("HeroPowerFrameInit")
        ExecuteFunc("PassCheckUIInit")
        ExecuteFunc("InitShowSaveFrame")
        
        ExecuteFunc("MagicItemFrameInit")
        ExecuteFunc("PlotSelectFrameInit")
        ExecuteFunc("PrizeFrameInit")
        ExecuteFunc("LearnAbilityFrameInit")
        ExecuteFunc("ReplaceAbilityFrameInit")
        

        

        ExecuteFunc("HeroFrameUIInit")
        
        ExecuteFunc("BossLifeBarFrameInit")
        
        ExecuteFunc("InitAttackFrameUI")

        ExecuteFunc("InitExNativeFrame")

        ExecuteFunc("InitAttackTipUI")
        ExecuteFunc("TipsToolInit")

        
        
        
        DestroyTrigger(GetTriggeringTrigger())
    end
    private function init()
        trigger trig = CreateTrigger()
        TriggerRegisterTimerEvent(trig, 0, false)
        TriggerAddAction(trig, function GameUIInitFunction)
        trig = null

        call DzFrameClearAllPoints(DzFrameGetMinimap())
        call DzFrameSetPoint(DzFrameGetMinimap(),6,DzGetGameUI(),6,.002,.004)
        call DzFrameSetSize(DzFrameGetMinimap(),.115,.111)
    endfunction
endlibrary
