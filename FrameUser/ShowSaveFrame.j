
library ShowSaveFrameFunction initializer InitShowSaveFrameData uses GameFrame
    /*
    581-600 左侧按钮
    */


    private FRAME Button = 0
    private FRAME Slider = 0
    private FRAME Back = 0
    private FRAME Back2 = 0
    private int origin = 0

    private int array Page
    private int array Step

    int array ShowSaveData[10][800]

    

    //获取max
    function GetShowSaveMax(int page)->int
        return ShowSaveData[page][0]
    endfunction
    //设置max
    function SetShowSaveMax(int page,int max)
        ShowSaveData[page][0] = max
    endfunction
    //增加max
    function AddShowSaveMax(int page,int add)
        ShowSaveData[page][0] = ShowSaveData[page][0] + add
    endfunction

    //获取id
    function GetShowSaveId(int page,int index)->int
        return ShowSaveData[page][index]
    endfunction
    //获取需求科技
    function GetShowSaveTech(int page,int index,int num)->int
        return ShowSaveData[page][100*num+index]
    endfunction


    //注册数据    
    function RegisterShowSaveFrameData(int page,int id,int use1,int use2,int use3,int use4,int use5)
        int index = ShowSaveData[page][0] + 1
        ShowSaveData[page][index] = id
        ShowSaveData[page][100+index] = use1
        ShowSaveData[page][200+index] = use2
        ShowSaveData[page][300+index] = use3
        ShowSaveData[page][400+index] = use4
        ShowSaveData[page][500+index] = use5
        ShowSaveData[page][0] = index
    endfunction
    //初始化函数
    function InitShowSaveFrameData()
        RegisterShowSaveFrameData(2,'RY1A','RY1A',0,0,0,0)
        RegisterShowSaveFrameData(2,'RY1B','RY1B',0,0,0,0)
        RegisterShowSaveFrameData(2,'RY1C','RY1C',0,0,0,0)
        RegisterShowSaveFrameData(2,'RY1D','RY1D',0,0,0,0)
        RegisterShowSaveFrameData(2,'RY1E','RY1E',0,0,0,0)
        RegisterShowSaveFrameData(3,'RY2A','RY2A',0,0,0,0)
        RegisterShowSaveFrameData(3,'RY2B','RY2B',0,0,0,0)
        RegisterShowSaveFrameData(3,'RY2C','RY2C',0,0,0,0)
        RegisterShowSaveFrameData(3,'RY2D','RY2D',0,0,0,0)
        RegisterShowSaveFrameData(4,'RY3A','RY3A',0,0,0,0)
        RegisterShowSaveFrameData(4,'RY3B','RY3B',0,0,0,0)
        RegisterShowSaveFrameData(4,'RY3C','RY3C',0,0,0,0)
        RegisterShowSaveFrameData(4,'RY3D','RY3D',0,0,0,0)
        RegisterShowSaveFrameData(1,'RY4A','RY4A',0,0,0,0)
        RegisterShowSaveFrameData(1,'RY4B','RY4B',0,0,0,0)
        RegisterShowSaveFrameData(1,'RY4C','RY4C',0,0,0,0)
        RegisterShowSaveFrameData(1,'RY4D','RY4D',0,0,0,0)
        RegisterShowSaveFrameData(1,'RY4E','RY4E',0,0,0,0)
        RegisterShowSaveFrameData(1,'RY4F','RY4F',0,0,0,0)
        RegisterShowSaveFrameData(1,'RY4G','RY4G',0,0,0,0)
        RegisterShowSaveFrameData(1,'RY4H','RY4H',0,0,0,0)
        RegisterShowSaveFrameData(1,'RY4I','RY4I',0,0,0,0)
        RegisterShowSaveFrameData(1,'RY4J','RY4J',0,0,0,0)
        RegisterShowSaveFrameData(1,'RY4K','RY4K',0,0,0,0)

        RegisterShowSaveFrameData(0,'RJ1A','RJ1A',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1B','RJ1B',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1C','RJ1C',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1D','RJ1D',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1E','RJ1E',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1F','RJ1F',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1G','RJ1G',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1A','RJ1A',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1B','RJ1B',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1C','RJ1C',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1D','RJ1D',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1E','RJ1E',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1F','RJ1F',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1G','RJ1G',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1A','RJ1A',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1B','RJ1B',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1C','RJ1C',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1D','RJ1D',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1E','RJ1E',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1F','RJ1F',0,0,0,0)
        RegisterShowSaveFrameData(0,'RJ1G','RJ1G',0,0,0,0)
    endfunction


    
    function GetShowSaveFrameTechTips(int pid,int index)->string
        string s = ""
        int step = Step[pid]
        int page = Page[pid]
        int techid = 0
        int lock = 1
        
        for i = 1,5
            techid = GetShowSaveTech(page,index+step*4,i)
            if  techid > 0
                if  GetPlayerTechCount(Player(pid),techid,true) > 0
                    s = s + "\n|cff00ff00 - "+GetObjectName(techid) + "|r"
                else
                    s = s + "\n|cff808080 - "+GetObjectName(techid) + "|r"
                    lock = 0
                endif
            else
                exitwhen true
            endif
        end
        if  lock == 1
            return ""
        else
            return "|cffffff00需求：|r"+s
        endif
    endfunction

    function BoxShowSaveFrame(int pid,int index)
        int step = Step[pid]
        int page = Page[pid]
        int id = GetShowSaveId(page,index+step*4)
        int h = 10
        int techid = 0
        string tech = ""
        BJDebugMsg("page"+I2S(page)+"step"+I2S(step))
        if  id > 0
            DzFrameSetTexture(BUTTON_Back[index+500][4] , "war3mapImported\\UI_BUTTON_High.blp", 0)
            DzFrameShow(UI_TipsHead, true)
            

            SetTipsData(1,"",GetTypeIdName(id))


            tech = GetShowSaveFrameTechTips(pid,index)
            if  tech != ""
                SetTipsData(10,"",tech)
                h = 11
            endif
            
            SetTipsData(h,"",GetTypeIdStateTips(id))
            h = h + 1
            SetTipsData(h,"",GetTypeIdTips(id))


            ShowTipsUI()
        endif
    endfunction

    //刷新显示
    function ReShowSaveFrame(int pid,int page,int step)
        int id = 0
        int index = 0
        int techid = 0
        if  GetLocalPlayer() == Player(pid)

            for x = 0,3 
                for y = 0,3
                    index = 1 + x + y*4

                    id = GetShowSaveId(page,index+step*4)
                    

                    

                    if  id > 0
                        
                        for i = 1,5
                            techid = GetShowSaveTech(page,index+step*4,i)
                            if  techid == 0
                                DzFrameSetTexture(BUTTON_Back[500+index][3],"war3mapImported\\alpha.tga",0)
                                exitwhen true
                            else
                                if  GetPlayerTechCount(Player(pid),techid,true) > 0
                                    DzFrameSetTexture(BUTTON_Back[500+index][3],"war3mapImported\\alpha.tga",0)
                                else
                                    DzFrameSetTexture(BUTTON_Back[500+index][3],"war3mapImported\\UI_DisBack.tga",0)
                                    exitwhen true
                                endif
                            endif
                        end

                        DzFrameSetTexture(BUTTON_Back[500+index][1],GetTypeIdIcon(id),0)
                        DzFrameSetText(BUTTON_Text[500+index],GetTypeIdColor(id)+GetTypeIdName(id))
                    else
                        
                        DzFrameSetTexture(BUTTON_Back[500+index][1],"war3mapImported\\alpha.tga",0)
                        DzFrameSetTexture(BUTTON_Back[500+index][3],"war3mapImported\\alpha.tga",0)
                        DzFrameSetText(BUTTON_Text[500+index],"")
                    endif
                end
            end
        endif
    endfunction

    
    function SetPlayerShowSaveStep(int pid,int step)
        int max = GetShowSaveMax(Page[pid])
        int stepmax = 0
        Step[pid] = step
        if  GetLocalPlayer() == Player(pid)
            stepmax = (max - 13) / 4
            if  stepmax > 0
                Slider.SetPoint(2,Back2.frameid ,2,-0.001,-0.005-0.197/I2R(stepmax+1)*I2R(step))
                Slider.SetSize(0.005,0.197/I2R(stepmax+1))
                Slider.SetTexture("war3mapImported\\UI_Save_Stripe.tga",0)
            else
                Slider.SetTexture("war3mapImported\\alpha.tga",0)
            endif
            ReShowSaveFrame(pid,Page[pid],step)
        endif
    endfunction

    function SetPlayerShowSavePage(int pid,int page)
        if  GetLocalPlayer() == Player(pid)
            DzFrameSetTexture(BUTTON_Back[581+Page[pid]][4],"war3mapImported\\alpha.tga",0)
        endif
        Page[pid] = page
        if  GetLocalPlayer() == Player(pid)
            DzFrameSetTexture(BUTTON_Back[581+Page[pid]][4],"war3mapImported\\UI_Save_Color1.tga",0)
        endif
        SetPlayerShowSaveStep(pid,0)
        if  GetLocalPlayer() == Player(pid)
            ReShowSaveFrame(pid,Page[pid],Step[pid])
        endif
    endfunction

    function PlayerWheelShowSaveFrame(int pid,int whell)
        int page = Page[pid]
        int step = Step[pid]
        int max = GetShowSaveMax(page)
        int stepmax = 0

        if  whell < 0
            if  max > 16
                stepmax = (max - 13) / 4
                if  step < stepmax
                    SetPlayerShowSaveStep(pid,step+1)
                    
                endif
            endif
        else
            if  step > 0
                SetPlayerShowSaveStep(pid,step-1)
            endif
        endif
    endfunction




    


    

    //通用函数
    function ShowSaveFrame(int pid,bool show)

        if  GetLocalPlayer() == Player(pid)
            Button.show = show
        endif
    
    endfunction
    function GetShowSaveFrameShow()->bool
        return Button.show
    endfunction


    function CloseShowSaveFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            Button.show = false
        endif
    endfunction

    function ClickShowSaveFrame(int pid)
        if  GetLocalPlayer() == Player(pid)
            if  Button.show  == true
                Button.show = false
            else
                Button.show = true
            endif
        endif
    endfunction

    
    


    function CreateShowSaveButton1()//创建列表按钮
        int index = 0
        for x = 0,6
            index = 581+x
            CreateButton(index,Button.frameid,TYPE_BUTTON,0,Button.frameid,0,0.003,-0.03-x*0.03,0.075,0.027,"war3mapImported\\alpha.tga")
            
        end

        CreateText(581,Button.frameid,"centertext009",4,4,0.0,0.0,"成就")
        CreateText(582,Button.frameid,"centertext009",4,4,0.0,0.0,"称号")
        CreateText(583,Button.frameid,"centertext009",4,4,0.0,0.0,"光环")
        CreateText(584,Button.frameid,"centertext009",4,4,0.0,0.0,"翅膀")
        CreateText(585,Button.frameid,"centertext009",4,4,0.0,0.0,"神器")
        CreateText(586,Button.frameid,"centertext009",4,4,0.0,0.0,"隐藏成就")
        CreateText(587,Button.frameid,"centertext009",4,4,0.0,0.0,"商城")

    endfunction

    function CreateShowSaveButton2()//创建图标按钮
        int index = 0

        for x = 0,3 
            for y = 0,3
                index = 501 + x + y*4
                CreateButton(index,Button.frameid,TYPE_BUTTON,0,Back2.frameid,0,0.005+x*0.045,-0.005-y*0.05,0.034,0.034,"war3mapImported\\alpha.tga")
                CreateText(index,Button.frameid,"centertext008",1,7,0.0,-0.002,"")
            end
        end

    endfunction


    function InitShowSaveFrame()
        Slider = FRAME.create() //背景注册
        Button = FRAME.create() //背景注册
        
        Back2 = FRAME.create()  //注册按钮背景
        Back = FRAME.create()   //注册主背景
        

        //控件设置
        Button.frameid = FRAME.Tag("BUTTON","ShowSave",GameUI,Button)
        Button.SetPoint(8,GameUI,5,-0.01,-0.1)
        Button.SetSize(0.288,0.25)
        origin = Button.frameid

        //背景设置
        Back.frameid = FRAME.Tag("BACKDROP","ShowSave",origin,Back)
        Back.SetPoint(4,origin,4,0,0)
        Back.SetSize(Button.Width,Button.Height)
        Back.SetTexture("war3mapImported\\UI_Save_Back.tga",0)

        //按钮背景设置
        Back2.frameid = FRAME.Tag("BACKDROP","ShowSave",origin,Back2)
        Back2.SetPoint(0,origin,0,0.09,-0.03)
        Back2.SetSize(0.19,0.207)
        Back2.SetTexture("war3mapImported\\alpha.tga",0)

        Slider.frameid = FRAME.Tag("BACKDROP","ShowSave",origin,Slider)
        Slider.SetPoint(2,Back2.frameid ,2,-0.001,-0.005)
        Slider.SetSize(0.005,0.02)
        Slider.alpha = 120
        Slider.SetTexture("war3mapImported\\UI_Save_Stripe.tga",0)

        

        FrameSetScriptByExecute( origin, 6,580,TYPE_NULL)


        CreateShowSaveButton1()
        CreateShowSaveButton2()
        Button.show = false

        for pid = 0,3
            SetPlayerShowSaveStep(pid,0)
            SetPlayerShowSavePage(pid,0)
        end
        
    endfunction
endlibrary




