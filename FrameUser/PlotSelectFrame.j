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
        if  InGameWuJin == 0
            if  GetLocalPlayer() == Player(pid)
                if  Button.show  == true
                    Button.show = false
                else
                    Button.show = true
                endif
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r无尽开始后无法进入副本！")
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

    function GetNowOverPlotIndex(int pid)->int
        for i = 1,8
            if  GetPlayerPlotStateByIndex(pid,9-i) == 2
                return 9-i
            endif
        end
        return 1
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
        //DzFrameShow(BUTTON_Back[index+330][0],show)
    endfunction

    //设置控件为未解锁
    function RePlotSelectState0(int pid,int index)
        
        DzFrameSetTexture(BUTTON_Back[index+300][0],"war3mapImported\\UI_fuben"+I2S(index)+"locked.tga",0)
        DzFrameSetTexture(BUTTON_Back[index+310][0],"war3mapImported\\UI_PlotSelect_unlock.tga",0)
        SetPlotButtonShow(index,false)
    endfunction
    //设置控件为已解锁
    function RePlotSelectState1(int pid,int index)
        SetPlotButtonShow(index,true)
        DzFrameSetTexture(BUTTON_Back[index+300][0],"war3mapImported\\UI_PlotSelect_FBBack.tga",0)
        DzFrameSetTexture(BUTTON_Back[index+310][0],GetPlotIcon(pid,index),0)
        DzFrameSetTexture(BUTTON_Back[index+320][0],GetTypeIdIcon(GetPlayerPlotPrizeId(pid,index,1)),0)
        //DzFrameSetTexture(BUTTON_Back[index+330][0],GetTypeIdIcon(GetPlayerPlotPrizeId(pid,index,2)),0)
        
    endfunction
    //设置控件为已通关
    function RePlotSelectState2(int pid,int index)
        DzFrameSetTexture(BUTTON_Back[index+300][0],"war3mapImported\\UI_PlotSelect_FBBack.tga",0)
        DzFrameSetTexture(BUTTON_Back[index+310][0],"war3mapImported\\UI_PlotSelect_finish.tga",0)
        SetPlotButtonShow(index,false)
    endfunction
    //设置控件为时渊
    function RePlotSelectState3(int pid,int index)
        DzFrameSetTexture(BUTTON_Back[index+300][0],"war3mapImported\\UI_PlotSelect_FBBack.tga",0)
        DzFrameSetTexture(BUTTON_Back[index+310][0],GetPlotIcon(pid,index),0)
        DzFrameSetTexture(BUTTON_Back[index+320][0],GetTypeIdIcon(GetPlayerPlotPrizeId(pid,index,1)),0)
        //DzFrameSetTexture(BUTTON_Back[index+330][0],"war3mapImported\\alpha.tga",0)
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
            //SetPlayerPlotPrizeId(pid,i,2,'IN32')
        end

        
    endfunction


    function GetNotNullPrize(int pid,int id)->int
        int max = GetPrizePoolMax(pid,id)
        if  max == 0
            if  id == 12
                return GetNotNullPrize(pid,14)
            else
                return GetNotNullPrize(pid,id - 1)
            endif
        endif
        return id
    endfunction

    //读取时渊奖励法宝池序号
    function GetExPlotPrizeMagicIndex(int pid)->int
        int ran = GetRandomInt(1,100)
        int prizeid = 0
        if  ran <= 30
            prizeid = 14
        elseif  ran <= 80
            prizeid = 13
        else
            prizeid = 12
        endif

        prizeid = GetNotNullPrize(pid,prizeid)

        return prizeid
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

        id1 = GetPrize(pid,GetExPlotPrizeMagicIndex(pid),true)
        
        
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
        int use = 15

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
    function GetPlotPrizeMagicIndex(int pid,int index,real r)->int
        int prizeid = 0

        real ran = GetRandomInt(1,100)
        real cj = 1.0
        real add = 0

        real green = 60
        real zi = index * 3
        real blue = 100 - zi - green

        

        if  GameSaveClose == 0
            if  GetPlayerTechCount(Player(pid),'RG1C',true)>0
                add = add + 0.15
            endif
            if  GetPlayerTechCount(Player(pid),'RG1E',true)>0
                add = add + 0.15
            endif
            if  GetPlayerTechCount(Player(pid),'RG1G',true)>0
                add = add + 0.15
            endif
            if  GetPlayerTechCount(Player(pid),'RSHF',true)>0
                add = add + 0.15
            endif
            if  GetPlayerTechCount(Player(pid),'RSHG',true)>0
                add = add + 0.06
            endif
            if  GetPlayerTechCount(Player(pid),'RGBG',true)>0
                add = add + 0.05
            endif
            if  GetPlayerTechCount(Player(pid),'RGDB',true)>0
                add = add + 0.05
            endif
            if  GetPlayerTechCount(Player(pid),'RGDD',true)>0
                add = add + 0.05
            endif
            if  GetPlayerTechCount(Player(pid),'RGDF',true)>0
                add = add + 0.05
            endif
        else
            add = 0.5
        endif
        
        
        cj = cj + add * r
        

        blue = blue *cj
        zi = zi * cj
        green = 100-blue-zi

        BJDebugMsg("法宝加成:"+R2S(cj*100)+"%")
        BJDebugMsg("法宝概率:绿"+R2S(green)+"%")
        BJDebugMsg("法宝概率:蓝"+R2S(blue)+"%")
        BJDebugMsg("法宝概率:紫"+R2S(zi)+"%")

        if  ran <= green
            prizeid = 15
        elseif  ran <= 100-zi
            prizeid = 14
        else
            prizeid = 13
        endif

        if  prizeid == 15
            if  GetPrizePoolMax(pid,15) == 0
                prizeid = 14
            endif
        endif
        if  prizeid == 14
            if  GetPrizePoolMax(pid,14) == 0
                prizeid = 13
            endif
        endif
        if  prizeid == 13
            if  GetPrizePoolMax(pid,13) == 0
                prizeid = 12
            endif
        endif

        if  GameWuJin == 1 and prizeid == 15
            prizeid = 14
        endif

        return prizeid
    endfunction


    //刷新副本
    function PlayerReRandomPrize(int pid,real r)->bool
        int rid = 0
        int index = GetNowOverPlotIndex(pid)

        int id3 = 0
        int id4 = 0
        int id5 = 0
        BJDebugMsg("当前副本"+I2S(index))
        //if  Pint[300] == 0
            if  GetUnitIntState(Pu[1],403) > 0
                for i = 1,3
                    rid = GetUnitIntState(Pu[1],402+i)
                    if  rid > 0
                        
                        RecoveryPrizePoolData(pid,10+GetTypeIdData(rid,101),rid)
                        SetUnitIntState(Pu[1],402+i,0)
                    endif
                end
                
                id3 = GetPrize(pid,GetPlotPrizeMagicIndex(pid,index,r),true)
                id4 = GetPrize(pid,GetPlotPrizeMagicIndex(pid,index,r),true)
                if  GameLevel >= 3
                    id5 = GetPrize(pid,GetPlotPrizeMagicIndex(pid,index,r),true)
                endif
                GivePlayerPrize(pid,'CF01',0,id3,id4,id5)

                return true
            endif
        //endif
        return false
    endfunction


    //钻石刷新副本

    
    function ClickRePrizeFrame(int pid)
        int use = (PlayerRePrizeNum1+1)*2
        if  use > 8
            use = 8
        endif
        if  GetPlayerFood(pid) >= use
            PlayerRePrizeNum1 = PlayerRePrizeNum1 + 1
            BJDebugMsg("刷副本次数"+I2S(PlayerRePrizeNum1))
            if  PlayerReRandomPrize(pid,0.5) == true    
                UsePlayerFood(pid,use)
                if  GetLocalPlayer() == Player(pid)
                    if  Frame2Id(LastFrame) == 420
                        BoxShowRePrize(pid,1)
                    endif
                endif
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r钻石不足|cffff0000"+I2S(use)+"|r，无法重置！")
        endif
    endfunction




    //给玩家副本奖励
    function GivePlayerFinishPlotPrize(int pid,int index)
        int Type = GetPlayerPlotStateByIndex(pid,index)
        int id1 = 0
        int id2 = 0
        int id3 = 0
        int id4 = 0
        int id5 = 0

        //int prizeid = GetPlotPrizeMagicIndex(index)
        BJDebugMsg("Type is "+I2S(Type))
        if  Type == 3
            BJDebugMsg("时渊奖励")
            id1 = GetPlayerPlotPrizeId(pid,index,1)
            //id2 = GetPlayerPlotPrizeId(pid,index,2)
        else
            BJDebugMsg("普通奖励")
            id1 = GetPlayerPlotPrizeId(pid,index,1)
            //id2 = GetPlayerPlotPrizeId(pid,index,2)
            id3 = GetPrize(pid,GetPlotPrizeMagicIndex(pid,index,1.0),true)
            id4 = GetPrize(pid,GetPlotPrizeMagicIndex(pid,index,1.0),true)
            if  GameLevel >= 3
                id5 = GetPrize(pid,GetPlotPrizeMagicIndex(pid,index,1.0),true)

                if  index == 3 and GameLevel >= 4
                    if  GetMagicItemMaxColor(pid) > 3
                        BJDebugMsg("前2副本没有紫")
                        if  GetTypeIdData(id3,101) > 3 and GetTypeIdData(id4,101) > 3 and GetTypeIdData(id5,101) > 3
                            BJDebugMsg("新奖励中没有紫")
                            RecoveryPrizePoolData(pid,10+GetTypeIdData(id3,101),id3)
                            BJDebugMsg("回收第一格法宝")
                            id3 = GetPrize(pid,13,true)
                        else
                            BJDebugMsg("新奖励中有紫,跳过")
                        endif
                    else
                        BJDebugMsg("前2本出紫了,不管了")
                    endif
                endif
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
        
        //LocAddEffect(GetUnitX(Pu[1]),GetUnitY(Pu[1]),"effectex_MissionComplete.mdl")
        if  Type == 1
            
            
            //发奖励
            GivePlayerFinishPlotPrize(pid,index)
            

            if  index == 8
                PlayerOpenExPlot(pid)
            else
                //PlayerUnLockPlot(pid,index+1)
                SetPlayerPlotStateByIndex(pid,index,2)
                RePlotSelectByIndex(pid,index)
            endif

            SetPlayerTechResearched(Player(pid),'RF0A'+index-1,1)
            

        elseif  Type  == 3
            
            GivePlayerFinishPlotPrize(pid,index)
            
            SetPlayerPlotPartNum(pid,GetPlayerPlotPartNum(pid)-1)

            SetPlayerPlotStateByIndex(pid,index,2)
            RePlotSelectByIndex(pid,index)
            
            //RePlayerExPlotPrizeId(pid,index)

        
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
                CreateButton(index+300,Button.frameid,TYPE_FUNC,0,Button.frameid,0,0.01+x*0.081,-0.01-y*0.120,0.076,0.115,"war3mapImported\\UI_fuben"+I2S(index)+"locked.tga")


                CreateButton(index+310,Button.frameid,TYPE_FUNC,0,BUTTON_Back[index+300][0],0,0.001,-0.001,0.074,0.073,"war3mapImported\\alpha.tga")

                CreateButton(index+320,Button.frameid,TYPE_BUTTON,7,BUTTON_Back[index+300][0],7,0.0,0.0025,0.033,0.033,"war3mapImported\\alpha.tga")
                //CreateButton(index+330,Button.frameid,TYPE_BUTTON,8,BUTTON_Back[index+300][0],8,-0.0025,0.0025,0.033,0.033,"war3mapImported\\alpha.tga")

                
                DzFrameShow(BUTTON_Back[index+320][0],false)
                //DzFrameShow(BUTTON_Back[index+330][0],false)
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
