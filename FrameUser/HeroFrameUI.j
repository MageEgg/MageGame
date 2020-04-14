library HeroFrameUI initializer InitHeroFrameUITimer uses GameFrame,PassCheckMission

    /*
    150-160     道果
    161-172     附加属性
    190-200     道果标识
    */

    /*
    701-708     附加按钮
    */

    private FRAME Back = 0
    private int origin = 0


    private FRAME Button = 0
    private FRAME Exp0 = 0
    private FRAME Exp1 = 0
    private FRAME ExpName = 0

    FRAME ExpModel = 0
    FRAME IncEquipModel = 0

    private FRAME Button2 = 0
    private FRAME Back2 = 0

    int MaxHeroLevel = 10

    //升级装备显示
    function IncEquipModelFunc(int pid,int index)
        if  GetLocalPlayer() == Player(pid)
            if  index == 1
                IncEquipModel.SetModel("war3mapImported\\ui_win.mdx",1,0)
            else
                IncEquipModel.SetModel("war3mapImported\\ui_lose.mdx",1,0)
            endif
            IncEquipModel.SetAnimate(0,true)
        endif
    endfunction
    //给物品快速闪烁
    function GiveItemShowModel(int pid,int index)
        if  GetLocalPlayer() == Player(pid)
            DzFrameSetModel( BUTTON_Model[801+index], "war3mapImported\\UI-ModalButtonOn.mdx", 0, 0 )
            DzFrameSetAnimate(BUTTON_Model[801+index],0,true)
        endif
    endfunction


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


    function HeroExpMaxTipsTimer(int p)
        int pid = p
        TimerStart(5,false)
        {
            HeroExpMaxTips = false
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function GetExExpMax(int pid)->int
        int max = 30000
        real add = GetUnitRealState(Pu[1],52)+0.001
        
        max = max + R2I(add)
        return max
    endfunction
    function HeroAddExp(unit wu,int exp)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int last = 0
        int now = GetHeroXP(wu) + exp
        int max = DzGetUnitNeededXP(wu,GetHeroLevel(wu))-1
        int exmax = GetExExpMax(pid)
        if  now > max
            HeroExExp = HeroExExp + (now-max)
            if  HeroExExp > exmax
                HeroExExp = exmax
            endif
            now = max
        else
            if  HeroExExp > 0
                if  now + HeroExExp <= max
                    now = now + HeroExExp
                    HeroExExp = 0 
                else
                    HeroExExp = HeroExExp - (max-now)
                    now = max
                endif
            endif
        endif

        if  now != GetHeroXP(wu)
            SetHeroXP(wu,now,true)
            ReHeroXpBar(GetPlayerId(GetOwningPlayer(wu)))
        elseif  GetHeroLevel(wu) != MaxHeroLevel+1
            if  GetLocalPlayer() == Player(pid)
                ExpModel.show =true
            endif
            if  HeroExpMaxTips == false
                HeroExpMaxTips = true
                HeroExpMaxTipsTimer(pid)
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：境界经验已满，请挑战任意雷劫获得道果晋级")
            endif
        endif
    endfunction
    function HeroIncLevel(unit wu)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        //int now = GetHeroXP(wu)
        int max = DzGetUnitNeededXP(wu,GetHeroLevel(wu))
        //if  now + 1 == max
            SetHeroXP(wu,max,true)
            ReHeroXpBar(GetPlayerId(GetOwningPlayer(wu)))

            if  GetLocalPlayer() == Player(pid)
                ExpModel.show = false
            endif
        //endif
    endfunction


    function ReAddAbilityByIndex(unit wu,int index,int id)
        SetUnitIntState(wu,110+index,id)
        SetUnitIntState(wu,120+index,1)
        ReHeroAbilityTips(wu,index)
    endfunction

    //添加道果
    function AddImmortalFruit(unit wu,int id,int move)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int num = GetUnitIntState(Pu[1],150)

        if  num < MaxHeroLevel
            BJDebugMsg(GetTypeIdIcon(id))
            num = num + 1
            SetUnitIntState(Pu[1],150+num,id)
            SetUnitIntState(Pu[1],150,num)
            SetPlayerTechResearched(Player(pid),'RJ0A'+num - 1,1)
            
            AddEquipState(Pu[1],id)
            HeroIncLevel(Pu[1])
            HeroAddExp(Pu[1],1)

            
            if  GetPlayerTechCount(Player(pid),'RY3F',true) > 0
                SetEquipStateOfPlayer(Pu[1],id,0.08)
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：拥有商城道具诛仙剑，额外获得8%道果属性！")
            endif
            

            if  GetUnitTypeId(wu) == 'H018'
                SpellS518.execute(Pu[1],id)//九转神功
            endif
/*
            if  num == 7
                SetPlayerMonsterSoulSkillOfHeroLevel.execute(pid) 
            endif
*/
            if  GetLocalPlayer() == Player(pid)
            
                DzFrameSetModel( BUTTON_Model[150+num], GetTypeIdIcon(id), 1, 0 )

                
                if  id == 'IJ10'
                    DzFrameSetTexture(BUTTON_Back[190+num][0],"war3mapImported\\DGnumber0.tga",0)
                else
                    DzFrameSetTexture(BUTTON_Back[190+num][0],"war3mapImported\\DGnumber"+I2S(id-'IJ00')+".tga",0)
                endif
                

                ExpName.SetText(GetTypeIdName('IJ5A'+num))
                
            endif
            SetBoardText(3,pid+2,GetTypeIdName('IJ5A'+num))
            //LocAddEffect(GetUnitX(wu),GetUnitY(wu),"effectex_TParchive.mdl")
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r恭喜您！境界突破成功！")

            //境界突破提高技能等级
            if  num == 3 or num == 5 or num == 10
                HeroIncAbility(wu,5)
            endif
            if  id == 'IJ10'
                MissionAddNumFunc(pid,26,1)//获得混沌道果
            endif
            /*
            if  move == 1
                if  PlayerDeathBool == false 
                    HeroMoveToRoom.execute(pid)
                endif
            endif
            */
        endif 
    endfunction

    function AddPlayerImmortalFruit(unit wu,int id,int move)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int num = GetUnitIntState(Pu[1],150)
        int now = GetHeroXP(Pu[1]) 
        int max = DzGetUnitNeededXP(Pu[1],GetHeroLevel(Pu[1]))
        int i1 = 0
        if  max - now == 1
            AddImmortalFruit(wu,id,move)
        endif
    endfunction

    function PlayerHeroMoveToImmortal(unit wu,int id)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int num = GetUnitIntState(Pu[1],150)
        int now = GetHeroXP(Pu[1]) 
        int max = DzGetUnitNeededXP(Pu[1],GetHeroLevel(Pu[1]))
        if  max - now == 1
            if  num < MaxHeroLevel
                SendPlayerUnit(pid,GetTypeIdData(id,151),GetTypeIdData(id,152))
            else
                ReturnPlayerBuyItemUse(pid,id)//返还物品资源消耗
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r当前境界已满，无法挑战境界！")
            endif 
        else
            ReturnPlayerBuyItemUse(pid,id)//返还物品资源消耗
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r境界经验不足，无法挑战境界！")
        endif
    endfunction


    scope Gem
        //宝珠
        int array PlayerGemData[12][680]


        function SetPlayerGemByIndex(int pid,int index,int id)
            PlayerGemData[pid][index] = id
        endfunction
        function GetPlayerGemByIndex(int pid,int index)->int 
            return PlayerGemData[pid][index]
        endfunction

        

        function GetGemMaxNum(int pid)->int
            int num = PlayerChallengeWMCos
            int max = 0
            if  num > 0
                max = 2 + num / 10
            endif
            if  max > 6
                max = 6
            endif
            return max
        endfunction
        function GetGemNullIndex(int pid)->int
            int max = GetGemMaxNum(pid)
            if  max > 0
                for i = 1,max
                    if  GetPlayerGemByIndex(pid,i) == 0
                        return i
                    endif
                end
            endif
            return 0
        endfunction
        function IsPlayerCanAddGem(int pid)->bool
            return GetGemNullIndex(pid) > 0
        endfunction

        function ReGemFrame(int pid)
            int id = 0
            int max = 0
            if  GetLocalPlayer() == Player(pid)
                max = GetGemMaxNum(pid)
                for index = 1,6
                    if  max >= index
                        id = GetPlayerGemByIndex(pid,index)
                        if  id > 0
                            DzFrameSetTexture( BUTTON_Back[750+index][0],GetTypeIdIcon(id), 0)
                        else
                            DzFrameSetTexture( BUTTON_Back[750+index][0],"war3mapImported\\UI_baowu1.tga", 0)
                        endif
                    else
                        DzFrameSetTexture( BUTTON_Back[750+index][0],"war3mapImported\\UI_baowu0.tga", 0)
                    endif
                end
            endif
        endfunction 


        function SetGemState(unit wu,int id,int offset)
            int pid = GetPlayerId(GetOwningPlayer(wu))
            int Type = GetTypeIdData(id,100)
            if  Type > 0
                AddUnitRune(wu,'FY00'+Type,1*offset)
                ReRuneFrame(pid)
            endif
            SetEquipStateOfPlayer(wu,id,offset)

            if  id == 'IK03'
                AddUnitRealState(wu,75,30*offset)
            elseif  id >= 'IK3A' and id <= 'IK3Z'
                AddUnitRealState(wu,75,60*offset)
            endif
        endfunction

        function PlayerRemGemByIndex(int pid,int index)
            int id = GetPlayerGemByIndex(pid,index)
            UnitAddItemById(Pu[1],id)
            SetGemState(Pu[1],id,-1)
            SetPlayerGemByIndex(pid,index,0)
            ReGemFrame(pid)
        endfunction

        function PlayerAddGem(int pid,int id)
            int index = GetGemNullIndex(pid)
            if  index > 0
                SetGemState(Pu[1],id,1)
                SetPlayerGemByIndex(pid,index,id)
                ReGemFrame(pid)
            endif
        endfunction

        function PlayerUseGemItem(unit wu,item it)
            int pid = GetPlayerId(GetOwningPlayer(wu))
            int index = GetGemNullIndex(pid)
            if  index > 0
                PlayerAddGem(pid,GetItemTypeId(it))
                UnitRemoveItem(wu,it)
                RemoveItem(it)
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r宝物槽已满！无法镶嵌！")
            endif
        endfunction
        function PlayerClickGemItem(int pid,int index)
            if  GetPlayerGemByIndex(pid,index) > 0
                PlayerRemGemByIndex(pid,index)
            endif
        endfunction



        function BoxShowGem(int pid,int index)
            int id = 0
            int max = GetGemMaxNum(pid)
            DzFrameShow(UI_TipsHead, true)

            if  max >= index
                id = GetPlayerGemByIndex(pid,index)
                if  id > 0
                    SetTipsData(1,"",GetTypeIdName(id))
                    SetTipsData(10,"",GetTypeIdTips(id))
                else
                    SetTipsData(1,"","宝物槽 - 空")
                    SetTipsData(10,"","|cff00ff00物品栏内点击宝物可镶嵌至该槽位|r")
                endif
            else
                SetTipsData(1,"","宝物槽 - |cff808080未解锁|r")
                if  index == 1 or index == 2
                    max = 1
                else
                    max = index * 10 - 20
                endif
                SetTipsData(10,"","万魔窟达到|CffFFD24D"+I2S(max)+"|r层后解锁")
            endif
            
            
            
            ShowTipsUI()
        endfunction

        function DropGemItem(unit wu,real r1,real r2)
            
            if  GetRandomReal(1,100)<= r1
                bj_lastCreatedItem = CreateItem(GetRandomInt('IK01','IK08'),GetUnitX(wu),GetUnitY(wu))
                LocAddEffect(GetItemX(bj_lastCreatedItem),GetItemY(bj_lastCreatedItem),"effect_tx_shanguang.mdx")
            endif
            if  GetRandomReal(1,100)<= r2
                bj_lastCreatedItem = CreateItem(GetRandomInt('IK91','IK98'),GetUnitX(wu),GetUnitY(wu))
                LocAddEffect(GetItemX(bj_lastCreatedItem),GetItemY(bj_lastCreatedItem),"effect_tx_shanguang.mdx")
            endif
            bj_lastCreatedItem = null
        endfunction
    endscope


    function HeroFrameUIInit()
        
        
        Back = FRAME.create()   //注册主背景


        Button = FRAME.create() //经验条
        Exp0 = FRAME.create()   //经验条
        Exp1 = FRAME.create()   //经验条
        ExpName = FRAME.create()   //经验条
        ExpModel = FRAME.create()   //经验条


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
        DzFrameSetPoint(GetFrameHeroPanelIcon(),3,GetFrameHeroPanel(),3,0.004,0.0005)
        DzFrameSetSize(GetFrameHeroPanelIcon(),0.021,0.063)
        
        
        
        //DzFrameClearAllPoints(DzFrameGetPortrait())
        //DzFrameSetPoint(DzFrameGetPortrait(),1,GetFrameUnitNameFrame(),7,0.0,-0.01)
        DzFrameSetSize(DzFrameGetPortrait(),0.08,0.06)
        
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
        
        

        ExpModel.frameid = FRAME.Tag("SPRITE","HeroExp",origin,ExpModel)
        ExpModel.SetPoint(6,Exp0.frameid,6,-0.005,0)
        ExpModel.SetModel("war3mapImported\\UI_Firebar.mdx",0,0)
        ExpModel.SetAnimate(0,true)
        ExpModel.show = false
        ExpName.frameid = FRAME.Fdf("centertext009",origin,ExpName)
        ExpName.SetPoint(7,Exp0.frameid ,7,0,0)
        ExpName.SetText("炼气士[0]")



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
        DzFrameSetScale(GetFrameItemTipsFrame(),1.3)
        
        
        
        for i = 1,MaxHeroLevel
            CreateButton(150+i,Button.frameid,TYPE_BUTTON,0,Button.frameid,6,0.005+0.0215*(i-1),-0.003,0.018,0.018,"war3mapImported\\UI_Level_Button.tga")
            CreateModel(150+i,Button.frameid,TYPE_BUTTON,6,6,-0.005,-0.002,"")

            CreateButton(190+i,Button.frameid,TYPE_NULL,0,BUTTON_Back[150+i][0],8,-0.005,0.005,0.01,0.01,"war3mapImported\\alpha.tga")
        end
        

        for bz = 1,6
            CreateButton(750+bz,Button.frameid,TYPE_BUTTON,0,Button.frameid,7,0.192,0.0225-bz*0.018,0.015,0.015,"war3mapImported\\UI_baowu0.tga")
        end
        
        
        Button2.frameid = FRAME.Tag("BUTTON","Hero",origin,Button2)
        Button2.SetPoint(0,origin,0,-0.167,0.0)
        Button2.SetSize(0.1,0.02)


        Back2.frameid = FRAME.Tag("BACKDROP","Hero",GameUI,Back2)
        Back2.SetPoint(6,Button2.frameid,0,0.0,0.005)
        Back2.SetSize(0.19,0.15)
        Back2.SetTexture("ui\\widgets\\battlenet\\bnet-inputbox-back.blp", 0)
        for p = 1,2
            for m = 1,9
                CreateButton(160+m,Back2.frameid,TYPE_NOT,0,Back2.frameid,0,0.0,-0.015*(m-1)-0.005,0.014,0.014,"ui\\widgets\\glues\\dialogbox-question.blp")
                CreateButton(169+m,Back2.frameid,TYPE_NOT,0,Back2.frameid,0,0.1,-0.015*(m-1)-0.005,0.014,0.014,"ui\\widgets\\glues\\dialogbox-question.blp")
            end
        end
        //Back2.SetPoint(0,BUTTON_Back[168][0],0,-0.005,0.0)

        CreateText(161,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00攻击加成：|r0%")
        CreateText(162,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00业力加成：|r0%")
        CreateText(163,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00攻击伤害：|r0%")
        CreateText(164,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00技能伤害：|r0%")
        CreateText(165,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00暴击：|r0%")
        CreateText(166,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00暴击伤害：|r0%")
        CreateText(167,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00金币加成：|r0%")
        CreateText(168,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00闪避：|r0%")
        CreateText(169,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00伤害减免：|r0%")
        CreateText(170,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00分裂：|r0%")
        CreateText(171,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00吸血：|r0%")
        CreateText(172,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00伤害加成：|r0%")
        CreateText(173,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00护甲穿透：|r0")
        CreateText(174,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00触发概率：|r0%")
        CreateText(175,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00生命加成：|r0%")
        CreateText(176,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00每秒攻击：|r0")
        CreateText(177,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00每秒业力：|r0")
        CreateText(178,Back2.frameid,"text009",3,5,0.003,0,"|cffffcc00每秒生命：|r0")



        FrameSetScriptByExecute( Button2.frameid, 1,160,TYPE_FUNC)


        
    
        

        CreateButton(702,GameUI,TYPE_BUTTON,4,DzFrameGetHeroBarButton(0),4,0.0,-0.048,0.038,0.038,"replaceabletextures\\commandbuttons\\BTNUI001.blp")
        CreateButton(703,GameUI,TYPE_BUTTON,4,DzFrameGetHeroBarButton(0),4,0.0,-0.096,0.038,0.038,"replaceabletextures\\commandbuttons\\BTNUI002.blp")
        CreateButton(704,GameUI,TYPE_BUTTON,4,DzFrameGetHeroBarButton(0),4,0.0,-0.144,0.038,0.038,"replaceabletextures\\commandbuttons\\BTNUI006.blp")
        CreateModelEx(704,BUTTON_Back[704][0],TYPE_NOT,4,BUTTON_Back[704][0],4,-0.0185,-0.0185,"")
        //CreateButton(705,GameUI,TYPE_BUTTON,4,DzFrameGetHeroBarButton(0),4,0.0,-0.192,0.038,0.038,"replaceabletextures\\commandbuttons\\BTNUI003.blp")
        //CreateButton(706,GameUI,TYPE_BUTTON,4,DzFrameGetHeroBarButton(0),4,0.0,-0.240,0.038,0.038,"replaceabletextures\\commandbuttons\\BTNUI004.blp")

        
        for i2 = 2,4
            DzFrameShow(BUTTON_Back[700+i2][0], false)
        end
        

        
        Back2.show = false

        Button.show = false










        int index = 0
        IncEquipModel = FRAME.create()

        IncEquipModel.frameid = FRAME.Tag("SPRITE","IncEquipModel",GameUI,IncEquipModel)
        IncEquipModel.SetPoint(4,DzFrameGetItemBarButton(0),2,0.01,-0.02)
        IncEquipModel.SetSize(0.000001,0.000001)
        


        for i2 = 0,5
            CreateModelEx(801+i2,origin,TYPE_NOT,4,DzFrameGetItemBarButton(i2),6,-0.004,-0.004,"")
        end
        for jx = 0,3
            for jy = 0,2
                index = 810+jy * 4 + jx + 1
                CreateModelEx(801+index,origin,TYPE_NOT,6,DzFrameGetCommandBarButton(jy, jx),6,-0.004,-0.004,"")
            end
        end

    endfunction


    function InitHeroFrameUITimer()
        
    endfunction


    
    
endlibrary


