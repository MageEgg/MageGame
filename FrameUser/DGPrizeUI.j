
library DGPrizeFrame uses GameFrame,HeroFrameUI
    private FRAME Button = 0
    private FRAME Back = 0
    private int origin = 0


    function GetNewDGPrize(int pid)->int

        real ran = GetRandomReal(0,100)
        int ID = 'IJ03'

        int num = GetUnitIntState(Pu[1],150)
        if  num <= 3
            if  ran >=78.95
                ID = 'IJ03'
            elseif  ran >=59.2
                ID = 'IJ04'
            elseif  ran >=37.8
                ID = 'IJ05'
            elseif  ran >=19.69
                ID = 'IJ06'
            elseif  ran >=10.64
                ID = 'IJ07'
            elseif  ran >=4.88
                ID = 'IJ08'
            elseif  ran >=0.35
                ID = 'IJ09'
            elseif  ran >=-2.12
                ID = 'IJ10'
            elseif  ran >=-2.94
                ID = 'IJ11'
            endif
        elseif  num <= 6
            if  ran >=79.89
                ID = 'IJ03'
            elseif  ran >=60.14
                ID = 'IJ04'
            elseif  ran >=38.74
                ID = 'IJ05'
            elseif  ran >=20.63
                ID = 'IJ06'
            elseif  ran >=11.58
                ID = 'IJ07'
            elseif  ran >=5.82
                ID = 'IJ08'
            elseif  ran >=1.29
                ID = 'IJ09'
            elseif  ran >=-1.18
                ID = 'IJ10'
            elseif  ran >=-2
                ID = 'IJ11'
            endif
        else
            if  ran >=81.89
                ID = 'IJ03'
            elseif  ran >=62.14
                ID = 'IJ04'
            elseif  ran >=40.74
                ID = 'IJ05'
            elseif  ran >=22.63
                ID = 'IJ06'
            elseif  ran >=13.58
                ID = 'IJ07'
            elseif  ran >=7.82
                ID = 'IJ08'
            elseif  ran >=3.29
                ID = 'IJ09'
            elseif  ran >=0.82
                ID = 'IJ10'
            elseif  ran >=0
                ID = 'IJ11'
            endif
        endif
        BJDebugMsg(R2S(ran)+":"+GetTypeIdName(ID))
        return ID
    endfunction

    function DGsort(int pid)
        int max = GetUnitIntState(Pu[1],150)
        int n = 1
        int f = 0
        int next = 0
        int now = 0
        int id = 0
        if  max > 10
            max = 10
        endif
        loop
            n = 1
            f = 0
            loop
                now = GetUnitIntState(Pu[1],150+n)
                next = GetUnitIntState(Pu[1],150+n+1)
                exitwhen next == 0
                if  now > next
                    SetUnitIntState(Pu[1],150+n,next)
                    SetUnitIntState(Pu[1],150+n+1,now)
                    HeroDGId[pid][n] = next
                    HeroDGId[pid][n+1] = now
                    f = 1
                endif
                n = n + 1
            endloop
            exitwhen f == 0
        endloop

        if  GetLocalPlayer() == Player(pid)
            for num = 1,max
                id = HeroDGId[pid][num]
                if  num > 10
                    DzFrameSetModel( BUTTON_Model[150+num-10], GetTypeIdIcon(id), 1, 0 )
                    if  id == 'IJ10'
                        DzFrameSetTexture(BUTTON_Back[190+num-10][0],"war3mapImported\\DGnumber0.tga",0)
                    elseif  id == 'IJ11'
                        DzFrameSetTexture(BUTTON_Back[190+num-10][0],"war3mapImported\\DGnumber11.tga",0)
                    else
                        DzFrameSetTexture(BUTTON_Back[190+num-10][0],"war3mapImported\\DGnumber"+I2S(id-'IJ00')+".tga",0)
                    endif
                else
                    DzFrameSetModel( BUTTON_Model[150+num], GetTypeIdIcon(id), 1, 0 )
                    if  id == 'IJ10'
                        DzFrameSetTexture(BUTTON_Back[190+num][0],"war3mapImported\\DGnumber0.tga",0)
                    elseif  id == 'IJ11'
                        DzFrameSetTexture(BUTTON_Back[190+num][0],"war3mapImported\\DGnumber11.tga",0)
                    else
                        DzFrameSetTexture(BUTTON_Back[190+num][0],"war3mapImported\\DGnumber"+I2S(id-'IJ00')+".tga",0)
                    endif
                endif


            end
        endif
    endfunction
    
  

    
    //刷新道果奖励UI
    function ReDGPrizeFrame(int pid)
        int id = 0
        int use = 30000
        if  GetLocalPlayer() == Player(pid)
            for i = 1,3
                id = GetUnitIntState(Pu[1],930+i)
                
                if  id > 0
                    DzFrameSetTexture( BUTTON_Back[940+i][0],"war3mapImported\\alpha.tga", 0)
                    DzFrameSetModel( BUTTON_Model[940+i], GetTypeIdIcon(id), 1, 0 )
                    DzFrameSetText(BUTTON_Text[940+i],GetTypeIdName(id))
                else
                    DzFrameSetTexture( BUTTON_Back[940+i][0],"ReplaceableTextures\\WorldEditUI\\Editor-Random-Item.blp", 0)
                    DzFrameSetModel( BUTTON_Model[940+i], "", 1, 0 )
                    DzFrameSetText(BUTTON_Text[940+i],"")
                endif
            end
            DzFrameSetText(BUTTON_Text[940],I2S(use)+"经验")
        endif
    endfunction
    

    
    
