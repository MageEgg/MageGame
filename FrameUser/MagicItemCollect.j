library MagicItemCollectFrame uses GameFrame

    /*按钮序号
    1-8    法宝按钮
    9-17
    21      重铸
    22      锻造
    23      补天石  ui\\widgets\\escmenu\\human\\alliance-gold.blp
    24      鸿蒙结晶ui\\widgets\\escmenu\\human\\alliance-lumber.blp
    51-75   羁绊按钮
    */

    private FRAME Button = 0
    private FRAME Back = 0

    private FRAME BackSmall = 0
    
    private int origin = 0

    
    
    

    function ShowCollectFrame(int pid,bool show)

        if  GetLocalPlayer() == Player(pid)
            Button.show = show
            BackSmall.show = show == false
        endif
    
    endfunction
    function GetCollectFrameShow()->bool
        return Button.show
    endfunction

    function CloseCollectFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            Button.show = false
            BackSmall.show = true
        endif
    endfunction

    function ClickCollectFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            if  Button.show  == true
                Button.show = false
                BackSmall.show = true
            else
                Button.show = true
                BackSmall.show = false
            endif
        endif
    endfunction



    function CreateMagicItemButton1()
        int index = 0
        for y = 0,1
            for x = 0,3
                index = y*4+x+1
                
                CreateButton(index,Button.frameid,TYPE_BUTTON,0,Button.frameid,0,0.01+x*0.042,-0.035-y*0.042,0.038,0.038,"war3mapImported\\UI_MagicItem_Button1.tga")
                //CreateText(index,Button.frameid,"righttext008",8,8,0.0,0.0,I2S(index))


                
            end
        end

    endfunction

    function CreateMagicItemButton2()
        int index = 0
        for y = 0,2
            for x = 0,2
                index = y*3+x+9
                
                CreateButton(index,Button.frameid,TYPE_BUTTON,0,Back.frameid,0,0.19+x*0.031,-0.035-y*0.031,0.028,0.028,"war3mapImported\\UI_MagicItem_Button1.tga")
                //CreateText(index,Button.frameid,"righttext008",8,8,0.0,0.0,I2S(index))
            end
        end

    endfunction

    function CreateMagicItemButton3()
        int index = 0
        
        for y = 0,1
            for x = 0,3
                index = y*4+x+ 1 + 50
                
                CreateButton(index,Button.frameid,TYPE_BUTTON,0,Button.frameid,0,0.01+x*0.042,-0.145-y*0.025,0.019,0.019,"war3mapImported\\alpha.tga")

                DzFrameClearAllPoints( BUTTON_Back[index][2])
                DzFrameSetPoint( BUTTON_Back[index][2], 3, BUTTON_Back[index][0], 5,0 , 0 )

                CreateText(index,Button.frameid,"centertext008",4,4,0.019,0.0,"")
            end
        end
        
    endfunction

    function CreateMagicItemButton4()
        int index = 0
        
        for y = 0,1
            for x = 0,3
                index = y*4+x+ 1 + 30
                
                CreateButton(index,BackSmall.frameid,TYPE_BUTTON,0,BackSmall.frameid,0,0.046+x*0.02,-0.0055-y*0.02,0.018,0.018,"war3mapImported\\UI_MagicItem_Button1.tga")
                
            end
        end
    endfunction
    



    function MagicItemFrameInit()


        Button = FRAME.create() //背景注册
        Back = FRAME.create()   //注册主背景



        BackSmall.frameid = FRAME.Tag("BACKDROP","Collect",GameUI,BackSmall)
        BackSmall.SetPoint(0,GameUI,0,0.05,-0.027)
        BackSmall.SetSize(0.13,0.048)
        BackSmall.SetTexture("war3mapImported\\UI_MagicItem_SmallBack.tga",0)
        //创建small按钮
        CreateMagicItemButton4()


        //控件设置
        Button.frameid = FRAME.Tag("BUTTON","Collect",GameUI,Button)
        Button.SetPoint(4,GameUI,4,0,0)
        Button.SetSize(0.29,0.2)
        origin = Button.frameid
        //背景设置
        Back.frameid = FRAME.Tag("BACKDROP","Collect",origin,Back)
        Back.SetPoint(4,origin,4,0,0)
        Back.SetSize(0.29,0.2)
        Back.SetTexture("war3mapImported\\UI_MagicItem_Back.tga",0)




        //创建法宝按钮
        CreateMagicItemButton1()

        //创建法宝仓库
        CreateMagicItemButton2()
        //创建羁绊按钮
        CreateMagicItemButton3()

        CreateButton(21,Button.frameid,TYPE_BUTTON,8,Back.frameid,8,-0.061,0.01,0.04,0.022,"war3mapImported\\UI_MagicItem_Recast.tga")
        CreateButton(22,Button.frameid,TYPE_BUTTON,8,Back.frameid,8,-0.01,0.01,0.04,0.022,"war3mapImported\\UI_MagicItem_Forge.tga")

        CreateButton(23,Button.frameid,TYPE_BUTTON,7,BUTTON_Back[21][0],1,0.0,0.008,0.04,0.02,"war3mapImported\\UI_MagicItem_Resources1.tga")
        CreateButton(24,Button.frameid,TYPE_BUTTON,7,BUTTON_Back[22][0],1,0.0,0.008,0.04,0.02,"war3mapImported\\UI_MagicItem_Resources2.tga")
        CreateText(23,Button.frameid,"righttext008",5,5,-0.005,0.0,"0")
        CreateText(24,Button.frameid,"righttext008",5,5,-0.005,0.0,"0")



        


        Button.show = false


        
    endfunction
    
