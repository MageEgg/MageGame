library PassCheckMission initializer InitPassCheckMission uses DzSave
    int MissionDay = 1
    int MaxMissionNum = 6
    
    scope RegisterMission
        int array PassCheckMissionData[1000][8]
        string array PassCheckMissionString[1000][8]

        function GetMissionExp(int missionid)->int//获取任务经验
            return PassCheckMissionData[missionid][1]
        endfunction
        function GetMissionUse(int missionid)->int//获取任务需求数量
            return PassCheckMissionData[missionid][2]
        endfunction
        function GetMissionName(int missionid)->string//获取任务名称
            return PassCheckMissionString[missionid][1]
        endfunction
        function GetMissionTips(int missionid)->string//获取任务说明
            return PassCheckMissionString[missionid][2]
        endfunction
        
        function RegisterPassCheckMission(int missionid,int exp,int use,string name,string tips)
            PassCheckMissionData[missionid][1] = exp
            PassCheckMissionData[missionid][2] = use
            PassCheckMissionString[missionid][1] = name
            PassCheckMissionString[missionid][2] = tips
        endfunction

        
    endscope

    scope RegisterDay

        int array PassCheckMissionId[800][10]

        function GetDayMissionId(int index)->int
            return PassCheckMissionId[MissionDay][index]
        endfunction
        
        function RegisterPassCheckDay(int day,int id1,int id2,int id3,int id4,int id5,int id6)
            PassCheckMissionId[day][1]=id1
            PassCheckMissionId[day][2]=id2
            PassCheckMissionId[day][3]=id3
            PassCheckMissionId[day][4]=id4
            PassCheckMissionId[day][5]=id5
            PassCheckMissionId[day][6]=id6
        endfunction
        
    endscope


    scope RegisterPrize
        int array PassCheckPrize[2][1000]

        function GetPassCheckPrize(int index,int num)->int
            return PassCheckPrize[num][index]
        endfunction

        function RegisterPassCheckPrize(int index,int id1,int id2)
            PassCheckPrize[1][index] = id1
            PassCheckPrize[2][index] = id2
        endfunction
    endscope


    function InitRegisterPrize()//注册奖励
        for i = 0,9
            RegisterPassCheckPrize(i+1,'FB00'+i,'FB10'+i)
        end
        RegisterPassCheckPrize(12,'FB01','FB11')
        RegisterPassCheckPrize(13,0,'FB11')
        RegisterPassCheckPrize(14,'FB01',0)

        RegisterPassCheckPrize(20,'FB01','FB11')

        RegisterPassCheckPrize(25,'FB01','FB11')
    endfunction

    function InitRegisterMission()//注册任务
        RegisterPassCheckMission(1,1,10,"击杀","击杀10个Boss")
        RegisterPassCheckMission(2,1,20,"击杀","击杀20个小怪")
        RegisterPassCheckMission(3,1,30,"击杀","击杀30个Boss")
        RegisterPassCheckMission(4,1,40,"击杀","击杀40个Boss")
        RegisterPassCheckMission(5,3,50,"击杀","击杀50个Boss")
        RegisterPassCheckMission(6,3,60,"击杀","击杀60个Boss")
    endfunction

    function InitRegisterDay()//注册每日任务
        for i = 1,5
            RegisterPassCheckDay(i,1,2,3,4,5,6)
        end
    endfunction

    function InitPassCheckMission()
        ExecuteFunc("InitRegisterMission")
        ExecuteFunc("InitRegisterDay")
        ExecuteFunc("InitRegisterPrize")
    endfunction



    scope PlayerPassMission
        int array PassCheckPlayerData[12][680]
        #define PlayerPassData  PassCheckPlayerData[pid]

        function GetPlayerPassExp(int pid)->int
            int exp = GetDzPlayerData(pid,4,1)
            return exp
        endfunction
        function GetPlayerPassLevel(int pid)->int
            int exp = GetPlayerPassExp(pid)
            int level = GetDzPlayerData(pid,4,2) + exp / 10
            return level
        endfunction

        function GetMissionIndex(int pid,int missionid)->int//根据任务判断今天的index
            for i = 1,MaxMissionNum
                if  GetDayMissionId(i) == missionid
                    return i
                endif
            end
            return 0
        endfunction

        function PlayerMissionComplete(int pid,int missionid)//任务完成
            if  DzConA[0] == 1 //全局限制
                int exp = GetMissionExp(missionid)
                AddDzPlayerData(pid,4,1,exp)
                DisplayTimedTextToPlayer(Player(pid),0,0,10, "|cffffcc00[系统]：|r"+GetMissionName(missionid)+"任务完成！通行证经验+"+I2S(exp))
            endif
        endfunction
        
        function PlayerMissionAddNum(int pid,int missionid,int num)//任务计数
            int index = GetMissionIndex(pid,missionid)
            int data = PlayerPassData[index]
            int use = GetMissionUse(missionid)
            if  data < use
                data = data + num
                if  data >= use
                    data = use
                    PlayerPassData[index] = use
                    PlayerMissionComplete(pid,missionid)
                else
                    PlayerPassData[index] = PlayerPassData[index] + num
                endif
                SetDzPlayerData(pid,5,index,PlayerPassData[index])
                RePassClickFrame.execute(pid)
            else
                BJDebugMsg(I2S(missionid)+"任务已完成")
            endif
        endfunction
        
        function MissionAddNumFunc(int pid,int missionid,int num)//任务达成计数
            int index = 0
            if  DzConA[0] == 1 //全局限制
                index = GetMissionIndex(pid,missionid)
                if  index > 0
                    PlayerMissionAddNum(pid,missionid,num)

                else
                    //BJDebugMsg(I2S(missionid)+"不是今日任务")
                endif
            endif
        endfunction

        function PlayerAddMission(int pid)//读取当前任务进度
            for i = 1,5
                PlayerPassData[i] = GetDzPlayerData(pid,5,i)
            end
        endfunction

        function PlayerLoadPassCheck(int pid)//加载通行证
            int exp = 0
            int lv = 0
            
            if  DzConA[0] == 1 //全局限制
                
                PlayerAddMission(pid)
                
                //通行证加载道具

            endif
        endfunction
    endscope
