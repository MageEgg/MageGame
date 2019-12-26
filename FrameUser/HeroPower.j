library HeroPowerFrame uses GameFrame
    /*
    81-90   数字显示
    91-100  增加显示
    */

    private FRAME Model1 = 0
    private FRAME Model2 = 0
    private int AngerNow = 0
    private int AngerNew = 0

    private FRAME Button = 0
    private FRAME Back = 0
    private int PowerNow = 0
    private int PowerNew = 0
    private int PowerNum = 0




    //怒气条刷新

    function ReAngerBar(int pid,real newoff)
        if  GetLocalPlayer() == Player(pid)
            real off = Model2.offset
            off = off + (I2R(AngerNew)-I2R(AngerNow))/1000
            if  off >= newoff
                off = newoff
                AngerNow = AngerNew
            endif
            Model2.SetAnimate(0,false)
            Model2.offset = off
        endif
    endfunction

    function SetAngerBar(int pid,int num)
        if  GetLocalPlayer() == Player(pid)
            AngerNew = num
        endif
    endfunction

    


    //战斗力刷新
    function RePlayerHeroPower(int pid,int num)
        int long = StringLength(I2S(num))
        if  GetLocalPlayer() == Player(pid)
            for i = 1,10
                if  i > long
                    DzFrameSetTexture(BUTTON_Back[80+i][0],"war3mapImported\\alpha.tga",0)
                else
                    DzFrameSetTexture(BUTTON_Back[80+i][0],"war3mapImported\\UI_Number"+SubString(I2S(num),i-1,i)+".tga",0)
                    
                endif
            end
            DzFrameClearAllPoints(Back.frameid)
            Back.SetPoint(3,BUTTON_Back[80+long][0],5,0.0,0.0)
        endif
    endfunction


    function ShowPlayerHeroPowerAdd(int pid,int num)
        int long = StringLength(I2S(num))
        if  GetLocalPlayer() == Player(pid)
            Back.SetTexture("war3mapImported\\UI_SmallNumBack.tga",0)
            for i = 1,10
                if  i > long
                    DzFrameSetTexture(BUTTON_Back[90+i][0],"war3mapImported\\alpha.tga",0)
                else
                    DzFrameSetTexture(BUTTON_Back[90+i][0],"war3mapImported\\UI_SmallNum"+SubString(I2S(num),i-1,i)+".tga",0)
                    
                endif
            end
            Back.alpha = 255
            Back.show = true
        endif
    endfunction

    function ShowPlayerHeroPowerRem(int pid,int num)
        int long = StringLength(I2S(num))
        if  GetLocalPlayer() == Player(pid)
            Back.SetTexture("war3mapImported\\UI_SmallNumBack2.tga",0)
            for i = 1,10
                if  i > long
                    DzFrameSetTexture(BUTTON_Back[90+i][0],"war3mapImported\\alpha.tga",0)
                else
                    DzFrameSetTexture(BUTTON_Back[90+i][0],"war3mapImported\\UI_SmallNum2"+SubString(I2S(num),i-1,i)+".tga",0)
                    
                endif
            end
            Back.alpha = 255
            Back.show = true
        endif
    endfunction

    function SetPlayerHeroPower(int pid,int num)
        if  GetLocalPlayer() == Player(pid)
            PowerNew = num
        endif
    endfunction







    function PlayerHeroPowerTimer()
        for pid = 0,3
            if  GetLocalPlayer() == Player(pid)
                
                if  PowerNow != PowerNew
                    if  PowerNum == 0
                        PowerNum = 20
                        if  PowerNew > PowerNow
                            ShowPlayerHeroPowerAdd(pid,PowerNew-PowerNow)
                        else
                            ShowPlayerHeroPowerRem(pid,PowerNow-PowerNew)
                        endif
                        //新的
                    else
                        PowerNum = PowerNum - 1
                    endif
                    
                    if  PowerNum > 0
                        if  PowerNum > 10
                            RePlayerHeroPower(pid,PowerNow+(PowerNew-PowerNow)/(PowerNum-10))
                        else
                            Back.alpha = Back.alpha - 10
                        endif
                    else
                        PowerNow = PowerNew
                        PowerNum = 0
                        Back.show = false
                    endif
                endif
                if  AngerNow != AngerNew
                    ReAngerBar(pid,I2R(AngerNew)/100)
                endif

            endif
        end
    endfunction


    function HeroPowerFrameInit()
        Model1 = FRAME.create()  //注册怒气条
        Model2 = FRAME.create()  //注册怒气条

        Button = FRAME.create() //背景注册
        Back = FRAME.create() //背景2注册


        Button.frameid = FRAME.Tag("BACKDROP","Power",GameUI,Button)
        Button.SetPoint(7,GetFrameUnitDetail(),1,0,0.01)
        Button.SetSize(0.25,0.025)
        Button.SetTexture("war3mapImported\\UI_zhandouli.tga",0)
        
        PowerNow = 0
        PowerNew = 0
        PowerNum = 0

        CreateButton(81,Button.frameid,TYPE_NULL,3,Button.frameid,3,0.075,0.0,0.028,0.038, "war3mapImported\\alpha.tga")

        for i = 2,10
            CreateButton(80+i,Button.frameid,TYPE_NULL,3,BUTTON_Back[79+i][0],5,-0.014,0.0,0.028,0.038, "war3mapImported\\alpha.tga")
        end



        Back.frameid = FRAME.Tag("BACKDROP","Power",GameUI,Back)
        Back.SetPoint(3,BUTTON_Back[81][0],5,0.0,0.0)
        Back.SetSize(0.01,0.01)
        Back.SetTexture("war3mapImported\\UI_SmallNumBack.tga",0)

        CreateButton(91,Back.frameid,TYPE_NULL,3,Back.frameid,5,-0.006,0,0.012,0.012, "war3mapImported\\UI_SmallNum0.tga")
        for i = 2,10
            CreateButton(90+i,Back.frameid,TYPE_NULL,3,BUTTON_Back[89+i][0],5,-0.006,0.0,0.012,0.012, "war3mapImported\\UI_SmallNum"+I2S(i-1)+".tga")
        end

        Back.show = false


        Model1.frameid = FRAME.Tag("SPRITE","Hero",GameUI,Model1)
        Model1.SetPoint(7,GameUI,7,0.163,0.15)
        Model1.SetModel("ui_expbar70.mdx",0,0)
        Model1.SetAnimate(0,true)

        
        Model2.frameid = FRAME.Tag("SPRITE","Hero",Model1.frameid,Model2)
        Model2.SetPoint(0,Model1.frameid,0,0.0,0.0)
        Model2.SetModel("ui_expbar_black70.mdx",0,0)
        Model2.SetAnimate(0,false)
        



        TimerStart(CreateTimer(),0.03,true,function PlayerHeroPowerTimer)

    endfunction
endlibrary
