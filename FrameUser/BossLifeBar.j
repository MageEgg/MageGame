library BossLifeBarFrame uses GameFrame,System,SystemCodes
    private FRAME Back = 0
    private FRAME Name = 0
    private FRAME Life = 0
    private FRAME Time = 0
    private FRAME Model1 = 0
    private FRAME Model2 = 0
    private FRAME Model3 = 0
    private FRAME Model4 = 0
    private int origin = 0


    function BossLifeBarFrameTimer()
        real life = 0
        real maxlife = 0
        for pid = 0,3
            if  GetUnitTypeId(Pu[6]) != 0 and Pu[6] != null
                if  Udis(Pu[1],Pu[6]) < 2000
                    if  GetLocalPlayer() == Player(pid)
                        if  GetUnitAbilityLevel(Pu[6],'AZ01') > 0
                            Back.SetTexture("war3mapImported\\UI_Life_4.tga", 0)
                        else
                            Back.SetTexture("war3mapImported\\UI_Life_1.tga", 0)
                        endif
                        life = GetUnitState(Pu[6],UNIT_STATE_LIFE)
                        maxlife = GetUnitState(Pu[6],UNIT_STATE_MAX_LIFE)
                        Life.SetText(I2S(R2I(life))+"/"+I2S(R2I(maxlife)))
                        Name.SetText(GetUnitName(Pu[6]))
                        Model2.SetAnimate(0,false)
                        Model2.offset = life /maxlife
                        Back.show = true
                    endif
                else
                    Pu[6] = null
                endif
            else
                if  GetLocalPlayer() == Player(pid)
                    Back.show = false
                endif
            endif
        end
    endfunction

    function BossLifeBarFrameInit()
        Back = FRAME.create()   //注册头像
        Name = FRAME.create()   //注册名称
        Life = FRAME.create()   //注册生命文本
        Time = FRAME.create()   //注册剩余时间
        Model1 = FRAME.create()   //条1
        Model2 = FRAME.create()   //条2
        Model3 = FRAME.create()   //条3
        Model4 = FRAME.create()   //条4

        Back.frameid = FRAME.Tag("BACKDROP","BossLife",GameUI,Back)
        Back.SetPoint(2,GameUI,1,-0.128,-0.05)
        Back.SetSize(0.036,0.036)
        Back.SetTexture("war3mapImported\\UI_Life_1.tga", 0)
        origin = Back.frameid

        Model1.frameid = FRAME.Tag("SPRITE","BossLife",origin,Model1)
        Model1.SetPoint(3,Back.frameid,5,-0.128,0.006)
        Model1.SetModel("war3mapImported\\ui_hpbar_B.mdx",0,0)
        Model1.SetAnimate(0,true)

        
        Model2.frameid = FRAME.Tag("SPRITE","BossLife",origin,Model2)
        Model2.SetPoint(0,Model1.frameid,0,0.0,0.0)
        Model2.SetModel("war3mapImported\\ui_hpbar_ black_npc_B.mdx",0,0)
        Model2.SetAnimate(0,true)


        Model3.frameid = FRAME.Tag("SPRITE","BossLife",origin,Model3)
        Model3.SetPoint(3,origin,5,-0.0005,-0.005)
        Model3.SetModel("ui_expbar70.mdx",0,0)
        Model3.SetAnimate(0,true)

        
        Model4.frameid = FRAME.Tag("SPRITE","BossLife",origin,Model4)
        Model4.SetPoint(0,Model3.frameid,0,0.0,0.0)
        Model4.SetModel("ui_expbar_black70.mdx",0,0)
        Model4.SetAnimate(0,true)
        Model4.offset = 1

        Time.frameid = FRAME.Fdf("text010",origin,Time)
        Time.SetPoint(3,Model3.frameid ,3,0.197,-0.0192)
        Time.SetText("击杀倒计时:5s")
        

        Life.frameid = FRAME.Fdf("centertext010",origin,Life)
        Life.SetPoint(4,Back.frameid ,5,0.128,-0.01)
        Life.SetText("12313213/132132132")


        Name.frameid = FRAME.Fdf("text013",origin,Name)
        Name.SetPoint(0,Back.frameid ,2,0.002,-0.002)
        Name.SetText("无墨傻逼")

        Back.show = false

        TimerStart(CreateTimer(),0.1,true,function BossLifeBarFrameTimer)
        
    endfunction

endlibrary


