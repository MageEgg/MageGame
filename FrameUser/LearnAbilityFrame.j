
library LearnAbilityFrame uses GameFrame
   /*按钮序号
    101-103     备选技能背景
    111-113     备选技能框

    120         当前技能
    121-123     待替换技能背景
    131-133     待替换技能框
    */
    private FRAME Button = 0

    private FRAME Back = 0
    
    private int origin = 0

    //通用函数
    function ShowLearnFrame(int pid,bool show)

        if  GetLocalPlayer() == Player(pid)
            Button.show = show
        endif
    
    endfunction
    function GetLearnFrameShow()->bool
        return Button.show
    endfunction
    function CloseLearnFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            Button.show = false
        endif
    endfunction

    function ClickLearnFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            if  Button.show  == true
                Button.show = false
            else
                Button.show = true
            endif
        endif
    endfunction


    //获取玩家技能槽数量
    function GetPlayerAbilitySlot(int pid)->int
        return 3
    endfunction

    function GetPlayerNullIndex(int pid)->int
        int max = GetPlayerAbilitySlot(pid)
        int id = 0
        for index = 1,max
            id = GetUnitIntState(Pu[1],110+index)
            if  id == 0
                return index
            elseif  GetTypeIdData(id,101) == 9
                return index
            endif
        end
        return 0    
    endfunction

    //获取空槽数量
    function GetPlayerAbilityNullNum(int pid)->int
        int max = GetPlayerAbilitySlot(pid)
        int num = 0
        for index = 1,max
            if  GetUnitIntState(Pu[1],110+index) == 0
                num = num + 1
            endif
        end
        return num
    endfunction



    function ReLearnAbility(int pid)
        int id = 0
        if  GetLocalPlayer() == Player(pid)

            for i = 1,3
                id = GetUnitIntState(Pu[1],i+130)
                DzFrameSetTexture(BUTTON_Back[i+110][1],GetTypeIdIcon(id),0)
                DzFrameSetText(BUTTON_Text[i+110],GetTypeIdColor(id)+GetTypeIdName(id))
            end
        endif
    endfunction

    function CreateLearnButton()
        
        for x = 0,2
            CreateButton(x+101,Button.frameid,TYPE_BUTTON,3,Button.frameid,3,0.005+x*0.051,0.0,0.046,0.060,"war3mapImported\\UI_Learn_ButtonBack0.tga")

            CreateButton(x+111,Button.frameid,TYPE_BUTTON,1,BUTTON_Back[x+101][0],1,0.0,-0.005,0.036,0.036,"ReplaceableTextures\\CommandButtons\\BTNDragonHawk.blp")
        end
        
        CreateText(111,Button.frameid,"centertext009",1,7,0.0,-0.005,"|cff999999技能名称|r")
        CreateText(112,Button.frameid,"centertext009",1,7,0.0,-0.005,"|cff999999技能名称|r")
        CreateText(113,Button.frameid,"centertext009",1,7,0.0,-0.005,"|cff999999技能名称|r")
    endfunction


    function LearnAbilityFrameInit()
        Button = FRAME.create() //背景注册
        Back = FRAME.create()   //注册主背景
        

        //控件设置
        Button.frameid = FRAME.Tag("BUTTON","Learn",GameUI,Button)
        Button.SetPoint(8,GameUI,5,-0.01,-0.1)
        Button.SetSize(0.158,0.12)
        origin = Button.frameid

        //背景设置
        Back.frameid = FRAME.Tag("BACKDROP","Learn",origin,Back)
        Back.SetPoint(4,origin,4,0,0)
        Back.SetSize(0.158,0.12)
        Back.SetTexture("war3mapImported\\UI_Learn_Back0.tga",0)


        CreateLearnButton()

        Button.show = false
    endfunction

endlibrary

