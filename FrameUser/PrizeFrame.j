library PrizeFrame uses GameFrame,MagicItemCollectCode

    /*
    401     副本奖励1
    402     副本奖励2
    411     副本奖励待选框架1
    412     副本奖励待选框架2
    413     副本奖励待选框架3
    421     副本奖励待选图标1
    422     副本奖励待选图标2
    423     副本奖励待选图标3
    */

    private FRAME Button = 0

    private FRAME Back = 0
    private FRAME Title = 0
    private FRAME Key = 0
    
    private int origin = 0

    //通用函数
    function ShowPrizeFrame(int pid,bool show)

        if  GetLocalPlayer() == Player(pid)
            Button.show = show
        endif
    
    endfunction
    function GetPrizetFrameShow()->bool
        return Button.show
    endfunction


    function ClosePrizeFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            Button.show = false
        endif
    endfunction

    function ClickPrizeFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            if  Button.show  == true
                Button.show = false
            else
                Button.show = true
            endif
        endif
    endfunction


    function SetPrizeType(int pid,int Type)
        SetUnitIntState(Pu[1],400,Type)
        if  GetLocalPlayer() == Player(pid)
            if  Type == 0
                for x = 0,2
                    DzFrameShow(BUTTON_Back[x+411][0],true)
                    DzFrameShow(BUTTON_Back[x+421][0],true)
                    DzFrameSetText(BUTTON_Text[x+421],"")
                end
                Back.SetTexture("war3mapImported\\UI_Prize_Back0.tga",0)
                Button.SetSize(0.134,0.12)
                Back.SetSize(0.134,0.12)
            else
                for x = 0,2
                    DzFrameShow(BUTTON_Back[x+411][0],false)
                    DzFrameShow(BUTTON_Back[x+421][0],false)
                    DzFrameSetText(BUTTON_Text[x+421],"")
                end
                Back.SetTexture("war3mapImported\\UI_Prize_Back1.tga",0)
                Button.SetSize(0.134,0.1)
                Back.SetSize(0.134,0.1)
            endif
        endif
    endfunction

    function CreatePrizeButton()
    
        CreateButton(411,Button.frameid,TYPE_BUTTON,6,Button.frameid,6,0.005+1*0.042,0.012,0.04,0.060,"war3mapImported\\UI_Prize_ButtonBack1.tga")
        CreateButton(421,Button.frameid,TYPE_BUTTON,1,BUTTON_Back[411][0],1,0.0,-0.002,0.036,0.036,"war3mapImported\\alpha.tga")
        CreateText(421,Button.frameid,"centertext008",1,7,0.0,-0.005,"|cff999999物品名称|r")

        CreateButton(412,Button.frameid,TYPE_BUTTON,6,Button.frameid,6,0.005+0*0.042,0.012,0.04,0.060,"war3mapImported\\UI_Prize_ButtonBack1.tga")
        CreateButton(422,Button.frameid,TYPE_BUTTON,1,BUTTON_Back[412][0],1,0.0,-0.002,0.036,0.036,"war3mapImported\\alpha.tga")
        CreateText(422,Button.frameid,"centertext008",1,7,0.0,-0.005,"|cff999999物品名称|r")

        CreateButton(413,Button.frameid,TYPE_BUTTON,6,Button.frameid,6,0.005+2*0.042,0.012,0.04,0.060,"war3mapImported\\UI_Prize_ButtonBack1.tga")
        CreateButton(423,Button.frameid,TYPE_BUTTON,1,BUTTON_Back[413][0],1,0.0,-0.002,0.036,0.036,"war3mapImported\\alpha.tga")
        CreateText(423,Button.frameid,"centertext008",1,7,0.0,-0.005,"|cff999999物品名称|r")


        CreateButton(410,Button.frameid,TYPE_CLOSE,2,Button.frameid,2,0.0,0.0,0.03,0.016,"war3mapImported\\UI_ESC.tga")

        
    endfunction

    function PrizeFrameInit()

        Button = FRAME.create() //背景注册
        Title = FRAME.create()  //注册标题
        Back = FRAME.create()   //注册主背景

        //控件设置
        Button.frameid = FRAME.Tag("BUTTON","Prize",GameUI,Button)
        Button.SetPoint(4,GameUI,4,0,0)
        Button.SetSize(0.134,0.12)
        origin = Button.frameid

        //背景设置
        Back.frameid = FRAME.Tag("BACKDROP","Prize",origin,Back)
        Back.SetPoint(4,origin,4,0,0)
        Back.SetSize(0.134,0.12)
        Back.SetTexture("war3mapImported\\UI_Prize_Back0.tga",0)

   
        
        CreatePrizeButton()

        Button.show = false
    endfunction


    
    function RePrizeFrame(int pid)
        int Type = GetUnitIntState(Pu[1],400)
        int id = 0
        if  GetLocalPlayer() == Player(pid)


            if  Type == 0
                for i = 0,2
                    id = GetUnitIntState(Pu[1],403+i)
                    
                    if  id > 0
                        DzFrameSetTexture(BUTTON_Back[411+i][1],"war3mapImported\\UI_Prize_ButtonBack0.tga",0)
                        DzFrameSetTexture(BUTTON_Back[421+i][1],GetTypeIdIcon(id),0)
                        DzFrameSetText(BUTTON_Text[421+i],GetTypeIdName(id))
                        
                    else
                        DzFrameSetTexture(BUTTON_Back[411+i][1],"war3mapImported\\UI_Prize_ButtonBack1.tga",0)
                        DzFrameSetTexture(BUTTON_Back[421+i][1],"war3mapImported\\alpha.tga",0)
                        DzFrameSetText(BUTTON_Text[421+i],"")
                    endif
                end
            endif
        endif
    endfunction

