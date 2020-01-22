library ItemGameFunc uses DamageCode

    int array ItemGameFuncArrayInt[12][680]

    bool array ItemGameFuncArrayBool[12][680]

    #define ItemGameFuncInt                 ItemGameFuncArrayInt[pid]

    #define ItemGameFuncBool                ItemGameFuncArrayBool[pid]
    #define GameGiftBool                    ItemGameFuncArrayBool[pid]

    #define PlayerMonsterSoulNum            ItemGameFuncInt[100]
    #define PlayerMonsterSoulLuckNum        ItemGameFuncInt[101]
    #define PlayerMonsterSoul(num)          ItemGameFuncInt[102+num]

    private int array itema

    function SetGifeItemStock(int pid)
        for num = 1,8
            if  num != 3
                RemoveItemFromStock(Pu[26],'IB00'+num)
                RemoveItemFromStock(Pu[26],'IB50'+num)
            endif
        end
        for num = 1,8
            if  num != 3
                if  GameGiftBool[num] == false
                    AddItemToStock(Pu[26],'IB00'+num,1,1)
                else
                    AddItemToStock(Pu[26],'IB50'+num,1,1)
                endif
            endif
        end
    endfunction

    function ItemGameGift(int pid,string gift)  
        int num = 0 
        int gold = 0
        if  true//gift != null and gift != ""
            if  gift == "公众号"
                num = 1
                if  GetDzPlayerData(pid,1,21) == 0
                    if  GameGiftBool[num] == false
                        GameGiftBool[num] = true
                        SaveDzPlayerData(pid,1,21,1)
                        AddUnitRealState(Pu[1],46,3)
                        AddUnitRealState(Pu[1],43,1)
                        AddUnitRealState(Pu[1],48,1)
                        DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[系统]：|r成功领取|cffffcc00【"+gift+"礼包】|r，杀敌金币+3、杀敌攻击+1、每秒业力+1！") 
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r您已领取过该礼包！")
                    endif
                else
                    if  GameGiftBool[num] == false
                        GameGiftBool[num] = true
                        AddUnitRealState(Pu[1],46,3)
                        AddUnitRealState(Pu[1],43,1)
                        AddUnitRealState(Pu[1],48,1)
                        DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[系统]：|r成功领取|cffffcc00【"+gift+"礼包】|r，杀敌金币+3、杀敌攻击+1、每秒业力+1！") 
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r您已领取过该礼包！")
                    endif
                endif
            elseif  gift == "入群"
                num = 2
                if  GetDzPlayerData(pid,1,22) == 0
                    if  GameGiftBool[num] == false
                        GameGiftBool[num] = true
                        SaveDzPlayerData(pid,1,22,1)
                        UnitAddItemEx(Pu[1],'I012')
                        DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[系统]：|r成功领取|cffffcc00【"+gift+"礼包】|r，获得"+GetObjectName('I012')+"！")
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r您已领取过该礼包！")
                    endif
                else
                    if  GameGiftBool[num] == false
                        GameGiftBool[num] = true
                        UnitAddItemEx(Pu[1],'I012')
                        DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[系统]：|r成功领取|cffffcc00【"+gift+"礼包】|r，获得"+GetObjectName('I012')+"！")
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r您已领取过该礼包！")
                    endif
                endif
            elseif  gift == "评价"
                num = 3
                if  DzPlayerLv(Player(pid)) >= 3 
                    if  GameGiftBool[num] == false
                        GameGiftBool[num] = true
                        AddUnitRealState(Pu[1],46,5)
                        AddUnitRealState(Pu[1],44,1)
                        DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[系统]：|r成功领取|cffffcc00【"+gift+"礼包】|r，杀敌生命+5、杀敌业力+1！") 
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r您已领取过该礼包！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r领取|cffffcc00【"+gift+"礼包】|r失败！")
                endif
            elseif  gift == "收藏"
                num = 4
                if  DzAPI_Map_Returns(Player(pid),16) == true
                    if  GameGiftBool[num] == false
                        GameGiftBool[num] = true
                        AddUnitRealState(Pu[1],15,5)
                        AddUnitRealState(Pu[1],16,5)
                        DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[系统]：|r成功领取|cffffcc00【"+gift+"礼包】|r，物理伤害+5%、法术伤害+5%！") 
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r您已领取过该礼包！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r领取|cffffcc00【"+gift+"礼包】|r失败！")
                endif
            elseif  gift == "重置版"
                num = 5
                if  DzAPI_Map_IsBuyReforged(Player(pid)) == true
                    if  GameGiftBool[num] == false
                        GameGiftBool[num] = true
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,1000)
                        AddUnitRealState(Pu[1],47,2)
                        AddUnitRealState(Pu[1],48,1)
                        DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[系统]：|r成功领取|cffffcc00【"+gift+"礼包】|r，金币+1000、每秒攻击+2、每秒业力+1！") 
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r您已领取过该礼包！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r领取|cffffcc00【"+gift+"礼包】|r失败！")
                endif
            elseif  gift == "公会"
                num = 6
                if  IsPlayerIn_MZRPG_Cooperate_Guild(pid) == true
                    if  GameGiftBool[num] == false
                        GameGiftBool[num] = true
                        AddUnitRealState(Pu[1],46,10)
                        AddUnitRealState(Pu[1],27,1)
                        AddUnitRealState(Pu[1],25,5)
                        DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[系统]：|r成功领取|cffffcc00【"+gift+"礼包】|r，杀敌生命+10、被动触发概率+1%、技能冷却-5%！") 
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r您已领取过该礼包！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r领取|cffffcc00【"+gift+"礼包】|r失败！")
                endif
            elseif  gift == "星耀"    
                num = 7
                if  IsPlayerIn_MZRPG_Star(pid) == true
                    if  GameGiftBool[num] == false
                        GameGiftBool[num] = true
                        AddUnitRealState(Pu[1],46,50)
                        AddUnitRealState(Pu[1],44,2)
                        AddUnitRealState(Pu[1],27,2)
                        AddUnitRealState(Pu[1],25,10)
                        DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[系统]：|r成功领取|cffffcc00【"+gift+"礼包】|r，杀敌生命+50、杀敌业力+2、被动触发概率+2%、技能冷却-10%！") 
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r您已领取过该礼包！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r领取|cffffcc00【"+gift+"礼包】|r失败！")
                endif
            elseif  gift == "魔芝"    
                num = 8
                if  GameGiftBool[num] == false
                    GameGiftBool[num] = true
                    AddUnitRealState(Pu[1],61,1)
                    DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[系统]：|r成功领取|cffffcc00【"+gift+"礼包】|r，练功房怪物数量+1！") 
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r您已领取过该礼包！")
                endif
            elseif  gift == "老铁"    
                num = 9
                if  GetPublicMapLevel(pid) > 0
                    if  GameGiftBool[num] == false
                        GameGiftBool[num] = true
                        
                        DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[系统]：|r成功领取|cffffcc00【"+gift+"礼包】|r，！") 
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r您已领取过该礼包！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r领取|cffffcc00【"+gift+"礼包】|r失败！")
                endif
            endif
        endif
        SetGifeItemStock(pid)
    endfunction

    function PlayerGetGameGift(int pid,int itid)
        if  itid == 'IB01' //公众号 口令
            SetGifeItemStock(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r该礼包需要输入口令领取！")
        elseif  itid == 'IB02' //公众号 入群
            SetGifeItemStock(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r该礼包需要输入口令领取！")
        elseif  itid == 'IB03'
            ItemGameGift(pid,"评价")
        elseif  itid == 'IB04'
            ItemGameGift(pid,"收藏")
        elseif  itid == 'IB05'
            ItemGameGift(pid,"重置版")
        elseif  itid == 'IB06'
            ItemGameGift(pid,"公会")
        elseif  itid == 'IB07'
            ItemGameGift(pid,"星耀")
        elseif  itid == 'IB08' //魔芝RPG 口令   
            SetGifeItemStock(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r该礼包需要输入口令领取！")
        elseif  itid == 'IB09'
            ItemGameGift(pid,"老铁")
        else
            SetGifeItemStock(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r您已领取过该礼包！")
        endif
    endfunction

    function InitPlayerGameGiftEx(int id)
        int time = 0
        int pid = id
        if  GetDzPlayerData(pid,1,21) == 1
            ItemGameGift(pid,"公众号") //自动领取
            AddItemToStock(Pu[26],'IB51',1,1)
        else
            AddItemToStock(Pu[26],'IB01',1,1)
        endif
        if  GetDzPlayerData(pid,1,22) == 1
            ItemGameGift(pid,"入群") //自动领取
            AddItemToStock(Pu[26],'IB52',1,1)
        else
            AddItemToStock(Pu[26],'IB02',1,1)
        endif
        AddItemToStock(Pu[26],'IB03',1,1)
        AddItemToStock(Pu[26],'IB04',1,1)
        AddItemToStock(Pu[26],'IB05',1,1)
        AddItemToStock(Pu[26],'IB06',1,1)
        AddItemToStock(Pu[26],'IB07',1,1)
        AddItemToStock(Pu[26],'IB08',1,1)
        TimerStart(0.1,true)
        {
            time = time + 1
            if  time == 1
                UnitAddItemEx(Pu[1],'IB06')//自动领取
            elseif  time == 2
                UnitAddItemEx(Pu[1],'IB07')//自动领取
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function InitPlayerGameGift(int id)
        int pid = id
        DisplayTimedTextToPlayer(Player(pid),0,0,6,"|cffffcc00[系统]：|r您已完成新手任务，为您自动领取游戏礼包！")
        TimerStart(0.5,false)
        {
            InitPlayerGameGiftEx(pid)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function AttackUnitItemStop(int pid,int num,real time) //进攻怪暂停
        if  InfiniteAttackBool == false
            if  CrazyAttackBool == false
                if  AttackUnitStopNum < num 
                    if  AttackUnitWN < AttackUnitWNOver
                        if  StopAttackBool == false
                            AttackUnitStopNum = AttackUnitStopNum + 1
                            FuncStopAttack(time)
                            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]：|r"+GetPlayerName(Player(pid))+"使用了暂停刷怪"+I2S(R2I(time/60))+"分钟（"+I2S(AttackUnitStopNum)+"/"+I2S(num)+"）" )
                        else
                            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,10000)
                            DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[系统]：|r当前已处于暂停刷怪！")
                        endif
                    endif
                else
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,10000)
                    DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[系统]：|r暂停刷怪次数已达"+I2S(num)+"次！")
                endif
            else
                AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,10000)
                DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[系统]：|r当前为疯狂模式无法暂停刷怪！")
            endif
        else
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,10000)
            DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[系统]：|r当前为无尽模式无法暂停刷怪！")
        endif
    endfunction

    function AttackUnitItemSpeedUp(int pid) //进攻怪加速
        if  InfiniteAttackBool == false
            if  CrazyAttackBool == false
                if  StopAttackBool == false
                    if  AttackUnitWN != 0
                        if  AttackUnitWN < AttackUnitWNOver
                            FlushChildHashtable(ht,GetHandleId(AttackTimer))
                            DestroyTimer(AttackTimer)
                            StartAttackUnit()
                            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]：|r"+GetPlayerName(Player(pid))+"使用了进攻怪加速！")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r第1波进攻怪无法加速！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[系统]：|r当前处于暂停刷怪，无法加速！")
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[系统]：|r当前为疯狂模式无法加速！")
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,1,"|cffffcc00[系统]：|r当前为无尽模式无法加速！")
        endif
    endfunction

    //////////////////////////////////兽魂///////////////////////////////

    function IsCanGetMonsterSoul(int pid)->boolean
        if  PlayerMonsterSoulNum == 0
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD) >= 10
                AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-10)
                return true
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[兽魂]：|r|cffff0000您的金币不足10！|r")
                return false
            endif
        elseif  PlayerMonsterSoulNum == 1
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD) >= 300
                AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-300)
                return true
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[兽魂]：|r|cffff0000您的金币不足300！|r")
                return false
            endif
        elseif  PlayerMonsterSoulNum == 2
            if  GetUnitIntState(Pu[1],108) >= 100
                AddUnitIntState(Pu[1],108,-100)
                return true
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[兽魂]：|r|cffff0000您的杀敌数不足100！|r")
                return false
            endif
        elseif  PlayerMonsterSoulNum == 3
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD) >= 1000
                AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-1000)
                return true
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[兽魂]：|r|cffff0000您的金币不足1000！|r")
                return false
            endif
        elseif  PlayerMonsterSoulNum == 4
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER) >= 1
                AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-1)
                return true
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[兽魂]：|r|cffff0000您的玄铁不足1！|r")
                return false
            endif
        elseif  PlayerMonsterSoulNum == 5
            if  GetUnitIntState(Pu[1],108) >= 300
                AddUnitIntState(Pu[1],108,-300)
                return true
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[兽魂]：|r|cffff0000您的杀敌数不足300！|r")
                return false
            endif
        elseif  PlayerMonsterSoulNum == 6
            if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD) >= 2000
                AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-2000)
                return true
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[兽魂]：|r|cffff0000您的金币不足2000！|r")
                return false
            endif
        elseif  PlayerMonsterSoulNum == 7
            if  GetUnitIntState(Pu[1],108) >= 600
                AddUnitIntState(Pu[1],108,-600)
                return true
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[兽魂]：|r|cffff0000您的杀敌数不足600！|r")
                return false
            endif
        endif
        return false
    endfunction

    function GetPlayerMonsterSoulLuck(int pid)->int
        int n = 0
        for num = 0,7
            if  PlayerMonsterSoul(num) == 0
                n = n + 1
                itema[n] = num
            endif
        end
        return itema[GetRandomInt(1,n)]
    endfunction

    function GetMonsterSoulLuck(int num)->string
        if  num == 0
            return "陛犴之魂"
        elseif  num == 1
            return "奎牛之魂"
        elseif  num == 2
            return "麒麟之魂"
        elseif  num == 3
            return "狻猊之魂"
        elseif  num == 4
            return "青鸾之魂"
        elseif  num == 5
            return "狰狞之魂"
        elseif  num == 6
            return "黑虎之魂"
        elseif  num == 7
            return "孔雀之魂"
        endif
        return ""
    endfunction

    function GetMonsterSoulState(int num)->string
        if  num == 0
            return "攻击+20%"
        elseif  num == 1
            return "生命+20%"
        elseif  num == 2
            return "杀敌生命+"+I2S(16+24*GameLevel)
        elseif  num == 3
            return "物理伤害+"+I2S(7+3*GameLevel)+"%"
        elseif  num == 4
            return "魔法伤害+"+I2S(7+3*GameLevel)+"%"
        elseif  num == 5
            return "暴击+5%"
        elseif  num == 6
            return "杀敌攻击+"+I2S(4+6*GameLevel)
        elseif  num == 7
            return "冷却缩减+10%"
        endif
        return ""
    endfunction
    
    function AddPlayerMonsterSoulState(int pid,int num)
        if  num == 0
            AddUnitRealState(Pu[1],32,20)
        elseif  num == 1
            AddUnitRealState(Pu[1],31,20)
        elseif  num == 2
            AddUnitRealState(Pu[1],45,16+24*GameLevel)
        elseif  num == 3
            AddUnitRealState(Pu[1],15,7+3*GameLevel)
        elseif  num == 4
            AddUnitRealState(Pu[1],16,7+3*GameLevel)
        elseif  num == 5
            AddUnitRealState(Pu[1],19,5)
        elseif  num == 6
            AddUnitRealState(Pu[1],43,4+6*GameLevel)
        elseif  num == 7
            AddUnitRealState(Pu[1],25,10)
        endif
    endfunction

    function SetPlayerMonsterSoulSkill(int pid)
        string s = ""
        s = "|cffffff00觉醒需求：|r"
        for num = 0,7
            if  PlayerMonsterSoul(num) == 1
                s = s + "|n|cff00ff00 - "+GetMonsterSoulLuck(num)+" "+GetMonsterSoulState(num)+"|r"
            else
                s = s + "|n|cff808080 - "+GetMonsterSoulLuck(num)+" "+GetMonsterSoulState(num)+"|r"
            endif
        end
        s = s + "|n|n|cff00ff00占星商店|r抽奖中，集齐|cff00ff00所有兽魂|r，可觉醒随机神兽神通。"
        if  Player(pid) == GetLocalPlayer()
            YDWESetUnitAbilityDataString(Pu[1],'AC04',1,203,"|cffff0000神兽神通|r - [|cffffcc00R|r]|n|cffff0000Ex级|r")
            YDWESetUnitAbilityDataString(Pu[1],'AC04',1,215,"|cffff0000神兽神通|r - [|cffffcc00R|r]|n|cffff0000Ex级|r")
            YDWESetUnitAbilityDataString(Pu[1],'AC04',1,218,s)
        endif
    endfunction

    function SetPlayerMonsterSoulItem(int pid)
        string s = ""
        if  PlayerMonsterSoulNum < 8
            if  PlayerMonsterSoulNum == 0
                s = "|cffffcc00抽取消耗：|r10金币"
            elseif  PlayerMonsterSoulNum == 1
                s = "|cffffcc00抽取消耗：|r300金币"
            elseif  PlayerMonsterSoulNum == 2
                s = "|cffffcc00抽取消耗：|r100杀敌数"
            elseif  PlayerMonsterSoulNum == 3
                s = "|cffffcc00抽取消耗：|r1000金币"
            elseif  PlayerMonsterSoulNum == 4
                s = "|cffffcc00抽取消耗：|r1玄铁"
            elseif  PlayerMonsterSoulNum == 5
                s = "|cffffcc00抽取消耗：|r300杀敌数"
            elseif  PlayerMonsterSoulNum == 6
                s = "|cffffcc00抽取消耗：|r2000金币"
            elseif  PlayerMonsterSoulNum == 7
                s = "|cffffcc00抽取消耗：|r600杀敌数"
            endif
            s = s + "|n|cffffcc00抽取次数：|r"+I2S(PlayerMonsterSoulLuckNum)
            s = s + "|n|cffffcc00抽取几率：|r"+I2S((7+PlayerMonsterSoulLuckNum*3))+"%"
            s = s + "|n|n|cffffcc00可获得：|r|cffff0080"
            for num = 0,7
                s = s + "|n"+GetMonsterSoulLuck(num)+" "+GetMonsterSoulState(num)
            end
            s = s + "|n|n|r|cff808080[抽取不会获得相同兽魂]|r"
            s = s + "|n|r|cff808080[中奖后会重置抽取几率]|r"
        else
            s = "|cffffcc00您已集齐所有兽魂！！！|r"
        endif
        if  Player(pid) == GetLocalPlayer() 
            YDWESetItemDataString('IS12',3,s)
            YDWESetItemDataString('IZ0C',3,s)
        endif
    endfunction

    function AddPlayerMonsterSoulSkill(int pid)
        HeroAddAbilityByIndex(Pu[1],4,'S230'+GetRandomInt(0,7))
        for num = 1,3
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[神兽神通]：|r|cffffff80恭喜"+GetPlayerNameOfColor(pid)+"|cffffff80觉醒了|cffff0080“神兽神通”|cffffff80！|r")
        end
    endfunction

    function SetMonsterSoulToStock(int id,int t)
        int pid = id
        int flag = t
        TimerStart(0.001,false)
        {
            if  flag == 0
                AddItemToStock(Pu[28],'IS12',1,1)
            elseif  flag == 1
                AddItemToStock(Pu[28],'IS12',0,1)
            elseif  flag == 2
                AddItemToStock(Pu[28],'IZ0C',0,1)
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function ItemLuckOfMonsterSoul(int pid)
        int num = 0
        real ran = 0
        if  PlayerMonsterSoulNum < 8
            if  IsCanGetMonsterSoul(pid) == true
                ran = 0.01*(7+PlayerMonsterSoulLuckNum*3)
                //BJDebugMsg(R2S(ran))
                if  GetRandomReal(0,1) <= ran
                    num = GetPlayerMonsterSoulLuck(pid)
                    PlayerMonsterSoul(num) = 1
                    PlayerMonsterSoulNum = PlayerMonsterSoulNum + 1
                    PlayerMonsterSoulLuckNum = -1
                    SetPlayerMonsterSoulSkill(pid)
                    AddPlayerMonsterSoulState(pid,num)
                    AddPlayerTechResearched(Player(pid),'RM50'+num,1)
                    if  PlayerMonsterSoulNum == 8 //and GetHeroLevel(Pu[1]) >= 8
                        //觉醒
                        AddPlayerMonsterSoulSkill(pid)
                        SetMonsterSoulToStock(pid,2)
                        GivePlayerMissionPrize(pid,'RR0A')
                    else
                        SetMonsterSoulToStock(pid,1)
                    endif
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[兽魂]：|r|cffffff80恭喜"+GetPlayerNameOfColor(pid)+"|cffffff80抽奖获得|cffff0080“"+GetMonsterSoulLuck(num)+"”|cffffff80！|r")
                    UnitAddEffectSetSize(Pu[1],"effect_hero_levelup.mdx",3)
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[兽魂]：|r很遗憾抽取失败！")
                    SetMonsterSoulToStock(pid,0)
                endif
                PlayerMonsterSoulLuckNum = PlayerMonsterSoulLuckNum + 1
                SetPlayerMonsterSoulItem(pid)
            else
                SetMonsterSoulToStock(pid,0)
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[兽魂]：|r|cffffff80您已觉醒所有兽魂！|r")
            SetMonsterSoulToStock(pid,0)
        endif
    endfunction

    function InitPlayerMonsterSoulSkillEx(int pid)
        
    endfunction

    function InitPlayerMonsterSoulSkill(int pid)
        string s = ""
        RemoveItem(CreateItem('IS12',0,0))
        RemoveItem(CreateItem('IZ0C',0,0))
        SetPlayerMonsterSoulSkill(pid)
        SetPlayerMonsterSoulItem(pid)
        InitPlayerMonsterSoulSkillEx(pid)
        for num = 0,7
            if  num == 0
                s = "|CffAAAAAA基础属性：|r|n攻击|Cffffd24d+20%|n|n|r|Cffaaaaaa龙生九子之一，形如猛虎，吞吃虎豹。|r"
            elseif  num == 1
                s = "|CffAAAAAA基础属性：|r|n生命|Cffffd24d+20%|n|n|r|Cffaaaaaa出入水必有风雨，能发出雷鸣之声，乃洪荒神兽。|r"
            elseif  num == 2
                s = "|CffAAAAAA基础属性：|r|n杀敌生命|Cffffd24d+"+I2S(16+24*GameLevel)+"|n|n|r|Cffaaaaaa四足风云声响亮，麟生雾彩映金光。|r"
            elseif  num == 3
                s = "|CffAAAAAA基础属性：|r|n物理伤害|Cffffd24d+"+I2S(7+3*GameLevel)+"%|n|n|r|Cffaaaaaa龙生九子之一，形如雄狮，生裂狮虎，据说和麒麟有仇。|r"
            elseif  num == 4
                s = "|CffAAAAAA基础属性：|r|n法术伤害|Cffffd24d+"+I2S(7+3*GameLevel)+"%|n|n|r|Cffaaaaaa凤生九雏之一，空中飞行，有巨爪利喙。|r"
            elseif  num == 5
                s = "|CffAAAAAA基础属性：|r|n暴击|Cffffd24d+5%|n|n|r|Cffaaaaaa五尾一角，类赤豹，上古凶兽，异常凶猛|r"
            elseif  num == 6
                s = "|CffAAAAAA基础属性：|r|n杀敌攻击|Cffffd24d+"+I2S(4+6*GameLevel)+"|n|n|r|Cffaaaaaa利爪如钩心胆壮，钢牙似剑劳凶顽。|r"
            elseif  num == 7
                s = "|CffAAAAAA基础属性：|r|n冷却缩减|Cffffd24d+10%|n|n|r|Cffaaaaaa孔宣所化，战力非凡|r"
            endif
            if  Player(pid) == GetLocalPlayer()
                YDWESetUnitAbilityDataString(Pu[1],'AM50'+num,1,218,s)
                YDWESetUnitAbilityDataString(Pu[1],'AM50'+num,1,204,"replaceabletextures\\commandbuttons\\BTNIH0"+I2S(num+1)+".blp")
            endif
        end
    endfunction

    //////////////////////////////使用类//////////////////////////////////
    
    function UnitItemIN07(int id)
        int pid = id
        int time = 0
        if  GetUnitState(Pu[1],UNIT_STATE_LIFE) < GetUnitState(Pu[1],UNIT_STATE_MAX_LIFE)
            SetUnitState(Pu[1],UNIT_STATE_LIFE,GetUnitState(Pu[1],UNIT_STATE_LIFE)+GetUnitState(Pu[1],UNIT_STATE_MAX_LIFE)*0.1)
        endif
        LocAddEffect(GetUnitX(Pu[1]),GetUnitY(Pu[1]),"effect_e_buffgreen2a.mdl")
        TimerStart(1,true)
        {
            time = time + 1
            if  time < 9
                if  GetUnitState(Pu[1],UNIT_STATE_LIFE) < GetUnitState(Pu[1],UNIT_STATE_MAX_LIFE)
                    SetUnitState(Pu[1],UNIT_STATE_LIFE,GetUnitState(Pu[1],UNIT_STATE_LIFE)+GetUnitState(Pu[1],UNIT_STATE_MAX_LIFE)*0.1)
                endif
                LocAddEffect(GetUnitX(Pu[1]),GetUnitY(Pu[1]),"effect_e_buffgreen2a.mdl")
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    
    function UnitItemIN08(int pid,int itid)
        if  IsChangeGodStage == false
            KillAttackUnitGroup()
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r"+GetPlayerNameOfColor(pid)+"使用了"+GetObjectName(itid)+"，|cffffff00为大家清除了所有进攻怪！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r"+GetPlayerNameOfColor(pid)+"使用了"+GetObjectName(itid)+"，|cffffff00为大家清除了所有进攻怪！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r"+GetPlayerNameOfColor(pid)+"使用了"+GetObjectName(itid)+"，|cffffff00为大家清除了所有进攻怪！！！|r")
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000已进入最终大决战阶段，无法使用该道具！|r")
        endif
    endfunction

    function UnitItemIN10(unit u1,unit u2)
        int gold = 0
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitTypeId(u2) >= 'g00A' and GetUnitTypeId(u2) <= 'g00F'
            gold = GetTypeIdData(GetUnitTypeId(u2),103)*100
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,gold)
            LocAddText(GetUnitX(u2),GetUnitY(u2),"+"+I2S(gold),255,202,0,255,90,0.023)
            LocAddEffectSetSize(GetUnitX(u2),GetUnitY(u2),"Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl",1.5)
            for i = 0,5
                if  GetItemTypeId(UnitItemInSlot(u1,i)) == 'IN10'
                    RemoveItem(UnitItemInSlot(u1,i))
                    exitwhen true
                endif
            end
            SetUnitState(u2,UNIT_STATE_LIFE,1)
            ShowUnit(u2,false)
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r无法对此单位使用该道具！")
        endif
    endfunction

    function UnitItemIN12(int pid,int itid)
        unit u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np31',-5984,-6656,270)
        PingMinimap(-5984,-6656,8)
        RemoveUnitTimer(u,30)
        
        GetPoolItemId(31)

        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r"+GetPlayerNameOfColor(pid)+"使用了"+GetObjectName(itid)+"，|cffffff00为大家召唤了黑市商店，快回城看看！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r"+GetPlayerNameOfColor(pid)+"使用了"+GetObjectName(itid)+"，|cffffff00为大家召唤了黑市商店，快回城看看！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r"+GetPlayerNameOfColor(pid)+"使用了"+GetObjectName(itid)+"，|cffffff00为大家召唤了黑市商店，快回城看看！！！|r")
        u = null
    endfunction

    function UnitItemIN13(int n,int itid)
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  PlayerDeathBool == false
                    AddUnitStateExTimer(Pu[1],16,30,10)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r"+GetPlayerNameOfColor(n)+"使用了"+GetObjectName(itid)+"，|cffffff00为您在10秒内增加30%法术伤害！|r")
                endif
            endif
        end
    endfunction

    function UnitItemIN14(int pid,int itid)
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r"+GetPlayerNameOfColor(pid)+"使用了"+GetObjectName(itid)+"，|cffffff00主城获得5秒无敌！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r"+GetPlayerNameOfColor(pid)+"使用了"+GetObjectName(itid)+"，|cffffff00主城获得5秒无敌！！！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r"+GetPlayerNameOfColor(pid)+"使用了"+GetObjectName(itid)+"，|cffffff00主城获得5秒无敌！！！|r")
        UnitTimerAddSkill(GameDefendUnit,'AZ08',5)
        UnitTimerAddSkill(GameDefendUnit,'Avul',5)
    endfunction

    function UnitItemIN15(int n,int itid)
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  PlayerDeathBool == false
                    AddUnitStateExTimer(Pu[1],18,20,10)
                    AddUnitStateExTimer(Pu[1],4,20,10)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r"+GetPlayerNameOfColor(n)+"使用了"+GetObjectName(itid)+"，|cffffff00为您在10秒内增加20%伤害抵抗！|r")
                endif
            endif
        end
    endfunction

    function UnitItemIN21(int n,int itid)
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  PlayerDeathBool == false
                    AddUnitStateExTimer(Pu[1],28,30,10)
                    AddUnitStateExTimer(Pu[1],15,50,10)
                    AddUnitStateExTimer(Pu[1],16,50,10)
                    UnitAddAbility(Pu[1],'AZA0')
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r"+GetPlayerNameOfColor(n)+"使用了"+GetObjectName(itid)+"，|cffffff00为您在10秒内增加30%每秒回血和50%双伤害，但结束后生命会变为20%（负面效果）！|r")
                endif
            endif
        end
        TimerStart(10,false)
        {
            for pid = 0,3
                if  GetUnitAbilityLevel(Pu[1],'AZA0') > 0
                    UnitRemoveAbility(Pu[1],'AZA0')
                    if  GetUnitState(Pu[1],UNIT_STATE_LIFE) > GetUnitState(Pu[1],UNIT_STATE_MAX_LIFE)*0.2
                        SetUnitState(Pu[1],UNIT_STATE_LIFE,GetUnitState(Pu[1],UNIT_STATE_MAX_LIFE)*0.2)
                        LocAddEffect(GetUnitX(Pu[1]),GetUnitY(Pu[1]),"effect_by_wood_effect_d2_shadowfiend_shadowraze_1.mdl")
                    endif
                endif
            end
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function PlayerUsesstrangeItem(int pid,int itid)
        int ran = 0
        if  itid == 'IN07'
            UnitItemIN07(pid)
        elseif  itid == 'IN08'
            UnitItemIN08(pid,itid)
        elseif  itid == 'IN09'
            //死亡复活
        elseif  itid == 'IN10' //写在释放技能
        elseif  itid == 'IN11'
            AddUnitStateExTimer(Pu[1],15,100,5)
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r为您在5秒内增加100%物理伤害！")
        elseif  itid == 'IN12'
            UnitItemIN12(pid,itid)
        elseif  itid == 'IN13'
            UnitItemIN13(pid,itid)
        elseif  itid == 'IN14'
            UnitItemIN14(pid,itid) //没有爪子
        elseif  itid == 'IN15'
            UnitItemIN15(pid,itid)
        elseif  itid == 'IN16'
            //境界
        elseif  itid == 'IN17'
            ran = GetRandomInt(5,50)
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,ran)
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜你获得玄铁x"+I2S(ran)+"！")
        elseif  itid == 'IN18'
            AddUnitStateExTimer(Pu[1],41,30,30)
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r为您在30秒内增加30%金币加成！")
        //没有 'IN19'
        elseif  itid == 'IN20'
            AddUnitStateExTimer(Pu[1],46,10,30)
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r为您在30秒内增加10点杀敌金币！")
        elseif  itid == 'IN21'
            UnitItemIN21(pid,itid)
        elseif  itid == 'IN22'

        elseif  itid == 'IN23'

        elseif  itid == 'IN24'

        endif
    endfunction

    ///////////////////////////////拾取函数///////////////////////////////////////////

    function PickUpItemOfIP07Func()
        int num = UnitHasItemOfTypeReNum(PickUpItemUnit,'IP07')
        if  GetItemTypeId(GetEnumItem()) == 'IP07'
            RemoveItem(GetEnumItem())
            SetItemCharges(UnitItemInSlot(PickUpItemUnit,num),GetItemCharges(UnitItemInSlot(PickUpItemUnit,num))+1)
        endif
    endfunction

    function PickUpItemOfIP07(unit u,real x,real y)
        rect rc = Rect( x - 550, y - 550, x + 550, y + 550 )
        PickUpItemUnit = u
        LocAddEffectSetSize(x,y,"effect_az_goods_tp_target(3).mdx",1)
        EnumItemsInRect(rc, null, function PickUpItemOfIP07Func)
        RemoveRect(rc)
        PickUpItemUnit = null
        rc = null
    endfunction

    function PickUpItemOfIN30Func()
        int num = UnitHasItemOfTypeReNum(PickUpItemUnit,'IN30')
        if  GetItemTypeId(GetEnumItem()) == 'IN30'
            RemoveItem(GetEnumItem())
            SetItemCharges(UnitItemInSlot(PickUpItemUnit,num),GetItemCharges(UnitItemInSlot(PickUpItemUnit,num))+1)
        endif
    endfunction

    function PickUpItemOfIN30(unit u,real x,real y)
        rect rc = Rect( x - 550, y - 550, x + 550, y + 550 )
        PickUpItemUnit = u
        LocAddEffectSetSize(x,y,"effect_az_goods_tp_target(3).mdx",1)
        EnumItemsInRect(rc, null, function PickUpItemOfIN30Func)
        RemoveRect(rc)
        PickUpItemUnit = null
        rc = null
    endfunction




endlibrary
