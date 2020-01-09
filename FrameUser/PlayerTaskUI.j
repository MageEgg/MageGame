library PlayerTaskUI uses GameFrame

    FRAME PlayerTaskUI_Back

    FRAME PlayerTaskUI_ChatBack
    FRAME PlayerTaskUI_ChatTitle 
    FRAME PlayerTaskUI_ChatTextA
    FRAME PlayerTaskUI_ChatTextB

    FRAME PlayerTaskUI_TaskBack
    FRAME PlayerTaskUI_TaskTitle
    FRAME PlayerTaskUI_TaskText

    function ClosePlayerTaskUI()
        int hp = 255
        int time = 0
        PlayerTaskUI_Back.alpha = hp
        PlayerTaskUI_Back.show = true
        TimerStart(0.004,true)
        {
            if  time < 50
                time = time + 1
                hp = hp - 5
                PlayerTaskUI_Back.alpha = hp
            else
                PlayerTaskUI_Back.alpha = 0
                PlayerTaskUI_Back.show = false
                endtimer    
            endif
            flush locals
        }
        flush locals
    endfunction

    function OpenPlayerTaskUI()
        int hp = 0
        int time = 0
        PlayerTaskUI_Back.alpha = hp
        PlayerTaskUI_Back.show = true
        TimerStart(0.004,true)
        {
            if  time < 50
                time = time + 1
                hp = hp + 5
                PlayerTaskUI_Back.alpha = hp
            else
                PlayerTaskUI_Back.alpha = 255
                PlayerTaskUI_Back.show = true
                endtimer    
            endif
            flush locals
        }
        flush locals
    endfunction

    function ShowPlayerTaskUI(bool b,real time)
        bool show = b
        TimerStart(time,false)
        {
            if  show == true
                OpenPlayerTaskUI()
            else
                ClosePlayerTaskUI()
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function ClosePlayerTaskUIOfPlayer(int id)
        int pid = id
        int hp = 255
        int time = 0
        if  Player(pid) == GetLocalPlayer()
            PlayerTaskUI_Back.alpha = hp
            PlayerTaskUI_Back.show = true
        endif
        TimerStart(0.004,true)
        {
            if  time < 50
                time = time + 1
                if  Player(pid) == GetLocalPlayer()
                    hp = hp - 5
                    PlayerTaskUI_Back.alpha = hp
                endif
            else
                if  Player(pid) == GetLocalPlayer()
                    PlayerTaskUI_Back.alpha = 0
                    PlayerTaskUI_Back.show = false
                endif
                endtimer    
            endif
            flush locals
        }
        flush locals
    endfunction

    function OpenPlayerTaskUIOfPlayer(int id)
        int pid = id
        int hp = 0
        int time = 0
        if  Player(pid) == GetLocalPlayer()
            PlayerTaskUI_Back.alpha = hp
            PlayerTaskUI_Back.show = true
        endif
        TimerStart(0.004,true)
        {
            if  time < 50
                time = time + 1
                if  Player(pid) == GetLocalPlayer()
                    hp = hp + 5
                    PlayerTaskUI_Back.alpha = hp
                endif
            else
                if  Player(pid) == GetLocalPlayer()
                    PlayerTaskUI_Back.alpha = 255
                    PlayerTaskUI_Back.show = true
                endif
                endtimer    
            endif
            flush locals
        }
        flush locals
    endfunction

    function ShowPlayerTaskUIOfPlayer(int id,bool b,real time)
        int pid = id
        bool show = b
        TimerStart(time,false)
        {
            if  show == true
                OpenPlayerTaskUIOfPlayer(pid)
            else
                ClosePlayerTaskUIOfPlayer(pid)
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function SetPlayerTaskUITask(string s,real time)
        string task = s
        TimerStart(time,false)
        {
            PlayerTaskUI_TaskText.SetText(task)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function SetPlayerTaskUITaskOfPlayer(int id,string s,real time)
        int pid = id
        string task = s
        TimerStart(time,false)
        {
            if  Player(pid) == GetLocalPlayer()
                PlayerTaskUI_TaskText.SetText(task)
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function ShowPlayerTaskUIChat(string s)
        string chat = s
        string show = ""
        int time = 0
        int cos = 0
        TimerStart(0.014,true)
        {
            time = time + 1
            if  time <= 100 and cos < StringLength(chat)
                show = SubString(chat,cos,cos+2)
                if  show == "|c"
                    show = SubString(chat,0,cos+13)
                    cos = cos + 13
                elseif  show == "|r"
                    show = SubString(chat,0,cos+5)
                    cos = cos + 5
                else
                    show = SubString(chat,0,cos+3)
                    cos = cos + 3
                endif
                PlayerTaskUI_ChatTextB.SetText(show)
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction


    function SetPlayerTaskUIChat(string s1,string s2,real time)
        string title = s1
        string chat = s2
        TimerStart(time,false)
        {
            PlayerTaskUI_ChatTextA.SetText("|cffffcc00"+title+"：|r")
            ShowPlayerTaskUIChat(chat)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function ShowPlayerTaskUIChatOfPlayer(int id,string s)
        int pid = id
        string chat = s
        string show = ""
        int time = 0
        int cos = 0
        TimerStart(0.014,true)
        {
            time = time + 1
            if  time <= 100 and cos < StringLength(chat)
                show = SubString(chat,cos,cos+2)
                if  show == "|c"
                    show = SubString(chat,0,cos+13)
                    cos = cos + 13
                elseif  show == "|r"
                    show = SubString(chat,0,cos+5)
                    cos = cos + 5
                else
                    show = SubString(chat,0,cos+3)
                    cos = cos + 3
                endif
                if  Player(pid) == GetLocalPlayer()
                    PlayerTaskUI_ChatTextB.SetText(show)
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SetPlayerTaskUIChatOfPlayer(int id,string s1,string s2,real time)
        int pid = id
        string title = s1
        string chat = s2
        TimerStart(time,false)
        {
            if  Player(pid) == GetLocalPlayer()
                PlayerTaskUI_ChatTextA.SetText("|cffffcc00"+title+"：|r")
            endif
            ShowPlayerTaskUIChatOfPlayer(pid,chat)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function InitPlayerTaskUI()
        PlayerTaskUI_Back = FRAME.create() 

        PlayerTaskUI_ChatBack = FRAME.create() 
        PlayerTaskUI_ChatTitle  = FRAME.create() 
        PlayerTaskUI_ChatTextA = FRAME.create() 
        PlayerTaskUI_ChatTextB = FRAME.create() 

        PlayerTaskUI_TaskBack = FRAME.create() 
        PlayerTaskUI_TaskTitle = FRAME.create() 
        PlayerTaskUI_TaskText = FRAME.create()  

        PlayerTaskUI_Back.frameid = FRAME.Tag("BACKDROP","PlayerTaskUI_Back",GameUI,0)
        PlayerTaskUI_Back.SetSize(0.36,0.07)
        PlayerTaskUI_Back.SetTexture("war3mapImported\\PlayerTaskUI_Back.tga",0)
        PlayerTaskUI_Back.SetPoint(7,GameUI,7,0,0.126)

        PlayerTaskUI_ChatBack.frameid = FRAME.Tag("BACKDROP","PlayerTaskUI_TaskBack",PlayerTaskUI_Back.frameid,0)
        PlayerTaskUI_ChatBack.SetSize(0.288,0.058)
        PlayerTaskUI_ChatBack.SetTexture("war3mapImported\\PlayerTaskUI_Back.tga",0)
        PlayerTaskUI_ChatBack.SetPoint(3,PlayerTaskUI_Back.frameid,3,0.005,0)

        PlayerTaskUI_TaskBack.frameid = FRAME.Tag("BACKDROP","PlayerTaskUI_TaskBack",PlayerTaskUI_ChatBack.frameid,0)
        PlayerTaskUI_TaskBack.SetSize(0.058,0.058)
        PlayerTaskUI_TaskBack.SetTexture("war3mapImported\\PlayerTaskUI_Back.tga",0)
        PlayerTaskUI_TaskBack.SetPoint(3,PlayerTaskUI_ChatBack.frameid,5,0.004,0)

        PlayerTaskUI_TaskTitle.frameid = FRAME.Tag("BACKDROP","PlayerTaskUI_TaskBack",PlayerTaskUI_TaskBack.frameid,0)
        PlayerTaskUI_TaskTitle.SetSize(0.058,0.014)
        PlayerTaskUI_TaskTitle.SetTexture("textures\\white32.blp",0)
        PlayerTaskUI_TaskTitle.SetPoint(0,PlayerTaskUI_TaskBack.frameid,0,0,0)

        PlayerTaskUI_TaskText.frameid = FRAME.Tag("TEXT","PlayerTaskUI_TaskText",PlayerTaskUI_TaskTitle.frameid,0)
        PlayerTaskUI_TaskText.SetPoint(1,PlayerTaskUI_TaskTitle.frameid,7,0.002,-0.003)
        PlayerTaskUI_TaskText.SetSize(0.054,0.039)
        PlayerTaskUI_TaskText.SetText("")

        PlayerTaskUI_ChatTextA.frameid = FRAME.Fdf("text012",PlayerTaskUI_ChatBack.frameid,PlayerTaskUI_ChatTextA)
        //FRAME.Tag("TEXT","PlayerTaskUI_ChatTextA",PlayerTaskUI_ChatBack.frameid,0)
        PlayerTaskUI_ChatTextA.SetPoint(0,PlayerTaskUI_ChatBack.frameid,0,0.003,-0.002)
        PlayerTaskUI_ChatTextA.SetSize(0.282,0.012)
        PlayerTaskUI_ChatTextA.SetText("")

        PlayerTaskUI_ChatTextB.frameid = FRAME.Tag("TEXT","PlayerTaskUI_ChatTextB",PlayerTaskUI_ChatBack.frameid,0)
        PlayerTaskUI_ChatTextB.SetPoint(0,PlayerTaskUI_ChatBack.frameid,0,0.003,-0.017)
        PlayerTaskUI_ChatTextB.SetSize(0.282,0.039)
        PlayerTaskUI_ChatTextB.SetText("")

        PlayerTaskUI_Back.alpha = 0
        PlayerTaskUI_Back.show = false

    endfunction

endlibrary

