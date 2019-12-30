library BossDamageFrame uses GameFrame

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
            DzFrameSetSize( EquipButton_back[401+i][3], 0.001,0.01)
            DzFrameSetText( EquipButton_text[401+i][2],"")
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
                DzFrameSetText( EquipButton_text[401+pid][1],GetPlayerNameOfColor(pid))
                DzFrameSetText( EquipButton_text[401+pid][2],R2SI(r1*100)+"%")
                DzFrameSetSize( EquipButton_back[401+pid][3], 0.14*(r1),0.01)
            else
                DzFrameSetText( EquipButton_text[401+pid][1],GetPlayerNameOfColor(pid))
                DzFrameSetSize( EquipButton_back[401+pid][3], 0.001,0.01)
                DzFrameSetText( EquipButton_text[401+pid][2],"0.0%")
            endif
        else
            DzFrameSetSize( EquipButton_back[401+pid][3], 0.001,0.01)
            DzFrameSetText( EquipButton_text[401+pid][2],"")
        endif
        
        DzFrameShow(EquipButton_back[401+pid][1],show)
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
        int hp = 255
        int time = 0
        TimerStart(0.006,true)
        {
            if  time < 50
                time = time + 1
                hp = hp - 5
                DzFrameSetAlpha(DamageBoardFrame,hp)
            else
                DzFrameShow(DamageBoardFrame,false)
                IsBossDamageUIShow = false
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
        int hp = 5
        int time = 0
        DzFrameShow(DamageBoardFrame,true)
        DzFrameSetAlpha(DamageBoardFrame,hp)
        IsBossDamageUIShow = true
        TimerStart(0.006,true)
        {
            if  time < 50
                time = time + 1
                hp = hp + 5
                DzFrameSetAlpha(DamageBoardFrame,hp)
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

        name.frameid = FRAME.Fdf("centertext010",origin,Name)
        name.SetPoint(1,origin ,1,0,-0.008)
        name.SetText("|cFF33FF00BOSS伤害排行|r")

        
        for i = 1,4
            CreateDamageShowItem(i+450,TYPE_FUNC,MyFrame_ACHOR_TopRight,DamageBoardFrame,MyFrame_ACHOR_TopRight,0,-0.028-(i-1)*0.035,0.15,0.03,"")
        end
        DzFrameShow(DamageBoardFrame,false)
    endfunction
    
    
endlibrary


