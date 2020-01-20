library ItemMeridians uses DamageCode,ItemGameFunc

    int DzMeridiansDayNum = 5
    int MeridiansMaxLv = 5

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
    
    function AddPlayerMeridiansState(int pid,int num)
        int lv = GetDzPlayerData(pid,6,num+1)
        int id = 0
        for num = 1,lv
            id = 'RM1A'+(num-1)*256
            SetPlayerTechResearchedEx(Player(pid),id+num-1)
        end
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

    function OpenMeridiansChallenge(int pid)
        int num = 0
        unit u = null
        real x = AttackRoomPostion[pid][1]
        real y = AttackRoomPostion[pid][2]
        int uid = 0
        int n = AttackUnitWN+1
        num = GetDzPlayerData(pid,1,10)
        if  GameLevel >= 2
            if  num < DzMeridiansDayNum
                u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'uJ01',x,y,270)
                UnitAddAbility(u,'AZ99')
                SetUnitAbilityLevel(u,'AZ99',pid+1)
                AddAttackSummonUnit.execute(pid,u)
                if  n >= 30
                    n = 30
                endif
                if  n >= 10
                    uid = YDWES2Id("m0"+I2S(n))
                else
                    uid = 'm001'+n
                endif
                SetUnitRealStateOfOtherId(u,uid)
                SetUnitRealState(u,1,GetUnitRealState(u,1)*5)
                SetUnitRealState(u,3,GetUnitRealState(u,3)*1.5)
                SetUnitRealState(u,5,GetUnitRealState(u,5)*10)
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[存档挑战-经脉]：|r|cffff0000为您召唤"+GetUnitName(u)+"！|r[今日成功突破经脉 |cffffcc00"+I2S(num)+"/"+I2S(DzMeridiansDayNum)+"|r]")
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[存档挑战-经脉]：|r您今日突破经脉次数已达上限！")
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[存档挑战-经脉]：|r该挑战难度2或以上才开放哦！")
        endif
        flush locals
    endfunction

    function MeridiansChallengeDeath(int pid)
        int num = GetRandomInt(1,8)
        real ran = 0
        if  GetDzPlayerData(pid,1,10) < DzMeridiansDayNum
            if  GetDzPlayerData(pid,6,num+1) < MeridiansMaxLv
                ran = 0.01*(40+3*GameLevel)
                if  GetRandomReal(0,1) <= ran
                    AddDzPlayerData(pid,1,10,1)
                    AddDzPlayerData(pid,6,num+1,1)
                    AddDzPlayerData(pid,6,1,1)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[存档挑战-经脉]：|r恭喜你成功突破|cffffff00“"+GetMeridiansName(num)+"”|r！|r[今日成功突破经脉 |cffffcc00"+I2S(GetDzPlayerData(pid,1,10))+"/"+I2S(DzMeridiansDayNum)+"|r]")
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[存档挑战-经脉]：|r很遗憾突破经脉失败，继续加油哦！")
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[存档挑战-经脉]：|r很遗憾突破经脉失败，继续加油哦！")
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[存档挑战-经脉]：|r您今日突破经脉次数已达上限！")
        endif
    endfunction

endlibrary