library ReplaceAbilityFrame uses GameFrame,LearnAbilityFrame
   /*按钮序号
    
    101-103     备选技能背景
    111-113     备选技能框

    120         当前技能
    121-123     待替换技能背景
    131-133     待替换技能框
    */
    private FRAME Button = 0

    private FRAME Back = 0
    
    private int origin = 0

    //通用函数
    function ShowReplaceFrame(int pid,bool show)

        if  GetLocalPlayer() == Player(pid)
            Button.show = show
        endif
    endfunction

    function GetReplaceFrameShow()->bool
        return Button.show
    endfunction

    function CloseReplaceFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            Button.show = false
        endif
    endfunction

    function ClickReplaceFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            if  Button.show  == true
                Button.show = false
            else
                Button.show = true
            endif
        endif
    endfunction


     //刷新显示
    function ReReplaceAbility(int pid)
        int max = 0
        int id = 0
        if  GetLocalPlayer() == Player(pid)
            
            
            DzFrameSetTexture(BUTTON_Back[120][1],GetTypeIdIcon(GetUnitIntState(Pu[1],120)),0)
            DzFrameSetText(BUTTON_Text[120],GetTypeIdColor(GetUnitIntState(Pu[1],120))+GetTypeIdName(GetUnitIntState(Pu[1],120)))

            max = GetPlayerAbilitySlot(pid)
            for i = 1,3
                if  i <= max
                    id = GetHeroAbilityID(Pu[1],i)
                    DzFrameSetTexture(BUTTON_Back[i+130][1],GetTypeIdIcon(id),0)
                    DzFrameSetTexture(BUTTON_Back[i+120][1],"war3mapImported\\UI_Learn_ButtonBack0.tga",0)
                    DzFrameSetText(BUTTON_Text[i+130],GetTypeIdColor(id)+GetTypeIdName(id))
                    DzFrameShow(BUTTON_Back[i+130][0],true)
                else
                    DzFrameSetTexture(BUTTON_Back[i+130][1],"war3mapImported\\alpha.tga",0)
                    DzFrameSetText(BUTTON_Text[i+130],"")
                    if  i == 2
                        
                        DzFrameSetTexture(BUTTON_Back[i+120][1],"war3mapImported\\UI_Learn_ButtonBack1.tga",0)
                    else
                        DzFrameSetTexture(BUTTON_Back[i+120][1],"war3mapImported\\UI_Learn_ButtonBack2.tga",0)
                    endif
                    DzFrameShow(BUTTON_Back[i+130][0],false)
                endif
            end
        endif
    endfunction




    function CreateReplaceButton()
        

        CreateButton(120,Button.frameid,TYPE_BUTTON,1,Button.frameid,1,0.0,-0.027,0.036,0.036,"war3mapImported\\alpha.tga")
        CreateText(120,Button.frameid,"centertext009",1,7,0.0,-0.005,"|cff999999技能名称|r")

        for x = 0,2
            CreateButton(x+121,Button.frameid,TYPE_BUTTON,6,Button.frameid,6,0.005+x*0.051,0.02,0.046,0.060,"war3mapImported\\UI_Learn_ButtonBack0.tga")

            CreateButton(x+131,Button.frameid,TYPE_BUTTON,1,BUTTON_Back[x+121][0],1,0.0,-0.005,0.036,0.036,"war3mapImported\\alpha.tga")
        end
        

        CreateText(121,Button.frameid,"centertext007",4,4,0.0,-0.005,"")
        CreateText(122,Button.frameid,"centertext007",4,4,0.0,-0.005,"")
        CreateText(123,Button.frameid,"centertext007",4,4,0.0,-0.005,"")

        CreateText(131,Button.frameid,"centertext009",1,7,0.0,-0.005,"|cff999999技能名称|r")
        CreateText(132,Button.frameid,"centertext009",1,7,0.0,-0.005,"|cff999999技能名称|r")
        CreateText(133,Button.frameid,"centertext009",1,7,0.0,-0.005,"|cff999999技能名称|r")
    endfunction


    function ReplaceAbilityFrameInit()
        Button = FRAME.create() //背景注册
        Back = FRAME.create()   //注册主背景
        

        //控件设置
        Button.frameid = FRAME.Tag("BUTTON","Replace",GameUI,Button)
        Button.SetPoint(8,GameUI,5,-0.01,-0.1)
        Button.SetSize(0.158,0.18)
        origin = Button.frameid

        //背景设置
        Back.frameid = FRAME.Tag("BACKDROP","Replace",origin,Back)
        Back.SetPoint(4,origin,4,0,0)
        Back.SetSize(0.158,0.18)
        Back.SetTexture("war3mapImported\\UI_Learn_Back1.tga",0)

        CreateReplaceButton()

        Button.show = false
    endfunction

