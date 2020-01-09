library GameChallenge0 uses GameChallengeBase
    
    function GameChallenge_0_C_Death(int pid)
        if  GameChallengBool[0] == true and GameChallengBool[1] == true
            GameChallengBool[2] = true
            for n = 4,5
                SetUnitAPOfBool(GameBiaoJI[n],2)
            end
            UnitAddAbility(Pu[1],'AZ16')
            SetUnitAPOfBool(GameBiaoJI[6],3)
            PlayerReviveX = -6656
            PlayerReviveY = -6656
            SendPlayerUnit(pid,PlayerReviveX,PlayerReviveY)
            PlayerReviveX = -6752
            PlayerReviveY = -6752
            SetPlayerTaskUIChatOfPlayer(pid,"剧情","前日卜算，只知有一将星出世，想必就是阁下了。商汤气微，封神大典即将拉开序幕。道友可去西岐历练一番，日后可成大功！",0)
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff寻找周文王|r",0)
        endif
    endfunction


    function GameChallenge_0_B_Death(int pid)
        if  GameChallengBool[0] == true
            GameChallengInt[1] = GameChallengInt[1] + 1
            if  GameChallengBool[1] == false
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀妖魅|r|n|cffffcc00累积：|r"+I2S(GameChallengInt[1])+"/20",0)
            endif
            if  GameChallengInt[1] < 20
                if  GameChallengInt[1] == 1 or ModuloInteger(GameChallengInt[1],5) == 0
                    //DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r击杀妖魅("+I2S(GameChallengInt[1])+"/20)")
                endif
            elseif  GameChallengInt[1] == 20
                GameChallengBool[1] = true
                for n = 1,3
                    SetUnitAPOfBool(GameBiaoJI[n],1)
                end
                for n = 4,5
                    SetUnitAPOfBool(GameBiaoJI[n],2)
                end
                UnitAddItemEx(Pu[1],'E201')
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[完成任务]：|r奖励"+GetObjectName('E201')+"！\n")
                SetPlayerTaskUIChatOfPlayer(pid,"姜子牙","妖魅已除，这些宝物就作为我的答谢了。唔？庄外妖气弥漫，似有妖物作祟。仁兄不若助我一臂之力，将其降伏？",0)
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀玉石琵琶精|r",0)
            endif
        endif
    endfunction

    function GameChallenge_0_A(int pid)
        SetPlayerZDLPointEx(pid,true,0)
        ShowPlayerTaskUIOfPlayer(pid,true,0)
        SetPlayerTaskUIChatOfPlayer(pid,"剧情","纣王昏庸无道，商朝气运将至。姜子牙奉命下山主持封神榜，此时寄居于旧友宋异人府中，静待明君现世！",0.3)
        SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff寻找姜子牙|r",0.3)
        SetUnitAPOfBool(GameBiaoJI[0],0)
    endfunction
    
    function GameChallenge_0Start(int id)
        int pid = id
        TimerStart(1.5,false)
        {
            GameChallenge_0_A(pid)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function EnRctGameChalleng_0_JZY()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  GameChallengBool[0] == false
                    GameChallengBool[0] = true
                    UnitAddItemEx(Pu[1],'E001')
                    UnitAddItemEx(Pu[1],'E101')
                    UnitAddAbility(Pu[1],'AZ15')
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[完成任务]：|r奖励"+GetObjectName('E001')+"和"+GetObjectName('E101')+"！\n")
                    SetPlayerTaskUIChatOfPlayer(pid,"姜子牙","宋兄待我不薄，此后花园乃风水之地，却造不起楼房，定是有妖魅作怪。可否替我前去一看？",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀20个妖魅|r",0)
                    SetUnitAPOfBool(GameBiaoJI[0],0)
                    for n = 1,3
                        SetUnitAPOfBool(GameBiaoJI[n],1)
                    end
                endif
            endif
        endif
        flush locals
    endfunction

    function EnRctGameDefendUnit()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  GameChallengBool[0] == true and GameChallengBool[1] == true and GameChallengBool[2] == true
                    if  GameChallengBool[3] == false
                        GameChallengBool[3] = true
                        SetUnitAPOfBool(GameBiaoJI[6],3)
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,1000)
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[完成任务]：|r奖励1000金币！\n")
                        SetPlayerTaskUIChatOfPlayer(pid,"周文王","今飞熊应召，上天垂象，特赐大贤助我皇基，是我西岐的福泽。此后山有一莲池，乃修行宝地。大贤可前去修炼一番，以征战商汤。",0)
                        SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff使用F3传送至修炼池|r",0)
                        ShowPlayerTaskUIOfPlayer(pid,false,2.5)
                        SetPlayerTaskUIChatOfPlayer(pid," "," ",2.5)
                        SetPlayerTaskUITaskOfPlayer(pid," ",2.5)
                        SetPlayerZDLPointEx(pid,false,2.7)
                    endif
                endif
            endif
        endif
        flush locals
    endfunction

    function InitGameChallenge_0()
        trigger tig = null
        GameChalleng_0_JZY = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np07',-4672,-3840,180)
        EXSetUnitMoveType(GameChalleng_0_JZY,0x01)
        GameBiaoJI[0] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e007',-4672,-3840,0)
        
        GameBiaoJI[1] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',-5493.500,-3660.500,136.589)
        GameBiaoJI[2] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',-5715.250,-3460.750,136.589)
        GameBiaoJI[3] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',-5931.000,-3247.000,136.589)

        GameBiaoJI[4] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',-5730.500,-2583.250,32.262)
        GameBiaoJI[5] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',-5482.500,-2427.000,32.262)

        GameBiaoJI[6] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e007',GetUnitX(GameDefendUnit),GetUnitY(GameDefendUnit),0)

        for num = 0,6
            EXSetUnitMoveType(GameBiaoJI[num],0x01)
            SetUnitColor(GameBiaoJI[num], PLAYER_COLOR_RED )
            SetUnitVertexColor(GameBiaoJI[num],255,255,255,0)
        end
        
        tig = CreateTrigger() //姜子牙
        TriggerRegisterUnitInRange(tig, GameChalleng_0_JZY,150,null)
        TriggerAddAction(tig, function EnRctGameChalleng_0_JZY)

        tig = CreateTrigger() //周文王
        TriggerRegisterUnitInRange(tig, GameDefendUnit,250,null)
        TriggerAddAction(tig, function EnRctGameDefendUnit)

        tig = null
    endfunction

endlibrary
