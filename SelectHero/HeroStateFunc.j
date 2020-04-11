library HeroStateFunc uses DamageCode,MagicItemCollectCode

    function GetPlayerBuyShopNumber(int pid)->int
        int num = 0
        if  DzShop(Player(pid),"GH1") == true
            num = num + 1
        endif
        if  DzShop(Player(pid),"CB1") == true
            num = num + 1
        endif
        if  DzShop(Player(pid),"WQ1") == true
            num = num + 1
        endif
        if  DzShop(Player(pid),"CH1") == true
            num = num + 1
        endif
        if  DzShop(Player(pid),"CW1") == true
            num = num + 1
        endif
        if  DzShop(Player(pid),"LB1") == true
            num = num + 1
        endif
        if  DzShop(Player(pid),"LB2") == true
            num = num + 1
        endif
        if  DzShop(Player(pid),"LB3") == true
            num = num + 1
        endif
        if  DzShop(Player(pid),"RWK") == true
            num = num + 1
        endif

        //新增
        if  DzShop(Player(pid),"LB4") == true
            num = num + 1
        endif
        if  DzShop(Player(pid),"CB2") == true
            num = num + 1
        endif

        return num
    endfunction


    function InitPlayerDzShopState(int pid)
        int lv = DzPlayerLv(Player(pid))
        int shopnum = 0
        int buynum = GetPlayerBuyShopNumber(pid)
        /////////////////////额外给予////////////////////////

        if  DzAPI_Map_IsBlueVIP(Player(pid)) == true
            BJDebugMsg("DzAPI_Map_IsBlueVIP")
            if  GetPlayerTechCount(Player(pid),'RK1A',true) == 0 //小狐妖
                AddPlayerTechResearched(Player(pid),'RK1A',1)
                buynum = buynum + 1
            endif
        endif

        
        if  DzAPI_Map_GetGuildName(Player(pid)) == "星辰俱乐部"
            BJDebugMsg("DzAPI_Map_GetGuildName")
            if  GetPlayerTechCount(Player(pid),'RY4D',true) == 0 //金鼠送福
                AddPlayerTechResearched(Player(pid),'RY4D',1)
                buynum = buynum + 1
            endif
            if  GetPlayerTechCount(Player(pid),'RK1A',true) == 0 //小狐妖
                AddPlayerTechResearched(Player(pid),'RK1A',1)
                buynum = buynum + 1
            endif
            if  GetPlayerTechCount(Player(pid),'RY2D',true) == 0 //幻莲仙翼
                AddPlayerTechResearched(Player(pid),'RY2D',1)
                buynum = buynum + 1
            endif
            if  GetPlayerTechCount(Player(pid),'RJ1X',true) == 0 //赞助礼包
                AddPlayerTechResearched(Player(pid),'RJ1X',1)
                buynum = buynum + 1
            endif
            
        endif

        /////////////////////等级赠送////////////////////////

        if  lv >= 18 //幻莲仙翼
            AddPlayerTechResearched(Player(pid),'RY2D',1)
        endif
        if  lv >= 22 //鼠年大吉
            AddPlayerTechResearched(Player(pid),'RY4D',1)
        endif
        if  lv >= 26 //戮仙剑
            AddPlayerTechResearched(Player(pid),'RY3D',1)
        endif


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
            

            
            if  lv >= 26 and DzShop(Player(pid),"WQ1") == true
                AddUnitRealState(Pu[1],20,75)
                AddUnitRealState(Pu[1],19,15)
                AddUnitRealState(Pu[1],17,45)
            else
                AddUnitRealState(Pu[1],20,50)
                AddUnitRealState(Pu[1],19,10)
                AddUnitRealState(Pu[1],17,30)
            endif
            
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：商城道具《|cff00ff00戮仙剑|r》已激活！")
        endif
        if  GetPlayerTechCount(Player(pid),'RY4D',true) == 1 //金鼠送福
            shopnum = shopnum + 1

            UnitAddItemEx(Pu[2],'I015')
            
            
            if  lv >= 22 and DzShop(Player(pid),"CH1") == true
                AddUnitRealState(Pu[1],64,15)
                AddUnitRealState(Pu[1],17,30)
                AddUnitRealState(Pu[1],52,30000)
                UnitAddItemEx(Pu[2],'I015')
            else
                AddUnitRealState(Pu[1],64,10)
                AddUnitRealState(Pu[1],17,20)
                AddUnitRealState(Pu[1],52,20000)
            endif
            
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
        

        if  GetPlayerTechCount(Player(pid),'RJ1X',true) == 1 //赞助礼包
            shopnum = shopnum + 1
            AddUnitRealState(Pu[1],17,10)
            AddUnitRealState(Pu[1],47,20)
            AddUnitRealState(Pu[1],49,100)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：商城道具《|cff00ff00赞助礼包|r》已激活！")
        endif 

        if  GetPlayerTechCount(Player(pid),'RY2G',true) == 1 //幽冥之翼
            shopnum = shopnum + 1
            AddUnitRealState(Pu[1],15,20)
            AddUnitRealState(Pu[1],16,20)
            AddUnitRealState(Pu[1],31,20)
            UnitAddItemEx(Pu[2],'ID14')
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：商城道具《|cff00ff00幽冥之翼|r》已激活！")
        endif




        //商城套装
        if  buynum >= 3
            AddPlayerTechResearched(Player(pid),'RSHA',1)
            AddUnitRealState(Pu[1],18,1)
            AddUnitRealState(Pu[1],49,100)
            UnitAddItemEx(Pu[2],'CS03')
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：商城成就《|cff00ff003件套|r》已激活！")
        endif
        if  buynum >= 4
            AddPlayerTechResearched(Player(pid),'RSHD',1)
            AddUnitRealState(Pu[1],18,1)
            AddUnitRealState(Pu[1],48,6)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：商城成就《|cff00ff004件套|r》已激活！")

            
           

        endif
        if  buynum >= 5
            AddPlayerTechResearched(Player(pid),'RSHB',1)
            AddUnitRealState(Pu[1],18,2)
            AddUnitRealState(Pu[1],49,200)
            UnitAddItemEx(Pu[2],'CS21')
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：商城成就《|cff00ff005件套|r》已激活！")
        endif
        if  buynum >= 8
            AddPlayerTechResearched(Player(pid),'RSHC',1)
            AddUnitRealState(Pu[1],18,3)
            AddUnitRealState(Pu[1],49,300)
            SetPlayerMagicItemResources(pid,1,GetPlayerMagicItemResources(pid,1)+2)
            ReCollectFrameResources(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：商城成就《|cff00ff008件套|r》已激活！")
        endif
        if  buynum >= 11
            AddPlayerTechResearched(Player(pid),'RSHE',1)
            AddUnitRealState(Pu[1],18,3)
            AddUnitRealState(Pu[1],48,30)
            UnitAddItemEx(Pu[2],'CS21')
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：商城成就《|cff00ff0011件套|r》已激活！")
        endif

        

        if  shopnum > 0
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：|cff00ff00商城道具已激活！存档F5-商城分页中查看!|r")
        endif



        //加载存档的物品道具
        if  GetPlayerTechCount(Player(pid),'RY4I',true) == 1 //剑血浮生
            bj_lastCreatedItem = CreateItem('IN30',GetUnitX(Pu[2]),GetUnitY(Pu[2]))
            SetItemCharges(bj_lastCreatedItem,2)
            UnitAddItem(Pu[2],bj_lastCreatedItem)
            bj_lastCreatedItem = null
        endif

        if  GetPlayerTechCount(Player(pid),'RG0C',true) > 0//通关难3
            UnitAddItem(Pu[2],CreateItem('IN34',GetUnitX(Pu[2]),GetUnitY(Pu[2])))
            UnitAddItem(Pu[2],CreateItem('IN37',GetUnitX(Pu[2]),GetUnitY(Pu[2])))
        endif

        if  GetPlayerTechCount(Player(pid),'RG0D',true) > 0//通关难4
            UnitAddItem(Pu[2],CreateItem('I013',GetUnitX(Pu[2]),GetUnitY(Pu[2])))
        endif

        if  GetPlayerTechCount(Player(pid),'RG0E',true) > 0//通关难5
            UnitAddItem(Pu[2],CreateItem('CS21',GetUnitX(Pu[2]),GetUnitY(Pu[2])))
        endif

        if  GetPlayerTechCount(Player(pid),'RG0G',true) > 0//通关难7
            UnitAddItem(Pu[2],CreateItem('IN40',GetUnitX(Pu[2]),GetUnitY(Pu[2])))
        endif

        



        if  GetPlayerTechCount(Player(pid),'RY4E',true) > 0
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,500)
        endif




    endfunction





endlibrary