endlibrary

library LearnAbility initializer LearnAbilityInit uses ReplaceAbilityFrame,LearnAbilityFrame

    
    //替换技能
    function PlayerReplaceAbility(int pid,int index)
        int id = GetUnitIntState(Pu[1],120)
        int max = GetPlayerAbilitySlot(pid)
        if  index <= max
            int rid = GetUnitIntState(Pu[1],110+index)
            RecoveryPrizePoolData(pid,GetTypeIdData(rid,101),rid)
            BJDebugMsg("替换回收"+GetTypeIdName(rid))

            HeroRemoveAbilityByIndex(Pu[1],index)
            HeroAddAbilityByIndex(Pu[1],index,id)
            SetUnitIntState(Pu[1],120,0)
            ShowReplaceFrame(pid,false)
        endif
        
    endfunction

    //学习技能
    function PlayerLearnAbilityFunc(int pid,int id)
        int index = GetPlayerNullIndex(pid)
        if  index > 0
            HeroAddNewAbility(Pu[1],id)
        else
            SetUnitIntState(Pu[1],120,id)
            ShowReplaceFrame(pid,true)
            ReReplaceAbility(pid)
        endif
    endfunction




    function PlayerSelectLearnAbility(int pid,int index)
        int id = GetUnitIntState(Pu[1],130+index)
        int rid = 0

        for i =1,3
            rid = GetUnitIntState(Pu[1],130+i)
            if  rid > 0
                if  rid == id
                    PlayerLearnAbilityFunc(pid,id)
                else
                    RecoveryPrizePoolData(pid,GetTypeIdData(rid,101),rid)
                    BJDebugMsg("回收"+GetTypeIdName(rid))
                endif
            endif
            SetUnitIntState(Pu[1],130+i,0)
        end

        ShowLearnFrame(pid,false)
    endfunction

    function PlayerLearnThreeAbilityFunc(int pid,int id1,int id2,int id3)
        SetUnitIntState(Pu[1],131,id1)
        SetUnitIntState(Pu[1],132,id2)
        SetUnitIntState(Pu[1],133,id3)
        ShowLearnFrame(pid,true)
        ReLearnAbility(pid)
    endfunction
    

    //新的技能学习逻辑


    function GetIncAbilityName(int id,int color)->string
        if  id == 0
            return ""
        else
            return GetSkillNameColor(color) + GetTypeIdString(id,100) + GetSkillGrade(color)
        endif
    endfunction

    function GetNowLColor(int pid,int index)->int
        return GetUnitIntState(Pu[1],120+index)
    endfunction

    //获取一个期待的颜色
    function GetExpectLevel(int pid,int itemid)->int
        int ran = GetRandomInt(1,100)
        if  itemid == 'IS01' or itemid == 'IS06'
            if  ran <= 70
                return 5
            else
                return 4
            endif
        elseif  itemid == 'IS02' or itemid == 'IS07'
            if  ran <= 25
                return 5
            elseif  ran <= 75
                return 4
            else
                return 3
            endif
        elseif  itemid == 'IS03' or itemid == 'IS08'
            if  ran <= 25
                return 4
            elseif  ran <= 75
                return 3
            else
                return 2
            endif
        endif

        return 0
    endfunction


    
    //抽技能
    function PlayerUseLearnAbilityBook(int pid,int index,int itemid)
        int now = GetHeroAbilityID(Pu[1],index)
        int new = 0
        int prize = 0
        int level = GetExpectLevel(pid,itemid)
        if  index == 1
            prize = level + 5
        else
            prize = level
        endif
        BJDebugMsg("读取奖池"+I2S(prize))

        new = GetPrize(pid,prize,true)

        if  GetTypeIdData(now,101) != 9
            //重复抽 回收技能
            if  GetTypeIdData(now,100) == 1
                RecoveryPrizePoolData(pid,GetTypeIdData(now,101),now)
            else
                RecoveryPrizePoolData(pid,GetTypeIdData(now,101)+5,now)
            endif
        endif
        
        BJDebugMsg("新技能"+GetTypeIdName(new))
        //删除老技能
        HeroRemoveAbilityByIndex(Pu[1],index)

        //添加新技能
        HeroAddAbilityByIndex(Pu[1],index,new)

        HeroSetAbilityLevelByIndex(Pu[1],index,6-level)
        

        MissionAddNumFunc(pid,5,1)//抽技能
        MissionAddNumFunc(pid,33,1)//抽技能
    endfunction



    //读取可升级的技能id
    function GetCanIncAbilityId(int pid,int index,int max)->int
        int n = 0
        int color = 0
        int id = 0
        for i = 1,3
            id = GetHeroAbilityID(Pu[1],i)
            if  id > 0 and GetTypeIdData(id,101) != 9
                color = GetNowLColor(pid,i)
                if  max == 5
                    if  color == 4
                        n = n + 1
                    endif
                else
                    if  color < max
                        n = n + 1
                    endif
                endif
                BJDebugMsg("color"+I2S(color))
                if  n == index
                    return id
                endif
            endif
        end
        return 0
    endfunction

    function IncAbilityGemFunc1()
        int pid = Dialog.GetPlayerid()
        int i = Dialog.GetButtonid()



        int id = GetCanIncAbilityId(pid,i,4)
        int index = GetHeroAbilityIndex(Pu[1],id)
        HeroIncAbility(Pu[1],index)

        int lv = GetHeroAbilityLevel(Pu[1],id)
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r进阶成功，得到技能"+GetIncAbilityName(id,lv))
    endfunction
    function IncAbilityGemFunc2()
        int pid = Dialog.GetPlayerid()
        int i = Dialog.GetButtonid()



        int id = GetCanIncAbilityId(pid,i,5)
        int index = GetHeroAbilityIndex(Pu[1],id)
        HeroIncAbility(Pu[1],index)
        int lv = GetHeroAbilityLevel(Pu[1],id)
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r进阶成功，得到技能"+GetIncAbilityName(id,lv))
    endfunction

    
    function IncAbilityGemFunc3()
        int pid = Dialog.GetPlayerid()
        int i = Dialog.GetButtonid()


        if  GetRandomInt(1,100)<= 50
            int id = GetCanIncAbilityId(pid,i,4)
            int index = GetHeroAbilityIndex(Pu[1],id)
            HeroIncAbility(Pu[1],index)
            int lv = GetHeroAbilityLevel(Pu[1],id)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r进阶成功，得到技能"+GetIncAbilityName(id,lv))

            AddUnitIntState(Pu[1],'RDAH',1)
            if  GetUnitIntState(Pu[1],'RDAH') >= 3
                if  GetPlayerTechCount(Player(pid),'RDAH',true) == 0
                    SetDzPlayerData(pid,15,8,8)
                    SetPlayerTechResearchedEx(Player(pid),'RDAH')
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000太欧了！|r（永久存档）！")
                endif
            endif
        else
            SetUnitIntState(Pu[1],'RDAH',0)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：很遗憾！技能进阶失败！")
        endif
    endfunction

    function IncAbilityGemFunc4()
        int pid = Dialog.GetPlayerid()
        int i = Dialog.GetButtonid()


        if  GetRandomInt(1,100)<= 50
            int id = GetCanIncAbilityId(pid,i,5)
            int index = GetHeroAbilityIndex(Pu[1],id)
            HeroIncAbility(Pu[1],index)
            int lv = GetHeroAbilityLevel(Pu[1],id)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r进阶成功，得到技能"+GetIncAbilityName(id,lv))
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：很遗憾！技能进阶失败！")
        endif
    endfunction

    

    //洗技能品级
    function PlayerUseIncAbilityGem(unit u1,int itemid)
        int pid = GetPlayerId(GetOwningPlayer(u1))
        int max = 0
        if  itemid == 'CS22' or itemid == 'CS24'
            max = 5
        else
            max = 4
        endif
        int id1 = GetCanIncAbilityId(pid,1,max)
        int id2 = GetCanIncAbilityId(pid,2,max)
        int id3 = GetCanIncAbilityId(pid,3,max)
        int ic1 = GetHeroAbilityLevel(Pu[1],id1)
        int ic2 = GetHeroAbilityLevel(Pu[1],id2)
        int ic3 = GetHeroAbilityLevel(Pu[1],id3)

        if  id1 > 0
            if  itemid == 'CS21'
                Dialog.create(Player(pid),"请选择技能",GetIncAbilityName(id1,ic1),GetIncAbilityName(id2,ic2),GetIncAbilityName(id3,ic3),"","","","","","","","","","IncAbilityGemFunc1")
            elseif  itemid == 'CS22'
                Dialog.create(Player(pid),"请选择技能",GetIncAbilityName(id1,ic1),GetIncAbilityName(id2,ic2),GetIncAbilityName(id3,ic3),"","","","","","","","","","IncAbilityGemFunc2")
            elseif  itemid == 'CS23'
                Dialog.create(Player(pid),"请选择技能",GetIncAbilityName(id1,ic1),GetIncAbilityName(id2,ic2),GetIncAbilityName(id3,ic3),"","","","","","","","","","IncAbilityGemFunc3")
            elseif  itemid == 'CS24'
                Dialog.create(Player(pid),"请选择技能",GetIncAbilityName(id1,ic1),GetIncAbilityName(id2,ic2),GetIncAbilityName(id3,ic3),"","","","","","","","","","IncAbilityGemFunc4")
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：没有可以升级的技能！")
            UnitAddItem(u1,CreateItem(itemid,GetUnitX(u1),GetUnitY(u1)))
        endif

    endfunction



        


