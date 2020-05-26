library PKRankingFrame uses GameFrame
    private FRAME Button
    private FRAME Back

    private FRAME TextTime1
    private FRAME TextTime2
    private FRAME TextTime3
    FRAME HYHDButton

    private int origin = 0


    function ClickButtonBlessGive(unit wu,int index)->int
            int id = 0
            bj_lastCreatedItem = PlaceRandomItem(ItemPool[index],GetUnitX(wu),GetUnitY(wu))
            id = GetItemTypeId(bj_lastCreatedItem)
            UnitAddItem(wu,bj_lastCreatedItem)
            bj_lastCreatedItem = null
            return id
        endfunction

    function ClickButtonBlessFuncShow(unit wu)
            int pid = GetPlayerId(GetOwningPlayer(wu))
            int id = ClickButtonBlessGive(wu,17)
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r恭喜玩家"+GetPlayerNameOfColor(pid)+"通过|cffffcc00封神祝福|r获得 "+GetObjectName(id)+"x1")
        endfunction
    function ClickButtonBlessFunc(int pid)
        PlayerHYJSBless = PlayerHYJSBless + 1
        if  Pu[5] == Pu[2]
            ClickButtonBlessFuncShow(Pu[2])
        else
            ClickButtonBlessFuncShow(Pu[1])
        endif
    endfunction
    function ClickButtonBless(int pid)
        if  AttackUnitWN >= 2
            if  PlayerHYJSBless == 0
                if  GameSaveClose == 0
                    ClickButtonBlessFunc(pid)
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r全民竞速模式下无法使用祝福功能！")
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r这局游戏你已经用过祝福啦！")
            endif

        else
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r进攻3波后可进行祝福！")
        endif
    endfunction

    function ClickButtonHYHD(int pid)
        if  GetLocalPlayer() == Player(pid)
            Button.show = true
        endif
    endfunction

    function InitPKRankingFrame()
        Button = FRAME.create() //背景注册
        Back = FRAME.create()   //注册主背景

        TextTime1 = FRAME.create()
        TextTime2 = FRAME.create()
        TextTime3 = FRAME.create()

        //控件设置
        Button.frameid = FRAME.Tag("BUTTON","PKRank",GameUI,Button)
        Button.SetPoint(4,GameUI,4,0,0.02)
        Button.SetSize(0.6,0.4)
        origin = Button.frameid

        //背景设置
        Back.frameid = FRAME.Tag("BACKDROP","PKRank",origin,Back)
        Back.SetPoint(4,origin,4,0,0.02)
        Back.SetSize(0.6,0.4)
        Back.SetTexture("UI_winner_Back.tga",0)

        TextTime1.frameid = FRAME.Fdf("centertext010",origin,TextTime1)
        TextTime1.SetPoint(4,origin,0,0.437,-0.110-0.022)
        TextTime1.SetText("")

        TextTime2.frameid = FRAME.Fdf("centertext010",origin,TextTime2)
        TextTime2.SetPoint(4,origin,0,0.437,-0.182-0.022)
        TextTime2.SetText("")

        TextTime3.frameid = FRAME.Fdf("centertext010",origin,TextTime3)
        TextTime3.SetPoint(4,origin,0,0.437,-0.255-0.022)
        TextTime3.SetText("")

        CreateButton(1000,origin,TYPE_BUTTON,6,origin,6,0.114,0.1,0.072,0.036,"UI_winner_Button.tga")

        CreateButton(1001,origin,TYPE_NULL,0,origin,0,0.362+0.000,-0.088,0.012,0.012,"war3mapImported\\UI_Winner_Win.blp")
        CreateButton(1002,origin,TYPE_NULL,0,origin,0,0.362+0.075,-0.088,0.012,0.012,"war3mapImported\\UI_Winner_Win.blp")
        CreateButton(1003,origin,TYPE_NULL,0,origin,0,0.362+0.000,-0.106,0.012,0.012,"war3mapImported\\UI_Winner_Win.blp")
        CreateButton(1004,origin,TYPE_NULL,0,origin,0,0.362+0.075,-0.106,0.012,0.012,"war3mapImported\\UI_Winner_Win.blp")

        CreateButton(1005,origin,TYPE_NULL,0,origin,0,0.362+0.000,-0.160,0.012,0.012,"war3mapImported\\UI_Winner_Win.blp")
        CreateButton(1006,origin,TYPE_NULL,0,origin,0,0.362+0.075,-0.160,0.012,0.012,"war3mapImported\\UI_Winner_Win.blp")
        CreateButton(1007,origin,TYPE_NULL,0,origin,0,0.362+0.000,-0.178,0.012,0.012,"war3mapImported\\UI_Winner_Win.blp")
        CreateButton(1008,origin,TYPE_NULL,0,origin,0,0.362+0.075,-0.178,0.012,0.012,"war3mapImported\\UI_Winner_Win.blp")

        CreateButton(1009,origin,TYPE_NULL,0,origin,0,0.362+0.000,-0.233,0.012,0.012,"war3mapImported\\UI_Winner_Win.blp")
        CreateButton(1010,origin,TYPE_NULL,0,origin,0,0.362+0.075,-0.233,0.012,0.012,"war3mapImported\\UI_Winner_Win.blp")
        CreateButton(1011,origin,TYPE_NULL,0,origin,0,0.362+0.000,-0.251,0.012,0.012,"war3mapImported\\UI_Winner_Win.blp")
        CreateButton(1012,origin,TYPE_NULL,0,origin,0,0.362+0.075,-0.251,0.012,0.012,"war3mapImported\\UI_Winner_Win.blp")
        
        for i = 1,12
            CreateText(1000+i,origin,"text008",3,5,0.0,0.0,"|cff00ff00无玩家|r")
        end

        Button.show = false

        HYHDButton = Button
    endfunction
endlibrary
