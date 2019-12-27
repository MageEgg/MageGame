library AttackFrameUI initializer InitAttackFrameUI uses GameFrame

    private FRAME Button
    private FRAME AttackTimerUI 
    private FRAME AttackTimerTextUI 
    private FRAME AttackTimerTextExUI 

    /*func CreateAttackTimerUI()
        AttackTimerUI = DzCreateFrameByTagName("BACKDROP","AttackTimerUI",GameUI,"template",0)
        DzFrameSetSize(AttackTimerUI,0.117,0.054)
        DzFrameSetTexture(AttackTimerUI,"AttackTimerUI.tga",0)
        DzFrameSetPoint(AttackTimerUI,4,GameUI,4,0,0.272)
        
        AttackTimerTextUI = DzCreateFrame("UITextCenter",AttackTimerUI, 20)//DzCreateFrameByTagName("itemnumber","AttackTimerTextUI",AttackTimerUI,"template",0)
        DzFrameSetSize(AttackTimerTextUI,0.117,0.03)
        DzFrameSetPoint(AttackTimerTextUI,1,AttackTimerUI,1,0,-0.007)
        DzFrameSetText(AttackTimerTextUI,"|cff00ff00进攻怪第1波 210秒|r")

        AttackTimerTextExUI = DzCreateFrame("UITextCenter",AttackTimerTextUI, 21)
        DzFrameSetSize(AttackTimerTextExUI,0.117,0.03)
        DzFrameSetPoint(AttackTimerTextExUI,1,AttackTimerTextUI,4,0,-0.005)
        DzFrameSetText(AttackTimerTextExUI,"|cff00ff00210秒|r")
        
        DzFrameShow(AttackTimerUI,false)
        
    end*/

    function InitAttackFrameUI()

        Button = FRAME.create() 
        AttackTimerUI = FRAME.create() 
        AttackTimerTextUI = FRAME.create()  
        AttackTimerTextExUI = FRAME.create()  

        //背景设置
        AttackTimerUI.frameid = FRAME.Tag("BACKDROP","AttackTimerUI",GameUI,0)
        AttackTimerUI.SetSize(0.117,0.054)
        AttackTimerUI.SetTexture("war3mapImported\\UI_AttackTimer.tga",0)
        AttackTimerUI.SetPoint(4,GameUI,4,0,0.272)

        Button.frameid = FRAME.Tag("BUTTON","AttackTimerUIBUTTON",GameUI,0)
        //Button.SetPoint(4,AttackTimerUI.frameid,4,0,0)
        Button.SetSize(0.117,0.054)

        //文本设置
        //AttackTimerTextUI.frameid = FRAME.Fdf("UITextOfAttackShow",AttackTimerUI,AttackTimerTextUI)
        //AttackTimerTextUI.SetPoint(1,AttackTimerUI.frameid,1,0,-0.007)
        //AttackTimerTextUI.SetSize(0.117,0.03)
        //AttackTimerTextUI.SetText("|cff00ff00进攻怪第1波 210秒|r")

        //设置快捷键文本
        //AttackTimerTextExUI.frameid = FRAME.Fdf("UITextOfAttackShow",AttackTimerTextUI,AttackTimerTextExUI)
        //AttackTimerTextExUI.SetPoint(1,AttackTimerTextUI.frameid,4,0,-0.005)
        //AttackTimerTextExUI.SetSize(0.117,0.03)
        //AttackTimerTextExUI.SetText("|cff00ff00210秒|r")

        //AttackTimerUI.show = false
    endfunction

endlibrary

