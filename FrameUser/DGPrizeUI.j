
library DGPrizeFrame uses GameFrame,HeroFrameUI
    private FRAME Button = 0
    private FRAME Back = 0
    private int origin = 0

    
  

    
    //刷新符印奖励UI
    function ReDGPrizeFrame(int pid)
        int id = 0
        int use = 10000
        if  GetLocalPlayer() == Player(pid)
            for i = 1,3
                id = GetUnitIntState(Pu[1],930+i)
                
                if  id > 0
                    DzFrameSetTexture(BUTTON_Back[940+i][1],GetTypeIdIcon(id),0)
                    DzFrameSetText(BUTTON_Text[940+i],GetTypeIdName(id))
                else
                    DzFrameSetTexture(BUTTON_Back[940+i][1],"war3mapImported\\alpha.tga",0)
                    DzFrameSetText(BUTTON_Text[940+i],"")
                endif
            end
            DzFrameSetText(BUTTON_Text[940],"10000经验")
        endif
    endfunction
    function GivePlayerHeroDG(int pid,int id)

    endfunction

    function GetNewDGPrize(int pid)->int
        return 0
    endfunction

    function GivePlayerDGPrizeFrame(int pid)
        int id = GetUnitIntState(Pu[1],931)
        
        if  id >= 'IJ01' and id <= 'IJ15'
            //给一个 防止上一个窗口残留
            GivePlayerHeroDG(pid,id)
        endif

        int id1 = GetNewDGPrize(pid)
        int id2 = GetNewDGPrize(pid)
        int id3 = GetNewDGPrize(pid)

        SetUnitIntState(Pu[1],931,id1)
        SetUnitIntState(Pu[1],932,id2)
        SetUnitIntState(Pu[1],933,id3)
        
        //PlayerRePrizeNum3 = 0

        if  GetLocalPlayer() == Player(pid)
            Button.show = true
            ReDGPrizeFrame(pid)
        endif
    endfunction


    function DGPrizeFrameInit()
        Button = FRAME.create() //背景注册
        Back = FRAME.create()   //注册主背景

        //控件设置
        Button.frameid = FRAME.Tag("BUTTON","Prize3",GameUI,Button)
        Button.SetPoint(4,GameUI,4,0,0)
        Button.SetSize(0.134,0.134)
        origin = Button.frameid

        //背景设置
        Back.frameid = FRAME.Tag("BACKDROP","Prize3",origin,Back)
        Back.SetPoint(4,origin,4,0,0)
        Back.SetSize(0.134,0.134)
        Back.SetTexture("war3mapImported\\UI_Prize_Back3.tga",0)


        for x = 0,2
            CreateButton(931+x,Button.frameid,TYPE_BUTTON,6,Button.frameid,6,0.005+x*0.042,0.034,0.04,0.060,"war3mapImported\\UI_Prize_ButtonBack0.tga")
            CreateButton(941+x,Button.frameid,TYPE_BUTTON,1,BUTTON_Back[931+x][0],1,0.0,-0.002,0.036,0.036,"war3mapImported\\alpha.tga")
            CreateText(941+x,Button.frameid,"centertext008",1,7,0.0,-0.005,"|cff999999物品名称|r")
        end
        CreateButton(930,Button.frameid,TYPE_CLOSE,2,Button.frameid,2,0.0,0.0,0.03,0.016,"war3mapImported\\UI_ESC.tga")

        CreateButton(940,Button.frameid,TYPE_BUTTON,7,Button.frameid,7,0.0,0.005,0.1,0.024,"war3mapImported\\UI_ReDG_Button.tga")
        CreateText(940,Button.frameid,"text008",3,4,-0.005,0.0,"10000经验")
        
        //Button.show = false
    endfunction
endlibrary
