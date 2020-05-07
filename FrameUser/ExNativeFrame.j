library ExNativeFrame uses GameFrame
    
    
    FRAME HeroHDFrame = 0
    FRAME HeroHDButton = 0
    
    private FRAME Button = 0

    private FRAME Back = 0
    private FRAME Title = 0
    private FRAME Key = 0
    
    private int origin = 0

    FRAME ReHeroBack = 0
    FRAME ReHeroButton = 0
    FRAME ReHeroNumber = 0
    
    FRAME Blood = 0
    
      
    //鼠标显示符印
    function BoxShowRuneFrame(int pid,int index)
        int id = 'FY00'+index
        int lv = GetUnitIntState(Pu[1],id)
        
        DzFrameShow(UI_TipsHead, true)
            
        if  lv > 0
            SetTipsData(1,"","|cffff0000"+GetTypeIdName(id)+"|rx"+I2S(lv))
        else
            SetTipsData(1,"","|cffff0000"+GetTypeIdName(id)+"|cff808080(未拥有)")
        endif
        
        SetTipsData(10,"",GetTypeIdTips(id))
        
        if  lv >= 3
            SetTipsData(11,"","\n|cff00ff00"+GetTypeIdName(id)+"x3\n"+GetTypeIdString(id,131))
        else
            SetTipsData(11,"","\n|cff808080"+GetTypeIdName(id)+"x3\n"+GetTypeIdString(id,131))
        endif

        if  lv >= 6
            SetTipsData(12,"","\n|cff00ff00"+GetTypeIdName(id)+"x6\n"+GetTypeIdString(id,132))
        else
            SetTipsData(12,"","\n|cff808080"+GetTypeIdName(id)+"x6\n"+GetTypeIdString(id,132))
        endif


        if  GetTypeIdString(id,133)!=""
            SetTipsData(13,"","\n|cff808080"+GetTypeIdString(id,133))
        endif



        ShowTipsUISetPosition(0.0,0.1)
    endfunction
    
    
    //刷新符印显示
    function ReRuneFrame(int pid)
        int lv = 0
        int index = 0
        if  GetLocalPlayer() == Player(pid)
            for i = 1,8
                index = 900 + i
                lv = GetUnitIntState(Pu[1],'FY00'+i)
                if  lv > 0
                    DzFrameSetTexture(BUTTON_Back[index][0],"war3mapImported\\UI_Fuin_Back0"+I2S(i)+".tga",0)
                    DzFrameSetTexture(BUTTON_Back[index][1],"war3mapImported\\UI_Fuin_num"+I2S(lv)+".tga",0)
                else
                    DzFrameSetTexture(BUTTON_Back[index][0],"war3mapImported\\UI_Fuin_DisBack0"+I2S(i)+".tga",0)
                    DzFrameSetTexture(BUTTON_Back[index][1],"war3mapImported\\alpha.tga",0)
                endif
            end
        endif
    endfunction

    //刷新符印奖励UI
    function ReRunePrizeFrame(int pid)
        int id = 0
        int use = (PlayerRePrizeNum2+1)*2
        if  use > 8
            use = 8
        endif
        if  GetLocalPlayer() == Player(pid)
            for i = 1,3
                id = GetUnitIntState(Pu[1],910+i)
                
                if  id > 0
                    DzFrameSetTexture(BUTTON_Back[920+i][1],GetTypeIdIcon(id),0)
                    DzFrameSetText(BUTTON_Text[920+i],GetTypeIdName(id))
                else
                    DzFrameSetTexture(BUTTON_Back[920+i][1],"war3mapImported\\alpha.tga",0)
                    DzFrameSetText(BUTTON_Text[920+i],"")
                endif
            end
            DzFrameSetText(BUTTON_Text[920],"钻石x"+I2S(use))
        endif
    endfunction

    

    

    function AddUnitRune(unit wu,int id,int num)
        
        if  id == 'FY02'
            AddUnitRealState(wu,31,5*num)
            if  num == 1
                if  GetUnitIntState(wu,id) == 2
                    AddUnitRealState(wu,27,6)
                endif
            elseif  num == -1
                if  GetUnitIntState(wu,id) == 3
                    AddUnitRealState(wu,27,-6)
                endif
            endif
        elseif  id == 'FY03'
            AddUnitRealState(wu,75,5*num)
        endif

        AddUnitIntState(wu,id,num)
    endfunction

    function PlayerClickRunePrize(int pid,int index)
        int id = GetUnitIntState(Pu[1],910+index)
        if  id >= 'FY01' and id <= 'FY08'
            AddUnitRune(Pu[1],id,1)
            ReRuneFrame(pid)
        else
            BJDebugMsg("错误的符印")
        endif

        for i = 1,3
            SetUnitIntState(Pu[1],910+i,0)
        end

        if  GetLocalPlayer() == Player(pid)
            Button.show = false
        endif
    endfunction

    function GetNewRunePrize(int id1,int id2)->int
        int new = 'FY00'+GetRandomInt(1,8)
        loop
            exitwhen new != id1 and new != id2
            new = 'FY00'+GetRandomInt(1,8)
        endloop
        return new
    endfunction

    function GivePlayerRunePrizeFrame(int pid)
        int id = GetUnitIntState(Pu[1],911)
        
        if  id >= 'FY01' and id <= 'FY08'
            //给一个 防止上一个窗口残留
            AddUnitRune(Pu[1],id,1)
            ReRuneFrame(pid)
        endif

        int id1 = GetNewRunePrize(0,0)
        int id2 = GetNewRunePrize(id1,0)
        int id3 = GetNewRunePrize(id1,id2)

        SetUnitIntState(Pu[1],911,id1)
        SetUnitIntState(Pu[1],912,id2)
        SetUnitIntState(Pu[1],913,id3)
        
        PlayerRePrizeNum2 = 0

        if  GetLocalPlayer() == Player(pid)
            Button.show = true
            ReRunePrizeFrame(pid)
        endif
    endfunction


    function PlayerReRuneRandomPrize(int pid)->bool
        if  GetUnitIntState(Pu[1],911) > 0

            int id1 = GetNewRunePrize(0,0)
            int id2 = GetNewRunePrize(id1,0)
            int id3 = GetNewRunePrize(id1,id2)

            SetUnitIntState(Pu[1],911,id1)
            SetUnitIntState(Pu[1],912,id2)
            SetUnitIntState(Pu[1],913,id3)

            if  GetLocalPlayer() == Player(pid)
                Button.show = true
                ReRunePrizeFrame(pid)
            endif

            return true
        endif
        return false
    endfunction

    function BoxShowRePrize(int pid,int index)
        int use = 0
        DzFrameShow(UI_TipsHead, true)
        if  index == 1
            use = (PlayerRePrizeNum1 + 1) * 2
            if  use > 8
                use = 8
            endif
        elseif  index == 2
            use = (PlayerRePrizeNum2 + 1) * 2 
            if  use > 8
                use = 8
            endif
        endif
        if  GetPlayerFood(pid) >= use
            SetTipsData(1,"","需要 - 钻石x|cff00ff00"+I2S(use))
        else
            SetTipsData(1,"","需要 - 钻石x|cffff0000"+I2S(use))
        endif
        SetTipsData(10,"","点击刷新当前奖励")
        SetTipsData(11,""," ")
        SetTipsData(12,"","|cffffcc00当局钻石：|r"+I2S(PlayerFoodStart))
        SetTipsData(13,"","|cffffcc00签到钻石：|r"+I2S(PlayerFoodFree))
        SetTipsData(14,"","|cffffcc00特殊钻石：|r"+I2S(PlayerFoodShop))
        /*
        if  GameGiftBool[8] == false
            SetTipsData(15,""," ")
            SetTipsData(16,"","|cff00ff00输入mzrpg，奖励开局钻石x6！")
        endif
        */

        SetTipsData(15,"","|cffff0000切勿沉迷刷新！！！")
        ShowTipsUI()
    endfunction

    //刷新符印
    function ClickReRunePrizeFrame(int pid)
        int use = (PlayerRePrizeNum2+1)*2
        if  use > 8
            use = 8
        endif
        if  GetPlayerFood(pid) >= use
            PlayerRePrizeNum2 = PlayerRePrizeNum2 + 1
            if  PlayerReRuneRandomPrize(pid) == true    
                UsePlayerFood(pid,use)
                if  GetLocalPlayer() == Player(pid)
                    if  Frame2Id(LastFrame) == 920
                        BoxShowRePrize(pid,2)
                    endif
                endif
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r钻石不足|cffff0000"+I2S(use)+"|r，无法重置！")
        endif
    endfunction
    

    

    //重随英雄模块
    int array ReHeroPool[12][680]
    function GetReHeroPoolMax(int pid)->int
        return ReHeroPool[pid][0]
    endfunction
    function SetReHeroPoolMax(int pid,int max)
        ReHeroPool[pid][0] = max
    endfunction
    function AddReHeroPoolMax(int pid,int num)
        ReHeroPool[pid][0] = ReHeroPool[pid][0] + num
    endfunction

    function GetHeroPoolIndex(int pid,int id)->int
        int max = GetReHeroPoolMax(pid)
        if  max > 0
            for i = 1,max
                if  id == ReHeroPool[pid][i]
                    return i
                endif
            end
        endif
        return 0
    endfunction
    function IsPoolHasHero(int pid,int id)->bool
        return GetHeroPoolIndex(pid,id) != 0
    endfunction


    function ReReHeroFrameUI(int pid)
        int id = 0
        if  GetLocalPlayer() == Player(pid)
            for i = 1,8
                id = ReHeroPool[pid][i]
                if  id > 0
                    DzFrameSetTexture(BUTTON_Back[950+i][0],GetTypeIdIcon(id),0)
                    DzFrameSetText(BUTTON_Text[950+i],GetTypeIdName(id))
                else
                    DzFrameSetTexture(BUTTON_Back[950+i][0],"war3mapImported\\alpha.tga",0)
                    DzFrameSetText(BUTTON_Text[950+i],"")
                endif
            end
        endif
    endfunction

    private function PoolAdd(int pid,int id)
        int max = GetReHeroPoolMax(pid)+1
        SetReHeroPoolMax(pid,max) 
        ReHeroPool[pid][max] = id
        ReReHeroFrameUI(pid)
    endfunction
    private function PoolRemByIndex(int pid,int index)
        int max = GetReHeroPoolMax(pid)
        if  max == index
            ReHeroPool[pid][index] = 0
        else
            ReHeroPool[pid][index] = ReHeroPool[pid][max]
            ReHeroPool[pid][max] = 0
        endif
        SetReHeroPoolMax(pid,max-1)
        ReReHeroFrameUI(pid)
    endfunction
    function PoolAddHeroId(int pid,int id)
        if  IsPoolHasHero(pid,id) == false
            BJDebugMsg("增加"+GetTypeIdName(id))
            PoolAdd(pid,id)
        endif
    endfunction
    function PoolRemHeroId(int pid,int id)
        int index = GetHeroPoolIndex(pid,id)
        if  index != 0
            PoolRemByIndex(pid,index)
        endif
    endfunction

    

    function ReHeroFrameUI(int pid)
        if  GetLocalPlayer() == Player(pid)
            ReHeroNumber.SetText( I2S(HeroReNumber))
        endif

    endfunction

    function HeroHDFrameEsc()
        if  GetLocalPlayer() == DzGetTriggerUIEventPlayer()
            HeroHDFrame.show = false
        endif
    endfunction


    function InitExNativeFrame()
        int index = 0
        ReHeroBack = FRAME.create() //背景注册
        ReHeroButton = FRAME.create() //背景注册
        ReHeroNumber = FRAME.create() //背景注册
        HeroHDFrame =  FRAME.create() //背景注册
        HeroHDButton =  FRAME.create() //背景注册


        //控件设置
        ReHeroButton.frameid = FRAME.Tag("BUTTON","ReHero",GameUI,ReHeroButton)
        ReHeroButton.SetPoint(0,GameUI,0,0.13,-0.05)
        ReHeroButton.SetSize(0.173,0.142)
        //0.23

        //背景设置
        ReHeroBack.frameid = FRAME.Tag("BACKDROP","ReHero",ReHeroButton.frameid,ReHeroBack)
        ReHeroBack.SetPoint(4,ReHeroButton.frameid,4,0,0)
        ReHeroBack.SetSize(0.173,0.142)
        ReHeroBack.SetTexture("war3mapImported\\UI_ReHero_Back.tga",0)

        CreateButton(950,ReHeroButton.frameid,TYPE_BUTTON,7,ReHeroButton.frameid,7,0.0,0.01,0.1,0.028,"war3mapImported\\UI_ReHero_Button.tga")

        ReHeroNumber.frameid = FRAME.Fdf("text014",ReHeroButton.frameid,ReHeroNumber)
        ReHeroNumber.SetPoint(5,BUTTON_Back[950][0],5,-0.01,0)
        ReHeroNumber.SetText("1")

        for hx = 0,3
            for hy = 0,1
                index = hy * 4 + hx + 1
                CreateButton(950+index,ReHeroButton.frameid,TYPE_FUNC,0,ReHeroButton.frameid,0,0.01+0.04*hx,-0.01-hy*0.044,0.033,0.033,"war3mapImported\\alpha.tga")
                CreateText(950+index,ReHeroButton.frameid,"centertext008",1,7,0.0,-0.002,"")
            end
        end
        ReHeroButton.show = false



        HeroHDFrame.frameid = FRAME.Tag("BACKDROP","HeroHDFrame",GameUI,HeroHDFrame)
        HeroHDFrame.SetPoint(1,GameUI,1,0.0,-0.1)
        HeroHDFrame.SetSize(0.5,0.21)
        HeroHDFrame.SetTexture("war3mapImported\\UI_HeroHD.tga",0)
        HeroHDFrame.show = false

        HeroHDButton.frameid = FRAME.Tag("BUTTON","HeroHDButton",HeroHDFrame.frameid,HeroHDButton)
        HeroHDButton.SetPoint(4,HeroHDFrame.frameid,4,0.0,0.0)
        HeroHDButton.SetSize(0.5,0.21)
        DzFrameSetScript( HeroHDButton.frameid,1, "HeroHDFrameEsc" , true )



        
        for x = 0,2
            for y = 0,2
                index = y * 3 + x + 1
                if  index >= 1 and index <= 8
                    CreateButton(900+index,GameUI,TYPE_BUTTON,4,GameUI,6,0.142+x*0.028,0.08-y*0.028,0.024,0.024,"war3mapImported\\UI_Fuin_DisBack0"+I2S(index)+".tga")

                    DzFrameClearAllPoints(BUTTON_Back[900+index][1])
                    DzFrameSetPoint( BUTTON_Back[900+index][1], 4, BUTTON_Back[900+index][0], 8,-0.005, 0.005 )
                    DzFrameSetSize(BUTTON_Back[900+index][1],0.014,0.014)
                endif
            end
        end

        Button = FRAME.create() //背景注册
        Title = FRAME.create()  //注册标题
        Back = FRAME.create()   //注册主背景

        //控件设置
        Button.frameid = FRAME.Tag("BUTTON","Prize2",GameUI,Button)
        Button.SetPoint(4,GameUI,4,0,0)
        Button.SetSize(0.134,0.134)
        origin = Button.frameid

        //背景设置
        Back.frameid = FRAME.Tag("BACKDROP","Prize2",origin,Back)
        Back.SetPoint(4,origin,4,0,0)
        Back.SetSize(0.134,0.134)
        Back.SetTexture("war3mapImported\\UI_Prize_Back2.tga",0)


        for x = 0,2
            CreateButton(911+x,Button.frameid,TYPE_BUTTON,6,Button.frameid,6,0.005+x*0.042,0.034,0.04,0.060,"war3mapImported\\UI_Prize_ButtonBack0.tga")
            CreateButton(921+x,Button.frameid,TYPE_BUTTON,1,BUTTON_Back[911+x][0],1,0.0,-0.002,0.036,0.036,"war3mapImported\\alpha.tga")
            CreateText(921+x,Button.frameid,"centertext008",1,7,0.0,-0.005,"|cff999999物品名称|r")
        end
        CreateButton(910,Button.frameid,TYPE_CLOSE,2,Button.frameid,2,0.0,0.0,0.03,0.016,"war3mapImported\\UI_ESC.tga")

        CreateButton(920,Button.frameid,TYPE_BUTTON,7,Button.frameid,7,0.0,0.005,0.08,0.022,"war3mapImported\\UI_RePrize_Button.tga")
        CreateText(920,Button.frameid,"text008",3,4,0.005,0.0,"")
        
        Button.show = false
        


        Blood = FRAME.create() //背景注册
        
        Blood.frameid = FRAME.Tag("SPRITE","Blood",GameUI,Blood)
        Blood.SetPoint(4,GameUI,4,0,0)
        Blood.SetModel("war3mapImported\\UI_xueliangx.mdx",1,0)
        Blood.SetAnimate(0,true)
        Blood.SetSize(0.00001,0.00001)
        Blood.show = false

    endfunction
endlibrary


    