library GameChallenge6 uses GameChallengeBase

    function GameChallenge_6Flush(int pid,real time)
        for num = 0,3
            SetUnitVertexColor(GameChallengUnit[60+num],255,255,255,0)
        end
        GameChallengInt[60] = 0
        if  GameChallengUnit[69] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[69]))
            RemoveUnit(GameChallengUnit[69])
            GameChallengUnit[69] = null
        endif
        GameChallenge_GlobalFlush(pid,time)
    endfunction

    function OpenGameChallenge_6_A_ChatTimer(int id)
        int pid = id
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[赤精子]：|r贫道将一洞珍宝都给了殷洪。这孽障不知听何人唆使，中途改了念头。")
        TimerStart(1,false)
        {
            if  IsPlayerInChallenge == true
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[姜子牙]：|r今殷洪背师言而助苏护征伐西岐，又有马元凶顽肆虐。我有一策可治之。")
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff前往赤精子|r")
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function OpenGameChallenge_6_B_Timer(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r殷郊奉命下山助西岐攻伐纣。")
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = -1696
                        y = 8224
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf62',x,y,315)
                        SetUnitOverStateOfGameChalleng(pid,GameChallengUnit[num],2)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                    endif
                elseif  time == 2
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[申公豹]：|r殷殿下，你父亲固得罪于天下，可与之为仇。但殿下弟弟殷洪，听说他下山助周，没想姜子牙欲邀功，竟用太极图把他化成灰了！")
                elseif  time == 3
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00["+GetPlayerName(Player(pid))+"]：|r信口胡说！")
                elseif  time == 4
                    UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                    SetUnitOwner(GameChallengUnit[num],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击败申公豹|r")
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function OpenGameChallenge_6(int pid,int ty)
        real x = 0
        real y = 0
        GameChallenge_6Flush(pid,0)
        ShowPlayerTaskUIOfPlayer(pid,true,0.01)
        if  ty == 0
            x = -2272
            y = 6720
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 6
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[60],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[61],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[62],UnitAPOfPlayer)
            OpenGameChallenge_6_A_ChatTimer(pid)
        elseif  ty == 1
            x = -1440
            y = 7904
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 6
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[63],UnitAPOfPlayer)
            UnitAddEffectOfGameChalleng(GameChallengUnit[63])
            OpenGameChallenge_6_B_Timer(pid)
        endif
    endfunction

    function GameChalleng_6_JumpAttack1(int id)
        int pid = id
        int num = 0
        real x = 0
        real y = 0 
        int time = 0
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = -992
                        y = 7200
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[马元]：|r姜子牙不要跑！")
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf60',x,y,225)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                    endif
                elseif  time == 2
                    SetUnitXY(GameChallengUnit[69],-1312,7264)
                    UnitAddEffectOfGameChalleng(GameChallengUnit[69])
                    SetUnitOwner(GameChallengUnit[num],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀马元|r")
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_6_JumpAttack2TimerEnd(int pid,int num)
        SetUnitXY(GameChallengUnit[69],-64,7136)
        UnitAddEffectOfGameChalleng(GameChallengUnit[69])
        SetUnitFaceOfUnit(GameChallengUnit[69],GameChallengUnit[num])
        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
        SetUnitOwner(GameChallengUnit[num],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
        IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀殷洪|r")
    endfunction

    function GameChalleng_6_JumpAttack2Timer(int id,unit wu,int n,real r1,real r2)
        int pid = id
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = r1
        real y2 = r2
        real ang = Atan2(y2-y1,x2-x1)
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        int time = R2I(Pdis(x1,y1,x2,y2)/30)
        int num = n
        SetUnitFacing(u1,ang/0.01745)
        LocAddEffectSetSize(x1,y1,"effect_blue-guagnzhu-special.mdx",1)
        SetUnitVertexColor(u1,255,255,255,0)
        TimerStart(0.03,true)
        {
            time = time - 1
            if  time > 0 and IsPlayerInChallenge == true
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitFacing(u1,ang/0.01745)
                SetUnitPosition(u1,x1,y1)
                SetUnitAnimation(u1,"walk")
                //if  ModuloInteger(time,2) == 0
                    LocAddEffectSetSize(x1,y1,"effect_blue-blink2.mdx",2)
                //endif
            else
                LocAddEffectSetSize(x1,y1,"effect_blue-chuansong.mdx",1)
                ShowUnitOfOnlyPlayer(pid,u1,UnitAPOfPlayer)
                GameChalleng_6_JumpAttack2TimerEnd(pid,num)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_6_JumpAttack2(int id)
        int pid = id
        int num = 0
        real x = 0
        real y = 0 
        int time = 0
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = -192
                        y = 7168
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[姜子牙]：|r殷洪你可敢上桥来，和我打三回合？")
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf61',x,y,225)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                    endif
                elseif  time == 2
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[殷洪]：|r哼！就算我师父在我也不惧，又何怕你幻术？我来了！")
                    GameChalleng_6_JumpAttack2Timer(pid,GameChallengUnit[num],num,144,6400)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_6_Jump1(int id,unit wu,real r1,real r2,int fl)
        int pid = id
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = r1
        real y2 = r2
        real ang = Atan2(y2-y1,x2-x1)
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        int time = R2I(Pdis(x1,y1,x2,y2)/30)
        int flag = fl
        SetUnitFacing(u1,ang/0.01745)
        LocAddEffectSetSize(x1,y1,"effect_blue-guagnzhu-special.mdx",1)
        SetUnitVertexColor(u1,255,255,255,0)
        TimerStart(0.035,true)
        {
            time = time - 1
            if  time > 0 and IsPlayerInChallenge == true
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitFacing(u1,ang/0.01745)
                SetUnitPosition(u1,x1,y1)
                SetUnitAnimation(u1,"walk")
                //if  ModuloInteger(time,2) == 0
                    LocAddEffectSetSize(x1,y1,"effect_blue-blink2.mdx",2)
                //endif
            else
                LocAddEffectSetSize(x1,y1,"effect_blue-chuansong.mdx",1)
                ShowUnitOfOnlyPlayer(pid,u1,UnitAPOfPlayer)
                if  flag == 0
                    GameChalleng_6_JumpAttack1(pid)
                elseif  flag == 1
                    GameChalleng_6_JumpAttack2(pid)
                endif
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function EnRctGameChalleng_6_Way0()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  GameChallengUnit[69] == null and GameChallengInt[60] == 0 and IsFinshChallenge(6) == false and IsPlayerInChallenge == true
                    GameChallengInt[60] = 1
                    SetUnitVertexColor(GameChallengUnit[61],255,255,255,0)
                    SetUnitVertexColor(GameChallengUnit[51],255,255,255,0)
                    GameChallengUnit[69] = CreateUnit(Player(9),'np07',GetUnitX(Pu[1]),GetUnitY(Pu[1]),45)
                    ShowUnitOfOnlyPlayer(pid,GameChallengUnit[69],UnitAPOfPlayer)
                    UnitAddAbility(GameChallengUnit[69],'AZ99')
                    SetUnitAbilityLevel(GameChallengUnit[69],'AZ99',pid+1)
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff跟随姜子牙|r")
                    GameChalleng_6_Jump1(pid,GameChallengUnit[69],-1184,7072,0)
                endif
            endif
        endif
        flush locals
    endfunction

    function GameChallenge_6_A_Death(int pid,unit u2)
        int uid = GetUnitTypeId(u2)
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        if  uid == 'uf60'
            if  GameChallengInt[60] == 1
                GameChallengInt[60] = 2
                GameChalleng_6_Jump1(pid,GameChallengUnit[69],-288,7296,1)
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff跟随姜子牙|r")
            endif
        elseif  uid == 'uf61'
            if  GameChallengInt[60] == 2
                GameChallengInt[60] = 0
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[殷洪]：|r老师，弟子愿保武王灭纣，望乞救命！")
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[赤精子]：|r此时迟了！你已犯天条，自化飞灰，莫误了进封神台时辰！")
                GameChallenge_6Flush(pid,2)
                IsFinshChallenge(6) = true
                //奖励
                PlayerFinishPlotEx(pid,6)
            endif
        elseif  uid == 'uf62'
            if  GameChallengOperaWay[6] == 0
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r成功击杀申公豹！")
                if  GetGameChallengOperaSelsect() == 0
                    GameChallengOperaWay[6] = 1
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[殷郊]：|r吾奉师尊之命，此事不可鲁莽。师尊自会给我一个答案。")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00殷郊加入己方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00殷郊加入己方阵营！|r") 
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00殷郊加入己方阵营！|r")                                  
                else
                    GameChallengOperaWay[6] = 2
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[殷郊]：|r兄弟竟死于恶人之手，我与姜尚不共戴天！")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000殷郊加入敌方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000殷郊加入敌方阵营！|r") 
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000殷郊加入敌方阵营！|r") 
                endif
            endif
            GameChallenge_6Flush(pid,2)
            PlayerChallengeCosNum(6) = PlayerChallengeCosNum(6) + 1
            //奖励
            PlayerFinishPlotEx(pid,6)
        endif
    endfunction

    function InitGameChallenge_6()
        trigger tig = null
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengUnit[60] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np16',-2048,6368,180)
                SetUnitVertexColor(GameChallengUnit[60],255,255,255,0)
                GameChallengUnit[61] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e007',-2048,6368,0)
                SetUnitVertexColor(GameChallengUnit[61],255,255,255,0)
                GameChallengUnit[62] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np07',-2048,6560,0)
                SetUnitVertexColor(GameChallengUnit[62],255,255,255,0)

                GameChallengUnit[63] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np25',-1504,8352,225)
                SetUnitVertexColor(GameChallengUnit[63],255,255,255,0)
            endif
        end
        
        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[60],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_6_Way0)

        tig = null
    endfunction


endlibrary
