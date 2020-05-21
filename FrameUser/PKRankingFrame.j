library PKRankingFrame uses GameFrame
    private FRAME Button
    private FRAME Back

    private FRAME TextTime1
    private FRAME TextTime2
    private FRAME TextTime3

    private int origin = 0

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
        TextTime1.SetText("通关时间：00:00:00")

        TextTime2.frameid = FRAME.Fdf("centertext010",origin,TextTime2)
        TextTime2.SetPoint(4,origin,0,0.437,-0.182-0.022)
        TextTime2.SetText("通关时间：00:00:00")

        TextTime3.frameid = FRAME.Fdf("centertext010",origin,TextTime3)
        TextTime3.SetPoint(4,origin,0,0.437,-0.255-0.022)
        TextTime3.SetText("通关时间：00:00:00")


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
            CreateText(1000+i,origin,"text008",3,5,0.0,0.0,"|cff00ff00玩家名称|r")
        end

        Button.show = false
    endfunction
endlibrary
