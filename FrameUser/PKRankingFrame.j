library PKRankingFrame uses GameFrame
    private FRAME Button
    private FRAME Back

    private FRAME TextTime1
    private FRAME TextTime2
    private FRAME TextTime3
    FRAME HYHDButton

    private int origin = 0

    function IsPlayerHuYaMVP(int pid)->boolean
        string name = "a" + GetPlayerName(Player(pid))
        if  name == "a星耀丶怀旧y"
            return true
        elseif  name == "aY西瓜Y"
            return true
        elseif  name == "a红笔写黑字"
            return true
        elseif  name == "a这丿真灬有丶意思"
            return true
        elseif  name == "a秦王走位"
            return true
        elseif  name == "a偏执的沁"
            return true
        elseif  name == "a鬼舞辻無慘"
            return true
        elseif  name == "a星耀丶酒仙呐"
            return true
        elseif  name == "a凤求凰灬李白"
            return true
        elseif  name == "a磊仔菜B"
            return true
        elseif  name == "a防蚊贴"
            return true
        elseif  name == "a磊仔菜J"
            return true
        endif
        return false
    endfunction
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
                    if  IsPlayerHuYaMVP(pid) == true
                        ClickButtonBlessFunc(pid)
                    endif
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
        TextTime1.SetText("|cff00ff00通关时间：17分01秒|r")

        TextTime2.frameid = FRAME.Fdf("centertext010",origin,TextTime2)
        TextTime2.SetPoint(4,origin,0,0.437,-0.182-0.022)
        TextTime2.SetText("|cff00ff00通关时间：17分32秒|r")

        TextTime3.frameid = FRAME.Fdf("centertext010",origin,TextTime3)
        TextTime3.SetPoint(4,origin,0,0.437,-0.255-0.022)
        TextTime3.SetText("|cff00ff00通关时间：18分27秒|r")

        CreateButton(1000,origin,TYPE_BUTTON,6,origin,6,0.114,0.1,0.072,0.036,"UI_winner_Button.tga")



        CreateButton(1001,origin,TYPE_NULL,0,origin,0,0.362+0.000,-0.088,0.012,0.012,"ReplaceableTextures\\CommandButtons\\BTNH022.blp")
        CreateButton(1002,origin,TYPE_NULL,0,origin,0,0.362+0.075,-0.088,0.012,0.012,"ReplaceableTextures\\CommandButtons\\BTNH021.blp")
        CreateButton(1003,origin,TYPE_NULL,0,origin,0,0.362+0.000,-0.106,0.012,0.012,"ReplaceableTextures\\CommandButtons\\BTNH029.blp")
        CreateButton(1004,origin,TYPE_NULL,0,origin,0,0.362+0.075,-0.106,0.012,0.012,"ReplaceableTextures\\CommandButtons\\BTNH022.blp")

        CreateButton(1005,origin,TYPE_NULL,0,origin,0,0.362+0.000,-0.160,0.012,0.012,"ReplaceableTextures\\CommandButtons\\BTNPET02.blp")
        CreateButton(1006,origin,TYPE_NULL,0,origin,0,0.362+0.075,-0.160,0.012,0.012,"ReplaceableTextures\\CommandButtons\\BTNH021.blp")
        CreateButton(1007,origin,TYPE_NULL,0,origin,0,0.362+0.000,-0.178,0.012,0.012,"ReplaceableTextures\\CommandButtons\\BTNH021.blp")
        CreateButton(1008,origin,TYPE_NULL,0,origin,0,0.362+0.075,-0.178,0.012,0.012,"ReplaceableTextures\\CommandButtons\\BTNH017.blp")

        CreateButton(1009,origin,TYPE_NULL,0,origin,0,0.362+0.000,-0.233,0.012,0.012,"ReplaceableTextures\\CommandButtons\\BTNH006.blp")
        CreateButton(1010,origin,TYPE_NULL,0,origin,0,0.362+0.075,-0.233,0.012,0.012,"ReplaceableTextures\\CommandButtons\\BTNH021.blp")
        CreateButton(1011,origin,TYPE_NULL,0,origin,0,0.362+0.000,-0.251,0.012,0.012,"ReplaceableTextures\\CommandButtons\\BTNH036.blp")
        CreateButton(1012,origin,TYPE_NULL,0,origin,0,0.362+0.075,-0.251,0.012,0.012,"ReplaceableTextures\\CommandButtons\\BTNPET02.blp")
        
        CreateButton(1020,Button.frameid,TYPE_CLOSE,2,Button.frameid,2,-0.016,-0.027,0.03,0.03,"war3mapImported\\UI_Winner_Esc.tga")
        CreateText(1001,origin,"text009",3,5,0.0,0.0,"|cffffcc00星耀丶怀旧y|r")
        CreateText(1002,origin,"text009",3,5,0.0,0.0,"|cffffcc00Y西瓜Y|r")
        CreateText(1003,origin,"text009",3,5,0.0,0.0,"|cffffcc00红笔写黑字|r")
        CreateText(1004,origin,"text009",3,5,0.0,0.0,"|cffffcc00这丿真灬有丶意思|r")
        CreateText(1005,origin,"text009",3,5,0.0,0.0,"|cffffcc00秦王走位|r")
        CreateText(1006,origin,"text009",3,5,0.0,0.0,"|cffffcc00偏执的沁|r")
        CreateText(1007,origin,"text009",3,5,0.0,0.0,"|cffffcc00鬼舞辻無慘|r")
        CreateText(1008,origin,"text009",3,5,0.0,0.0,"|cffffcc00星耀丶酒仙呐|r")
        CreateText(1009,origin,"text009",3,5,0.0,0.0,"|cffffcc00凤求凰灬李白|r")
        CreateText(1010,origin,"text009",3,5,0.0,0.0,"|cffffcc00磊仔菜B|r")
        CreateText(1011,origin,"text009",3,5,0.0,0.0,"|cffffcc00防蚊贴|r")
        CreateText(1012,origin,"text009",3,5,0.0,0.0,"|cffffcc00磊仔菜J|r")

        
    

        Button.show = false

        HYHDButton = Button
    endfunction
endlibrary