endlibrary


library MagicItemCollectCode uses MagicItemCollectFrame
    #define MagicItemMax 17
    #define MagicItemStateMax 40
    #define MagicItemIndex 200
    #define MagicItemStateIndex 250

    //根据序号获取羁绊id
    function GetMagicStateId(int index)->int
        int n1 = index - (index / 10)* 10
        int n2 = (index - n1) / 10
        return 'FJ00' + n1 + n2 * 0x100
    endfunction

    

    //获取法宝内资源数量
    function GetPlayerMagicItemResources(int pid,int index)->int
        return GetUnitIntState(Pu[1],240+index)
    endfunction

    //获取补天石数量
    function GetPlayerMagicItemResources1(int pid)->int
        return GetPlayerMagicItemResources(pid,1)
    endfunction
    //获取鸿蒙结晶数量
    function GetPlayerMagicItemResources2(int pid)->int
        return GetPlayerMagicItemResources(pid,2)
    endfunction

    //设置法宝内资源数量
    function SetPlayerMagicItemResources(int pid,int index,int num)
        SetUnitIntState(Pu[1],240+index,num)
    endfunction
    //设置补天石数量
    function SetPlayerMagicItemResources1(int pid,int num)
        SetPlayerMagicItemResources(pid,1,num)
    endfunction
    //设置鸿蒙结晶数量
    function SetPlayerMagicItemResources2(int pid,int num)
        SetPlayerMagicItemResources(pid,2,num)
    endfunction
    
    //获取最后点击的按钮
    function GetPlayerMagicItemLast(int pid)->int
        return GetUnitIntState(Pu[1],250)
    endfunction
    //设置最后点击的按钮
    function SetPlayerMagicItemLast(int pid,int index)
        int last = GetPlayerMagicItemLast(pid)
        if  last > 0
            DzFrameSetTexture(BUTTON_Back[last][3],"war3mapImported\\alpha.tga",0)
        endif
        if  index > 0
            DzFrameSetTexture(BUTTON_Back[index][3],"war3mapImported\\UI_ButtonSelect.tga",0)
        endif
        SetUnitIntState(Pu[1],250,index)
    endfunction

    //获取对应法宝
    function GetPlayerMagicItem(int pid,int index)->int
        return GetUnitIntState(Pu[1],MagicItemIndex+index)
    endfunction


    //获取羁绊数量
    function GetPlayerMagicCollectNum(int pid,int index)->int
        return GetUnitIntState(Pu[1],MagicItemStateIndex+index)
    endfunction
    //获取羁绊最低需求
    function GetMagicCollectMinUse(int id)->int
        return GetTypeIdData(id,121)
    endfunction

    //获取羁绊最高数量需求
    function GetMagicCollectMaxUse(int id)->int
        int use = 0
        for i = 1,3
            use = GetTypeIdData(id,124-i)
            if  use > 0
                return use
            endif
        end
        return 0
    endfunction



    //根据羁绊栏序号 获取羁绊index
    function GetMagicFrameStateIndex(int pid,int fid)->int
        int id = 0
        int n = 0
        int num = 0
        int min = 0
        for index = 1,MagicItemStateMax
            id = GetMagicStateId(index)//获取羁绊id
            min = GetMagicCollectMinUse(id)//获取最小需求
            num = GetPlayerMagicCollectNum(pid,index)//获取羁绊数量
            if  num >= min and num > 0
                n = n + 1
                if  n == fid
                    return index
                endif
            endif
        end
        return 0
    endfunction


    //读取法宝背包空位
    function GetMagicItemNullIndex(int pid)->int
        for index = 1,MagicItemMax
            if  GetPlayerMagicItem(pid,index) == 0
                return index
            endif
        end
        return 0
    endfunction



    //鼠标UI显示类代码
    //获取法宝品质名称
    function GetMagicItemColorName(int id)->string
        int color = GetTypeIdData(id,101)
        if  color == 1
            return "|cffff0000造化至宝|r"
        elseif  color == 2
            return "|cffffcc00先天神器|r"
        elseif  color == 3
            return "|cff9cc3e6后天仙器|r"
        elseif  color == 4
            return "|cffa9d18d通天灵宝|r"
        endif
        return ""
    endfunction
    //获取法宝名称
    function GetMagicItemName(int id)->string
        int color = GetTypeIdData(id,101)
        if  color == 1
            return "|cffff0000造化至宝-"+ GetTypeIdName(id) + "|r"
        elseif  color == 2
            return "|cffffcc00先天神器-"+ GetTypeIdName(id) + "|r"
        elseif  color == 3
            return "|cff9cc3e6后天仙器-"+ GetTypeIdName(id) + "|r"
        elseif  color == 4
            return "|cffa9d18d通天灵宝-"+ GetTypeIdName(id) + "|r"
        endif
        return ""
    endfunction
    
    

    //获取法宝附加名称
    function GetMagicItemStateAllName(int id)->string
        string s = ""
        int n = 0
        for i = 1,10
            n = GetTypeIdData(id,110+i)
            if  n > 0
                return GetTypeIdName(GetMagicStateId(n))
            endif
            
        end
        return s
    endfunction

    

    //根据数量获取法宝羁绊等级说明
    function GetMagicItemCollectLevelTips(int id,int num)->string
        string s = ""
        int use = 0

        
        for i = 1,3
            use = GetTypeIdData(id,124-i)
            if  use > 0
                if  num >= use
                    return GetTypeIdString(id,124-i)
                endif
            endif
        end
        
        return GetTypeIdString(id,120)
    endfunction

    //获取羁绊说明
    function GetMagicItemCollectTips(int pid,int id)->string
        string s = ""
        int num = 0
        int value = 0
        for i = 1,10
            num = 0
            value = GetTypeIdData(id,110+i)
            if  value > 0
                num = GetUnitIntState(Pu[1],MagicItemStateIndex+value)
                s =  s + "\n" + GetMagicItemCollectLevelTips(GetMagicStateId(value),num) + "\n"
            endif
        end
        return "\n|cff999999羁绊|r" + s
    endfunction

    
    function BoxShowMagicItemPublic(int pid,int id)
        int h = 10
        int value = 0
        if  id > 0
            DzFrameShow(UI_TipsHead, true)
            

            SetTipsData(1,"GetTypeIdIcon(id)","["+GetMagicItemStateAllName(id)+"]"+GetTypeIdName(id))

            SetTipsData(10,"",GetMagicItemColorName(id))
            if  GetTypeIdTips(id) == ""
                SetTipsData(11,"","|cff999999基础属性|r" + GetTypeIdStateTips(id))
            else
                SetTipsData(11,"","|cff999999基础属性|r" + GetTypeIdStateTips(id)+"\n"+GetTypeIdTips(id))
            endif
            
            if  id == 'FB17'
                value = GetUnitIntState(Pu[1],'FC17')
                SetTipsData(12,"","|cff00ff00当前层数："+I2S(value))
                h = 13
            elseif  id == 'FB32'
                value = GetUnitIntState(Pu[1],'FC32')
                SetTipsData(12,"","|cff00ff00当前层数："+I2S(value))
                h = 13
            elseif  id == 'FB03'
                value = GetUnitIntState(Pu[1],'FC03')
                SetTipsData(12,"","|cff00ff00当前层数："+I2S(value))
                h = 13
            else
                h = 12
            endif
            

            SetTipsData(h,"",GetMagicItemCollectTips(pid,id))


            ShowTipsUI()
        endif
    endfunction

    //法宝栏box
    function BoxShowMagicItem(int pid,int fid)
        int id = GetPlayerMagicItem(pid,fid)
        
        BoxShowMagicItemPublic(pid,id)
        
    endfunction

    //羁绊栏box
    function BoxShowMagicCollect(int pid,int index)
        int use = 0
        int id = GetMagicStateId(index)
        int h = 10
        int last = 0
        
        if  id > 0
            
            DzFrameShow(UI_TipsHead, true)

            int num = GetPlayerMagicCollectNum(pid,index)
            int max = GetMagicCollectMaxUse(id)

            SetTipsData(1,"",GetTypeIdName(id)+" ("+I2S(num)+ "/"+I2S(max)+")")

            

            for i = 1,3
                use = GetTypeIdData(id,120+i)
                if  use > 0
                    if  num >= use
                        last = i
                    endif
                endif
            end
            for i = 1,3
                use = GetTypeIdData(id,120+i)
                if  use > 0
                    if  i == last
                        SetTipsData(h,"","|cff00cc33"+I2S(use)+"："+GetTypeIdString(id,130+i))
                    else
                        SetTipsData(h,"","|cff999999"+I2S(use)+"："+GetTypeIdString(id,130+i))
                    endif
                    
                    h = h + 1
                endif
            end

            ShowTipsUI()
        endif
    endfunction


    //UI显示

    //刷新背包显示
    function ReCollectFrameItem(int pid)
        int id = 0
        for index = 1,MagicItemMax
            id = GetPlayerMagicItem(pid,index)
            if  id > 0
                DzFrameSetTexture(BUTTON_Back[index][1],GetTypeIdIcon(id),0)
                if  index <= 8
                    DzFrameSetTexture(BUTTON_Back[30+index][1],GetTypeIdIcon(id),0)
                endif
            else
                DzFrameSetTexture(BUTTON_Back[index][1],"war3mapImported\\alpha.tga",0)
                if  index <= 8
                    DzFrameSetTexture(BUTTON_Back[30+index][1],"war3mapImported\\alpha.tga",0)
                endif
            endif
        end
    endfunction

    

    //刷新羁绊显示
    function ReCollectFrameState(int pid)
        int id = 0
        int n = 0
        int num = 0
        int min = 0
        for f = 1,8
            DzFrameSetTexture(BUTTON_Back[f+50][1],"war3mapImported\\alpha.tga",0)
            DzFrameSetTexture(BUTTON_Back[f+50][2],"war3mapImported\\alpha.tga",0)
            DzFrameSetText(BUTTON_Text[f+50],"")
        end

        for index = 1,MagicItemStateMax
            id = GetMagicStateId(index)
            num = GetPlayerMagicCollectNum(pid,index)
            min = GetMagicCollectMinUse(id)
            if  min != 0
                if  num >= min
                    n = n + 1
                    DzFrameSetTexture(BUTTON_Back[n+50][1],GetTypeIdIcon(id),0)
                    DzFrameSetTexture(BUTTON_Back[n+50][2],"war3mapImported\\UI_MagicItem_Button2.tga",0)
                    DzFrameSetText(BUTTON_Text[n+50],I2S(num))
                endif
            endif
        end
    endfunction

    //刷新法宝UI资源显示
    function ReCollectFrameResources(int pid)
        DzFrameSetText(BUTTON_Text[23],I2S(GetPlayerMagicItemResources(pid,1)))
        DzFrameSetText(BUTTON_Text[24],I2S(GetPlayerMagicItemResources(pid,2)))
    endfunction

    //刷新法宝UI显示
    function ReCollectFrame(int pid)
        

        if  GetLocalPlayer() == Player(pid)

            ReCollectFrameItem(pid)

            ReCollectFrameState(pid)

            ReCollectFrameResources(pid)
        endif

    endfunction


    //判断是否唯一
    function IsMagicItemOnly(int pid,int n)->bool
        int id = 0
        int only = GetPlayerMagicItem(pid,n)

        for index = 1,MagicItemMax
            id = GetPlayerMagicItem(pid,index)
                
            if  id > 0 and index != n
                if  id == only
                    return false
                endif
            endif
            
        end
        return true
    endfunction

    function RePlayerMagicOtherState(int pid,int id,int offset)
        int value = 0
        if  id == 'FB17'
            AddUnitRealState(Pu[1],17,GetUnitIntState(Pu[1],'FC17')*0.1*offset)
        elseif  id == 'FB32'
            value = GetUnitIntState(Pu[1],'FC32')
            AddUnitRealState(Pu[1],2,value*offset)
        elseif  id == 'FB03'
            value = GetUnitIntState(Pu[1],'FC03')
            AddUnitRealState(Pu[1],1,value*offset)
        endif
    endfunction



    //羁绊属性
    function SetMagicItemState(int pid,int index,int now,int offset)
        int s1 = 0
        int s2 = 0
        int v1 = 0
        int v2 = 0
        BJDebugMsg("index"+I2S(index)+"_now"+I2S(now)+"_off"+I2S(offset))
        if  index == 1
            s1 = 1
            if  now >= 4
                v1 = 450000
            elseif  now >= 3
                v1 = 300000
            elseif  now >= 2
                v1 = 150000
            endif
        elseif  index == 2
            s1 = 15
            if  now >= 4
                v1 = 12
            elseif  now >= 3
                v1 = 9
            elseif  now >= 2
                v1 = 6
            endif
        elseif  index == 3
            s1 = 10
            s2 = 18
            if  now >= 4
                v1 = 9
                v2 = 9
            elseif  now >= 3
                v1 = 6
                v2 = 6
            elseif  now >= 2
                v1 = 3
                v2 = 3
            endif
        elseif  index == 4
            s1 = 14
            if  now >= 4
                v1 = 8
            elseif  now >= 3
                v1 = 4
            elseif  now >= 2
                v1 = 3
            endif
        elseif  index == 5
            s1 = 13
            if  now >= 4
                v1 = 8
            elseif  now >= 3
                v1 = 4
            elseif  now >= 2
                v1 = 3
            endif

        elseif  index == 7
            s1 = 19
            s2 = 20
            if  now >= 4
                v1 = 6
                v2 = 50
            elseif  now >= 3
                v1 = 3
                v2 = 100
            elseif  now >= 2
                v1 = 2
                v2 = 150
            endif
        elseif  index == 8
            s1 = 4
            if  now >= 4
                v1 = 12
            elseif  now >= 3
                v1 = 8
            elseif  now >= 2
                v1 = 4
            endif
        elseif  index == 9
            s1 = 16
            if  now >= 4
                v1 = 12
            elseif  now >= 3
                v1 = 9
            elseif  now >= 2
                v1 = 6
            endif
        endif
        if  s1 > 0 and v1 > 0
            AddUnitRealState(Pu[1],s1,v1*offset)
        endif
        if  s2 > 0 and v2 > 0
            AddUnitRealState(Pu[1],s2,v2*offset)
        endif
    endfunction

    function ReMagicItemState(int pid,int index,int add)
        int now = GetUnitIntState(Pu[1],index)
        int new = now + add
        SetUnitIntState(Pu[1],index,new)
        SetMagicItemState(pid,index-MagicItemStateIndex,now,-1)
        SetMagicItemState(pid,index-MagicItemStateIndex,new,1)
    endfunction

    //移除刷新羁绊数据
    function RemPlayerMagicItemState(int pid,int index)
        int value = 0
        int id = GetPlayerMagicItem(pid,index)
        
        
        //if  IsMagicItemOnly(pid,index) == true
        if  id > 0
            RemoveEquipState(Pu[1],id)
            AddUnitIntState(Pu[1],id,-1)
            RePlayerMagicOtherState(pid,id,-1)
            for i = 1,10
                value = GetTypeIdData(id,110+i)
                if  value > 0
                    ReMagicItemState(pid,MagicItemStateIndex+value,-1)
                endif
            end
        endif
        //endif
        
    endfunction
    //添加刷新羁绊数据
    function AddPlayerMagicItemState(int pid,int index)
        int value = 0
        int id = GetPlayerMagicItem(pid,index)
        
        //if  IsMagicItemOnly(pid,index) == true
        if  id > 0
            AddEquipState(Pu[1],id)
            AddUnitIntState(Pu[1],id,1)
            RePlayerMagicOtherState(pid,id,1)
            for i = 1,10
                value = GetTypeIdData(id,110+i)
                if  value > 0
                    ReMagicItemState(pid,MagicItemStateIndex+value,1)
                endif
            end
        endif
        //endif
    endfunction
    

    //war3mapImported\UI_ButtonSelect.tga
    //设置法宝到对应位置
    function SetPlayerMagicItem(int pid,int index,int value)
        
        if  value > 0
            SetUnitIntState(Pu[1],MagicItemIndex+index,value)
            if  index <= 8
                AddPlayerMagicItemState(pid,index)
                
                BJDebugMsg("法宝增加属性"+GetTypeIdName(value))
            else    
                BJDebugMsg("不增加属性"+GetTypeIdName(value))
            endif
            //DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r恭喜您！获得法宝 "+GetTypeIdName(value))
        else
            if  index <= 8
                RemPlayerMagicItemState(pid,index)
            endif
            SetUnitIntState(Pu[1],MagicItemIndex+index,0)
        endif
        
        ReCollectFrame(pid)
    endfunction

    //添加法宝
    function AddPlayerMagicItem(int pid,int value)
        int index = GetMagicItemNullIndex(pid)
        if  index > 0
            SetPlayerMagicItem(pid,index,value)
        endif
    endfunction




    //获得法宝  唯一接口 任务用
    function GivePlayerMagicItem(int pid,int value)
        AddPlayerMagicItem(pid,value)

        int color = GetTypeIdData(value,101)
        if  color == 1
            TimerMissionAddNumFunc(pid,24,1)//获得法宝
        elseif  color == 2
            TimerMissionAddNumFunc(pid,9,1)//获得法宝
            TimerMissionAddNumFunc(pid,27,1)//获得法宝
            TimerMissionAddNumFunc(pid,34,1)//获得法宝
        elseif  color == 3
            TimerMissionAddNumFunc(pid,12,1)//获得法宝
        elseif  color == 4
            TimerMissionAddNumFunc(pid,13,1)//获得法宝
        endif

        
