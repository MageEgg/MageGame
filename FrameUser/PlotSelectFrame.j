library PlotSelectFrame uses GameFrame,MagicItemCollectCode,PrizeFrame

    /*按钮序号
    300         时渊时间
    301-308     副本按钮
    309         时渊入场券
    310         刷新时渊
    311-318     副本图片
    321-328     奖励1
    331-338     奖励2

    */
    private FRAME Button = 0

    private FRAME Back = 0
    private FRAME Title = 0

    
    private int origin = 0

    //通用函数
    function ShowPlotFrame(int pid,bool show)

        if  GetLocalPlayer() == Player(pid)
            Button.show = show
        endif
    
    endfunction
    function GetPlotFrameShow()->bool
        return Button.show
    endfunction


    function ClosePlotFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            Button.show = false
        endif
    endfunction

    function ClickPlotFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            if  Button.show  == true
                Button.show = false
            else
                Button.show = true
            endif
        endif
    endfunction

    


//玩家数据获取
    //获取副本奖励id
    function GetPlayerPlotPrizeId(int pid,int index,int number)->int
        return Pint[310+index+number*10]
    endfunction

    //获取副本类型 0普通 1时渊
    function GetPlayerPlotType(int pid)->int
        return Pint[300]
    endfunction
    //获取时渊入场券
    function GetPlayerPlotPartNum(int pid)->int
        return Pint[309]
    endfunction
    //获取时渊刷新秒数
    function GetPlayerPlotReNum(int pid)->int
        return Pint[310]
    endfunction
    //获取副本当前状态 0未解锁 1已解锁 2已通关 3时渊
    function GetPlayerPlotStateByIndex(int pid,int index)->int
        return Pint[300+index]
        /*
        if  GetPlayerPlotType(pid) == 1
        return 3
        else
        endif
        */
    endfunction


    //获取副本图标
    function GetPlotIcon(int pid,int index)->string
        if  GetPlayerPlotType(pid) == 0
            return "war3mapImported\\UI_PlotSelect_FB"+I2S(index)+".tga"
        else
            return "war3mapImported\\UI_PlotSelect_FBEx"+I2S(index)+".tga"
        endif
    endfunction


    //设置副本当前状态 0未解锁 1已解锁 2已通关 3时渊
    function SetPlayerPlotStateByIndex(int pid,int index,int Type)
        Pint[300+index] = Type
    endfunction
    //设置副本奖励id
    function SetPlayerPlotPrizeId(int pid,int index,int number,int id)
        Pint[310+index+number*10] = id
    endfunction
    //设置副本类型 0普通 1时渊
    function SetPlayerPlotType(int pid,int Type)
        Pint[300] = Type
    endfunction
    //设置时渊入场券
    function SetPlayerPlotPartNum(int pid,int num)
        Pint[309] = num
        //BJDebugMsg("309 is "+I2S(num))
        if  GetLocalPlayer() == Player(pid)
            DzFrameSetText(BUTTON_Text[309],"时渊入场券 "+I2S(num))
        endif
    endfunction
    //设置时渊刷新秒数
    function SetPlayerPlotReNum(int pid,int num)
        Pint[310] = num
    endfunction
    


    
    //设置奖励按钮显示状态
    function SetPlotButtonShow(int index,bool show)
        
        DzFrameShow(BUTTON_Back[index+320][0],show)
        DzFrameShow(BUTTON_Back[index+330][0],show)
    endfunction

    //设置控件为未解锁
    function RePlotSelectState0(int pid,int index)
        DzFrameSetTexture(BUTTON_Back[index+310][0],"war3mapImported\\UI_PlotSelect_unlock.tga",0)
        SetPlotButtonShow(index,false)
    endfunction
    //设置控件为已解锁
    function RePlotSelectState1(int pid,int index)
        SetPlotButtonShow(index,true)
        DzFrameSetTexture(BUTTON_Back[index+310][0],GetPlotIcon(pid,index),0)
        DzFrameSetTexture(BUTTON_Back[index+320][0],GetTypeIdIcon(GetPlayerPlotPrizeId(pid,index,1)),0)
        DzFrameSetTexture(BUTTON_Back[index+330][0],GetTypeIdIcon(GetPlayerPlotPrizeId(pid,index,2)),0)
        
    endfunction
    //设置控件为已通关
    function RePlotSelectState2(int pid,int index)
        DzFrameSetTexture(BUTTON_Back[index+310][0],"war3mapImported\\UI_PlotSelect_finish.tga",0)
        SetPlotButtonShow(index,false)
    endfunction
    //设置控件为时渊
    function RePlotSelectState3(int pid,int index)
        DzFrameSetTexture(BUTTON_Back[index+310][0],GetPlotIcon(pid,index),0)
        DzFrameSetTexture(BUTTON_Back[index+320][0],GetTypeIdIcon(GetPlayerPlotPrizeId(pid,index,1)),0)
        DzFrameSetTexture(BUTTON_Back[index+330][0],"war3mapImported\\alpha.tga",0)
        SetPlotButtonShow(index,true)
    endfunction

    //刷新显示
    function RePlotSelectByIndex(int pid,int index)
        int state = GetPlayerPlotStateByIndex(pid,index)
        BJDebugMsg("state"+I2S(state))
        if  GetLocalPlayer() == Player(pid)
            if  state == 0
                RePlotSelectState0(pid,index)
            elseif  state == 1
                RePlotSelectState1(pid,index)
            elseif  state == 2
                RePlotSelectState2(pid,index)
            elseif  state == 3
                RePlotSelectState3(pid,index)
            endif
        endif
    endfunction



    function RePlayerPlotPrizeId(int pid)
        for i = 1,8
            SetPlayerPlotPrizeId(pid,i,1,'CF01')
            SetPlayerPlotPrizeId(pid,i,2,'IN32')
        end

        
    endfunction

    //刷新深渊模式奖励
    function RePlayerExPlotPrizeId(int pid,int index)
        int id1 = 0
        int id2 = 0

        int rid = GetPlayerPlotPrizeId(pid,index,1)
        int ran = GetRandomInt(1,100)
        if  rid > 0
            //回收
            RecoveryPrizePoolData(pid,10+GetTypeIdData(rid,101),rid)
        endif

    
        
        if  ran <= 85
            id1 = GetPrize(pid,13,true)
        else
            id1 = GetPrize(pid,12,true)
        endif

        
        SetPlayerPlotStateByIndex(pid,index,3)

        SetPlayerPlotPrizeId(pid,index,1,id1)
        SetPlayerPlotPrizeId(pid,index,2,0)
        RePlotSelectByIndex(pid,index)
    endfunction
    //玩家开启深渊模式
    function PlayerOpenExPlot(int pid)
        //设置为深渊
        if  GetPlayerPlotType(pid) == 0
            SetPlayerPlotType(pid,1)
            Title.SetTexture("war3mapImported\\UI_PlotSelect_Title2.tga",0)
            DzFrameShow(BUTTON_Back[310][0],true)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r所有副本已通关！为您开启时渊模式！")
        endif
        for i = 1,8
            RePlayerExPlotPrizeId(pid,i)
        end

    endfunction


    //刷新副本奖励
    function RePlayerAllExPlotPrize(int pid)
        int num = GetPlayerPlotReNum(pid)+1
        int use = num * 5

        if  GetPlayerState(Player(pid), PLAYER_STATE_RESOURCE_LUMBER)>=use
            AdjustPlayerStateBJ(-use, Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
            SetPlayerPlotReNum(pid,num)
            for i = 1,8
                RePlayerExPlotPrizeId(pid,i)
            end
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r时渊副本奖励重置成功！")
            if  GetLocalPlayer() == Player(pid)
                DzFrameShow(UI_TipsHead, true)
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r重置失败！玄铁不足"+I2S(use)+"|r")
        endif
        
    
    endfunction

    
    //解锁副本
    function PlayerUnLockPlot(int pid,int index)
        if  GetPlayerPlotStateByIndex(pid,index) == 0
            SetPlayerPlotStateByIndex(pid,index,1)
            RePlotSelectByIndex(pid,index)
        endif
    endfunction

    

    //读取奖励法宝池序号
    function GetPlotPrizeMagicIndex(int index)->int
        int ran = GetRandomInt(1,100)
        if  index == 1
            return 14
        elseif  index >= 2 and index <= 4
            BJDebugMsg("副本2-4概率"+I2S(ran))
            if  ran <= 80
                BJDebugMsg(I2S(index)+"副本概率"+I2S(ran)+"头顶带绿")
                return 14
            else
                BJDebugMsg(I2S(index)+"副本概率"+I2S(ran)+"出了个蓝")
                return 13
            endif
        else
            if  ran <= 10
                return 14
            elseif  ran<= 95
                return 13
            else
                return 12
            endif
        endif
        BJDebugMsg("副本序号"+I2S(index))
    endfunction

    //给玩家副本奖励
    function GivePlayerFinishPlotPrize(int pid,int index)
        int Type = GetPlayerPlotStateByIndex(pid,index)
        int id1 = 0
        int id2 = 0
        int id3 = 0
        int id4 = 0
        int id5 = 0

        int prizeid = GetPlotPrizeMagicIndex(index)

        if  Type == 3
            BJDebugMsg("时渊奖励")
            id1 = GetPlayerPlotPrizeId(pid,index,1)
            id2 = GetPlayerPlotPrizeId(pid,index,2)
        else
            BJDebugMsg("普通奖励")
            id1 = GetPlayerPlotPrizeId(pid,index,1)
            id2 = GetPlayerPlotPrizeId(pid,index,2)
            id3 = GetPrize(pid,prizeid,true)
            id4 = GetPrize(pid,prizeid,true)
            if  GameLevel >= 3
                id5 = GetPrize(pid,prizeid,true)
            endif
        endif

        GivePlayerPrize(pid,id1,id2,id3,id4,id5)

        SetPlayerPlotPrizeId(pid,index,1,0)
        SetPlayerPlotPrizeId(pid,index,2,0)

        MissionAddNumFunc(pid,4,1)//完成副本
        MissionAddNumFunc(pid,15,1)//完成副本
        MissionAddNumFunc(pid,30,1)//完成副本
    endfunction

    //完成副本
    function PlayerFinishPlot(int pid,int index)
        int Type = GetPlayerPlotStateByIndex(pid,index)
        SetPlayerPlotStateByIndex(pid,index,2)
        if  Type == 1
            
            
            //发奖励
            GivePlayerFinishPlotPrize(pid,index)
            RePlotSelectByIndex(pid,index)

            if  index == 8
                PlayerOpenExPlot(pid)
            else
                PlayerUnLockPlot(pid,index+1)
            endif

        elseif  Type  == 3
            
            GivePlayerFinishPlotPrize(pid,index)
            
            //RePlayerExPlotPrizeId(pid,index)

            RePlotSelectByIndex(pid,index)
        
        endif
        if  GetLocalPlayer() == Player(pid)
            Button.show = false
        endif
    endfunction

    
    function PlayerTestPlot(int pid,int index)
        int Type = GetPlayerPlotStateByIndex(pid,index)
        if  Type == 0 and index == 1
            PlayerUnLockPlot(pid,index)
        elseif  Type  == 1
            PlayerFinishPlot(pid,index)
        elseif  Type  == 3
            if  GetPlayerPlotPartNum(pid) > 0
                PlayerFinishPlot(pid,index)
            endif
        endif
    endfunction
    

    



    function CreatePlotSelectButton()
        int index = 0
        for x = 0,3
            for y = 0,1
                index = y * 4 + x + 1
                CreateButton(index+300,Button.frameid,TYPE_FUNC,0,Button.frameid,0,0.01+x*0.081,-0.01-y*0.120,0.076,0.115,"war3mapImported\\UI_PlotSelect_FBBack.tga")


                CreateButton(index+310,Button.frameid,TYPE_FUNC,0,BUTTON_Back[index+300][0],0,0.001,-0.001,0.074,0.073,"war3mapImported\\UI_PlotSelect_unlock.tga")

                CreateButton(index+320,Button.frameid,TYPE_BUTTON,6,BUTTON_Back[index+300][0],6,0.0025,0.0025,0.033,0.033,"war3mapImported\\alpha.tga")
                CreateButton(index+330,Button.frameid,TYPE_BUTTON,8,BUTTON_Back[index+300][0],8,-0.0025,0.0025,0.033,0.033,"war3mapImported\\alpha.tga")

                
                DzFrameShow(BUTTON_Back[index+320][0],false)
                DzFrameShow(BUTTON_Back[index+330][0],false)
            end
        end
        CreateButton(309,Button.frameid,TYPE_BUTTON,8,Button.frameid,8,-0.01,0.01,0.076,0.021,"war3mapImported\\UI_PlotSelect_Resources.tga")
        CreateText(309,Button.frameid,"righttext010",5,5,-0.005,0.0,"时渊入场券 0")

        CreateButton(310,Button.frameid,TYPE_BUTTON,5,BUTTON_Back[309][0],3,-0.005,0.0,0.075,0.021,"war3mapImported\\UI_PlotSelect_Refresh.tga")
        DzFrameShow(BUTTON_Back[310][0],false)
        
        //CreateButton(300,Button.frameid,TYPE_NULL,7,Button.frameid,7,0.0,0.0,0.01,0.01,"war3mapImported\\alpha.tga")
        //CreateText(300,Button.frameid,"centertext012",7,7,0.0,0.01,"1:59\n|cff999999奖励重置倒计时|r")
    endfunction

    function PlotSelectFrameInit()

        Button = FRAME.create() //背景注册
        Title = FRAME.create()  //注册标题
        Back = FRAME.create()   //注册主背景


        //控件设置
        Button.frameid = FRAME.Tag("BUTTON","Plot",GameUI,Button)
        Button.SetPoint(4,GameUI,4,0,0)
        Button.SetSize(0.339,0.29)
        origin = Button.frameid

        //背景设置
        Back.frameid = FRAME.Tag("BACKDROP","Plot",origin,Back)
        Back.SetPoint(4,origin,4,0,0)
        Back.SetSize(0.339,0.29)
        Back.SetTexture("war3mapImported\\UI_PlotSelect_Back.tga",0)

        //标题设置
        Title.frameid = FRAME.Tag("BACKDROP","Plot",origin,Back)
        Title.SetTexture("war3mapImported\\UI_PlotSelect_Title.tga",0)
        Title.SetPoint(6,origin,6,0.01,0.01)
        Title.SetSize(0.145,0.026)

        
        
        CreatePlotSelectButton()

        

        RePlayerPlotPrizeId(0)
        RePlayerPlotPrizeId(1)
        RePlayerPlotPrizeId(2)
        RePlayerPlotPrizeId(3)

        Button.show = false
    endfunction





endlibrary
