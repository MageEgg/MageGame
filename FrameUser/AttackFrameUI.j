library AttackFrameUI uses GameFrame

    FRAME AttackTimerUIButton
    FRAME AttackTimerUI 
    FRAME AttackTimerTextUI 
    FRAME AttackTimerTextExUI 

    function ShowAttackTimerUI(bool flag)
        AttackTimerUI.show = flag
    endfunction



    function InitAttackFrameUI()

        AttackTimerUIButton = FRAME.create() 
        AttackTimerUI = FRAME.create() 
        AttackTimerTextUI = FRAME.create()  
        AttackTimerTextExUI = FRAME.create()  

        //背景设置
        AttackTimerUI.frameid = FRAME.Tag("BACKDROP","AttackTimerUI",GameUI,0)
        AttackTimerUI.SetSize(0.117,0.054)
        AttackTimerUI.SetTexture("war3mapImported\\UI_AttackTimer.tga",0)
        AttackTimerUI.SetPoint(4,GameUI,4,0,0.272)

        AttackTimerUIButton.frameid = FRAME.Tag("BUTTON","AttackTimerUIBUTTON",GameUI,0)
        AttackTimerUIButton.SetPoint(4,AttackTimerUI.frameid,4,0,0)
        AttackTimerUIButton.SetSize(0.117,0.054)

        //文本设置
        AttackTimerTextUI.frameid = FRAME.Fdf("centertext015",AttackTimerUI.frameid,AttackTimerTextUI)
        AttackTimerTextUI.SetPoint(1,AttackTimerUI.frameid,1,0,0)
        AttackTimerTextUI.SetSize(0.117,0.03)
        AttackTimerTextUI.SetText("|cff00ff00进攻怪第1波 210秒|r")

        //设置快捷键文本
        AttackTimerTextExUI.frameid = FRAME.Fdf("centertext015",AttackTimerTextUI.frameid,AttackTimerTextExUI)
        AttackTimerTextExUI.SetPoint(1,AttackTimerTextUI.frameid,4,0,-0.005)
        AttackTimerTextExUI.SetSize(0.117,0.03)
        AttackTimerTextExUI.SetText("|cff00ff00210秒|r")

        AttackTimerUI.show = false
    endfunction

endlibrary

