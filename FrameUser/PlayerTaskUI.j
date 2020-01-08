library PlayerTaskUI uses GameFrame

    FRAME PlayerTaskUI_Back

    FRAME PlayerTaskUI_ChatBack
    FRAME PlayerTaskUI_ChatTitle 
    FRAME PlayerTaskUI_ChatTextA
    FRAME PlayerTaskUI_ChatTextB

    FRAME PlayerTaskUI_TaskBack
    FRAME PlayerTaskUI_TaskTitle
    FRAME PlayerTaskUI_TaskText

    function ShowPlayerTaskUI(bool flag)
        PlayerTaskUI_Back.show = flag
    endfunction

    /*function ClosePlayerTaskUI()
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

    function OpenPlayerTaskUI(string back,real t)
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
    endfunction*/

    function InitPlayerTaskUI()
        PlayerTaskUI_Back = FRAME.create() 

        PlayerTaskUI_ChatBack = FRAME.create() 
        PlayerTaskUI_ChatTitle  = FRAME.create() 
        PlayerTaskUI_ChatTextA = FRAME.create() 
        PlayerTaskUI_ChatTextB = FRAME.create() 

        PlayerTaskUI_TaskBack = FRAME.create() 
        PlayerTaskUI_TaskTitle = FRAME.create() 
        PlayerTaskUI_TaskText = FRAME.create()  

        //背景设置
        PlayerTaskUI_Back.frameid = FRAME.Tag("BACKDROP","PlayerTaskUI_Back",GameUI,0)
        PlayerTaskUI_Back.SetSize(0.36,0.07)
        PlayerTaskUI_Back.SetTexture("war3mapImported\\UI_AttackTimer.tga",0)
        PlayerTaskUI_Back.SetPoint(7,GameUI,7,0,0.127)

        PlayerTaskUI_TaskBack.frameid = FRAME.Tag("BACKDROP","PlayerTaskUI_TaskBack",PlayerTaskUI_Back.frameid,0)
        PlayerTaskUI_TaskBack.SetSize(0.055,0.055)
        PlayerTaskUI_TaskBack.SetTexture("a.blp",0)
        PlayerTaskUI_TaskBack.SetPoint(3,PlayerTaskUI_Back.frameid,3,0.005,0)

        PlayerTaskUI_ChatBack.frameid = FRAME.Tag("BACKDROP","PlayerTaskUI_TaskBack",PlayerTaskUI_TaskBack.frameid,0)
        PlayerTaskUI_ChatBack.SetSize(0.29,0.055)
        PlayerTaskUI_ChatBack.SetTexture("a.blp",0)
        PlayerTaskUI_ChatBack.SetPoint(3,PlayerTaskUI_TaskBack.frameid,5,0.005,0)

        PlayerTaskUI_TaskTitle.frameid = FRAME.Tag("BACKDROP","PlayerTaskUI_TaskBack",PlayerTaskUI_TaskBack.frameid,0)
        PlayerTaskUI_TaskTitle.SetSize(0.055,0.012)
        PlayerTaskUI_TaskTitle.SetTexture("textures\\white32.blp",0)
        PlayerTaskUI_TaskTitle.SetPoint(0,PlayerTaskUI_TaskBack.frameid,0,0,0)

        PlayerTaskUI_TaskText.frameid = FRAME.Tag("TEXT","PlayerTaskUI_TaskText",PlayerTaskUI_TaskTitle.frameid,0)
        PlayerTaskUI_TaskText.SetPoint(1,PlayerTaskUI_TaskTitle.frameid,7,0,-0.003)
        PlayerTaskUI_TaskText.SetSize(0.055,0.037)
        PlayerTaskUI_TaskText.SetText("|cffffcc00击杀新手BOSS|r")

        PlayerTaskUI_ChatTextA.frameid = FRAME.Tag("TEXT","PlayerTaskUI_ChatTextA",PlayerTaskUI_ChatBack.frameid,0)
        PlayerTaskUI_ChatTextA.SetPoint(0,PlayerTaskUI_ChatBack.frameid,0,0.003,-0.002)
        PlayerTaskUI_ChatTextA.SetSize(0.282,0.012)
        PlayerTaskUI_ChatTextA.SetText("|cffffcc00剧情：|r")

        PlayerTaskUI_ChatTextB.frameid = FRAME.Tag("TEXT","PlayerTaskUI_ChatTextB",PlayerTaskUI_ChatTextA.frameid,0)
        PlayerTaskUI_ChatTextB.SetPoint(0,PlayerTaskUI_ChatTextA.frameid,6,0,-0.002)
        PlayerTaskUI_ChatTextB.SetSize(0.282,0.035)
        PlayerTaskUI_ChatTextB.SetText("|cffffcc00击杀新手BOSS|r|n|cffffcc00击杀新手BOSS|r|n|cffffcc00击杀新手BOSS|r")

        //文本设置
        /*AttackTimerTextUI.frameid = FRAME.Fdf("centertext015",AttackTimerUI.frameid,AttackTimerTextUI)
        AttackTimerTextUI.SetPoint(1,AttackTimerUI.frameid,1,0,0)
        AttackTimerTextUI.SetSize(0.117,0.03)
        AttackTimerTextUI.SetText("|cffffcc00等待玩家选择|r")*/

        //设置快捷键文本
        /*AttackTimerTextExUI.frameid = FRAME.Fdf("centertext015",AttackTimerTextUI.frameid,AttackTimerTextExUI)
        AttackTimerTextExUI.SetPoint(1,AttackTimerTextUI.frameid,4,0,-0.005)
        AttackTimerTextExUI.SetSize(0.117,0.03)
        AttackTimerTextExUI.SetText("|cffffcc00等待玩家选择|r")*/

        //AttackTimerUI.show = false

        /*AttackShowUI = FRAME.create() 
        AttackShowUI.frameid = FRAME.Tag("BACKDROP","AttackShowUI",GameUI,0)
        AttackShowUI.SetSize(0.26,0.16)
        AttackShowUI.SetTexture("war3mapImported\\UI_AttackTimer.tga",0)
        AttackShowUI.SetPoint(4,GameUI,4,0,0.16)*/

        //PlayerTaskUI_Back.show = false

    endfunction

endlibrary

