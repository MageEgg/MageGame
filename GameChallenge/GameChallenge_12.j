library GameChallenge12 uses GameChallengeBase

    function FlushGameTeamChallenge2()
        for num = 0,2
            SetUnitVertexColor(GameTeamChallengUnit(40+num),255,255,255,0)
            UnitRemoveAbility(GameTeamChallengUnit(40+num),'AZ99')
        end
        GameTeamChallengCanUsesUnitFlush()
        GameTeamChallengeInt(3) = 0
        GameTeamChallengeBool[22] = false
    endfunction

    function FlushGameTeamChallengeOfPlayer2(int pid,real time)
        GameChallengeBool[120] = false
        for num = 0,2
            SetUnitVertexColor(GameChallengeUnit[110+num],255,255,255,0)
        end
        IsPlayerInTeamChallenge2 = false
        if  time == -1
            if  Player(pid) == GetLocalPlayer()
                PlayerTaskUI_Back.alpha = 0
                PlayerTaskUI_Back.show = false
            endif
            ClosePlayerTaskUIOfPlayerEx(pid)
        else
            ShowPlayerTaskUIOfPlayer(pid,false,time)
        endif
        if  Player(pid) == GetLocalPlayer()
            PlayerTaskUI_TaskText.SetText("")
            PlayerTaskUI_ChatTextA.SetText("")
            PlayerTaskUI_ChatTextB.SetText("")
        endif
    endfunction

    function IsHasPlayerGoToTeamChalleng2()->bool
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  GameChallengeBool[120] == true 
                    return true
                endif
            endif
        end
        return false
    endfunction

    function IsHasPlayerInTeamChalleng2()->bool
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  IsPlayerInTeamChallenge2 == true 
                    return true
                endif
            endif
        end
        return false
    endfunction

    function GameTeamChallengWin2(int pid,int value)
        int flag = 0
        int itid = 0
        real ran = GetRandomReal(1,100)
        if  ran <= 50
            itid = 'CS41'
            UnitAddItemEx(Pu[1],itid)
        elseif  ran <= 70
            itid = 'CS41'
            UnitAddItemEx(Pu[1],itid)
            UnitAddItemEx(Pu[1],itid)
            flag = 1
        elseif  ran <= 80
            itid = 'CS42'
            UnitAddItemEx(Pu[1],itid)
        else
            itid = 'CS53'
            UnitAddItemEx(Pu[1],itid)
        endif
        AddUnitRealState(Pu[1],31,4)
        AddUnitRealState(Pu[1],32,4)
        AddUnitRealState(Pu[1],33,4)
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[鸿钧道人]：|r|cff00ff00贫道去云游一番的功夫，没想到闹出这么大事。。小友，幸好你及时出手，否则老夫也不好跟元灵交差了。。|r")
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[团队副本-虚空圣战]：|r|cffffff80成功通过挑战，全队奖励4%攻击力、4%业力和4%生命！！！|r")
        if  flag == 1
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本-虚空圣战]：|r"+GetPlayerNameOfColor(pid)+"随机获得"+GetObjectName(itid)+"x2！")
        else
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本-虚空圣战]：|r"+GetPlayerNameOfColor(pid)+"随机获得"+GetObjectName(itid)+"！")
        endif
    endfunction

    function GameTeamChallengDeath2_A(unit u2)
        int uid = GetUnitTypeId(u2)
        if  uid >= 'ut10' and uid <= 'ut19'
            GameTeamChallengUnit(R2I(GetUnitRealState(u2,99))) = null
            GameTeamChallengeInt(3) = GameTeamChallengeInt(3) + 1 
            if  GameTeamChallengeInt(3) == 5
                for pid = 0,3
                    if  IsPlaying(pid) == true
                        GameTeamChallengWin2(pid,GameTeamChallengeInt(1))
                        if  IsPlayerInTeamChallenge2 == true 
                            FlushGameTeamChallengeOfPlayer2(pid,0)
                        endif
                    endif
                end
                PlayerTeamChallengeCosNum2 = PlayerTeamChallengeCosNum2 + 1
                FlushGameTeamChallenge2()
            endif
        endif
    endfunction

    function GameTeamChalleng2A_Opera1Timer(int t)
        int time = t
        TimerStart(1,true)
        {   
            time = time - 1
            if  IsHasPlayerGoToTeamChalleng2() == true
                if  time == 0
                    if  GameTeamChallengeInt(3) == 5
                        BJDebugMsg("击杀 结束GameTeamChalleng2A_Opera1Timer")
                        endtimer
                    else
                        for pid = 0,3
                            if  IsPlaying(pid) == true
                                if  IsPlayerInTeamChallenge2 == true 
                                    FlushGameTeamChallengeOfPlayer2(pid,0)
                                endif
                            endif
                        end
                        FlushGameTeamChallenge2()
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未在时间内击杀BOSS，团队副本挑战失败！！！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未在时间内击杀BOSS，团队副本挑战失败！！！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未在时间内击杀BOSS，团队副本挑战失败！！！|r")
                        endtimer
                    endif
                endif
            else
                BJDebugMsg("未在区域 结束GameTeamChalleng2A_Opera1Timer")
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameTeamChalleng2A_Opera1()
        if  IsHasPlayerGoToTeamChalleng2() == true
            GameTeamChallengeBool[22] = true
            CreateUsesGameTeamChalleng(15,'ut10',6016,-544,0)
            CreateUsesGameTeamChalleng(16,'ut11',7552,-544,0)
            CreateUsesGameTeamChalleng(17,'ut12',6784-77.5,-960,270)
            CreateUsesGameTeamChalleng(18,'ut13',6016,-1376,180)
            CreateUsesGameTeamChalleng(19,'ut14',7552,-1376,180)
            SetUnitOverStateOfGameTeamChalleng2(GameTeamChallengUnit(15),0)
            SetUnitOverStateOfGameTeamChalleng2(GameTeamChallengUnit(16),0)
            SetUnitOverStateOfGameTeamChalleng2(GameTeamChallengUnit(17),0)
            SetUnitOverStateOfGameTeamChalleng2(GameTeamChallengUnit(18),0)
            SetUnitOverStateOfGameTeamChalleng2(GameTeamChallengUnit(19),0)
            OpenGameTeamChallengeTimer(60,40)
            for pid = 0,3
                if  IsPlaying(pid) == true
                    if  GameChallengeBool[120] == true 
                        IsPlayerInTeamChallenge2 = true
                        ShowPlayerTaskUIOfPlayer(pid,true,0.01)
                        SetPlayerTaskUIChatOfPlayer(pid,"剧情","糟糕！受通天教主杀意影响，四教斗争进入白热化，虚空已近崩溃了！",0.3)
                        SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff劝架|r",0.3)
                    endif
                endif
            end
            GameTeamChalleng2A_Opera1Timer(60)
        else
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000没有玩家进入挑战，可重新激活虚空圣战副本！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000没有玩家进入挑战，可重新激活虚空圣战副本！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000没有玩家进入挑战，可重新激活虚空圣战副本！！！|r")
        endif
    endfunction

    function OpenGameTeamChallengeEx2(int pid,int fl,int t)
        int flag = fl
        int time = t
        int cos = time / 5
        int num = 0
        GameTeamChallengeBool[21] = true
        for pid = 0,3
            if  IsPlaying(pid) == true
                SetUnitVertexColor(GameChallengeUnit[91],255,255,255,255)
                SetUnitAnimation(GameChallengeUnit[91],"birth")
                GameTeamChallengeDoorTimer(GameChallengeUnit[91],time)

                ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[110],UnitAPOfPlayer)
                ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[111],UnitAPOfPlayer)
                ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[112],UnitAPOfPlayer)
            endif
        end
        OpenGameTeamChallengeTimer(time,40)
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[团队副本]：|r"+GetPlayerNameOfColor(pid)+"激活了|cffff8000虚空圣战副本|r，请在|cff00ff00"+I2S(time)+"秒|R内进入副本集合！！！") 
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[团队副本]：|r"+GetPlayerNameOfColor(pid)+"激活了|cffff8000虚空圣战副本|r，请在|cff00ff00"+I2S(time)+"秒|R内进入副本集合！！！") 
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[团队副本]：|r"+GetPlayerNameOfColor(pid)+"激活了|cffff8000虚空圣战副本|r，请在|cff00ff00"+I2S(time)+"秒|R内进入副本集合！！！") 
        TimerStart(5,true)
        {
            num = num + 1
            if  num < cos
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[团队副本]：|r|cffff8000虚空圣战副本|r已激活，请在|cff00ff00"+I2S(time-num*5)+"秒|R内进入副本集合！！！") 
            else
                if  flag == 1
                    ExecuteFunc("GameTeamChalleng2A_Opera1")
                endif
                GameTeamChallengeBool[21] = false
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function FlushGameTeamChallengeStock2TimerNew(real time)
        TimerStart(time,false)
        {
            for pid = 0,3
                RemoveItemFromStock(GameChallengeUnit[90],'IZ06')
                AddItemToStock(GameChallengeUnit[90],'IZ06',1,1)
            end
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[变异模式]：|r|cffff8000团队副本-虚空圣战|r冷却已刷新！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[变异模式]：|r|cffff8000团队副本-虚空圣战|r冷却已刷新！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[变异模式]：|r|cffff8000团队副本-虚空圣战|r冷却已刷新！！！")
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    function FlushGameTeamChallengeStock2()
        int time = 150
        if  GmaeMode == 3
            time = 75
            FlushGameTeamChallengeStock2TimerNew(time)
        endif
        for pid = 0,3
            RemoveItemFromStock(GameChallengeUnit[90],'IZ06')
            AddItemToStock(GameChallengeUnit[90],'IZ06',0,1)
            AddUnitIntStateTimer(GameChallengeUnit[90],'IZ06',1,time)

            if  GetUnitIntState(GameChallengePlayerUnit[pid][90],'IZ01') == 0
                RemoveItemFromStock(GameChallengePlayerUnit[pid][90],'IZ01')
                AddItemToStock(GameChallengePlayerUnit[pid][90],'IZ01',1,1)
            endif
        end
    endfunction

    function OpenGameTeamChallenge2(int pid,int flag,int time)
        if  GameTeamChallengeBool[21] == false and GameTeamChallengeBool[22] == false
            OpenGameTeamChallengeEx2(pid,flag,time)
            FlushGameTeamChallengeStock2()
        elseif  GameTeamChallengeBool[21] == true and GameTeamChallengeBool[22] == false
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[团队副本]：|r当前已激活副本，可进入副本集合！")
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,50000)
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,15)

            RemoveItemFromStock(GameChallengeUnit[90],'IZ06')
            AddItemToStock(GameChallengeUnit[90],'IZ06',0,1)

            if  GetUnitIntState(GameChallengePlayerUnit[pid][90],'IZ01') == 0
                RemoveItemFromStock(GameChallengePlayerUnit[pid][90],'IZ01')
                AddItemToStock(GameChallengePlayerUnit[pid][90],'IZ01',1,1)
            endif
        elseif  GameTeamChallengeBool[21] == false and GameTeamChallengeBool[22] == true
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[团队副本]：|r当前正在挑战副本，无法重复激活！")
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,50000)
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,15)

            RemoveItemFromStock(GameChallengeUnit[90],'IZ06')
            AddItemToStock(GameChallengeUnit[90],'IZ06',0,1)

            if  GetUnitIntState(GameChallengePlayerUnit[pid][90],'IZ01') == 0
                RemoveItemFromStock(GameChallengePlayerUnit[pid][90],'IZ01')
                AddItemToStock(GameChallengePlayerUnit[pid][90],'IZ01',1,1)
            endif
        endif
    endfunction

    function InitGameChallenge_12()
        GameTeamChallengUnit(40) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',6706.5,-960,270)
        GameTeamChallengUnit(41) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',6861.5,-960,270)
        for num = 0,1
            SetUnitScale(GameTeamChallengUnit(40+num),10.5,10.5,10.5)
            SetUnitVertexColor(GameTeamChallengUnit(40+num),255,255,255,0)
            SetUnitFlyHeight(GameTeamChallengUnit(40+num),10,10000)
        end
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengeUnit[110] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',6975.500,-1547.250,133.758)
                GameChallengeUnit[111] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',7321,-1789.500,147.454)
                GameChallengeUnit[112] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',7706.250,-1972.500,156.103)
                DzSetUnitModel(GameChallengeUnit[110],"BiaoJi_jiantou2.MDX")
                DzSetUnitModel(GameChallengeUnit[111],"BiaoJi_jiantou2.MDX")
                DzSetUnitModel(GameChallengeUnit[112],"BiaoJi_jiantou2.MDX")
                SetUnitVertexColor(GameChallengeUnit[110],255,255,255,0)
                SetUnitVertexColor(GameChallengeUnit[111],255,255,255,0)
                SetUnitVertexColor(GameChallengeUnit[112],255,255,255,0)
                SetUnitColor(GameChallengeUnit[110], PLAYER_COLOR_YELLOW )
                SetUnitColor(GameChallengeUnit[111], PLAYER_COLOR_YELLOW )
                SetUnitColor(GameChallengeUnit[112], PLAYER_COLOR_YELLOW )
                EXSetUnitMoveType(GameChallengeUnit[110],0x01)
                EXSetUnitMoveType(GameChallengeUnit[111],0x01)
                EXSetUnitMoveType(GameChallengeUnit[112],0x01)
            endif
        end

    endfunction

endlibrary
