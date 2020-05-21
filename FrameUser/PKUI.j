library PKUI uses GameFrame
    private FRAME Button
    private FRAME Back
    private FRAME TextDay
    private FRAME TextTime
    private int origin = 0

    FRAME PKUIButton

    //801-810 811-820 821-830 831-840 道果

    //841-850 851-860 861-870 871-880 战斗力

    //881-884 头像

    //885 886 887 玩家1
    //888 889 890 玩家2
    //891 892 893 玩家3
    //894 895 896 玩家4
    //战斗力刷新

    
    function RePKUINumber(int pid,int index,int num)
        int long = StringLength(I2S(num))
    
        for i = 1,8
            if  i > long
                DzFrameSetTexture(BUTTON_Back[index+i][0],"war3mapImported\\alpha.tga",0)
            else
                DzFrameSetTexture(BUTTON_Back[index+i][0],"war3mapImported\\UI_Number"+SubString(I2S(num),i-1,i)+".tga",0)
            endif
        end
        
    endfunction

    private function GetTimeTips()->string
        int h = GameTime/3600
        int m = (GameTime-h*3600)/60
        int s = GameTime-h*3600-m*60
        string sh
        string sm
        string ss
        if  h >= 10
            sh = I2S(h)
        else
            sh = "0"+I2S(h)
        endif
        if  m >= 10
            sm = I2S(m)
        else
            sm = "0"+I2S(m)
        endif
        if  s >= 10
            ss = I2S(s)
        else
            ss = "0"+I2S(s)
        endif

        return sh+":"+sm+":"+ss
    endfunction


    function RePKUI()
        int index = 0

        TextTime.SetText(GetTimeTips())

        TextDay.SetText(I2S(TimeYear) + "年" + I2S(TimeMon)+"月"+ I2S(TimeDay)+"日")

        

        for pid = 0,3
            if  IsPlaying(pid) == true
                DzFrameSetText(BUTTON_Text[880+pid],"<"+PlayerColor+GetPlayerName(Player(pid))+"|r>"+GetUnitName(Pu[1]))
                DzFrameSetTexture( BUTTON_Back[880+pid][0],GetTypeIdIcon(GetUnitTypeId(Pu[1])), 0)

                index = 885 + pid*3//技能
                DzFrameSetTexture( BUTTON_Back[index+0][0],GetTypeIdIcon(GetHeroAbilityID(Pu[1],1)), 0)
                DzFrameSetTexture( BUTTON_Back[index+1][0],GetTypeIdIcon(GetHeroAbilityID(Pu[1],2)), 0)
                DzFrameSetTexture( BUTTON_Back[index+2][0],GetTypeIdIcon(GetHeroAbilityID(Pu[1],4)), 0)


                RePKUINumber(pid,840+pid*10,GetHeroZdl(Pu[1]))
                for i = 1,10
                    index = 800 + i + pid*10
                    DzFrameSetModel( BUTTON_Model[index], GetTypeIdIcon(HeroDGId[pid][i]), 1, 0 )
                end
            endif
        end
        
        Button.show = true
    endfunction

    function PKUIInit()
        Button = FRAME.create() //背景注册
        Back = FRAME.create()   //注册主背景

        TextDay = FRAME.create() //背景文字
        TextTime = FRAME.create() //背景文字

        //控件设置
        Button.frameid = FRAME.Tag("BUTTON","PK",GameUI,Button)
        Button.SetPoint(4,GameUI,4,0,0.02)
        Button.SetSize(0.6,0.4)
        origin = Button.frameid

        //背景设置
        Back.frameid = FRAME.Tag("BACKDROP","PK",origin,Back)
        Back.SetPoint(4,origin,4,0,0.02)
        Back.SetSize(0.6,0.4)
        Back.SetTexture("war3mapImported\\UI_speed_Bacj.tga",0)


        TextTime.frameid = FRAME.Fdf("centertext012",origin,TextTime)
        TextTime.SetPoint(4,origin,0,0.253,-0.058)
        TextTime.SetText("00:00:00")

        TextDay.frameid = FRAME.Fdf("centertext012",origin,TextDay)
        TextDay.SetPoint(4,origin,0,0.405,-0.058)
        TextDay.SetText("00:00:00")
        


        int index = 0

        for y = 0,3
            
            for i = 1,10
                index = 800 + i + y*10
                CreateButton(index,Button.frameid,TYPE_FUNC,0,Button.frameid,0,0.11+0.027*(i-1),-0.125-I2R(y)*0.0445,0.025,0.025,"war3mapImported\\UI_speed_DG.tga")
                CreateModel(index,Button.frameid,TYPE_FUNC,6,6,-0.002,-0.002,"")

                if  i <= 8
                    index = 840 + i + y*10
                    CreateButton(index,Button.frameid,TYPE_FUNC,0,Button.frameid,0,0.455+0.011*(i-1),-0.122-I2R(y)*0.0445,0.022,0.034,"war3mapImported\\alpha.tga")
                endif
            end

            index = 880 + y//头像
            CreateButton(index,Button.frameid,TYPE_FUNC,0,Button.frameid,0,0.07,-0.115-I2R(y)*0.0445,0.033,0.033,"war3mapImported\\UI_speed_hero.tga")

            CreateText(index,Button.frameid,"text010",6,2,0.01,-0.008,"")

            index = 885 + y*3//技能
            CreateButton(index+0,Button.frameid,TYPE_FUNC,0,Button.frameid,0,0.381+0.000,-0.126-I2R(y)*0.0445,0.024,0.024,"war3mapImported\\UI_speed_button.tga")
            CreateButton(index+1,Button.frameid,TYPE_FUNC,0,Button.frameid,0,0.381+0.025,-0.126-I2R(y)*0.0445,0.024,0.024,"war3mapImported\\UI_speed_button.tga")
            CreateButton(index+2,Button.frameid,TYPE_FUNC,0,Button.frameid,0,0.381+0.050,-0.126-I2R(y)*0.0445,0.024,0.024,"war3mapImported\\UI_speed_button.tga")

        end

        Button.show = false

        PKUIButton = Button
        
    endfunction
    
endlibrary


