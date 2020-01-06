
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
        if  GameLevel >= 3
            return 3
        endif
        return 2
    endfunction

    function GetPlayerNullIndex(int pid)->int
        int max = GetPlayerAbilitySlot(pid)
        int id = 0
        for index = 1,max
            id = GetUnitIntState(Pu[1],110+index)
            if  id == 0
                return index
            elseif  GetTypeIdData(id,101) == 6
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
        Button.SetPoint(4,GameUI,4,0,0)
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
        Button.SetPoint(4,GameUI,4,0,0)
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
            RegisterPrizePoolData(pid,GetTypeIdData(rid,101),rid)
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
                    RegisterPrizePoolData(pid,GetTypeIdData(rid,101),rid)
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

    function GetLearnAbilityBookId(int pid,int itemid)->int
        int index = 0
        if  itemid == 'CS01'
            if  GetRandomInt(1,100)<=60
                index = 5
            else
                index = 4
            endif
        elseif  itemid == 'CS02'
            index = 3
        elseif  itemid == 'CS03'
            index = 2
        elseif  itemid == 'CS04'
            index = 1
        endif
        return GetPrize(pid,index,true)
    endfunction

    function PlayerUseLearnAbilityBook(int pid,int itemid)
        int rid = 0
        for i =1,3
            rid = GetUnitIntState(Pu[1],130+i)
            if  rid > 0
                RegisterPrizePoolData(pid,GetTypeIdData(rid,101),rid)
                BJDebugMsg("回收"+GetTypeIdName(rid))
            endif
            SetUnitIntState(Pu[1],130+i,0)
        end


        rid = GetUnitIntState(Pu[1],120)
        if  rid > 0
            RegisterPrizePoolData(pid,GetTypeIdData(rid,101),rid)
            BJDebugMsg("回收"+GetTypeIdName(rid))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r您放弃了学习技能！")
            SetUnitIntState(Pu[1],120,0)
            CloseReplaceFrame(pid)
        else
            BJDebugMsg("新窗口学习技能")
        endif
        if  GameLevel >= 3
            PlayerLearnThreeAbilityFunc(pid,GetLearnAbilityBookId(pid,itemid),GetLearnAbilityBookId(pid,itemid),GetLearnAbilityBookId(pid,itemid))
        else
            PlayerLearnAbilityFunc(pid,GetLearnAbilityBookId(pid,itemid))
        endif
    endfunction


    function LearnAbilityInit()

    endfunction
endlibrary

