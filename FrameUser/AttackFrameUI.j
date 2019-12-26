library AttackFrameUI initializer InitAttackFrameUI uses GameFrame
    int array MapUIInt

    #define AttackTimerUI       MapUIInt[0]
    #define AttackTimerTextUI   MapUIInt[1]
    #define AttackTimerTextExUI MapUIInt[2]

    function InitAttackFrameUI()

        Button = FRAME.create() //背景注册
        Back = FRAME.create()   //注册主背景
        Key = FRAME.create()    //注册快捷键文本

        //控件设置
        Button.frameid = FRAME.Tag("BUTTON","Check",GameUI,Button)
        Button.SetPoint(4,GameUI,4,0,0)
        Button.SetSize(0.35,0.2875)
        origin = Button.frameid

        //背景设置
        Back.frameid = FRAME.Tag("BACKDROP","Check",origin,Back)
        Back.SetPoint(4,origin,4,0,0)
        Back.SetSize(0.35,0.2875)
        Back.SetTexture("war3mapImported\\UI_Pass_Back.tga",0)

        //设置快捷键文本
        Key.frameid = FRAME.Fdf("centertext010",origin,Key)
        Key.SetText("1/10")
        Key.SetPoint(1,Button.frameid ,1,0.0,-0.015)

        CreateFrameButton1()

        Button.show = false
    endfunction

endlibrary

