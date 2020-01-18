library ItemGameFunc uses DamageCode

    int array ItemGameFuncArrayInt[12][680]

    bool array ItemGameFuncArrayBool[12][680]

    #define ItemGameFuncInt         ItemGameFuncArrayInt[pid]

    #define ItemGameFuncBool        ItemGameFuncArrayBool[pid]
    #define GameGiftBool            ItemGameFuncArrayBool[pid]

    function IsPlayerGuildVIP(int pid)->bool
        /*
        AddUnitRealState(Pu[1],46,3)
        AddUnitRealState(Pu[1],43,1)
        AddUnitRealState(Pu[1],48,1)
        */
        return false
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
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,2000)
                        AddUnitRealState(Pu[1],47,2)
                        AddUnitRealState(Pu[1],48,1)
                        DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[系统]：|r成功领取|cffffcc00【"+gift+"礼包】|r，金币+2000、每秒攻击+2、每秒业力+1！") 
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r您已领取过该礼包！")
                    endif
                else
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,2000)
                    AddUnitRealState(Pu[1],47,2)
                    AddUnitRealState(Pu[1],48,1)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r自动为您领取|cffffcc00【"+gift+"礼包】|r！")
                endif
            elseif  gift == "入群"
                num = 2
                if  GetDzPlayerData(pid,1,22) == 0
                    if  GameGiftBool[num] == false
                        GameGiftBool[num] = true
                        SaveDzPlayerData(pid,1,22,1)
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,2000)
                        AddUnitRealState(Pu[1],47,2)
                        AddUnitRealState(Pu[1],48,1)
                        DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[系统]：|r成功领取|cffffcc00【"+gift+"礼包】|r，金币+2000、每秒攻击+2、每秒业力+1！") 
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r您已领取过该礼包！")
                    endif
                else
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,2000)
                    AddUnitRealState(Pu[1],47,2)
                    AddUnitRealState(Pu[1],48,1)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r自动为您领取|cffffcc00【"+gift+"礼包】|r！")
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
                        UnitAddItemEx(Pu[1],'I012')
                        DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[系统]：|r成功领取|cffffcc00【"+gift+"礼包】|r，获得"+GetObjectName('I012')+"！") 
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r您已领取过该礼包！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r领取|cffffcc00【"+gift+"礼包】|r失败！")
                endif
            elseif  gift == "公会"
                num = 6
                if  IsPlayerGuildVIP(pid) == true
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
                if  GetPublicMapLevel(pid) > 0
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
        for num = 1,8
            RemoveItemFromStock(Pu[26],'IB00'+num)
            RemoveItemFromStock(Pu[26],'IB50'+num)
            if  GameGiftBool[num] == false
                AddItemToStock(Pu[26],'IB00'+num,1,1)
            else
                AddItemToStock(Pu[26],'IB50'+num,1,1)
            endif
        end
    endfunction

    function PlayerGetGameGift(int pid,int itid)
        if  itid == 'IB01' //公众号 口令
        elseif  itid == 'IB02' //公众号 入群
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
        elseif  itid == 'IB09'
            ItemGameGift(pid,"老铁")
        endif
    endfunction

    function InitPlayerGameGift(int pid)
        if  GetDzPlayerData(pid,1,21) == 1
            ItemGameGift(pid,"公众号") //自动领取
        endif
        if  GetDzPlayerData(pid,1,22) == 1
            ItemGameGift(pid,"入群") //自动领取
        endif
        ItemGameGift(pid,"公会") //自动领取
        ItemGameGift(pid,"星耀") //自动领取
    endfunction
    
endlibrary