//抽技能
    //读取玩家抽技能次数
    function GetPlayerDrawNum(int pid,int index)->int
        return PlayerInt[pid][110+index]
    endfunction
    //增加玩家抽技能次数
    function AddPlayerDrawNum(int pid,int index)
        PlayerInt[pid][110+index] = PlayerInt[pid][110+index] + 1
    endfunction
    //读取玩家抽技能需求
    function GetPlayerDrawUse(int pid,int itemid)->int
        if  itemid == 'IS01' or itemid == 'IS06'
            return 1
        elseif  itemid == 'IS02' or itemid == 'IS07'
            return 2
        elseif  itemid == 'IS03' or itemid == 'IS08'
            return 3
        endif
        return 0
    endfunction
    function PlayerAbilityDraw(int pid,int index,int itemid)
        //int num = GetPlayerDrawNum(pid,index)
        //int use = GetPlayerDrawUse(pid,itemid)


             
                
        //if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER) >= use
            //AdjustPlayerStateBJ(-use, Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
            PlayerUseLearnAbilityBook(pid,index,itemid)
            AddPlayerDrawNum(pid,index)
        //else
            //DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r抽取失败！玄铁不足"+I2S(use)+"。")
        //endif
        
           
 
    endfunction
    //抽技能
    function PlayerUseAbilityBookCS01()
        int pid = Dialog.GetPlayerid()
        int i = Dialog.GetButtonid()
        if  i == 1
            PlayerAbilityDraw(pid,1,'IS03')
        else
            UnitAddItem(Pu[1],CreateItem('CS01',GetUnitX(Pu[1]),GetUnitY(Pu[1])))
        endif
    endfunction
    function PlayerUseAbilityBookCS03()
        int pid = Dialog.GetPlayerid()
        int i = Dialog.GetButtonid()
        if  i == 1
            PlayerAbilityDraw(pid,2,'IS06')
        else
            UnitAddItem(Pu[1],CreateItem('CS03',GetUnitX(Pu[1]),GetUnitY(Pu[1])))
        endif
    endfunction
    function PlayerUseAbilityBookCS04()
        int pid = Dialog.GetPlayerid()
        int i = Dialog.GetButtonid()
        if  i == 1
            PlayerAbilityDraw(pid,1,'IS02')
        else
            UnitAddItem(Pu[1],CreateItem('CS04',GetUnitX(Pu[1]),GetUnitY(Pu[1])))
        endif
    endfunction
    function PlayerUseAbilityBookCS05()
        int pid = Dialog.GetPlayerid()
        int i = Dialog.GetButtonid()
        if  i == 1
            PlayerAbilityDraw(pid,2,'IS07')
        else
            UnitAddItem(Pu[1],CreateItem('CS05',GetUnitX(Pu[1]),GetUnitY(Pu[1])))
        endif
    endfunction
    function PlayerUseAbilityBookCS06()
        int pid = Dialog.GetPlayerid()
        int i = Dialog.GetButtonid()
        if  i == 1
            PlayerAbilityDraw(pid,2,'IS08')
        else
            UnitAddItem(Pu[1],CreateItem('CS06',GetUnitX(Pu[1]),GetUnitY(Pu[1])))
        endif
    endfunction

    function PlayerUseAbilityBook(int pid,int index,int itemid)
        int sid = GetHeroAbilityID(Pu[1],index)
        
        if  sid == 0
            if  itemid == 'CS01'
                PlayerAbilityDraw(pid,1,'IS03')
            elseif  itemid == 'CS03'
                PlayerAbilityDraw(pid,2,'IS06')
            elseif  itemid == 'CS04'
                PlayerAbilityDraw(pid,1,'IS02')
            elseif  itemid == 'CS05'
                PlayerAbilityDraw(pid,2,'IS07')
            elseif  itemid == 'CS06'
                PlayerAbilityDraw(pid,2,'IS08')
            endif
        else
            if  itemid == 'CS01'
                Dialog.create(Player(pid),"当前技能："+GetHeroAbilityName(Pu[1],index)+"\n是否抽取新技能","确定","取消","","","","","","","","","","","PlayerUseAbilityBookCS01")
            elseif  itemid == 'CS03'
                Dialog.create(Player(pid),"当前技能："+GetHeroAbilityName(Pu[1],index)+"\n是否抽取新技能","确定","取消","","","","","","","","","","","PlayerUseAbilityBookCS03")
            elseif  itemid == 'CS04'
                Dialog.create(Player(pid),"当前技能："+GetHeroAbilityName(Pu[1],index)+"\n是否抽取新技能","确定","取消","","","","","","","","","","","PlayerUseAbilityBookCS04")
            elseif  itemid == 'CS05'
                Dialog.create(Player(pid),"当前技能："+GetHeroAbilityName(Pu[1],index)+"\n是否抽取新技能","确定","取消","","","","","","","","","","","PlayerUseAbilityBookCS05")
            elseif  itemid == 'CS06'
                Dialog.create(Player(pid),"当前技能："+GetHeroAbilityName(Pu[1],index)+"\n是否抽取新技能","确定","取消","","","","","","","","","","","PlayerUseAbilityBookCS06")
            endif
        endif
        

    endfunction


    function LearnAbilityInit()

    endfunction
endlibrary


