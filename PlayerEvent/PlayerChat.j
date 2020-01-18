scope PlayerCaht initializer InitPlayerChat

    function ShowUnitState(int pid)
        real value = 0
        for i = 1,70
            value = GetUnitRealState(Pu[5],i)
            if  value != 0
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00["+StateName[i]+"]:|r"+R2S(value)+StateName[i+200])
            endif
        end
        
    endfunction
    
    func PlayerChatActions()
        string chat = GetEventPlayerChatString()
        string chat1 = StringCase(chat,false)
        string chat2 = StringCase(SubString(chat,0,2),false)
        string chat3 = StringCase(SubString(chat,0,3),false)
        string chat4 = StringCase(SubString(chat,0,4),false)
        string chat5 = StringCase(SubString(chat,0,5),false)
        string str = ""
        int value = 0
        int i1 = 0
        int i2 = 0 
        int i3 = 0
        int i4 = 0
        int pid = GetPlayerId(GetTriggerPlayer())
        if  chat1 == QQqunNumber
            PlayerChatCode(pid,3)
        elseif  chat1 == "魔芝rpg" or chat1 == "墨汁rpg"
            PlayerChatCode(pid,1)
        elseif  chat1 == WXstring
            PlayerChatCode(pid,4)
        elseif  chat == "关闭特效"
            ShowEffect = false
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]:|r特效显示已关闭（屏蔽大部分特效，输入开启特效取消屏蔽）！")
        elseif  chat == "开启特效"
            ShowEffect = true
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]:|r特效显示已开启（输入关闭特效可屏蔽）！")
        elseif  chat1 == "hg"

        elseif  chat1 == "jf"
            DisplayTimedTextToPlayer(Player(pid),0,0,2,"|cffffcc00[当前通关积分]:|r"+I2S(GetData(pid,1,1)))
            DisplayTimedTextToPlayer(Player(pid),0,0,2,"|cffffcc00[当前守家积分]:|r"+I2S(GetData(pid,1,2)))
        elseif  chat1 == "hd"

        elseif  chat1 == "tg"
            for i = 1,9
                DisplayTimedTextToPlayer(Player(pid),0,0,2,"|cffffcc00[难"+I2S(i)+"通关次数]:|r"+I2S(GetData(pid,3,i)))
            end
        elseif  chat3 == "-sh"
            //if  TextBoll == false
            //    TextBoll = true
                //DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]:|r伤害显示已关闭！")
            //else
            //    TextBoll = false
                //DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]:|r伤害显示已开启！")
            //endif
        elseif  chat == "++" or chat == "+"
            real h = GetCameraField(CAMERA_FIELD_TARGET_DISTANCE) + 200
            if  Player(pid)==GetLocalPlayer()
                if  h > 4000
                    h = 4000
                endif
                SetCameraField( CAMERA_FIELD_TARGET_DISTANCE, h, 0 )
            endif
        elseif  chat2 == "--" or chat == "-" 
            h = GetCameraField(CAMERA_FIELD_TARGET_DISTANCE) - 200
            if  Player(pid)==GetLocalPlayer()
                if  h < 1000
                    h = 1000
                endif
                SetCameraField( CAMERA_FIELD_TARGET_DISTANCE, h, 0 )
            endif

        elseif  chat4 == "time"
            DisplayTimedTextToPlayer(Player(pid),0,0,3,I2S(NowDay)+ServerTimeDeBug())
        else
            if  DzBool == true
                if  chat3 == "add"
                    if  S2I(SubString(chat,3,6)) > 99
                        AddUnitIntState(Pu[1],S2I(SubString(chat,3,6)),S2I(SubString(chat,6,15)))
                    else
                        AddUnitRealState(Pu[1],S2I(SubString(chat,3,6)),S2I(SubString(chat,6,15)))
                    endif
                    BJDebugMsg("玩家"+I2S(pid)+StateName[S2I(SubString(chat,3,6))]+"增加"+SubString(chat,6,15))
                elseif  chat2 == "se"
                    SaveData(pid,S2I(SubString(chat,2,3)),S2I(SubString(chat,3,5)),S2I(SubString(chat,5,10)))
                    BJDebugMsg(SubString(chat,2,3)+"&"+SubString(chat,3,5)+"&"+SubString(chat,5,10))
                elseif  chat4 == "-uaa"
                    PlayerLearnAbilityFunc(pid,YDWES2Id(SubString(chat,5,10)))
                elseif  chat4 == "-ure"
                    ReHeroPrePareFunc(pid,YDWES2Id(SubString(chat,5,10)))
                elseif  chat4 == "-ual"
                    PlayerLearnThreeAbilityFunc(pid,'S001','S002','S003')
                elseif  chat4 == "-uaf"
                    AddPlayerMagicItem(pid,YDWES2Id(SubString(chat,5,10)))
                elseif  chat4 == "uci"
                    UnitAddItem(Pu[1],CreateItem(YDWES2Id(SubString(chat,4,8)),GetUnitX(Pu[1]),GetUnitY(Pu[1])))
                elseif  chat2 == "dz" 
                    SetUnitAnimationByIndex( Pu[1], S2I(SubString(chat,2,4)) )
                elseif  chat2 == "xp"
                    HeroAddExp( Pu[1], S2I(SubString(chat,2,10)))
                elseif  chat4 == "show"
                    ShowUnitState(pid)
                elseif  chat3 == "zdl" 
                    SetPlayerHeroPower(pid,S2I(SubString(chat,3,13)))
                elseif  chat3 == "gfb"
                    PlayerFinishPlotEx(pid,S2I(SubString(chat,3,13)))
                elseif  chat3 == "nqt"
                    SetAngerBar(pid,S2I(SubString(chat,3,6)))
                endif
                if  chat1 == "111"
                    ShowtOperaRectRange(true)
                elseif  chat1 == "222"
                    ShowtOperaRectRange(false)
                endif
                if  chat1 == "opera3"
                    ExecuteFunc("CreateOperaC")
                elseif  chat1 == "opera2"
                    ExecuteFunc("CreateOperaB")
                elseif  chat1 == "opera1"
                    ExecuteFunc("CreateOperaA")
                elseif  chat1 == "god"
                    ExecuteFunc("OpenChangeGodStage")
                elseif  chat1 == "fbb7"
                    OpenGameChallenge_7(pid,1)
                elseif  chat1 == "fbb8"
                    OpenGameChallenge_8(pid,1)
                elseif  chat1 == "fbb6"
                    OpenGameChallenge_6(pid,1)
                elseif  chat1 == "fbb5"
                    OpenGameChallenge_5(pid,1)
                elseif  chat1 == "fbb4"
                    OpenGameChallenge_4(pid,1)
                elseif  chat1 == "fbb3"
                    OpenGameChallenge_3(pid,1)
                elseif  chat1 == "fbb2"
                    OpenGameChallenge_2(pid,1)
                elseif  chat1 == "fbb1"
                    OpenGameChallenge_1(pid,1)
                elseif  chat1 == "fba7"
                    OpenGameChallenge_7(pid,0)
                elseif  chat1 == "fba8"
                    OpenGameChallenge_8(pid,0)
                elseif  chat1 == "fba6"
                    OpenGameChallenge_6(pid,0)
                elseif  chat1 == "fba5"
                    OpenGameChallenge_5(pid,0)
                elseif  chat1 == "fba4"
                    OpenGameChallenge_4(pid,0)
                elseif  chat1 == "fba3"
                    OpenGameChallenge_3(pid,0)
                elseif  chat1 == "fba2"
                    OpenGameChallenge_2(pid,0)
                elseif  chat1 == "fba1"
                    OpenGameChallenge_1(pid,0)
                elseif  chat1 == "fbc1"
                    OpenGameTeamChallenge(pid,1,10)
                endif
                if  chat1 == "debug"
                    WMLeakMonitorSystem()
                elseif  chat == "geiqian"
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,500000)
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,50000)
                endif
                if  StringCase(SubString(chat,0,9),false) == "bossskill"
                    for num = 0,25
                        if  GetUnitAbilityLevel(Pu[1],'AZ1A'+num) > 0
                            UnitRemoveAbility(Pu[1],'AZ1A'+num)
                        endif
                        if  GetUnitAbilityLevel(Pu[1],'AZ0A'+num) > 0
                            UnitRemoveAbility(Pu[1],'AZ0A'+num)
                        endif
                    end
                    if  S2I(SubString(chat,9,11)) >= 26
                        UnitAddAbility(Pu[1],'AZ1A'+S2I(SubString(chat,9,11))-26)
                    else
                        UnitAddAbility(Pu[1],'AZ0A'+S2I(SubString(chat,9,11)))
                    endif
                endif
                //ServerTime = ServerTime + 21600
            endif
        endif
    end

    func InitPlayerChat()
        trigger trg = CreateTrigger()
        for i = 0,3
            TriggerRegisterPlayerChatEvent(trg,Player(i),"",true)
        end
        TriggerAddAction(trg,function PlayerChatActions)
        trg = null
    end
endscope