//添加道果
    function GivePlayerHeroDG(unit wu,int id)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int num = GetUnitIntState(Pu[1],150)
        if  num < MaxHeroLevel

            //BJDebugMsg(GetTypeIdIcon(id))
            num = num + 1
            SetUnitIntState(Pu[1],150+num,id)
            SetUnitIntState(Pu[1],150,num)
            SetPlayerTechResearched(Player(pid),'RJ0A'+num - 1,1)
            
            AddEquipState(Pu[1],id)
            HeroIncLevel(Pu[1])
            HeroAddExp(Pu[1],1)

            if  GameSaveClose == 0
                if  GetPlayerTechCount(Player(pid),'RY3F',true) > 0
                    SetEquipStateOfPlayer(Pu[1],id,0.08)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：拥有商城道具诛仙剑，额外获得8%道果属性！")
                endif
            endif
            if  GetUnitTypeId(wu) == 'H018'
                SpellS518.execute(Pu[1],id)//九转神功
            endif



            if  GetLocalPlayer() == Player(pid)
                ExpName.SetText(GetTypeIdName('IJ5A'+num))
            endif
            SetBoardText(3,pid+2,GetTypeIdName('IJ5A'+num))

            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r恭喜您！境界突破成功！")

            //境界突破提高技能等级
            if  num == 3 or num == 5 or num == 10
                HeroIncAbility(wu,5)
            endif
            if  id == 'IJ10'
                MissionAddNumFunc(pid,26,1)//获得混沌道果
            endif

            HeroDGId[pid][num] = id

            DGsort(pid)

        endif 
        SetUnitIntState(Pu[1],931,0)
        SetUnitIntState(Pu[1],932,0)
        SetUnitIntState(Pu[1],933,0)
        if  GetLocalPlayer() == Player(pid)
            Button.show = false
        endif
    endfunction


    function GetOpenDgUse(int pid,int index)->int
        int use = 0
        use = 10000
        return use
    endfunction

    
    
    function BoxShowOpenDg(int pid,int index)
        int use = GetOpenDgUse(pid,index)
        DzFrameShow(UI_TipsHead, true)
        SetTipsData(1,"","开启随机道果")
        SetTipsData(10,"","|cffffcc00消耗经验：|r"+I2S(use))
        ShowTipsUI()
    endfunction

    function ClickReDGPrize(int pid)
        int use = 30000
        if  HeroExExp >= use
            HeroExExp = HeroExExp - use
            SetUnitIntState(Pu[1],931,GetNewDGPrize(pid))
            SetUnitIntState(Pu[1],932,GetNewDGPrize(pid))
            SetUnitIntState(Pu[1],933,GetNewDGPrize(pid))
            if  GetLocalPlayer() == Player(pid)
                Button.show = true
                ReDGPrizeFrame(pid)
            endif
            ReHeroXpBar(pid)
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r经验不足|cffffcc00"+I2S(use)+"|r，无法刷新！")
        endif
    endfunction

    function PlayerClickDGPrize(int pid,int index)
        int id = GetUnitIntState(Pu[1],930+index)
        int use = 0
        if  id == 0
            //开道果

            if  GetUnitIntState(Pu[1],931) > 0
                use = GetOpenDgUse(pid,index)
                if  HeroExExp >= use
                    HeroExExp = HeroExExp - use
                    SetUnitIntState(Pu[1],930+index,GetNewDGPrize(pid))
                    if  GetLocalPlayer() == Player(pid)
                        ReDGPrizeFrame(pid)
                    endif
                    ReHeroXpBar(pid)

                    if  GetUnitIntState(Pu[1],931) > 0 and GetUnitIntState(Pu[1],932) > 0 and GetUnitIntState(Pu[1],933) > 0
                        DzFrameShow(BUTTON_Back[940][0],true)
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r经验不足|cffffcc00"+I2S(use)+"|r，无法开启！")
                endif
            endif
        else
            //激活道果
            GivePlayerHeroDG(Pu[1],id)
            
            if  GetLocalPlayer() == Player(pid)
                Button.show = false
            endif
        endif
    endfunction

    function GivePlayerDGPrizeFrame(int pid)
        int id = GetUnitIntState(Pu[1],931)
        
        
        if  id >= 'IJ01' and id <= 'IJ15'
            //给一个 防止上一个窗口残留
            GivePlayerHeroDG(Pu[1],id)
            if  GetLocalPlayer() == Player(pid)
                Button.show = false
            endif
        endif

        int id1 = GetNewDGPrize(pid)

        SetUnitIntState(Pu[1],931,id1)
        SetUnitIntState(Pu[1],932,0)
        SetUnitIntState(Pu[1],933,0)
        
        //PlayerRePrizeNum3 = 0

        if  GetLocalPlayer() == Player(pid)
            Button.show = true
            ReDGPrizeFrame(pid)
            DzFrameShow(BUTTON_Back[940][0],false)
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
            CreateButton(941+x,Button.frameid,TYPE_BUTTON,1,BUTTON_Back[931+x][0],1,0.0,-0.008,0.024,0.024,"ReplaceableTextures\\WorldEditUI\\Editor-Random-Item.blpa")
            CreateModelEx(941+x,Button.frameid,TYPE_BUTTON,6,BUTTON_Back[941+x][0],6,-0.002,0.00,"")
            CreateText(941+x,Button.frameid,"centertext008",1,7,0.0,-0.008,"|cff999999物品名称|r")
        end
        CreateButton(930,Button.frameid,TYPE_CLOSE,2,Button.frameid,2,0.0,0.0,0.03,0.016,"war3mapImported\\UI_ESC.tga")

        CreateButton(940,Button.frameid,TYPE_BUTTON,7,Button.frameid,7,0.0,0.005,0.1,0.024,"war3mapImported\\UI_ReDG_Button.tga")
        CreateText(940,BUTTON_Back[940][0],"text008",3,4,-0.005,0.0,"30000经验")
        
        Button.show = false
    endfunction
endlibrary
