library BossDamageFrame uses GameFrame,System,SystemCodes

    private FRAME Back = 0
    private FRAME Name = 0
    private int origin = 0

    
    function GetPlayerDamage(int pid)->real
        real dam = GetUnitRealState(Pu[1],99)
        return dam
    endfunction
    function GetAllDamage()->real
        real allDam = 0
        for pid = 0,3
            allDam = allDam + GetPlayerDamage(pid)
        end
        //DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"伤害"+R2S(allDam))
        return allDam
    endfunction
    
    function ClearDamageRanking()
        for i = 0,3
            DzFrameSetSize( BUTTON_Back[461+i][0], 0.001,0.01)
            DzFrameSetText( BUTTON_Text[461+i],"")
        end
    endfunction
    
    function RePlayerDamageRanking(int pid,bool show)
        real r1 = 0
        real allDam = 0
        real Dam = 0
        
        if  show == true
            allDam = GetAllDamage()
            Dam = GetPlayerDamage(pid)
            if  Dam > 0
                if  allDam > 0
                    Dam = GetPlayerDamage(pid)
                    r1 = Dam/allDam
                else
                    r1 = 0
                endif
                DzFrameSetText( BUTTON_Text[451+pid],GetPlayerNameOfColor(pid))
                DzFrameSetText( BUTTON_Text[461+pid],R2SI(r1*100)+"%")
                DzFrameSetSize( BUTTON_Back[461+pid][0], 0.14*(r1),0.01)
            else
                DzFrameSetText( BUTTON_Text[451+pid],GetPlayerNameOfColor(pid))
                DzFrameSetText( BUTTON_Text[461+pid],"0.0%")
                DzFrameSetSize( BUTTON_Back[461+pid][0], 0.001,0.01)
            endif
        else
            DzFrameSetSize( BUTTON_Back[461+pid][0], 0.001,0.01)
            DzFrameSetText( BUTTON_Text[451+pid],"")
            DzFrameSetText( BUTTON_Text[461+pid],"")
        endif
        
        DzFrameShow(BUTTON_Back[461+pid][0],show)
    endfunction
    
    function ReDamageRanking()
        for pid = 0,3
            if  IsPlaying(pid) == true
                RePlayerDamageRanking(pid,true)
            else
                RePlayerDamageRanking(pid,false)
            endif
        end
    endfunction
    
    
    
    func BossDamageUICloceEx()
        int time = 0
        Back.alpha = 255
        TimerStart(0.006,true)
        {
            if  time < 50
                time = time + 1
                Back.alpha = Back.alpha - 5
            else
                Back.show = false
                for pid = 0,3
                    SetUnitRealState(Pu[1],99,0)
                end
                endtimer
            endif
            flush locals
        }
        flush locals
    end
    
    func BossDamageUIClose()
        TimerStart(8,true)
        {
            BossDamageUICloceEx()
            endtimer
            flush locals
        }
        flush locals
    end

    func BossDamageUIOpen()
        int time = 0
        Back.show = true
        Back.alpha = 5
        TimerStart(0.006,true)
        {
            if  time < 50
                time = time + 1
                Back.alpha = Back.alpha + 5
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    end
    
    func ShowBossDamageUI(bool b)
        if  b == true
            BossDamageUIOpen()
        else
            BossDamageUIClose()
        endif
    end
    
    function BossDamageFrameInit()

        Back = FRAME.create()   //注册主背景
        Name = FRAME.create() //经验条


        

        //背景设置
        Back.frameid = FRAME.Tag("BACKDROP","BossDamag",GameUI,Back)
        Back.SetPoint(2,GameUI,2,-0.01,-0.16)
        Back.SetSize(0.15,0.17)
        Back.SetTexture("UI\\Widgets\\BattleNet\\bnet-inputbox-back.blp",0)
        Back.alpha = 200

        origin = Back.frameid

        Name.frameid = FRAME.Fdf("centertext012",origin,Name)
        Name.SetPoint(1,origin ,1,0,-0.008)
        Name.SetText("|cFF33FF00BOSS伤害排行|r")

        
        for i = 1,4
            CreateButton(450+i,origin,TYPE_FUNC,2,origin,2,0,-0.028-(i-1)*0.035,0.15,0.03,"war3mapImported\\shanghaipaihang_0.blp")
            CreateButton(460+i,origin,TYPE_FUNC,2,origin,2,0,-0.028-(i-1)*0.035,0.15,0.03,"war3mapImported\\shanghaipaihang_1.blp")
            CreateText(450+i,origin,"text009",5,5,-0.002,0,"123")
            CreateText(460+i,origin,"text009",5,3,0.0,0,"321")
        end

    endfunction



    function ShowBossDamageStringEx()
        for pid = 0,3
            PlayerBossDamageEx = GetUnitRealState(Pu[1],99)
        end
    endfunction
    
    function GetPlayerBossDamageShow(real damage)->string
        if  damage >= 100000000
            damage = damage/100000000
            if  damage > 10000
                return R2SI(damage/10000)+"万亿"
            else
                return R2SI(damage)+"亿"
            endif
        elseif  damage >= 10000
            return R2SI(damage/10000)+"万"
        else
            return R2SI(damage)
        endif
    endfunction
    
    function ShowBossDamageString()
        real min = 0
        int hat = 0
        real ch = 0
        int b = 1
        ShowBossDamageStringEx()
        for n = 1,4
            min = 0
            hat = -1
            for pid = 0,3
                ch = PlayerBossDamageEx
                if  ch > min and ch != 0
                    hat = pid
                    min = ch
                endif
            end
            if  hat != -1
                PlayerReal[hat][3] = 0
                if  b == 1
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,"|cffffcc00[伤害排行]：|r第"+I2S(b)+"名："+GetPlayerNameOfColor(hat)+" 伤害值:"+GetPlayerBossDamageShow(min)+"  |cffffff80奖励200杀敌数|r")
                    AddUnitRealState(PlayerUnit[hat][1],34,200)
                else
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,"|cffffcc00[伤害排行]：|r第"+I2S(b)+"名："+GetPlayerNameOfColor(hat)+" 伤害值:"+GetPlayerBossDamageShow(min))
                endif
                b = b + 1
            endif
        end
    endfunction
    
    
endlibrary


