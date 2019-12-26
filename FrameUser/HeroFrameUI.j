library HeroFrameUI uses GameFrame

    /*
    150-160     道果
    161-172     附加属性
    */
    private FRAME Back = 0
    private int origin = 0


    private FRAME Button = 0
    private FRAME Back2 = 0



    //通用函数
    function ShowHeroFrame(int pid,bool show)

        if  GetLocalPlayer() == Player(pid)
            Back2.show = show
        endif
    
    endfunction
    function GetHeroFrameShow()->bool
        return Back2.show
    endfunction
    function CloseHeroFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            Back2.show = false
        endif
    endfunction

    function ClickHeroFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            if  Back2.show  == true
                Back2.show = false
            else
                Back2.show = true
            endif
        endif
    endfunction

    function HeroFrameUIInit()
        
        
        Back = FRAME.create()   //注册主背景


        Button = FRAME.create() //背景注册2
        Back2 = FRAME.create()   //注册主背景

        
        DzFrameClearAllPoints(GetFrameProgressBar())
        DzFrameSetPoint(GetFrameProgressBar(),1,GetFrameUnitDetail(),1,-0.0025,0.004)
        DzFrameSetSize(GetFrameProgressBar(),0.22,0.012)

        //初始化原生UI位置
        DzFrameClearAllPoints(GetFrameHeroLevelBar())
        DzFrameSetPoint(GetFrameHeroLevelBar(),1,GetFrameUnitDetail(),1,-0.0025,0.004)
        DzFrameSetSize(GetFrameHeroLevelBar(),0.22,0.012)
        DzFrameClearAllPoints(GetFrameUnitClassFrame())
        DzFrameSetPoint(GetFrameUnitClassFrame(),4,GetFrameHeroLevelBar(),4,0.0,0.0)
        DzFrameSetSize(GetFrameUnitClassFrame(),0.2,0.0)

        DzFrameClearAllPoints(GetFrameUnitNameFrame())
        DzFrameSetPoint(GetFrameUnitNameFrame(),4,GetFrameHeroLevelBar(),3,-0.038,-0.005)
        DzFrameSetSize(GetFrameUnitNameFrame(),0.1,0.0)

        DzFrameClearAllPoints(GetFrameItemNameFrame())
        DzFrameSetPoint(GetFrameItemNameFrame(),4,GetFrameHeroLevelBar(),3,-0.038,-0.005)
        DzFrameSetSize(GetFrameItemNameFrame(),0.1,0.0)

        DzFrameClearAllPoints(GetFrameItemTipsFrame())
        DzFrameSetPoint(GetFrameItemTipsFrame(),1,GetFrameHeroLevelBar(),7,0.0,-0.018)
        DzFrameSetSize(GetFrameItemTipsFrame(),0.2,0.0)
        

        DzFrameClearAllPoints(GetFrameUnitAttackIcon(0))
        DzFrameSetPoint(GetFrameUnitAttackIcon(0),6,GameUI,6,0.293,0.049)
        DzFrameSetSize(GetFrameUnitAttackLabel(0),0.0,0.0)
        DzFrameSetSize(GetFrameUnitAttackValue(0),0.0,0.0)


        DzFrameClearAllPoints(GetFrameUnitArmorIcon())
        DzFrameSetPoint(GetFrameUnitArmorIcon(),6,GameUI,6,0.293,0.016)
        DzFrameSetSize(GetFrameUnitArmorLabel(),0.0,0.0)
        DzFrameSetSize(GetFrameUnitArmorValue(),0.0,0.0)
        

        
        DzFrameClearAllPoints(GetFrameHeroPanelIcon())
        DzFrameSetPoint(GetFrameHeroPanelIcon(),3,GetFrameHeroPanel(),3,0.004,-0.002)
        DzFrameSetSize(GetFrameHeroPanelIcon(),0.021,0.063)
        
        
        /*
        DzFrameClearAllPoints(DzFrameGetPortrait())
        DzFrameSetPoint(DzFrameGetPortrait(),1,GetFrameUnitNameFrame(),7,0.0,-0.01)
        DzFrameSetSize(DzFrameGetPortrait(),0.04,0.04)
        */
        
        
        

        //控件设置
        Button.frameid = FRAME.Tag("BACKDROP","Hero",GameUI,Back)
        Button.SetPoint(0,GetFrameHeroLevelBar(),0,-0.001,0.001)
        Button.SetPoint(8,GetFrameHeroLevelBar(),8,0.001,-0.001)
        Button.SetTexture("war3mapImported\\human-xpbar-border.blp", 0)
        origin = Button.frameid

        
        
        
        for i = 1,10
            CreateButton(150+i,Button.frameid,TYPE_BUTTON,0,Button.frameid,6,0.005+0.0215*(i-1),0.0,0.018,0.018,"war3mapImported\\UI_Level_Button.tga")
        end
        
        for i = 1,7
            CreateButton(160+i,Button.frameid,TYPE_NOT,0,Button.frameid,0,-0.165,-0.015*(i-1)-0.01,0.014,0.014,"ui\\widgets\\glues\\dialogbox-question.blp")
        end
        
        
        CreateModel(151,Button.frameid,TYPE_BUTTON,6,6,-0.009,0.0,"war3mapImported\\ch_DG1x.mdx")
        
        Button.frameid = FRAME.Tag("BUTTON","Hero",origin,Button)
        Button.SetPoint(0,origin,0,-0.165,0.0)
        Button.SetSize(0.1,0.008)


        
        CreateText(161,origin,"text009",3,5,0.003,0,"|cffffcc00攻击：|r0%")
        CreateText(162,origin,"text009",3,5,0.003,0,"|cffffcc00法强：|r0%")
        CreateText(163,origin,"text009",3,5,0.003,0,"|cffffcc00生命：|r0%")
        CreateText(164,origin,"text009",3,5,0.003,0,"|cffffcc00物穿：|r0%")
        CreateText(165,origin,"text009",3,5,0.003,0,"|cffffcc00法穿：|r0%")
        CreateText(166,origin,"text009",3,5,0.003,0,"|cffffcc00暴击：|r0%")
        CreateText(167,origin,"text009",3,5,0.003,0,"|cffffcc00金币加成：|r0%")
        
        

        Back2.frameid = FRAME.Tag("BACKDROP","Hero",GameUI,Back2)
        Back2.SetPoint(6,Button.frameid,0,0.0,-0.01)
        Back2.SetSize(0.09,0.1)
        Back2.SetTexture("ui\\widgets\\battlenet\\bnet-inputbox-back.blp", 0)
        for i = 1,5
            CreateButton(167+i,Back2.frameid,TYPE_NOT,0,Back2.frameid,0,0.0,-0.015*(i-1)-0.005,0.014,0.014,"ui\\widgets\\glues\\dialogbox-question.blp")
        end
        //Back2.SetPoint(0,BUTTON_Back[168][0],0,-0.005,0.0)

        CreateText(168,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00闪避：|r0%")
        CreateText(169,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00减伤：|r0%")
        CreateText(170,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00吸血：|r0%")
        CreateText(171,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00增伤：|r0%")
        CreateText(172,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00暴伤：|r150%")


        FrameSetScriptByExecute( Button.frameid, 1,160,TYPE_FUNC)


        
    
        

   




        Back2.show = false

        
    endfunction


    function AddPlayerImmortalFruit(int pid,int id)
        int num = GetUnitIntState(Pu[1],150)
        if  num < 10
            num = num + 1
            SetUnitIntState(Pu[1],150+num,id)
            SetUnitIntState(Pu[1],150,num)
            BJDebugMsg("num"+I2S(num))
            AddEquipState(Pu[1],id)
            if  GetLocalPlayer() == Player(pid)
                DzFrameSetTexture(BUTTON_Back[150+num][1],GetTypeIdIcon(id),0)
            endif
        endif 
    endfunction
    
endlibrary


