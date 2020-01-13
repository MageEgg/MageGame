library GameChallenge9 uses GameChallengeBase

    function FlushGameTeamChallenge()
        for num = 0,3
            SetUnitVertexColor(GameTeamChallengUnit(num),255,255,255,0)
            UnitRemoveAbility(GameTeamChallengUnit(num),'AZ99')
        end
        GameTeamChallengCanUsesUnitFlush()
        GameTeamChallengeInt(0) = 0
        GameTeamChallengeBool[2] = false
    endfunction

    function FlushGameTeamChallengeOfPlayer(int pid,real time)
        GameChallengBool[90] = false
        IsPlayerInTeamChallenge = false
        if  time == -1
            PlayerTaskUI_Back.alpha = 0
            PlayerTaskUI_Back.show = false
        else
            ShowPlayerTaskUIOfPlayer(pid,false,time)
        endif
        PlayerTaskUI_TaskText.SetText("")
        PlayerTaskUI_ChatTextA.SetText("")
        PlayerTaskUI_ChatTextB.SetText("")
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

    function GameTeamChallengA_Opera2()
        int num = 0
        int time = 0
        GameTeamChallengCanUsesUnitFlushEx()
        SetUnitVertexColor(GameTeamChallengUnit(0),255,255,255,0)
        SetUnitVertexColor(GameTeamChallengUnit(1),255,255,255,0)
        UnitRemoveAbility(GameTeamChallengUnit(0),'AZ99')
        UnitRemoveAbility(GameTeamChallengUnit(1),'AZ99')
        OpenGameTeamChallengeTimer(60,2)
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  IsPlayerInTeamChallenge == true 
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
                if  time < 3 
                    for n = 1,2
                        num = GetCanUsesGameTeamChallengUnitID()
                        if  num != 0
                            CreateUsesGameTeamChalleng(num,'ut04',5792,7104,315)
                            IssuePointOrderById(GameTeamChallengUnit(num),851983,6592,6368)
                        endif
                        num = GetCanUsesGameTeamChallengUnitID()
                        if  num != 0
                            CreateUsesGameTeamChalleng(num,'ut04',7328,7104,315)
                            IssuePointOrderById(GameTeamChallengUnit(num),851983,6592,6368)
                        endif
                        num = GetCanUsesGameTeamChallengUnitID()
                        if  num != 0
                            CreateUsesGameTeamChalleng(num,'ut04',5760,5660,315)
                            IssuePointOrderById(GameTeamChallengUnit(num),851983,6592,6368)
                        endif
                        num = GetCanUsesGameTeamChallengUnitID()
                        if  num != 0
                            CreateUsesGameTeamChalleng(num,'ut04',7380,5660,315)
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

    function GameTeamChallengDeath(unit u2)
        int uid = GetUnitTypeId(u2)
        if  uid >= 'ut00' and uid <= 'ut03'
            GameTeamChallengUnit(R2I(GetUnitRealState(u2,99))) = null
            GameTeamChallengeInt(0) = GameTeamChallengeInt(0) + 1 
            if  GameTeamChallengeInt(0) == 4
                GameTeamChallengeInt(0) = 5
                ExecuteFunc("GameTeamChallengA_Opera2")
            endif   
        elseif  uid == 'ut04'
            GameTeamChallengUnit(R2I(GetUnitRealState(u2,99))) = null
            GameTeamChallengeInt(0) = GameTeamChallengeInt(0) + 1 
            if  GameTeamChallengeInt(0) == 29
                GameTeamChallengeInt(0) = 0
                ExecuteFunc("GameTeamChallengA_Opera3")
            endif   
        elseif  uid == 'ut05'
            for pid = 0,3
                if  IsPlaying(pid) == true
                    if  IsPlayerInTeamChallenge == true 
                        FlushGameTeamChallengeOfPlayer(pid,0)
                    endif
                endif
            end
            FlushGameTeamChallenge()
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本-万仙阵]：|r成功通过挑战！")
        endif
    endfunction

    function GameTeamChallengA_Opera1()
        if  IsHasPlayerGoToTeamChalleng() == true
            GameTeamChallengeBool[2] = true
            CreateUsesGameTeamChalleng(10,'ut00',5440,4288,315)
            CreateUsesGameTeamChalleng(11,'ut01',7392,4256,225)
            CreateUsesGameTeamChalleng(12,'ut02',5344,1952,45)
            CreateUsesGameTeamChalleng(13,'ut03',7488,1984,135)
            OpenGameTeamChallengeTimer(60,1)
            for pid = 0,3
                if  IsPlaying(pid) == true
                    if  GameChallengBool[90] == true 
                        IsPlayerInTeamChallenge = true
                        SendPlayerUnit(pid,6432,3104)
                        ShowPlayerTaskUIOfPlayer(pid,true,0.01)
                        SetPlayerTaskUIChatOfPlayer(pid,"通天教主","月缺难圆。今摆此万仙阵，必定见雌雄，以定一尊之位。今日万仙统会，以完劫数。",0.3)
                        SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff破太极四象阵|r",0.3)
                    endif
                endif
            end
            //TimerStart()
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
        elseif  GameTeamChallengeBool[1] == true and GameTeamChallengeBool[2] == false
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[团队副本]：|r当前已激活副本，可进入副本集合！")
        elseif  GameTeamChallengeBool[1] == false and GameTeamChallengeBool[2] == true
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[团队副本]：|r当前正在挑战副本，无法重复激活！")
        endif
    endfunction

    function ShowGameTeamChallengeNPC()
        for pid = 0,3
            if  IsPlaying(pid) == true
                SetUnitVertexColor(GameChallengUnit[90],255,255,255,255)
                UnitAddEffectOfNPC(GameChallengUnit[90])
            endif
        end
        BJDebugMsg("ShowGameTeamChallengeNPC")
    endfunction

    function InitGameChallenge_9()
        GameTeamChallengUnit(0) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',6340,3097,270)
        GameTeamChallengUnit(1) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',6495,3097,270)
        GameTeamChallengUnit(2) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',6490,6330,270)
        GameTeamChallengUnit(3) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',6645,6330,270)
        for num = 0,3
            SetUnitScale(GameTeamChallengUnit(num),9,9,9)
            SetUnitVertexColor(GameTeamChallengUnit(num),255,255,255,0)
            SetUnitFlyHeight(GameTeamChallengUnit(num),10,10000)
        end
    endfunction

endlibrary
