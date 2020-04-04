library GameChallenge10 uses GameChallengeBase

    function SendToGameChallenge_10_End()
        BJDebugMsg("SendToGameChallenge_10_End")
        if  DzConA[14] == 1
            //SendToGameChallenge_10(pid)
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[团队副本-万魔窟]：|r|cffff0000当前万魔窟暂未开放！！！|r")
        endif
    endfunction

    function OpenGameChallenge10_BOSS()
        int time = 30
        SetUnitOwner(GameChalleng_MJ_BOSS,Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
        OpenGameTeamChallengeTimer(time,20)
        SetUnitIntState(GameChalleng_MJ_BOSS,'ut21',time)
        TimerStart(1,true)
        {
            time = time - 1
            if  time > 0 and GetUnitTypeId(GameChalleng_MJ_BOSS) == 'ut21'
                SetUnitIntState(GameChalleng_MJ_BOSS,'ut21',time)
            else
                if  GetUnitTypeId(GameChalleng_MJ_BOSS) == 'ut21'
                    SetTextTagText(GameChallengeTexttag[0],"|cffffff00领主睡觉中！ "+I2S(GameTeamChallengeInt(2))+"/300|r",0.045)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本-寻宝秘境]：|r|cffff0000未在时间内击杀秘境领主，秘境领主回去睡觉了！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本-寻宝秘境]：|r|cffff0000未在时间内击杀秘境领主，秘境领主回去睡觉了！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本-寻宝秘境]：|r|cffff0000未在时间内击杀秘境领主，秘境领主回去睡觉了！！！|r")
                    SetUnitOwner(GameChalleng_MJ_BOSS,Player(PLAYER_NEUTRAL_PASSIVE),true)
                    SetUnitIntState(GameChalleng_MJ_BOSS,'ut21',0)
                    SetUnitPosition(GameChalleng_MJ_BOSS,11488,-7536)
                    SetUnitFacing(GameChalleng_MJ_BOSS,270)
                    UnitAddAbility(GameChalleng_MJ_BOSS,'Avul')
                    UnitAddAbility(GameChalleng_MJ_BOSS,'AZ8A')
                    UnitAddEffectOfGameChalleng(GameChalleng_MJ_BOSS)
                endif
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameTeamChallengDeath_B(unit u2)
        int uid = GetUnitTypeId(u2)
        if  uid == 'ut20'
            if  GetUnitTypeId(GameChalleng_MJ_BOSS) == 'ut21' and GetUnitAbilityLevel(GameChalleng_MJ_BOSS,'AZ8A') > 0
                GameTeamChallengeInt(2) = GameTeamChallengeInt(2) + 1
                SetTextTagText(GameChallengeTexttag[0],"|cffffff00领主睡觉中！ "+I2S(GameTeamChallengeInt(2))+"/300|r",0.045)
                if  GameTeamChallengeInt(2) == 300
                    SetTextTagText(GameChallengeTexttag[0],"",0.045)
                    UnitRemoveAbility(GameChalleng_MJ_BOSS,'Avul')
                    UnitRemoveAbility(GameChalleng_MJ_BOSS,'AZ8A')
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,15,"|cffffcc00[团队副本-寻宝秘境]：|r累积击杀"+I2S(GameTeamChallengeInt(2))+"只秘境小怪，|cffff0000秘境领主苏醒了！！！击杀领主可进入万魔窟！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,15,"|cffffcc00[团队副本-寻宝秘境]：|r累积击杀"+I2S(GameTeamChallengeInt(2))+"只秘境小怪，|cffff0000秘境领主苏醒了！！！击杀领主可进入万魔窟！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,15,"|cffffcc00[团队副本-寻宝秘境]：|r累积击杀"+I2S(GameTeamChallengeInt(2))+"只秘境小怪，|cffff0000秘境领主苏醒了！！！击杀领主可进入万魔窟！！！|r")
                    GameTeamChallengeInt(2) = 0
                elseif  ModuloInteger(GameTeamChallengeInt(2),50) == 0
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[团队副本-寻宝秘境]：|r|cffffff00已击杀"+I2S(GameTeamChallengeInt(2))+"只秘境小怪，累积击杀300只可唤醒秘境领主！|r")
                endif
            endif
        elseif  uid == 'ut21'
            for num = 0,1
                SetUnitVertexColor(GameTeamChallengUnit(30+num),255,255,255,0)
                UnitRemoveAbility(GameTeamChallengUnit(30+num),'AZ99')
            end
            SetTextTagLifespan(GameChallengeTexttag[0],2.00)
            SetTextTagFadepoint(GameChallengeTexttag[0],0.50)
            GameChalleng_MJ_BOSS = null

            GameChalleng_MJ_BOSS = CreateTmUnit(Player(PLAYER_NEUTRAL_PASSIVE),"effect_az_goods_tp_target(3).mdl",11488,-7536,270,0,1.8)
            EXSetUnitMoveType(GameChalleng_MJ_BOSS,0x01)
            EXSetUnitMoveType(CreateTmUnit(Player(PLAYER_NEUTRAL_PASSIVE),"sunwell.mdl",11488,-7536,270,0,1.98),0x01)
            CreateTrigUnitInRange(GameChalleng_MJ_BOSS,198,function SendToGameChallenge_10_End)

            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本-寻宝秘境]：|r|cffffff80成功击杀秘境领主，万魔窟已开启！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本-寻宝秘境]：|r|cffffff80成功击杀秘境领主，万魔窟已开启！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本-寻宝秘境]：|r|cffffff80成功击杀秘境领主，万魔窟已开启！！！|r")
        endif
    endfunction

    function SendToGameChallenge_10(int pid)
        real x = 0
        real y = 0
        if  pid == 0
            x = GetRectMaxX(ChallengeRct_MJ[pid])
            y = GetRectMinY(ChallengeRct_MJ[pid])
        elseif  pid == 1
            x = GetRectMinX(ChallengeRct_MJ[pid])
            y = GetRectMinY(ChallengeRct_MJ[pid])
        elseif  pid == 2
            x = GetRectMinX(ChallengeRct_MJ[pid])
            y = GetRectMaxY(ChallengeRct_MJ[pid])
        elseif  pid == 3
            x = GetRectMaxX(ChallengeRct_MJ[pid])
            y = GetRectMaxY(ChallengeRct_MJ[pid])
        endif
        SendPlayerUnit(pid,x,y)
        if  GetUnitTypeId(GameChalleng_MJ_BOSS) == 'ut21'
            DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[团队副本-寻宝秘境]：|r进入寻宝秘境，累积击杀300只秘境小怪可唤醒秘境领主！")
        endif
    endfunction

    function InitGameChallenge_10()
        real x = 0
        real y = 0
        real xlength = 192
        real ylength = 224
        real xs = 320
        real ys = 288
        ChallengeRct_MJ[0] = gg_rct_ChallengeRct_MJ_M_0
        ChallengeRct_MJ[1] = gg_rct_ChallengeRct_MJ_M_1
        ChallengeRct_MJ[2] = gg_rct_ChallengeRct_MJ_M_2
        ChallengeRct_MJ[3] = gg_rct_ChallengeRct_MJ_M_3

        GameChalleng_MJ_BOSS = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'ut21',11488,-7536,270)
        UnitAddAbility(GameChalleng_MJ_BOSS,'Avul')
        UnitAddAbility(GameChalleng_MJ_BOSS,'AZ8A')

        GameChallengeTexttag[0] = CreateTextTag()
        SetTextTagText(GameChallengeTexttag[0],"|cffffff00领主睡觉中！ 0/300|r",0.045)
        SetTextTagPos(GameChallengeTexttag[0],11488-240,-7536+150,0)

        for j = 0,4
            for k = 0,3
                x = GetRectMinX(ChallengeRct_MJ[0])+xlength+xs*j
                y = GetRectMaxY(ChallengeRct_MJ[0])-ylength-ys*k
                CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut20',x,y,270)
            end
        end

        for j = 0,4
            for k = 0,3
                x = GetRectMaxX(ChallengeRct_MJ[1])-xlength-xs*j
                y = GetRectMaxY(ChallengeRct_MJ[1])-ylength-ys*k
                CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut20',x,y,270)
            end
        end

        for j = 0,4
            for k = 0,3
                x = GetRectMaxX(ChallengeRct_MJ[2])-xlength-xs*j
                y = GetRectMinY(ChallengeRct_MJ[2])+ylength+ys*k
                CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut20',x,y,90)
            end
        end

        for j = 0,4
            for k = 0,3
                x = GetRectMinX(ChallengeRct_MJ[3])+xlength+xs*j
                y = GetRectMinY(ChallengeRct_MJ[3])+ylength+ys*k
                CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut20',x,y,90)
            end
        end

        GameTeamChallengUnit(30) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',11414,-7536,270)
        GameTeamChallengUnit(31) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',11562,-7536,270)
        for j = 0,1
            SetUnitScale(GameTeamChallengUnit(30+j),10.5,10.5,10.5)
            SetUnitVertexColor(GameTeamChallengUnit(30+j),255,255,255,0)
            SetUnitFlyHeight(GameTeamChallengUnit(30+j),10,10000)
        end
    endfunction

endlibrary
