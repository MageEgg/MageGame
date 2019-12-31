library GameChallenge0 uses GameChallengeBase

    function GameChallenge_0_C_Death(int pid)
        if  GameChallengBool[0] == true and GameChallengBool[1] == true
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r击杀玉石琵琶精(1/1)")
            GameChallengBool[2] = true
            for n = 4,5
                SetUnitAPOfBool(GameBiaoJI[n],2)
            end
            PlayerReviveX = -6528
            PlayerReviveY = -7520
            SendPlayerUnit(pid,PlayerReviveX,PlayerReviveY)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r前日卜算，只知有一将星出世，想必就是阁下了。商汤气微，封神大典即将拉开序幕。道友可去西岐历练一番，日后可成大功！")
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff寻找周文王|r)
        endif
    endfunction


    function GameChallenge_0_B_Death(int pid)
        if  GameChallengBool[0] == true
            GameChallengInt[1] = GameChallengInt[1] + 1
            if  GameChallengInt[1] < 20
                if  GameChallengInt[1] == 1 or ModuloInteger(GameChallengInt[1],5) == 0
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r击杀妖魅("+I2S(GameChallengInt[1])+"/20)")
                endif
            elseif  GameChallengInt[1] == 20
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r击杀妖魅("+I2S(GameChallengInt[1])+"/20)")
                GameChallengBool[1] = true
                for n = 1,3
                    SetUnitAPOfBool(GameBiaoJI[n],1)
                end
                for n = 4,5
                    SetUnitAPOfBool(GameBiaoJI[n],2)
                end
                UnitAddItemEx(Pu[1],'E201')
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r妖魅已除，这些宝物就作为我的答谢了。唔？庄外妖气弥漫，似有妖物作祟。仁兄不若助我一臂之力，将其降伏？")
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀玉石琵琶精|r)
            endif
        endif
    endfunction

    function GameChallenge_0_A(int pid)
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r纣王昏庸无道，商朝气运将至。姜子牙奉命下山主持封神榜，此时寄居于旧友宋异人府中，静待明君现世！")
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff寻找姜子牙|r)
        SetUnitAPOfBool(GameBiaoJI[0],0)
    endfunction
    
    function GameChallenge_0Start(int id)
        int pid = id
        TimerStart(2,false)
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
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务]：|r宋兄待我不薄，此后花园乃风水之地，却造不起楼房，定是有妖魅作怪。可否替我前去一看?")
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀20个妖魅|r)
                    SetUnitAPOfBool(GameBiaoJI[0],0)
                    for n = 1,3
                        SetUnitAPOfBool(GameBiaoJI[n],1)
                    end
                endif
            endif
        endif
        flush locals
    endfunction

    function InitGameChallenge_0()
        trigger tig = null
        GameChalleng_0_JZY = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np07',-4704,-4064,180)
        GameBiaoJI[0] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e007',-4704,-4064,0)

        GameBiaoJI[1] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',-5889.750,-4103.000,112.537)
        GameBiaoJI[2] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',-5996.500,-3829.000,112.537)
        GameBiaoJI[3] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',-6119.000,-3517.000,112.537)
        GameBiaoJI[4] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',-5674.000,-2726.250,48.455)
        GameBiaoJI[5] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',-5462.750,-2476.000,48.455)

        for num = 0,5
            SetUnitVertexColor(GameBiaoJI[num],255,255,255,0)
        end
        
        tig = CreateTrigger() //姜子牙
        TriggerRegisterUnitInRange(tig, GameChalleng_0_JZY,150,null)
        TriggerAddAction(tig, function EnRctGameChalleng_0_JZY)

        tig = null
    endfunction

    

endlibrary
