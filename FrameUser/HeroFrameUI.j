library HeroFrameUI initializer InitHeroFrameUITimer uses GameFrame

    /*
    150-160     道果
    161-172     附加属性
    190-193     兽魂
    */
    private FRAME Back = 0
    private int origin = 0


    private FRAME Button = 0
    private FRAME Exp0 = 0
    private FRAME Exp1 = 0
    private FRAME ExpName = 0

    private FRAME Button2 = 0
    private FRAME Back2 = 0

    //通用函数
    function HeroExpFrame(int pid,bool show)

        if  GetLocalPlayer() == Player(pid)
            Button.show = show
        endif
    
    endfunction



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


    function ReHeroXpBar(int pid)
        int last = 0
        int now = 0
        int use = 0
        if  GetLocalPlayer() == Player(pid)
            
            if  GetHeroLevel(Pu[1]) == 1
                last = 0
            else
                last = DzGetUnitNeededXP(Pu[1],GetHeroLevel(Pu[1])-1)
            endif
            
            now = GetHeroXP(Pu[1])-last
            use = DzGetUnitNeededXP(Pu[1],GetHeroLevel(Pu[1]))-last
            Exp1.width = 0.2199*(I2R(now)/I2R(use))+0.0001
        endif
    endfunction

    function HeroAddExp(unit wu,int exp)
        int last = 0
        int now = GetHeroXP(wu) + exp
        int max = DzGetUnitNeededXP(wu,GetHeroLevel(wu))-1

        if  now > max
            now = max
        endif

        if  now != GetHeroXP(wu)
            SetHeroXP(wu,now,true)
            ReHeroXpBar(GetPlayerId(GetOwningPlayer(wu)))
        endif
    endfunction
    function HeroIncLevel(unit wu)
        int now = GetHeroXP(wu)
        int max = DzGetUnitNeededXP(wu,GetHeroLevel(wu))
        if  now + 1 == max
            SetHeroXP(wu,now+1,true)
            ReHeroXpBar(GetPlayerId(GetOwningPlayer(wu)))
        endif
    endfunction


    function ReAddAbilityByIndex(unit wu,int index,int id)
        SetUnitIntState(wu,110+index,id)
        SetUnitIntState(wu,120+index,1)
        ReHeroAbilityTips(wu,index)
    endfunction

    //添加道果
    function AddPlayerImmortalFruit(unit wu,int id)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int num = GetUnitIntState(Pu[1],150)
        int now = GetHeroXP(Pu[1]) 
        int max = DzGetUnitNeededXP(Pu[1],GetHeroLevel(Pu[1]))

        if  max - now == 1
            if  num < 10
                num = num + 1
                SetUnitIntState(Pu[1],150+num,id)
                SetUnitIntState(Pu[1],150,num)
                //BJDebugMsg("num"+I2S(num))
                AddEquipState(Pu[1],id)
                HeroIncLevel(Pu[1])
                if  num == 7
                    ReAddAbilityByIndex(Pu[1],4,'S0R1')
                    ShowUnit(Pu[25],true)
                    LocAddEffect(GetUnitX(Pu[25]),GetUnitY(Pu[25]),"effect_az-blue-lizi-shangsheng.mdl")
                endif
                if  GetLocalPlayer() == Player(pid)
                    DzFrameSetModel( BUTTON_Model[150+num], GetTypeIdIcon(id), 0, 0 )
                endif
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r恭喜您！境界突破成功！")
            endif 
        else
            //DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r当前经验值不足，无法挑战境界！")
        endif
    endfunction

    function PlayerHeroMoveToImmortal(unit wu,int id)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int num = GetUnitIntState(Pu[1],150)
        int now = GetHeroXP(Pu[1]) 
        int max = DzGetUnitNeededXP(Pu[1],GetHeroLevel(Pu[1]))
        if  max - now == 1
            if  num < 10
                SendPlayerUnit(pid,GetTypeIdData(id,151),GetTypeIdData(id,152))
            endif 
        else
            ReturnPlayerBuyItemUse(pid,id)//返还物品资源消耗
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r当前经验值不足，无法挑战境界！")
        endif
    endfunction



    function HeroFrameUIInit()
        
        
        Back = FRAME.create()   //注册主背景


        Button = FRAME.create() //经验条
        Exp0 = FRAME.create()   //经验条
        Exp1 = FRAME.create()   //经验条
        ExpName = FRAME.create()   //经验条
        


        Button2 = FRAME.create() //背景注册2
        Back2 = FRAME.create()   //注册主背景

        
        DzFrameClearAllPoints(GetFrameProgressBar())
        DzFrameSetPoint(GetFrameProgressBar(),1,GetFrameUnitDetail(),1,-0.0025,0.004)
        DzFrameSetSize(GetFrameProgressBar(),0.22,0.012)

        DzFrameClearAllPoints(GetFrameHeroLevelBar())
        DzFrameSetPoint(GetFrameHeroLevelBar(),1,GameUI,1,0,-1)
        DzFrameClearAllPoints(GetFrameUnitClassFrame())
        DzFrameSetPoint(GetFrameUnitClassFrame(),1,GameUI,1,0,-1)


        //初始化原生UI位置
        

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
        /*
        DzFrameClearAllPoints(DzFrameFindByName("UnitsCheckBox",0))
        DzFrameClearAllPoints(DzFrameFindByName("UnitsCheckBox",6))

        DzFrameSetPoint(DzFrameFindByName("UnitsCheckBox",0),0,GameUI,0,-0.1,0.1)

        DzFrameSetPoint(DzFrameFindByName("UnitsCheckBox",6),1,DzFrameFindByName("UnitsCheckBox",0),7,0.0,-0.01)
        for x = 1,5
            DzFrameClearAllPoints(DzFrameFindByName("UnitsCheckBox",x))
            DzFrameClearAllPoints(DzFrameFindByName("UnitsCheckBox",x+6))
            DzFrameSetScale(DzFrameFindByName("UnitsCheckBox",x),0.5)
            DzFrameSetScale(DzFrameFindByName("UnitsCheckBox",x+6),0.5)

            DzFrameSetPoint(DzFrameFindByName("UnitsCheckBox",x),3,DzFrameFindByName("UnitsCheckBox",x-1),5,0.0,0.0)
            DzFrameSetPoint(DzFrameFindByName("UnitsCheckBox",x+6),3,DzFrameFindByName("UnitsCheckBox",x+6-1),5,0.0,0.0)
        end
        */

        //控件设置
        
        Button.frameid = FRAME.Tag("BUTTON","Hero",GameUI,Button)
        Button.SetSize(0.22,0.008)
        Button.SetPoint(1,GetFrameUnitDetail(),1,-0.0025,0.002)
        origin = Button.frameid

        Exp0.frameid = FRAME.Tag("BACKDROP","Hero",origin,Exp0)
        Exp0.SetTexture("war3mapImported\\UI_Hero_Exp0.tga", 0)
        Exp0.SetSize(0.22,0.008)
        Exp0.SetPoint(0,origin,0,0.0,0.0)

        Exp1.frameid = FRAME.Tag("BACKDROP","Hero",origin,Exp1)
        Exp1.SetTexture("war3mapImported\\UI_Hero_Exp1.tga", 0)
        Exp1.SetSize(0.0001,0.008)
        Exp1.SetPoint(0,origin,0,0.0,0.0)
        
        ExpName.frameid = FRAME.Fdf("centertext009",origin,ExpName)
        ExpName.SetPoint(7,Exp0.frameid ,7,0,0)
        ExpName.SetText("练气士")

        FrameSetScriptByExecute( Button.frameid, 1,150,TYPE_FUNC)

        

        DzFrameClearAllPoints(GetFrameUnitNameFrame())
        DzFrameSetPoint(GetFrameUnitNameFrame(),4,origin,3,-0.024,-0.003)
        DzFrameSetSize(GetFrameUnitNameFrame(),0.1,0.0)
        DzFrameSetScale(GetFrameUnitNameFrame(),1.6)

        DzFrameClearAllPoints(GetFrameItemNameFrame())
        DzFrameSetPoint(GetFrameItemNameFrame(),4,origin,3,-0.038,-0.005)
        DzFrameSetSize(GetFrameItemNameFrame(),0.1,0.0)
        

        DzFrameClearAllPoints(GetFrameItemTipsFrame())
        DzFrameSetPoint(GetFrameItemTipsFrame(),1,origin,7,0.0,-0.018)
        DzFrameSetSize(GetFrameItemTipsFrame(),0.2,0.0)
        
        
        
        for i = 1,10
            CreateButton(150+i,Button.frameid,TYPE_BUTTON,0,Button.frameid,6,0.005+0.0215*(i-1),-0.003,0.018,0.018,"war3mapImported\\UI_Level_Button.tga")
            CreateModel(150+i,Button.frameid,TYPE_BUTTON,6,6,-0.005,-0.002,"")
        end
        
        for i = 1,7
            CreateButton(160+i,Button.frameid,TYPE_NOT,0,Button.frameid,0,-0.165,-0.015*(i-1)-0.008,0.014,0.014,"ui\\widgets\\glues\\dialogbox-question.blp")
        end
        
        
        
        
        Button2.frameid = FRAME.Tag("BUTTON","Hero",origin,Button2)
        Button2.SetPoint(0,origin,0,-0.165,0.0)
        Button2.SetSize(0.1,0.008)


        
        CreateText(161,origin,"text009",3,5,0.003,0,"|cffffcc00攻击：|r0%")
        CreateText(162,origin,"text009",3,5,0.003,0,"|cffffcc00法强：|r0%")
        CreateText(163,origin,"text009",3,5,0.003,0,"|cffffcc00生命：|r0%")
        CreateText(164,origin,"text009",3,5,0.003,0,"|cffffcc00物穿：|r0%")
        CreateText(165,origin,"text009",3,5,0.003,0,"|cffffcc00法穿：|r0%")
        CreateText(166,origin,"text009",3,5,0.003,0,"|cffffcc00暴击：|r0%")
        CreateText(167,origin,"text009",3,5,0.003,0,"|cffffcc00金币加成：|r0%")
        
        

        Back2.frameid = FRAME.Tag("BACKDROP","Hero",GameUI,Back2)
        Back2.SetPoint(6,Button2.frameid,0,0.0,-0.01)
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


        FrameSetScriptByExecute( Button2.frameid, 1,160,TYPE_FUNC)


        
    
        

   



        
        Back2.show = false

        Button.show = false
    endfunction


    function InitHeroFrameUITimer()
        
    endfunction


    
    
endlibrary