//玩家点击奖励
    function PlayerClickPrize(int pid,int index)
        int id = 0
        int rid = 0
        int Type = 0

        if  index == 0
            if  GetUnitIntState(Pu[1],403) == 0
                //第3个位置空，代表没有备选框
                Type = 1
            endif

            if  GetUnitIntState(Pu[1],404) == 0
                //第4个位置空 说明奖励只有第三个位置有
                index = 1
            else
                index = GetRandomInt(1,3)
            endif

            
        endif
        
        id = GetUnitIntState(Pu[1],402+index)

        if  id > 0 or Type == 1
            
            if  Type == 0
                for i = 1,3
                    rid = GetUnitIntState(Pu[1],402+i)
                    if  i != index
                        RecoveryPrizePoolData(pid,10+GetTypeIdData(rid,101),rid)
                    endif
                end
                GivePlayerMagicItem(pid,id)
            endif

            for n = 1,2
                id = GetUnitIntState(Pu[1],400+n)
                if  id >= 'FB01' and id <= 'FB99'
                    GivePlayerMagicItem(pid,id)
                else
                    UnitAddItemExEx(Pu[1],CreateItem(id,GetUnitX(Pu[1]),GetUnitY(Pu[1])))
                endif
            end

            

            SetUnitIntState(Pu[1],401,0)
            SetUnitIntState(Pu[1],402,0)
            SetUnitIntState(Pu[1],403,0)
            SetUnitIntState(Pu[1],404,0)
            SetUnitIntState(Pu[1],405,0)
            if  GetLocalPlayer() == Player(pid)
                Button.show = false
            endif
        endif
    endfunction

    //给与玩家奖励
    function GivePlayerPrize(int pid,int id1,int id2,int id3,int id4,int id5)

        if  GetUnitIntState(Pu[1],401) > 0
            PlayerClickPrize(pid,0)
        endif

        SetUnitIntState(Pu[1],401,id1)
        SetUnitIntState(Pu[1],402,id2)
        SetUnitIntState(Pu[1],403,id3)
        SetUnitIntState(Pu[1],404,id4)
        SetUnitIntState(Pu[1],405,id5)

        if  id3 == 0
            PlayerClickPrize(pid,0)
        else
            if  GetLocalPlayer() == Player(pid)
                RePrizeFrame(pid)
                Button.show = true
            endif
        endif

        
        
    endfunction


    

    
    


endlibrary
