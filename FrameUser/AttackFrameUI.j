library AttackFrameUI uses GameFrame

    FRAME AttackTimerUIButton
    FRAME AttackTimerUI 
    FRAME AttackTimerTextUI 
    FRAME AttackTimerTextExUI 

    FRAME AttackShowUI

    FRAME VariationShowUI
    FRAME VariationTextUI 
    FRAME VariationTextExUI 

    function ShowAttackTimerUI(bool flag)
        AttackTimerUI.show = flag
    endfunction

    function CloseAttackShowUI()
        int time = 0
        real x = 0
        int ap = 255
        AttackShowUI.SetPoint(4,GameUI,4,x,0.16)
        AttackShowUI.alpha = ap
        TimerStart(0.0035,true)
        {
            if  time < 50
                time = time + 1
                x = x + 0.005
                ap = ap - 5
                AttackShowUI.SetPoint(4,GameUI,4,x,0.16)
                AttackShowUI.alpha = ap
            else
                AttackShowUI.alpha = ap
                AttackShowUI.show = false
                endtimer    
            endif
            flush locals
        }
        flush locals
    endfunction

    function StandAttackShowUI(real time)
        TimerStart(time,false)
        {
            CloseAttackShowUI()
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function OpenAttackShowUI(string back,real t)
        int time = 0
        real x = -0.25
        int ap = 5
        real tt = t
        AttackShowUI.SetTexture(back,0)
        AttackShowUI.SetPoint(4,GameUI,4,x,0.16)
        AttackShowUI.alpha = ap
        AttackShowUI.show = true
        TimerStart(0.0035,true)
        {
            if  time < 50
                time = time + 1
                x = x + 0.005
                ap = ap + 5
                AttackShowUI.SetPoint(4,GameUI,4,x,0.16)
                AttackShowUI.alpha = ap
            else
                StandAttackShowUI(tt)
                endtimer    
            endif
            flush locals
        }
        flush locals
    endfunction
    
    function ShowVariationUI(bool flag)
        VariationShowUI.show = flag
    endfunction

    function OpenVariationUI()
        int time = 0
        ShowVariationUI(true)
        TimerStart(0.05,true)
        {
            time = time + 1
            if  time < 17
                if  ModuloInteger(time,2) == 0
                    ShowVariationUI(true)
                else
                    ShowVariationUI(false)
                endif
            else
                ShowVariationUI(true)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function CloseVariationUI()
        int time = 0
        ShowVariationUI(false)
        TimerStart(0.05,true)
        {
            time = time + 1
            if  time < 17
                if  ModuloInteger(time,2) == 0
                    ShowVariationUI(false)
                else
                    ShowVariationUI(true)
                endif
            else
                ShowVariationUI(false)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function ShowVariationUIEx(bool flag)
        BJDebugMsg("ShowVariationUIEx")
        if  flag == true
            OpenVariationUI()
        else
            CloseVariationUI()
        endif
    endfunction

    function InitAttackFrameUI()

        AttackTimerUIButton = FRAME.create() 
        AttackTimerUI = FRAME.create() 
        AttackTimerTextUI = FRAME.create()  
        AttackTimerTextExUI = FRAME.create()  

        VariationShowUI = FRAME.create()
        VariationTextUI = FRAME.create()
        VariationTextExUI = FRAME.create()

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
        AttackTimerTextUI.SetText("|cffffcc00等待玩家选择|r")

        //设置快捷键文本
        AttackTimerTextExUI.frameid = FRAME.Fdf("centertext015",AttackTimerTextUI.frameid,AttackTimerTextExUI)
        AttackTimerTextExUI.SetPoint(1,AttackTimerTextUI.frameid,4,0,-0.005)
        AttackTimerTextExUI.SetSize(0.117,0.03)
        AttackTimerTextExUI.SetText("|cffffcc00等待玩家选择|r")

        //AttackTimerUI.show = false

        AttackShowUI = FRAME.create() 
        AttackShowUI.frameid = FRAME.Tag("BACKDROP","AttackShowUI",GameUI,0)
        AttackShowUI.SetSize(0.26,0.16)
        AttackShowUI.SetTexture("war3mapImported\\UI_AttackTimer.tga",0)
        AttackShowUI.SetPoint(4,GameUI,4,0,0.16)

        AttackShowUI.show = false

        VariationShowUI = FRAME.create() 
        VariationShowUI.frameid = FRAME.Tag("BACKDROP","VariationShowUI",GameUI,0)
        VariationShowUI.SetSize(0.12,0.052)
        VariationShowUI.SetTexture("war3mapImported\\UI_ShowVariation_Back.tga",0)
        VariationShowUI.SetPoint(0,GameUI,0,0.2,-0.025)

        //文本设置
        VariationTextUI.frameid = FRAME.Fdf("centertext015",VariationShowUI.frameid,VariationTextUI)
        VariationTextUI.SetPoint(1,VariationShowUI.frameid,1,0,-0.001)
        VariationTextUI.SetSize(0.117,0.03)
        VariationTextUI.SetText("|cffffcc00异变词缀|r")

        //设置快捷键文本
        VariationTextExUI.frameid = FRAME.Fdf("centertext015",VariationTextUI.frameid,VariationTextExUI)
        VariationTextExUI.SetPoint(1,VariationTextUI.frameid,4,0,-0.005)
        VariationTextExUI.SetSize(0.117,0.03)
        VariationTextExUI.SetText("|cffff0000生机，恐怖袭击|r")

        VariationShowUI.show = false

    endfunction

endlibrary

