library ItemMeridians uses DamageCode,ItemGameFunc

    int DzMeridiansDayNum = 2
    int MeridiansMaxLv = 5

    bool IsMeridiansChallenging = false

    function CreateMeridiansNPC()
        CreateUnit(Player(9),'np43',-1300,-7100,270)
        CreateUnit(Player(9),'np44',-1300,-7100,270)
        SetUnitScale(CreateUnit(Player(9),'eZ08',-1300,-7100,270),1.9,1.9,1.9)

        UnitAddAbility(GameDefendUnit,'AZ08')
        UnitAddAbility(GameDefendUnit,'Avul')
    endfunction

    function GetMeridiansName(int num)->string
        if  num == 1
            return "任脉"
        elseif  num == 2
            return "督脉"
        elseif  num == 3
            return "冲脉"
        elseif  num == 4
            return "带脉"
        elseif  num == 5
            return "阴跷脉"
        elseif  num == 6
            return "阳跷脉"
        elseif  num == 7
            return "阴维脉"
        elseif  num == 8
            return "阳维脉"
        endif
        return ""
    endfunction

    function AddPlayerMeridiansStateOfLevel(int pid,int num,int lv)
        int id = 'RM1A'+(num-1)*256
        if  lv > 0
            SetPlayerTechResearchedEx(Player(pid),id+lv-1)
        endif
    endfunction
    
    function AddPlayerMeridiansState(int pid,int num)
        int lv = GetDzPlayerData(pid,6,num+1)
        int id = 0
        if  lv > 0
            for n = 1,lv
                id = 'RM1A'+(num-1)*256
                SetPlayerTechResearchedEx(Player(pid),id+n-1)
            end
        endif
    endfunction

    function InitPlayerMeridiansState(int pid)
        int max = GetDzPlayerData(pid,6,1)
        int cos = 0
        for num = 1,8
            cos = cos + GetDzPlayerData(pid,6,num+1)
        end
        if  cos > max
            for num = 1,8
                if  max > 0
                    if  max >= MeridiansMaxLv
                        max = max - MeridiansMaxLv
                        SetDzPlayerData(pid,6,num+1,MeridiansMaxLv)
                    else
                        SetDzPlayerData(pid,6,num+1,max)
                        max = 0
                    endif
                else
                    SetDzPlayerData(pid,6,num+1,0)
                endif
            end
        endif
        for num = 1,8
            AddPlayerMeridiansState(pid,num)
        end
    endfunction

    function CreateOperaLastBoss()
        unit u = null
        unit u2 = null
        int uid = 'utJA'
        PingMinimap(-1664,-7328,5)
        u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),uid,-1664,-7328,270)
        UnitAddAbility(u,'AZ01')
        SetUnitAnimation(u,"attack")
        LocAddEffect(-1664,-7328,"effect_blue-chuansong.mdx")
        LocAddEffectSetSize(-1664,-7328,"effect_[dz.spell]001.mdl",1)
        LocAddEffectSetSize(-1664,-7328,"effect_red-yumao-zhendi-paoxiao.mdx",2.5)
        for num = 1,5
            u2 = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'e000',-1664+600*Cos(72*num*0.01745),-7328+600*Sin(72*num*0.01745),270)
            RemoveUnitTimer(u2,1)
            BossFuncSpell.execute(u,u2,'AZ0L')
        end
        AttackPlayingHero(u)
        flush locals
    endfunction

    function OpenMeridiansChallenge(int pid)
        unit u = null
        real x = AttackRoomPostion[pid][1]
        real y = AttackRoomPostion[pid][2]
        int uid = 0
        int n = AttackUnitWN+1
        if  GameLevel >= 3
            if  IsMeridiansChallenging == false
                IsMeridiansChallenging = true
                CreateOperaLastBoss()
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[通关挑战-经脉]：|r"+GetPlayerNameOfColor(pid)+"|cffff0000召唤了"+GetObjectName('utJA')+"！！！|r")
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[通关挑战-经脉]：|r"+GetPlayerNameOfColor(pid)+"|cffff0000召唤了"+GetObjectName('utJA')+"！！！|r")
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[通关挑战-经脉]：|r"+GetPlayerNameOfColor(pid)+"|cffff0000召唤了"+GetObjectName('utJA')+"！！！|r")
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[通关挑战-经脉]：|r当前正在挑战经脉！")
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[通关挑战-经脉]：|r该挑战难度3或以上才开放哦！")
        endif
        flush locals
    endfunction

    function MeridiansChallengeDeathEx(int pid)
        int num = GetRandomInt(1,8)
        real ran = 0
        BJDebugMsg(I2S(GetDzPlayerData(pid,1,10)))
        if  GetDzPlayerData(pid,1,10) < DzMeridiansDayNum
            if  GetDzPlayerData(pid,6,num+1) < MeridiansMaxLv
                AddDzPlayerData(pid,1,10,1)
                AddDzPlayerData(pid,6,num+1,1)
                AddDzPlayerData(pid,6,1,1)
                AddPlayerMeridiansStateOfLevel(pid,num,GetDzPlayerData(pid,6,num+1))
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[通关挑战-经脉]：|r恭喜你成功突破|cffffff00“"+GetMeridiansName(num)+"”|r！|r[今日成功突破经脉 |cffffcc00"+I2S(GetDzPlayerData(pid,1,10))+"/"+I2S(DzMeridiansDayNum)+"|r]")
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffff0000[通关挑战-经脉]：|r很遗憾突破经脉失败，继续加油哦！")
            endif
        else
            AddDzPlayerData(pid,2,1,20)
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[通关挑战-经脉]：|r您今日突破经脉次数已达上限，自动转化为20点通关积分！")
        endif
    endfunction

    function MeridiansChallengeDeath()
        for pid = 0,3
            if  IsPlaying(pid) == true
                MeridiansChallengeDeathEx(pid)
            endif
        end
        IsMeridiansChallenging = false
    endfunction

endlibrary