endlibrary

library PassCheckUI uses GameFrame,PassCheckMission

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

    

    function GetPassCheckPrizeId(int id,int num)->int
        return GetPassCheckPrize(Page*10+id,1)
    endfunction

    

    //刷新奖励显示
    function RePassClickPrize(int pid)
        int id = 0
        int index = 0
        int level = GetPlayerPassLevel(pid)
        if  GetLocalPlayer() == Player(pid)
            Key.SetText(I2S(Page+1)+"/10")
            DzFrameSetText(BUTTON_Text[650],"|cffffcc00"+I2S(level)+"|r")
            
            for i = 1,10
                index = Page*10+i
                if  level >= index
                    DzFrameSetText(BUTTON_Text[610+i],"|cff000000"+I2S(index)+"|r")
                    DzFrameSetTexture(BUTTON_Back[610+i][0],"war3mapImported\\UI_Pass_LevelBack.tga",0)
                else
                    DzFrameSetText(BUTTON_Text[610+i],"|cffffffff"+I2S(index)+"|r")
                    DzFrameSetTexture(BUTTON_Back[610+i][0],"war3mapImported\\alpha.tga",0)
                endif


                for y = 1,2
                    id = GetPassCheckPrize(index,y)
                    if  id > 0
                        DzFrameSetTexture(BUTTON_Back[610+y*10+i][1],GetTypeIdIcon(id),0)
                    else
                        DzFrameSetTexture(BUTTON_Back[610+y*10+i][1],"war3mapImported\\alpha.tga",0)
                    endif
                end
                
            end
        endif
    endfunction
    //刷新整体显示

    function RePassClickFrame(int pid)
        int missionid = 0
        int level = GetPlayerPassLevel(pid)
        int nowexp = 0
        int use = 0
        int exp = 0
        int now = 0
        if  GetLocalPlayer() == Player(pid)
            for i = 1,MaxMissionNum
                missionid = GetDayMissionId(i)
                use = GetMissionUse(missionid)
                exp = GetMissionExp(missionid)
                now = PlayerPassData[i]
                

                if  exp == 1
                    DzFrameSetTexture(BUTTON_Back[680+i][0],"war3mapImported\\UI_Pass_Text1.tga",0)
                elseif  exp == 3
                    DzFrameSetTexture(BUTTON_Back[680+i][0],"war3mapImported\\UI_Pass_Text2.tga",0)
                endif

                DzFrameSetText(BUTTON_Text[680+i],GetMissionTips(missionid))

                if  now >= use
                    DzFrameSetText(BUTTON_Text[640+i],"|cff00ff00已完成")
                    
                else
                    DzFrameSetText(BUTTON_Text[640+i],I2S(now)+"/"+I2S(use))
                endif
            end

            nowexp = GetPlayerPassExp(pid)
            nowexp = nowexp - (nowexp / 10) * 10
            for i = 1,10
                if  i <= nowexp
                    DzFrameSetTexture(BUTTON_Back[600+i][0],"war3mapImported\\UI_Pass_Exp1.tga",0)
                else
                    DzFrameSetTexture(BUTTON_Back[600+i][0],"war3mapImported\\UI_Pass_Exp0.tga",0)
                endif
            end
            RePassClickPrize(pid)
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

    //通用函数
    function ShowPassFrame(int pid,bool show)

        if  GetLocalPlayer() == Player(pid)
            Button.show = show
            if  show == true
                RePassClickFrame(pid)
            endif
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
                RePassClickFrame(pid)
            endif
        endif
    endfunction


    //注册按钮
    private function CreateFrameButton1()
        int last = 0
        //快速升级
        CreateButton(655,Button.frameid,TYPE_BUTTON,2,Button.frameid,2,-0.01,-0.008,0.056,0.02,"war3mapImported\\UI_Pass_LevelUp0.tga")
        
        


        //等级预览
        CreateButton(651,Button.frameid,TYPE_NULL,0,Button.frameid,0,0.0103,-0.033,0.028,0.014,"war3mapImported\\alpha.tga")
        CreateText(651,Button.frameid,"centertext008",4,4,0.0,0.0,"等级")

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
            CreateButton(620+i,Button.frameid,TYPE_BUTTON,3,BUTTON_Back[last][0],5,0.002,0.0,0.028,0.028,"war3mapImported\\alpha.tga") 
            last = 620+i
        end

        //超级通行证
        CreateButton(653,Button.frameid,TYPE_NULL,0,BUTTON_Back[652][0],6,0.0,-0.009,0.028,0.028,"")
        
        last = 653
        for i = 1,10
            CreateButton(630+i,Button.frameid,TYPE_BUTTON,3,BUTTON_Back[last][0],5,0.002,0.0,0.028,0.028,"war3mapImported\\alpha.tga") 
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
        CreateButton(654,Button.frameid,TYPE_NULL,0,BUTTON_Back[653][0],6,0.0,-0.045,0.028,0.028,"war3mapImported\\UI_Pass_Text3.tga") 

        CreateButton(641,Button.frameid,TYPE_NULL,0,BUTTON_Back[654][0],2,0.002,0.0,0.14,0.028,"war3mapImported\\UI_Pass_MissionButton.tga") 
        CreateButton(642,Button.frameid,TYPE_NULL,0,BUTTON_Back[641][0],6,0.0,-0.005,0.14,0.028,"war3mapImported\\UI_Pass_MissionButton.tga") 
        CreateButton(643,Button.frameid,TYPE_NULL,0,BUTTON_Back[642][0],6,0.0,-0.005,0.14,0.028,"war3mapImported\\UI_Pass_MissionButton.tga") 
        CreateButton(644,Button.frameid,TYPE_NULL,0,BUTTON_Back[641][0],2,0.018,0.0,0.14,0.028,"war3mapImported\\UI_Pass_MissionButton.tga") 
        CreateButton(645,Button.frameid,TYPE_NULL,0,BUTTON_Back[644][0],6,0.0,-0.005,0.14,0.028,"war3mapImported\\UI_Pass_MissionButton.tga") 
        CreateButton(646,Button.frameid,TYPE_NULL,0,BUTTON_Back[645][0],6,0.0,-0.005,0.14,0.028,"war3mapImported\\UI_Pass_MissionButton.tga") 

        CreateText(641,Button.frameid,"righttext008",5,5,-0.005,0.0,"0/20")
        CreateText(642,Button.frameid,"righttext008",5,5,-0.005,0.0,"")
        CreateText(643,Button.frameid,"righttext008",5,5,-0.005,0.0,"")
        CreateText(644,Button.frameid,"righttext008",5,5,-0.005,0.0,"")
        CreateText(645,Button.frameid,"righttext008",5,5,-0.005,0.0,"0/2")
        CreateText(646,Button.frameid,"righttext008",5,5,-0.005,0.0,"")

        

        for i = 1,6
            CreateButton(680+i,Button.frameid,TYPE_NULL,3,BUTTON_Back[640+i][0],3,0.0,0.0,0.028,0.028,"war3mapImported\\UI_Pass_Text1.tga")
        end
        CreateText(681,Button.frameid,"centertext008",3,5,0.005,0.0,"击杀20个Boss")
        CreateText(682,Button.frameid,"centertext008",3,5,0.005,0.0,"|cff00ff00已完成|r")
        CreateText(683,Button.frameid,"centertext008",3,5,0.005,0.0,"|cff00ff00已完成|r")
        CreateText(684,Button.frameid,"centertext008",3,5,0.005,0.0,"|cff00ff00已完成|r")
        CreateText(685,Button.frameid,"centertext008",3,5,0.005,0.0,"通关难度四")
        CreateText(686,Button.frameid,"centertext008",3,5,0.005,0.0,"|cff00ff00已完成|r")



        CreateButton(661,Button.frameid,TYPE_BUTTON,0,Button.frameid,1,-0.03,-0.012,0.015,0.015,"war3mapImported\\UI_Pass_Left.tga")
        CreateButton(662,Button.frameid,TYPE_BUTTON,2,Button.frameid,1,0.03,-0.012,0.015,0.015,"war3mapImported\\UI_Pass_Right.tga")

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
        Key.SetPoint(1,Button.frameid ,1,0.0,-0.015)

        CreateFrameButton1()

        
        Button.show = false
    endfunction



endlibrary



