
library PassCheckData initializer InitPassCheckData
    int array PassCheckData[2][1000]

    function GetPassCheckData(int index,int num)->int
        return PassCheckData[num][index]
    endfunction

    function RegisterPassCheckData(int index,int id1,int id2)
        PassCheckData[1][index] = id1
        PassCheckData[2][index] = id2
    endfunction

    function InitPassCheckData()
        for i = 0,9
            RegisterPassCheckData(i+1,'FB00'+i,'FB10'+i)
        end
        RegisterPassCheckData(12,'FB01','FB11')
        RegisterPassCheckData(13,0,'FB11')
        RegisterPassCheckData(14,'FB01',0)

        RegisterPassCheckData(20,'FB01','FB11')

        RegisterPassCheckData(25,'FB01','FB11')
    endfunction

    

endlibrary

library PassCheckUI uses GameFrame,PassCheckData

    /*按钮序号
    601-606     经验条
    611-620     等级标签
    621-630     普通通行证
    631-640     超级通行证
    641-646     任务完成进度
    681-686     每日任务

    650         当前等级
    651         等级预览
    652         普通通行证
    653         超级通行证
    654         每日任务
    655         快速升级
    661         ←
    662         →
    */
    private FRAME Button = 0
    private FRAME Back = 0
    private FRAME Key = 0
    private int origin = 0

    private int Page = 0
    private int PageMax = 9

    //通用函数
    function ShowPassFrame(int pid,bool show)

        if  GetLocalPlayer() == Player(pid)
            Button.show = show
        endif
    
    endfunction
    function GetPassFrameShow()->bool
        return Button.show
    endfunction


    function ClosePassFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            Button.show = false
        endif
    endfunction

    function ClickPassFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            if  Button.show  == true
                Button.show = false
            else
                Button.show = true
            endif
        endif
    endfunction

    function GetPassCheckPrizeId(int id,int num)->int
        return GetPassCheckData(Page*10+id,1)
    endfunction

    //刷新奖励显示
    function RePassClickPrize(int pid)
        int id = 0
        int index = 0
        if  GetLocalPlayer() == Player(pid)
            Key.SetText(I2S(Page+1)+"/10")
            for i = 1,10
                index = Page*10+i
                DzFrameSetText(BUTTON_Text[610+i],"|cff999999"+I2S(index)+"|r")


                for y = 1,2
                    id = GetPassCheckData(index,y)
                    if  id > 0
                        DzFrameSetTexture(BUTTON_Back[610+y*10+i][1],GetTypeIdIcon(id),0)
                    else
                        DzFrameSetTexture(BUTTON_Back[610+y*10+i][1],"war3mapImported\\alpha.tga",0)
                    endif
                end
                
            end
        endif
    endfunction
    //点击上一页
    function PassFreamClickLast(int pid)
        
        if  GetLocalPlayer() == Player(pid)
            if  Page > 0
                Page = Page - 1
                
                RePassClickPrize(pid)
            endif
        endif
    endfunction

    //点击下一页
    function PassFreamClickNext(int pid)
        if  GetLocalPlayer() == Player(pid)
            if  Page < PageMax
                Page = Page + 1
                
                RePassClickPrize(pid)
            endif
        endif
    endfunction

    


    private function CreateFrameButton1()
        int last = 0
        //快速升级
        CreateButton(655,Button.frameid,TYPE_BUTTON,2,Button.frameid,2,-0.01,-0.005,0.056,0.02,"war3mapImported\\UI_Pass_LevelUp0.tga")
        
        

        //等级预览
        CreateButton(651,Button.frameid,TYPE_NULL,0,Button.frameid,0,0.0103,-0.033,0.028,0.014,"war3mapImported\\UI_Pass_LevelBack.tga")
        CreateText(651,Button.frameid,"centertext008",4,4,0.0,0.0,"|cff000000等级|r")

        last = 651
        for i = 1,10
            CreateButton(610+i,Button.frameid,TYPE_NULL,3,BUTTON_Back[last][0],5,0.002,0.0,0.028,0.014,"war3mapImported\\UI_Pass_LevelBack.tga") 
            CreateText(610+i,Button.frameid,"centertext008",4,4,0.0,0.0,"|cff000000"+I2S(i)+"|r")
            last = 610+i
        end

        //普通通行证
        CreateButton(652,Button.frameid,TYPE_NULL,0,BUTTON_Back[651][0],6,0.0,-0.001,0.028,0.028,"")
        
        last = 652
        for i = 1,10
            CreateButton(620+i,Button.frameid,TYPE_BUTTON,3,BUTTON_Back[last][0],5,0.002,0.0,0.028,0.028,"") 
            last = 620+i
        end

        //超级通行证
        CreateButton(653,Button.frameid,TYPE_NULL,0,BUTTON_Back[652][0],6,0.0,-0.009,0.028,0.028,"")
        
        last = 653
        for i = 1,10
            CreateButton(630+i,Button.frameid,TYPE_BUTTON,3,BUTTON_Back[last][0],5,0.002,0.0,0.028,0.028,"") 
            last = 630+i
        end


        
        //当前等级
        CreateButton(650,Button.frameid,TYPE_NULL,0,BUTTON_Back[653][0],6,0.0,-0.01,0.028,0.028,"war3mapImported\\UI_Pass_LevelText.tga") 
        CreateText(650,Button.frameid,"centertext013",7,7,0.0,0.0,"|cffffcc008|r")
        last = 650
        for i = 1,10
            CreateButton(600+i,Button.frameid,TYPE_NULL,3,BUTTON_Back[last][0],5,0.002,0.0,0.028,0.0093,"war3mapImported\\UI_Pass_Exp0.tga") 
            last = 600+i
        end
        


        //每日任务
        CreateButton(654,Button.frameid,TYPE_NULL,0,BUTTON_Back[653][0],6,0.0,-0.04,0.028,0.028,"war3mapImported\\UI_Pass_Text3.tga") 

        CreateButton(641,Button.frameid,TYPE_NULL,0,BUTTON_Back[654][0],2,0.01,0.0,0.14,0.028,"war3mapImported\\UI_Pass_MissionButton.tga") 
        CreateButton(642,Button.frameid,TYPE_NULL,0,BUTTON_Back[641][0],6,0.0,-0.005,0.14,0.028,"war3mapImported\\UI_Pass_MissionButton.tga") 
        CreateButton(643,Button.frameid,TYPE_NULL,0,BUTTON_Back[642][0],6,0.0,-0.005,0.14,0.028,"war3mapImported\\UI_Pass_MissionButton.tga") 
        CreateButton(644,Button.frameid,TYPE_NULL,0,BUTTON_Back[641][0],2,0.01,0.0,0.14,0.028,"war3mapImported\\UI_Pass_MissionButton.tga") 
        CreateButton(645,Button.frameid,TYPE_NULL,0,BUTTON_Back[644][0],6,0.0,-0.005,0.14,0.028,"war3mapImported\\UI_Pass_MissionButton.tga") 
        CreateButton(646,Button.frameid,TYPE_NULL,0,BUTTON_Back[645][0],6,0.0,-0.005,0.14,0.028,"war3mapImported\\UI_Pass_MissionButton.tga") 

        CreateText(641,Button.frameid,"righttext008",5,5,-0.005,0.0,"0/20")
        CreateText(642,Button.frameid,"righttext008",5,5,-0.005,0.0,"")
        CreateText(643,Button.frameid,"righttext008",5,5,-0.005,0.0,"")
        CreateText(644,Button.frameid,"righttext008",5,5,-0.005,0.0,"")
        CreateText(645,Button.frameid,"righttext008",5,5,-0.005,0.0,"0/2")
        CreateText(646,Button.frameid,"righttext008",5,5,-0.005,0.0,"")

        

        for i = 1,6
            CreateButton(680+i,Button.frameid,TYPE_BUTTON,3,BUTTON_Back[640+i][0],3,0.0,0.0,0.028,0.028,"war3mapImported\\UI_Pass_Text1.tga")
        end
        CreateText(681,Button.frameid,"centertext008",3,5,0.005,0.0,"击杀20个Boss")
        CreateText(682,Button.frameid,"centertext008",3,5,0.005,0.0,"|cff00ff00已完成|r")
        CreateText(683,Button.frameid,"centertext008",3,5,0.005,0.0,"|cff00ff00已完成|r")
        CreateText(684,Button.frameid,"centertext008",3,5,0.005,0.0,"|cff00ff00已完成|r")
        CreateText(685,Button.frameid,"centertext008",3,5,0.005,0.0,"通关难度四")
        CreateText(686,Button.frameid,"centertext008",3,5,0.005,0.0,"|cff00ff00已完成|r")



        CreateButton(661,Button.frameid,TYPE_BUTTON,0,Button.frameid,1,-0.03,-0.01,0.01,0.01,"war3mapImported\\UI_Pass_Left.tga")
        CreateButton(662,Button.frameid,TYPE_BUTTON,2,Button.frameid,1,0.03,-0.01,0.01,0.01,"war3mapImported\\UI_Pass_Right.tga")

    endfunction

    function PassCheckUIInit()

        Button = FRAME.create() //背景注册
        Back = FRAME.create()   //注册主背景
        Key = FRAME.create()    //注册快捷键文本

        //控件设置
        Button.frameid = FRAME.Tag("BUTTON","Check",GameUI,Button)
        Button.SetPoint(4,GameUI,4,0,0)
        Button.SetSize(0.35,0.2875)
        origin = Button.frameid

        //背景设置
        Back.frameid = FRAME.Tag("BACKDROP","Check",origin,Back)
        Back.SetPoint(4,origin,4,0,0)
        Back.SetSize(0.35,0.2875)
        Back.SetTexture("war3mapImported\\UI_Pass_Back.tga",0)

        //设置快捷键文本
        Key.frameid = FRAME.Fdf("centertext010",origin,Key)
        Key.SetText("1/10")
        Key.SetPoint(1,Button.frameid ,1,0.0,-0.01)

        CreateFrameButton1()

        Button.show = false
    endfunction



endlibrary



