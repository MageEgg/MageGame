library BossLifeBarFrame uses GameFrame,System,SystemCodes
    private FRAME Back = 0
    private FRAME Name = 0
    private FRAME Life = 0
    private FRAME Model1 = 0
    private FRAME Model2 = 0
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
        Model1 = FRAME.create()   //条1
        Model2 = FRAME.create()   //条2


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
        Model2.SetModel("war3mapImported\\ui_hpbar_black_npc_B.mdx",0,0)
        Model2.SetAnimate(0,true)

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


