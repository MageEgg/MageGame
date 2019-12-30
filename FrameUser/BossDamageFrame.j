library BossDamageFrame uses GameFrame

    int DamageBoardFrame = 0
    bool IsBossDamageUIShow = false
    private int name = 0
    
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
    
    function CreateDamageShowItem(int id,int Type,int p1,int DadFrame,int p2,real x,real y,real sizex,real sizey,string origin)
        EquipButton_back[id][1] = DzCreateFrameByTagName("BACKDROP","DamageShowItem_1"+I2S(id), DadFrame,"template",0)
        DzFrameSetTexture(EquipButton_back[id][1], "war3mapImported\\alpha.tga", 0)
        DzFrameSetPoint( EquipButton_back[id][1], p1, DadFrame, p2, x, y)
        DzFrameSetSize( EquipButton_back[id][1], sizex,sizey)
        
        EquipButton_back[id][2] = DzCreateFrameByTagName("BACKDROP","DamageShowItem_2"+I2S(id), EquipButton_back[id][1],"template",0)
        DzFrameSetTexture(EquipButton_back[id][2], "war3mapImported\\shanghaipaihang_0.blp", 0)
        DzFrameSetPoint( EquipButton_back[id][2], MyFrame_ACHOR_TopRight, EquipButton_back[id][1], MyFrame_ACHOR_TopRight,0 , -0.015 )
        DzFrameSetSize( EquipButton_back[id][2], sizex,0.01)
        
        EquipButton_back[id][3] = DzCreateFrameByTagName("BACKDROP","DamageShowItem_3"+I2S(id), EquipButton_back[id][2],"template",0)
        DzFrameSetTexture(EquipButton_back[id][3], "war3mapImported\\shanghaipaihang_1.blp", 0)
        DzFrameSetPoint( EquipButton_back[id][3], MyFrame_ACHOR_Right, EquipButton_back[id][2], MyFrame_ACHOR_Right,0 , 0 )
        DzFrameSetSize( EquipButton_back[id][3], sizex*0.01,0.01)
        
        EquipButton_text[id][1] = DzCreateFrame("itemnumber",EquipButton_back[id][1], EquipButton_back[id][3])
        call DzFrameSetPoint( EquipButton_text[id][1], MyFrame_ACHOR_TopRight, EquipButton_back[id][1], MyFrame_ACHOR_TopRight, -0.002, 0)
        
        EquipButton_text[id][2] = DzCreateFrame("itemnumber",EquipButton_back[id][1], EquipButton_text[id][1])
        call DzFrameSetPoint( EquipButton_text[id][2], MyFrame_ACHOR_TopRight, EquipButton_back[id][2], MyFrame_ACHOR_TopRight, -0.002, 0)
        
        EquipButton_text[id][3] = DzCreateFrame("text010",EquipButton_back[id][1], EquipButton_text[id][2])
        call DzFrameSetPoint( EquipButton_text[id][3], MyFrame_ACHOR_TopRight, EquipButton_back[id][3], MyFrame_ACHOR_TopLeft, -0.002, 0)
        
        EquipButton_back[id][5] = DzCreateFrameByTagName("BACKDROP","DamageShowItem_8"+I2S(id), EquipButton_back[id][1],"template",0)
        DzFrameSetPoint( EquipButton_back[id][5], MyFrame_ACHOR_Center, EquipButton_back[id][1], MyFrame_ACHOR_Center,0 , 0 )
        DzFrameSetSize( EquipButton_back[id][5], sizex,sizey)
        DzFrameSetTexture(EquipButton_back[id][5], "war3mapImported\\alpha.tga", 0)
        
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
    
    function InitDamageShowFrame()
        DamageBoardFrame = DzCreateFrameByTagName("BACKDROP","DamageBoardFrame", DzGetGameUI(),"template",0)
        DzFrameSetTexture(DamageBoardFrame, "UI\\Widgets\\BattleNet\\bnet-inputbox-back.blp", 0)
        DzFrameSetPoint(DamageBoardFrame, MyFrame_ACHOR_TopRight, DzGetGameUI(), MyFrame_ACHOR_TopRight, -0.01, -0.16)
        DzFrameSetSize(DamageBoardFrame, 0.15,0.17)
        DzFrameSetAlpha( DamageBoardFrame,200)
        
        name = DzCreateFrame("BossTips",DamageBoardFrame, DamageBoardFrame)
        DzFrameSetPoint( name, MyFrame_ACHOR_Top, DamageBoardFrame, MyFrame_ACHOR_Top, 0, -0.008)
        DzFrameSetText( name, "|cFF33FF00BOSS伤害排行|r" )
        
        for i = 1,4
            CreateDamageShowItem(i+400,TYPE_FUNC,MyFrame_ACHOR_TopRight,DamageBoardFrame,MyFrame_ACHOR_TopRight,0,-0.028-(i-1)*0.035,0.15,0.03,"")
        end
        DzFrameShow(DamageBoardFrame,false)
    endfunction
    
    
endlibrary