<<<<<<< HEAD
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r恭喜您！获得 "+GetMagicItemName(value)+" ,F4查看法宝羁绊效果")
=======
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r恭喜您！获得法宝 "+GetTypeIdName(value)+",F4查看法宝羁绊效果")
>>>>>>> f2149edf87fe2b90a11d56aca50bf9671b615cc7

    endfunction


    //移除法宝
    function RemPlayerMagicItemByIndex(int pid,int index)
        if  index > 0
            SetPlayerMagicItem(pid,index,0)
        endif
    endfunction

    //重置法宝
    function RecastPlayerMagicItem(int pid)
        int last = GetPlayerMagicItemLast(pid)
        int id = GetPlayerMagicItem(pid,last)
        int num = 0
        int newid = 0
        int color = 0
        if  id > 0
            num = GetPlayerMagicItemResources(pid,1)//获取补天石数量
            if  num > 0
                SetPlayerMagicItemResources(pid,1,num-1)
                color = GetTypeIdData(id,101)
                newid = GetPrize(pid,10+color,true)
                RecoveryPrizePoolData(pid,10+color,id)//回收法宝


                //重铸
                RemPlayerMagicItemByIndex(pid,last)
                SetPlayerMagicItem(pid,last,newid)

                //重置玩家选择
                SetPlayerMagicItemLast(pid,0)
            else
                BJDebugMsg("补天石不足")
            endif
        else
            BJDebugMsg("未选中法宝")
        endif
    endfunction

    //锻造法宝
    function ForgePlayerMagicItem(int pid)
        int last = GetPlayerMagicItemLast(pid)
        int id = GetPlayerMagicItem(pid,last)
        int num = 0
        int newid = 0
        int color = 0
        if  id > 0
            num = GetPlayerMagicItemResources(pid,2)//获取鸿蒙结晶数量
            color = GetTypeIdData(id,101)-1
            if  color > 0
                if  num > 0
                    SetPlayerMagicItemResources(pid,2,num-1)
                    
                    newid = GetPrize(pid,10+color,true)
                    RecoveryPrizePoolData(pid,10+color,id)//回收法宝


                    //重铸
                    RemPlayerMagicItemByIndex(pid,last)
                    SetPlayerMagicItem(pid,last,newid)

                    //重置玩家选择
                    SetPlayerMagicItemLast(pid,0)
                else
                    BJDebugMsg("鸿蒙结晶不足")
                endif
            else
                //重置玩家选择
                BJDebugMsg("法宝品级太高")
            endif
        else
            BJDebugMsg("未选中法宝")
        endif
    endfunction


    //选择法宝 替换
    function SelectPlayerMagicItem(int pid,int index)
        int last = GetPlayerMagicItemLast(pid)
        int lastid = 0
        int nowid = 0
        if  last == index
            SetPlayerMagicItemLast(pid,0)
        else
            if  last > 0
                nowid = GetPlayerMagicItem(pid,index)
                lastid = GetPlayerMagicItem(pid,last)
                if  nowid > 0
                    SetPlayerMagicItem(pid,index,0)
                endif
                if  lastid > 0
                    SetPlayerMagicItem(pid,last,0)
                endif

                SetPlayerMagicItem(pid,last,nowid)
                SetPlayerMagicItem(pid,index,lastid)

                SetPlayerMagicItemLast(pid,0)
            else
                if  GetPlayerMagicItem(pid,index) > 0
                    SetPlayerMagicItemLast(pid,index)
                endif
            endif
            
        endif
    endfunction



    function FB49Func(unit wu)
        unit u1 = wu
        int time = 20
        SetUnitIntState(u1,'FC49',20)
        UnitAddAbility(u1,'AZ49')
        TimerStart(1,true)
        {
            time = time - 1
            SetUnitIntState(u1,'FC49',time)
            if  time <= 13
                if  GetUnitAbilityLevel(u1,'AZ49') > 0
                    UnitRemoveAbility(u1,'AZ49')
                endif
            endif
            if  time <= 0
                SetUnitIntState(u1,'FC49',0)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function FB01FuncTimer(unit wu)
        unit u1 = wu
        SetUnitIntState(wu,'FC01',1)
        TimerStart(15,false)
        {
            SetUnitIntState(u1,'FC01',0)
            endtimer
            flush locals
        }
        flush locals
    endfunction
    function FB01Func(unit wu)->bool
        if  GetUnitIntState(wu,'FB01') > 0
            if  GetUnitIntState(wu,'FC01') == 0
                ReviveHero(wu,GetUnitX(wu),GetUnitY(wu),true)
                LocAddEffectTimer(GetUnitX(wu),GetUnitY(wu),"effect_SetItems_N4_Immortal.mdx",1.0)
                FB01FuncTimer(wu)
                if  GetOwningPlayer(wu)==GetLocalPlayer()
                    ClearSelection()
                    SelectUnit(wu,true)
                    PanCameraToTimed(GetUnitX(wu),GetUnitY(wu),0)
                endif
                return true
            endif
        endif
        return false
    endfunction

    #undef MagicItemMax
    #undef MagicItemIndex
    #undef MagicItemStateMax
    #undef MagicItemStateIndex

endlibrary
