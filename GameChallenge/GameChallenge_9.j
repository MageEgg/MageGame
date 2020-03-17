library GameChallenge9 uses GameChallengeBase

    function FlushGameTeamChallenge()
        for num = 0,3
            SetUnitVertexColor(GameTeamChallengUnit(num),255,255,255,0)
            UnitRemoveAbility(GameTeamChallengUnit(num),'AZ99')
        end
        GameTeamChallengCanUsesUnitFlush()
        GameTeamChallengeInt(0) = 0
        GameTeamChallengeInt(1) = 0
        GameTeamChallengeBool[2] = false
    endfunction

    function FlushGameTeamChallengeOfPlayer(int pid,real time)
        GameChallengBool[90] = false
        for num = 0,7
            SetUnitVertexColor(GameChallengUnit[100+num],255,255,255,0)
        end
        IsPlayerInTeamChallenge = false
        if  time == -1
            if  Player(pid) == GetLocalPlayer()
                PlayerTaskUI_Back.alpha = 0
                PlayerTaskUI_Back.show = false
            endif
        else
            ShowPlayerTaskUIOfPlayer(pid,false,time)
        endif
        if  Player(pid) == GetLocalPlayer()
            PlayerTaskUI_TaskText.SetText("")
            PlayerTaskUI_ChatTextA.SetText("")
            PlayerTaskUI_ChatTextB.SetText("")
        endif
    endfunction

    function SetGameTeamChallengTimerText(unit wu,unit tu,int time)
        if  time >= 10
            s1 = SubString(I2S(time),0,1)
            s2 = SubString(I2S(time),1,2)
            DzSetUnitModel(wu,"UI_zhuatuzi"+SubString(I2S(time),0,1)+".mdl")
            DzSetUnitModel(tu,"UI_zhuatuzi"+SubString(I2S(time),1,2)+".mdl")
        else
            DzSetUnitModel(wu,"UI_zhuatuzi0.mdl")
            DzSetUnitModel(tu,"UI_zhuatuzi"+I2S(time)+".mdl")
        endif
    endfunction

    function IsHasPlayerGoToTeamChalleng()->bool
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  GameChallengBool[90] == true 
                    return true
                endif
            endif
        end
        return false
    endfunction

    function IsHasPlayerInTeamChalleng()->bool
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  IsPlayerInTeamChallenge == true 
                    return true
                endif
            endif
        end
        return false
    endfunction
    
    function OpenGameTeamChallengeTimer(int t,int fl)
        int time = t
        int flag = fl
        if  flag == 1
            SetUnitVertexColor(GameTeamChallengUnit(0),255,255,255,255)
            SetUnitVertexColor(GameTeamChallengUnit(1),255,255,255,255)
            UnitAddAbility(GameTeamChallengUnit(0),'AZ99')
            UnitAddAbility(GameTeamChallengUnit(1),'AZ99')
            SetGameTeamChallengTimerText(GameTeamChallengUnit(0),GameTeamChallengUnit(1),time)
        elseif  flag == 2
            SetUnitVertexColor(GameTeamChallengUnit(2),255,255,255,255)
            SetUnitVertexColor(GameTeamChallengUnit(3),255,255,255,255)
            UnitAddAbility(GameTeamChallengUnit(2),'AZ99')
            UnitAddAbility(GameTeamChallengUnit(3),'AZ99')
            SetGameTeamChallengTimerText(GameTeamChallengUnit(2),GameTeamChallengUnit(3),time)
        elseif  flag == 10
            SetUnitVertexColor(GameTeamChallengUnit(10),255,255,255,255)
            SetUnitVertexColor(GameTeamChallengUnit(11),255,255,255,255)
            UnitAddAbility(GameTeamChallengUnit(10),'AZ99')
            UnitAddAbility(GameTeamChallengUnit(11),'AZ99')
            SetGameTeamChallengTimerText(GameTeamChallengUnit(10),GameTeamChallengUnit(11),time)
        elseif  flag == 11
            SetUnitVertexColor(GameTeamChallengUnit(12),255,255,255,255)
            SetUnitVertexColor(GameTeamChallengUnit(13),255,255,255,255)
            UnitAddAbility(GameTeamChallengUnit(12),'AZ99')
            UnitAddAbility(GameTeamChallengUnit(13),'AZ99')
            SetGameTeamChallengTimerText(GameTeamChallengUnit(12),GameTeamChallengUnit(13),time)
        elseif  flag == 12
            SetUnitVertexColor(GameTeamChallengUnit(14),255,255,255,255)
            SetUnitVertexColor(GameTeamChallengUnit(15),255,255,255,255)
            UnitAddAbility(GameTeamChallengUnit(14),'AZ99')
            UnitAddAbility(GameTeamChallengUnit(15),'AZ99')
            SetGameTeamChallengTimerText(GameTeamChallengUnit(14),GameTeamChallengUnit(15),time)
        endif
        TimerStart(1,true)
        {
            time = time - 1
            if  time > 0
                if  flag == 1
                    if  GetUnitAbilityLevel(GameTeamChallengUnit(0),'AZ99') > 0 and GetUnitAbilityLevel(GameTeamChallengUnit(1),'AZ99') > 0
                        SetGameTeamChallengTimerText(GameTeamChallengUnit(0),GameTeamChallengUnit(1),time)
                    else
                        endtimer
                    endif
                elseif  flag == 2
                    if  GetUnitAbilityLevel(GameTeamChallengUnit(2),'AZ99') > 0 and GetUnitAbilityLevel(GameTeamChallengUnit(3),'AZ99') > 0
                        SetGameTeamChallengTimerText(GameTeamChallengUnit(2),GameTeamChallengUnit(3),time)
                    else
                        endtimer
                    endif
                elseif  flag == 10
                    if  GetUnitAbilityLevel(GameTeamChallengUnit(10),'AZ99') > 0 and GetUnitAbilityLevel(GameTeamChallengUnit(11),'AZ99') > 0
                        SetGameTeamChallengTimerText(GameTeamChallengUnit(10),GameTeamChallengUnit(11),time)
                    else
                        endtimer
                    endif
                elseif  flag == 11
                    if  GetUnitAbilityLevel(GameTeamChallengUnit(12),'AZ99') > 0 and GetUnitAbilityLevel(GameTeamChallengUnit(13),'AZ99') > 0
                        SetGameTeamChallengTimerText(GameTeamChallengUnit(12),GameTeamChallengUnit(13),time)
                    else
                        endtimer
                    endif
                elseif  flag == 12
                    if  GetUnitAbilityLevel(GameTeamChallengUnit(14),'AZ99') > 0 and GetUnitAbilityLevel(GameTeamChallengUnit(15),'AZ99') > 0
                        SetGameTeamChallengTimerText(GameTeamChallengUnit(14),GameTeamChallengUnit(15),time)
                    else
                        endtimer
                    endif
                endif
            else    
                if  flag == 1
                    SetUnitVertexColor(GameTeamChallengUnit(0),255,255,255,0)
                    SetUnitVertexColor(GameTeamChallengUnit(1),255,255,255,0)
                    UnitRemoveAbility(GameTeamChallengUnit(0),'AZ99')
                    UnitRemoveAbility(GameTeamChallengUnit(1),'AZ99')
                elseif  flag == 2
                    SetUnitVertexColor(GameTeamChallengUnit(2),255,255,255,0)
                    SetUnitVertexColor(GameTeamChallengUnit(3),255,255,255,0)
                    UnitRemoveAbility(GameTeamChallengUnit(2),'AZ99')
                    UnitRemoveAbility(GameTeamChallengUnit(3),'AZ99')
                elseif  flag == 10
                    SetUnitVertexColor(GameTeamChallengUnit(10),255,255,255,0)
                    SetUnitVertexColor(GameTeamChallengUnit(11),255,255,255,0)
                    UnitRemoveAbility(GameTeamChallengUnit(10),'AZ99')
                    UnitRemoveAbility(GameTeamChallengUnit(11),'AZ99')
                elseif  flag == 11
                    SetUnitVertexColor(GameTeamChallengUnit(12),255,255,255,0)
                    SetUnitVertexColor(GameTeamChallengUnit(13),255,255,255,0)
                    UnitRemoveAbility(GameTeamChallengUnit(12),'AZ99')
                    UnitRemoveAbility(GameTeamChallengUnit(13),'AZ99')
                elseif  flag == 12
                    SetUnitVertexColor(GameTeamChallengUnit(14),255,255,255,0)
                    SetUnitVertexColor(GameTeamChallengUnit(15),255,255,255,0)
                    UnitRemoveAbility(GameTeamChallengUnit(14),'AZ99')
                    UnitRemoveAbility(GameTeamChallengUnit(15),'AZ99')
                endif
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function EnRctGameTeamChallengA()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  GameTeamChallengeBool[0] == true and GameTeamChallengeBool[1] == true and GameTeamChallengeBool[2] == false
                    GameChallengBool[90] = true
                    SendPlayerUnit(pid,6432,3104)
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[副本]：|r您已进入团队副本，请等待挑战开始！")
                endif
            endif
        endif
        flush locals
    endfunction

    function GameTeamChallengA_Opera3()
        CreateUsesGameTeamChalleng(10,'ut05',6592,6368,270)
        SetUnitOverStateOfGameTeamChalleng(GameTeamChallengUnit(10),0)
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  IsPlayerInTeamChallenge == true 
                    SendPlayerUnit(pid,6592,6368)
                    ShowPlayerTaskUIOfPlayer(pid,true,0.01)
                    SetPlayerTaskUIChatOfPlayer(pid,"通天教主","哼！万仙阵虽破，但你我四人必须决一雌雄！",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击败通天教主分身|r",0)
                endif
            endif
        end
    endfunction

    function GameTeamChallengA_Opera2Timer(int t)
        int time = t
        TimerStart(1,true)
        {   
            time = time - 1
            if  IsHasPlayerGoToTeamChalleng() == true
                if  time == 0
                    for pid = 0,3
                        if  IsPlaying(pid) == true
                            if  IsPlayerInTeamChallenge == true 
                                FlushGameTeamChallengeOfPlayer(pid,0)
                            endif
                        endif
                    end
                    FlushGameTeamChallenge()
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未在时间内通过挑战，团队副本挑战失败！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未在时间内通过挑战，团队副本挑战失败！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未在时间内通过挑战，团队副本挑战失败！！！|r")
                    endtimer
                endif
            else
                BJDebugMsg("结束GameTeamChallengA_Opera2Timer")
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameTeamChallengA_Opera2()
        int num = 0
        int time = 0
        GameTeamChallengCanUsesUnitFlushEx()
        SetUnitVertexColor(GameTeamChallengUnit(0),255,255,255,0)
        SetUnitVertexColor(GameTeamChallengUnit(1),255,255,255,0)
        UnitRemoveAbility(GameTeamChallengUnit(0),'AZ99')
        UnitRemoveAbility(GameTeamChallengUnit(1),'AZ99')
        OpenGameTeamChallengeTimer(60,2)
        GameTeamChallengA_Opera2Timer(60)
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  IsPlayerInTeamChallenge == true 
                    DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[万仙阵]：|r破阵时间已到！进入二十八宿！")
                    SendPlayerUnit(pid,6592,6368)
                    ShowPlayerTaskUIOfPlayer(pid,true,0.01)
                    SetPlayerTaskUIChatOfPlayer(pid,"通天教主","徒儿们，今天你们都没有余地了，都一起进入阵中，以会截教万仙，不得错过。",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀九曜二十八宿|r",0)
                endif
            endif
        end
        TimerStart(1,true)
        {   
            time = time + 1
            if  IsHasPlayerGoToTeamChalleng() == true
                if  time <= 3 
                    for n = 1,2
                        num = GetCanUsesGameTeamChallengUnitID()
                        if  num != 0
                            CreateUsesGameTeamChalleng(num,'ut04',5792,7104,315)
                            SetUnitOverStateOfGameTeamChalleng(GameTeamChallengUnit(num),0)
                            IssuePointOrderById(GameTeamChallengUnit(num),851983,6592,6368)
                        endif
                        num = GetCanUsesGameTeamChallengUnitID()
                        if  num != 0
                            CreateUsesGameTeamChalleng(num,'ut04',7328,7104,315)
                            SetUnitOverStateOfGameTeamChalleng(GameTeamChallengUnit(num),0)
                            IssuePointOrderById(GameTeamChallengUnit(num),851983,6592,6368)
                        endif
                        num = GetCanUsesGameTeamChallengUnitID()
                        if  num != 0
                            CreateUsesGameTeamChalleng(num,'ut04',5760,5660,315)
                            SetUnitOverStateOfGameTeamChalleng(GameTeamChallengUnit(num),0)
                            IssuePointOrderById(GameTeamChallengUnit(num),851983,6592,6368)
                        endif
                        num = GetCanUsesGameTeamChallengUnitID()
                        if  num != 0
                            CreateUsesGameTeamChalleng(num,'ut04',7380,5660,315)
                            SetUnitOverStateOfGameTeamChalleng(GameTeamChallengUnit(num),0)
                            IssuePointOrderById(GameTeamChallengUnit(num),851983,6592,6368)
                        endif
                    end
                else
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameTeamChallengWin(int pid,int flag,int value)
        int itid = 0
        if  flag == 1
            if  GetRandomReal(0,1) <= 0.8
                UnitAddItemEx(Pu[1],'IP02')
                itid = 'IP02'
            else
                UnitAddItemEx(Pu[1],'IP03')
                itid = 'IP03'
            endif
            AddUnitRealState(Pu[1],31,3)
            AddUnitRealState(Pu[1],32,3)
            AddUnitRealState(Pu[1],33,3)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[团队副本-万仙阵]：|r|cff00ff00通天教主分身已死亡，成功通过挑战！！！|r")
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[团队副本-万仙阵]：|r|cffffff80全队奖励3%攻击力、3%业力和3%生命！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本-万仙阵]：|r"+GetPlayerNameOfColor(pid)+"随机获得"+GetObjectName(itid)+"！")

            if  GetUnitTypeId(Pu[1]) == 'H003' //彩蛋
                if  DzPlayerLv(Player(pid)) >= 6
                    if  GameLevel >= 3
                        if  GetPlayerTechCount(Player(pid),'RDAT',true) == 0
                            SetDzPlayerData(pid,15,20,20)
                            SetPlayerTechResearchedEx(Player(pid),'RDAT')
                            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000师弟，你不行|r（永久存档）！")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000师弟，你不行|r，但可惜难度不够要求！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000师弟，你不行|r，但可惜地图等级不够要求！")
                endif
            endif

            if  GetUnitTypeId(Pu[1]) == 'H005' //彩蛋
                if  DzPlayerLv(Player(pid)) >= 6
                    if  GameLevel >= 3
                        if  GetPlayerTechCount(Player(pid),'RDAU',true) == 0
                            SetDzPlayerData(pid,15,21,21)
                            SetPlayerTechResearchedEx(Player(pid),'RDAU')
                            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000师弟，你真不行|r（永久存档）！")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000师弟，你真不行|r，但可惜难度不够要求！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000师弟，你真不行|r，但可惜地图等级不够要求！")
                endif
            endif

        endif
    endfunction

    function GameTeamChallengDeath(unit u2)
        int uid = GetUnitTypeId(u2)
        if  uid >= 'ut00' and uid <= 'ut03'
            GameTeamChallengUnit(R2I(GetUnitRealState(u2,99))) = null
            GameTeamChallengeInt(0) = GameTeamChallengeInt(0) + 1 
            if  GameTeamChallengeInt(0) == 4
                GameTeamChallengeInt(1) = GameTeamChallengeInt(0)
                GameTeamChallengeInt(0) = 5
                ExecuteFunc("GameTeamChallengA_Opera2")
            endif   
        elseif  uid == 'ut04'
            GameTeamChallengUnit(R2I(GetUnitRealState(u2,99))) = null
            GameTeamChallengeInt(0) = GameTeamChallengeInt(0) + 1 
            if  GameTeamChallengeInt(0) == 29
                GameTeamChallengeInt(0) = 30
                ExecuteFunc("GameTeamChallengA_Opera3")
            endif   
        elseif  uid == 'ut05'
            if  GameTeamChallengeInt(0) == 30
                for pid = 0,3
                    if  IsPlaying(pid) == true
                        MissionAddNumFunc(pid,25,1) //任务
                        GameTeamChallengWin(pid,1,GameTeamChallengeInt(1))
                        if  IsPlayerInTeamChallenge == true 
                            FlushGameTeamChallengeOfPlayer(pid,0)
                        endif
                    endif
                end
                PlayerTeamChallengeCosNum = PlayerTeamChallengeCosNum + 1
                FlushGameTeamChallenge()
            endif
        endif
    endfunction

    function GameTeamChallengA_Opera1Timer(int t)
        int time = t
        TimerStart(1,true)
        {   
            time = time - 1
            if  IsHasPlayerGoToTeamChalleng() == true
                if  time == 0
                    if  GameTeamChallengeInt(0) >= 5// > 0
                        if  GameTeamChallengeInt(0) >= 5
                            BJDebugMsg("GameTeamChallengeInt(0)>5")
                            endtimer
                        else
                            GameTeamChallengeInt(1) = GameTeamChallengeInt(0)
                            GameTeamChallengeInt(0) = 5
                            ExecuteFunc("GameTeamChallengA_Opera2")
                            endtimer
                        endif
                    else
                        for pid = 0,3
                            if  IsPlaying(pid) == true
                                if  IsPlayerInTeamChallenge == true 
                                    FlushGameTeamChallengeOfPlayer(pid,0)
                                endif
                            endif
                        end
                        FlushGameTeamChallenge()
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未在时间内击杀BOSS，团队副本挑战失败！！！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未在时间内击杀BOSS，团队副本挑战失败！！！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000未在时间内击杀BOSS，团队副本挑战失败！！！|r")
                        endtimer
                    endif
                endif
            else
                BJDebugMsg("结束GameTeamChallengA_Opera1Timer")
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameTeamChallengA_Opera1()
        if  IsHasPlayerGoToTeamChalleng() == true
            GameTeamChallengeBool[2] = true
            CreateUsesGameTeamChalleng(10,'ut00',5440,4288,315)
            CreateUsesGameTeamChalleng(11,'ut01',7392,4256,225)
            CreateUsesGameTeamChalleng(12,'ut02',5344,1952,45)
            CreateUsesGameTeamChalleng(13,'ut03',7488,1984,135)
            SetUnitOverStateOfGameTeamChalleng(GameTeamChallengUnit(10),0)
            SetUnitOverStateOfGameTeamChalleng(GameTeamChallengUnit(11),0)
            SetUnitOverStateOfGameTeamChalleng(GameTeamChallengUnit(12),0)
            SetUnitOverStateOfGameTeamChalleng(GameTeamChallengUnit(13),0)
            OpenGameTeamChallengeTimer(30,1)
            for pid = 0,3
                if  IsPlaying(pid) == true
                    if  GameChallengBool[90] == true 
                        IsPlayerInTeamChallenge = true
                        SendPlayerUnit(pid,6432,3104)
                        ShowPlayerTaskUIOfPlayer(pid,true,0.01)
                        SetPlayerTaskUIChatOfPlayer(pid,"通天教主","月缺难圆。今摆此万仙阵，必定见雌雄，以定一尊之位。今日万仙统会，以完劫数。",0.3)
                        SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff破太极四象阵|r",0.3)
                        for num = 0,7
                            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[100+num],UnitAPOfPlayer)
                        end
                    endif
                endif
            end
            GameTeamChallengA_Opera1Timer(30)
        else
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000没有玩家进入挑战，可重新激活团队副本！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000没有玩家进入挑战，可重新激活团队副本！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本]：|r|cffff0000没有玩家进入挑战，可重新激活团队副本！！！|r")
        endif
    endfunction

    function GameTeamChallengeDoorTimer(unit wu,real time)
        unit u = wu
        TimerStart(time,false)
        {
            SetUnitVertexColor(u,255,255,255,0)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function OpenGameTeamChallengeEx(int pid,int fl,int t)
        int flag = fl
        int time = t
        int cos = time / 5
        int num = 0
        GameTeamChallengeBool[1] = true
        for pid = 0,3
            if  IsPlaying(pid) == true
                SetUnitVertexColor(GameChallengUnit[91],255,255,255,255)
                SetUnitAnimation(GameChallengUnit[91],"birth")
                GameTeamChallengeDoorTimer(GameChallengUnit[91],time)
            endif
        end
        if  flag == 1
            OpenGameTeamChallengeTimer(time,1)
        elseif  flag == 2
            OpenGameTeamChallengeTimer(time,3)
        endif
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[团队副本]：|r"+GetPlayerNameOfColor(pid)+"激活了|cffff8000团队副本|r，请在|cff00ff00"+I2S(time)+"秒|R内进入副本集合！！！") 
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[团队副本]：|r"+GetPlayerNameOfColor(pid)+"激活了|cffff8000团队副本|r，请在|cff00ff00"+I2S(time)+"秒|R内进入副本集合！！！") 
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[团队副本]：|r"+GetPlayerNameOfColor(pid)+"激活了|cffff8000团队副本|r，请在|cff00ff00"+I2S(time)+"秒|R内进入副本集合！！！") 
        TimerStart(5,true)
        {
            num = num + 1
            if  num < cos
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[团队副本]：|r|cffff8000团队副本|r已激活，请在|cff00ff00"+I2S(time-num*5)+"秒|R内进入副本集合！！！") 
            else
                if  flag == 1
                    ExecuteFunc("GameTeamChallengA_Opera1")
                endif
                GameTeamChallengeBool[1] = false
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function OpenGameTeamChallenge(int pid,int flag,int time)
        if  GameTeamChallengeBool[1] == false and GameTeamChallengeBool[2] == false
            OpenGameTeamChallengeEx(pid,flag,time)
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-30000)
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-10)
        elseif  GameTeamChallengeBool[1] == true and GameTeamChallengeBool[2] == false
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[团队副本]：|r当前已激活副本，可进入副本集合！")
        elseif  GameTeamChallengeBool[1] == false and GameTeamChallengeBool[2] == true
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[团队副本]：|r当前正在挑战副本，无法重复激活！")
        endif
    endfunction

    function ShowGameTeamChallengeNPC()
        if  GameTeamChallengeBool[0] == false
            for pid = 0,3
                if  IsPlaying(pid) == true
                    ShowUnit(GameChallengUnit[90],true)
                    UnitAddEffectOfNPC(GameChallengUnit[90])
                    PingMinimap(GetUnitX(GameChallengUnit[90]),GetUnitY(GameChallengUnit[90]),3)
                    CreateUnit(Player(pid),'nc30',GetUnitX(GameChallengUnit[90]),GetUnitY(GameChallengUnit[90]),270)
                endif
            end
            GameTeamChallengeBool[0] = true
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神榜]：|r|cffffff00成功防守16波，团队副本NPC已激活！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神榜]：|r|cffffff00成功防守16波，团队副本NPC已激活！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[封神榜]：|r|cffffff00成功防守16波，团队副本NPC已激活！！！|r")
        endif
    endfunction

    function InitGameChallenge_9()
        GameTeamChallengUnit(0) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',6340,3097,270)
        GameTeamChallengUnit(1) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',6495,3097,270)
        GameTeamChallengUnit(2) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',6490,6330,270)
        GameTeamChallengUnit(3) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',6645,6330,270)
        for num = 0,3
            SetUnitScale(GameTeamChallengUnit(num),10.5,10.5,10.5)
            SetUnitVertexColor(GameTeamChallengUnit(num),255,255,255,0)
            SetUnitFlyHeight(GameTeamChallengUnit(num),10,10000)
        end
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengUnit[100] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',5887.250,3658.750,135.000)
                GameChallengUnit[101] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',6084.000,3464.000,135.000)
                GameChallengUnit[102] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',6969.500,3642.500,45.000)
                GameChallengUnit[103] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',6771.500,3443.500,45.000)
                GameChallengUnit[104] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',5890.250,2567.000,225.000)
                GameChallengUnit[105] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',6082.500,2759.500,225.000)
                GameChallengUnit[106] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',6964.500,2570.000,315.000)
                GameChallengUnit[107] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',6768.250,2766.250,315.000)
                SetUnitVertexColor(GameChallengUnit[100],255,255,255,0)
                SetUnitVertexColor(GameChallengUnit[101],255,255,255,0)
                SetUnitVertexColor(GameChallengUnit[102],255,255,255,0)
                SetUnitVertexColor(GameChallengUnit[103],255,255,255,0)
                SetUnitVertexColor(GameChallengUnit[104],255,255,255,0)
                SetUnitVertexColor(GameChallengUnit[105],255,255,255,0)
                SetUnitVertexColor(GameChallengUnit[106],255,255,255,0)
                SetUnitVertexColor(GameChallengUnit[107],255,255,255,0)
                SetUnitColor(GameChallengUnit[100], PLAYER_COLOR_RED )
                SetUnitColor(GameChallengUnit[101], PLAYER_COLOR_RED )
                SetUnitColor(GameChallengUnit[102], PLAYER_COLOR_RED )
                SetUnitColor(GameChallengUnit[103], PLAYER_COLOR_RED )
                SetUnitColor(GameChallengUnit[104], PLAYER_COLOR_RED )
                SetUnitColor(GameChallengUnit[105], PLAYER_COLOR_RED )
                SetUnitColor(GameChallengUnit[106], PLAYER_COLOR_RED )
                SetUnitColor(GameChallengUnit[107], PLAYER_COLOR_RED )
                EXSetUnitMoveType(GameChallengUnit[100],0x01)
                EXSetUnitMoveType(GameChallengUnit[101],0x01)
                EXSetUnitMoveType(GameChallengUnit[102],0x01)
                EXSetUnitMoveType(GameChallengUnit[103],0x01)
                EXSetUnitMoveType(GameChallengUnit[104],0x01)
                EXSetUnitMoveType(GameChallengUnit[105],0x01)
                EXSetUnitMoveType(GameChallengUnit[106],0x01)
                EXSetUnitMoveType(GameChallengUnit[107],0x01)
            endif
        end

    endfunction

endlibrary
