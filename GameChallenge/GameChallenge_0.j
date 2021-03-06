library GameChallenge0 uses GameChallengeBase
    
    function GameChallenge_0_C_Death(int pid)
        if  GameChallengeBool[0] == true and GameChallengeBool[1] == true and GameChallengeBool[2] == false
            GameChallengeBool[2] = true
            for n = 4,5
                SetUnitAPOfBool(GameBiaoJI[n],2)
            end
            SetUnitAPOfBool(GameBiaoJI[6],3)
            if  GameMode == 4
                PlayerReviveX = -6752
                PlayerReviveY = -6752
            else
                PlayerReviveX = -6656
                PlayerReviveY = -6656
            endif
            SendPlayerUnit(pid,PlayerReviveX,PlayerReviveY)
            if  GameMode == 4
                if  pid == 0
                    PlayerReviveX = -4816
                    PlayerReviveY = 12496
                elseif  pid == 1
                    PlayerReviveX = -3344
                    PlayerReviveY = 12496
                elseif  pid == 2
                    PlayerReviveX = -3344
                    PlayerReviveY = 11056
                elseif  pid == 3
                    PlayerReviveX = -4816
                    PlayerReviveY = 11056
                endif
            else
                PlayerReviveX = -6752
                PlayerReviveY = -6752
            endif
            UnitAddItemEx(Pu[1],'E101')
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[完成任务]：|r奖励"+GetObjectName('E101')+"！")
            SetPlayerTaskUIChatOfPlayer(pid,"剧情","前日卜算，只知有一将星出世，想必就是阁下了。商汤气微，封神大典即将拉开序幕。道友可去西岐历练一番，日后可成大功！",0)
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff寻找周文王|r",0)
        endif
    endfunction


    function GameChallenge_0_B_Death(int pid)
        if  GameChallengeBool[0] == true
            GameChallengeInt[1] = GameChallengeInt[1] + 1
            if  GameChallengeBool[1] == false
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀妖魅|r|n|cffffcc00累积：|r"+I2S(GameChallengeInt[1])+"/20",0)
            endif
            if  GameChallengeInt[1] < 20
                if  GameChallengeInt[1] == 1 or ModuloInteger(GameChallengeInt[1],5) == 0
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r击杀妖魅("+I2S(GameChallengeInt[1])+"/20)")
                endif
            elseif  GameChallengeInt[1] == 20
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r击杀妖魅("+I2S(GameChallengeInt[1])+"/20)")
                GameChallengeBool[1] = true
                for n = 1,3
                    SetUnitAPOfBool(GameBiaoJI[n],1)
                end
                for n = 4,5
                    SetUnitAPOfBool(GameBiaoJI[n],2)
                end
                UnitAddItemEx(Pu[1],'E001')
                UnitAddItemEx(Pu[1],'E201')
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[完成任务]：|r奖励"+GetObjectName('E001')+"和"+GetObjectName('E201')+"！")
                SetPlayerTaskUIChatOfPlayer(pid,"姜子牙","妖魅已除，这些宝物就作为我的答谢了。唔？庄外妖气弥漫，似有妖物作祟。仁兄不若助我一臂之力，将其降伏？",0)
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀玉石琵琶精|r",0)

                
            endif
        endif
    endfunction

    function GameChallenge_0_A(int pid)
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

    function SendPlyaerToGameChalleng0(unit u)
        int pid = GetPlayerId(GetOwningPlayer(u))
        if  GameChallengeBool[0] == false
            SetUnitXY(u,GetUnitX(GameChallenge_0_JZY),GetUnitY(GameChallenge_0_JZY))
        endif
    endfunction

    function EnRctGameChallenge_0_JZY()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  GameChallengeBool[0] == false
                    GameChallengeBool[0] = true
                    SetPlayerTaskUIChatOfPlayer(pid,"姜子牙","宋兄待我不薄，此后花园乃风水之地，却造不起楼房，定是有妖魅作怪。可否替我前去一看？",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀20个妖魅|r",0)
                    SetUnitAPOfBool(GameBiaoJI[0],0)
                    for n = 1,3
                        SetUnitAPOfBool(GameBiaoJI[n],1)
                    end
                    SaveInteger(ht,GetHandleId(Pu[1]),'AT0A',1000)
                    SelectHeroAddSaveState.execute(pid)//读取属性
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
                if  GameChallengeBool[0] == true and GameChallengeBool[1] == true and GameChallengeBool[2] == true
                    if  GameChallengeBool[3] == false
                        GameChallengeBool[3] = true
                        SetUnitAPOfBool(GameBiaoJI[6],3)
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,5)
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[完成任务]：|r奖励玄铁x5！")
                        SetPlayerTaskUIChatOfPlayer(pid,"周文王","今飞熊应召，上天垂象，特赐大贤助我皇基，是我西岐的福泽。此后山有一莲池，乃修行宝地。大贤可前去修炼一番，以征战商汤。",0)
                        if  GameMode == 4
                            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff欢迎来到碧游宫|r",0)
                            AttackRoomPostion[pid][1] = PlayerReviveX
                            AttackRoomPostion[pid][2] = PlayerReviveY
                            HeroMoveToRoom.execute(pid)
                        else
                            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff使用F3传送至修炼池|r",0)
                        endif
                        if  GetLocalPlayer() == Player(pid)
                            for i = 2,3
                                DzFrameShow(BUTTON_Back[700+i][0], true)
                            end
                            DzFrameShow(BUTTON_Back[708][0], true)
                            DzFrameShow(BUTTON_Back[709][0], true)
                            if  GameMode == 4
                                DzFrameShow(BUTTON_Back[704][0], true)
                                CloseCollectFrame(pid)
                            endif
                        endif
                    endif
                endif
            endif
        endif
        flush locals
    endfunction

    function InitGameChallenge_0()
        trigger tig = null
        GameChallenge_0_JZY = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np07',-5696,-3200,180)
        EXSetUnitMoveType(GameChallenge_0_JZY,0x01)
        GameBiaoJI[0] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ07',-5696,-3200,0)
        CreateUnit(Player(9),'nc07',-5696,-3200,0)
        
        GameBiaoJI[1] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-5364.000,-3279.500,155.655)
        GameBiaoJI[2] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-5611.750,-3175.250,155.655)
        GameBiaoJI[3] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-5875.500,-3071.750,155.655)

        GameBiaoJI[4] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',-5800.000,-2487.750,31.256)
        GameBiaoJI[5] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',-5572.500,-2355.500,31.256)

        GameBiaoJI[6] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ07',GetUnitX(GameDefendUnit),GetUnitY(GameDefendUnit),0)

        for num = 0,6
            EXSetUnitMoveType(GameBiaoJI[num],0x01)
            SetUnitColor(GameBiaoJI[num], PLAYER_COLOR_RED )
            SetUnitVertexColor(GameBiaoJI[num],255,255,255,0)
        end
        
        tig = CreateTrigger() //姜子牙
        TriggerRegisterUnitInRange(tig, GameChallenge_0_JZY,150,null)
        TriggerAddAction(tig, function EnRctGameChallenge_0_JZY)

        tig = CreateTrigger() //周文王
        TriggerRegisterUnitInRange(tig, GameDefendUnit,250,null)
        TriggerAddAction(tig, function EnRctGameDefendUnit)

        tig = null
    endfunction

endlibrary
