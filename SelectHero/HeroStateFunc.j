library HeroStateFunc uses DamageCode


    function InitPlayerDzShopState(int pid)
        int lv = DzPlayerLv(Player(pid))
        int shopnum = 0
        /////////////////////额外给予////////////////////////

        if  DzAPI_Map_IsBlueVIP(Player(pid)) == true
            BJDebugMsg("DzAPI_Map_IsBlueVIP")
            if  GetPlayerTechCount(Player(pid),'RK1A',true) == 0 //小狐妖
                AddPlayerTechResearched(Player(pid),'RK1A',1)
            endif
        endif

        /*
        if  DzAPI_Map_GetGuildName(Player(pid)) == "星辰俱乐部" 
            BJDebugMsg("DzAPI_Map_GetGuildName")
            if  GetPlayerTechCount(Player(pid),'RK1A',true) == 0 //小狐妖
                AddPlayerTechResearched(Player(pid),'RK1A',1)
            endif
            if  GetPlayerTechCount(Player(pid),'RY2D',true) == 0 //幻莲仙翼
                AddPlayerTechResearched(Player(pid),'RY2D',1)
            endif 
        endif
        
        if  IsPlayerIn_MZRPG_Admin(pid) == true
            BJDebugMsg("IsPlayerIn_MZRPG_Admin")
            if  GetPlayerTechCount(Player(pid),'RY1D',true) == 0 //星月光环
                AddPlayerTechResearched(Player(pid),'RY1D',1)
            endif
            if  GetPlayerTechCount(Player(pid),'RY2D',true) == 0 //幻莲仙翼
                AddPlayerTechResearched(Player(pid),'RY2D',1)
            endif 
            if  GetPlayerTechCount(Player(pid),'RY3D',true) == 0 //戮仙剑
                AddPlayerTechResearched(Player(pid),'RY3D',1)
            endif
            if  GetPlayerTechCount(Player(pid),'RY4D',true) == 0 //金鼠送福
                AddPlayerTechResearched(Player(pid),'RY4D',1)
            endif 
            if  GetPlayerTechCount(Player(pid),'RK1A',true) == 0 //小狐妖
                AddPlayerTechResearched(Player(pid),'RK1A',1)
            endif
            if  GetPlayerTechCount(Player(pid),'RJ1U',true) == 0 //封神礼包
                AddPlayerTechResearched(Player(pid),'RJ1U',1)
            endif 
            if  GetPlayerTechCount(Player(pid),'RJ1V',true) == 0 //金币礼包
                AddPlayerTechResearched(Player(pid),'RJ1V',1)
            endif 
            if  GetPlayerTechCount(Player(pid),'RJ1W',true) == 0 //木材礼包
                AddPlayerTechResearched(Player(pid),'RJ1W',1)
            endif 
        endif
        */
        /////////////////////等级赠送////////////////////////

        if  lv >= 18 //幻莲仙翼
            AddPlayerTechResearched(Player(pid),'RY2D',1)
        endif

        /*
        if  lv >= 24 //金鼠送福
            AddPlayerTechResearched(Player(pid),'RY4D',1)
        endif

        if  lv >= 32 //金鼠送福
            AddPlayerTechResearched(Player(pid),'RY3D',1)
        endif

        */
        /////////////////////载入属性////////////////////////



        if  GetPlayerTechCount(Player(pid),'RY1D',true) == 1 //星月光环
            shopnum = shopnum + 1
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,2000)
            AddUnitRealState(Pu[1],47,10)

            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：商城道具《|cff00ff00星月光环|r》已激活！")
        endif
        if  GetPlayerTechCount(Player(pid),'RY2D',true) == 1 //幻莲仙翼
            shopnum = shopnum + 1
            UnitAddItemEx(Pu[1],'CS01')
            
            
            if  lv >= 18 and DzShop(Player(pid),"CB1") == true
                //别忘了改我!!!
                AddUnitRealState(Pu[1],49,450)
                AddUnitRealState(Pu[1],18,18)
                AddUnitRealState(Pu[1],9,45)
            else
                AddUnitRealState(Pu[1],49,300)
                AddUnitRealState(Pu[1],18,12)
                AddUnitRealState(Pu[1],9,30)
            endif
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：商城道具《|cff00ff00幻莲羽翼|r》已激活！")
        endif 
        if  GetPlayerTechCount(Player(pid),'RY3D',true) == 1 //戮仙剑
            shopnum = shopnum + 1
            UnitAddItemEx(Pu[1],'CS02')
            AddUnitRealState(Pu[1],20,50)
            AddUnitRealState(Pu[1],19,10)
            AddUnitRealState(Pu[1],17,30)

            /*
            if  lv >= 32 and DzShop(Player(pid),"WQ1") == true
                AddUnitRealState(Pu[1],20,25)
                AddUnitRealState(Pu[1],19,5)
                AddUnitRealState(Pu[1],17,15)
            endif
            */
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：商城道具《|cff00ff00戮仙剑|r》已激活！")
        endif
        if  GetPlayerTechCount(Player(pid),'RY4D',true) == 1 //金鼠送福
            shopnum = shopnum + 1

            UnitAddItemEx(Pu[2],'I015')
            AddUnitRealState(Pu[1],64,10)
            AddUnitRealState(Pu[1],17,20)
            AddUnitRealState(Pu[1],52,20000)
            /*
            if  lv >= 24 and DzShop(Player(pid),"CH1") == true
                AddUnitRealState(Pu[1],64,5)
                AddUnitRealState(Pu[1],17,10)
                AddUnitRealState(Pu[1],52,10000)
            endif
            */
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：商城道具《|cff00ff00金鼠送福|r》已激活！")
        endif 
        if  GetPlayerTechCount(Player(pid),'RK1A',true) == 1 //小狐妖
            shopnum = shopnum + 1

            UnitAddItemEx(Pu[1],'IP01')
            AddUnitRealState(Pu[1],33,20)
            AddUnitRealState(Pu[1],48,20)
            CreatePet.execute(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：商城道具《|cff00ff00小狐妖|r》已激活！")
        endif
        if  GetPlayerTechCount(Player(pid),'RJ1U',true) == 1 //封神礼包
            shopnum = shopnum + 1

            AddUnitRealState(Pu[1],48,10)
            AddUnitRealState(Pu[1],64,10)
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,10)

            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：商城道具《|cff00ff00小狐妖|r》已激活！")
        endif 
        if  GetPlayerTechCount(Player(pid),'RJ1V',true) == 1 //金币礼包
            shopnum = shopnum + 1

            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,2000)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：商城道具《|cff00ff00金币礼包|r》已激活！")
        endif 
        if  GetPlayerTechCount(Player(pid),'RJ1W',true) == 1 //木材礼包
            shopnum = shopnum + 1

            AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,5)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：商城道具《|cff00ff00木材礼包|r》已激活！")
        endif 


        if  shopnum > 0
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：|cff00ff00商城道具已激活！存档F5-商城分页中查看!|r")
        endif

    endfunction





endlibrary


