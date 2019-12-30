
    scope GiftandPrize
        //礼包领取
        
        function IsCanReceivePackage(int pid,int id)->bool
            if  PlayerInt[pid][200+id] != 1
                return true
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r这个礼包你已经领过啦！")
                return false
            endif
        endfunction
        
        function IsPlayerChatCode(int pid,int id)->bool
            return PlayerInt[pid][200+id] == 2
        endfunction
        
        
        function IsCanPackageActivation(int pid,int id)->bool
            if  IsCanReceivePackage(pid,id) == true
                PlayerInt[pid][200+id] = 1
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r礼包领取成功！")
                return true
            else
                return false
            endif
        endfunction
        
        
        function IsLevelCanActivation(int pid,int lv)->boolean
            if  DzPlayerLv(Player(pid)) >= lv
                return true
            endif
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r当前等级不足"+I2S(lv)+"无法领取！")
            return false
        endfunction
        
        function AddUnitLBState(unit wu,int index,real value)
            AddUnitRealState(wu,index,value)
            DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]:|r奖励"+StateName[index]+"+"+R2S(value)+StateName[index+200])
        endfunction
        
        
        function PackageActivation(int pid,unit u1,int id)
            int value = 0
            int i1 = 0
            if  id >= 1 and id <= 10
                if  id == 1
                    if  IsCanReceivePackage(pid,id) == true//单独判断
                        if  IsPlayerChatCode(pid,id) == true
                            if  IsCanPackageActivation(pid,id) == true//设置判断
                                AddUnitRealState(Pu[1],15,10)
                                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r魔芝rpg礼包领取成功！奖励 物理伤害+10%")
                            endif
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r游戏内输入《魔芝rpg》自动领取该礼包！")

                        endif
                    endif
                elseif  id == 2
                    if  DzPlayerLv(Player(pid)) >= 3
                        i1 = DzAPI_Map_CommentCount(Player(pid))
                        if  i1 > 0
                            if  IsCanPackageActivation(pid,id) == true//设置判断
                                AdjustPlayerStateBJ(20, Player(pid), PLAYER_STATE_RESOURCE_LUMBER)
                                AddUnitRealState(Pu[1],1,1000)
                                AddUnitRealState(Pu[1],31,i1)
                                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]:|r玩家"+GetPN(pid)+"好评礼包领取成功！奖励 木材+20 全属性+1000 杀敌属性+"+I2S(i1)+"|cffadff2f(评论次数"+I2S(i1)+")|r")
                            endif
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r请达到地图3级后，给与五星好评后领取。|cff00ff00评论次数越多|r，奖励越丰厚！！")
                    endif
                elseif  id == 3
                    if  IsCanReceivePackage(pid,id) == true//单独判断
                        if  IsPlayerChatCode(pid,id) == true
                            if  IsCanPackageActivation(pid,id) == true//设置判断
                                i1 = DzAPI_Map_CommentCount(Player(pid))
                                AdjustPlayerStateBJ(100000, Player(pid), PLAYER_STATE_RESOURCE_GOLD)
                                AddUnitRealState(Pu[1],71,1)
                                AddUnitRealState(Pu[1],15,10)
                                AddUnitRealState(Pu[1],31,i1)
                                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]:|r玩家"+GetPN(pid)+"入群礼包领取成功！奖励 练功房怪数量+1 金币+100000 物理伤害+10% 杀敌属性+"+I2S(i1)+"|cffadff2f(评论次数"+I2S(i1)+")|r")
                                
                            endif
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r加入QQ群 "+QQNumber+" 查看礼包密码！")
                        endif
                    endif
                elseif  id == 4
                    if  IsCanReceivePackage(pid,id) == true//单独判断
                        if  IsPlayerChatCode(pid,id)==true
                            if  IsCanPackageActivation(pid,id) == true//设置判断
                                i1 = DzAPI_Map_CommentCount(Player(pid))
                                AdjustPlayerStateBJ(100, Player(pid), PLAYER_STATE_RESOURCE_LUMBER)
                                AddUnitRealState(Pu[1],1,i1*300)
                                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]:|r玩家"+GetPN(pid)+"入群礼包领取成功！奖励 木材+100 全属性+"+I2S(i1*300)+"|cffadff2f(评论次数"+I2S(i1)+")|r")
                            endif
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r关注公众号魔芝rpg回复《封神榜》查看密码！")
   
                        endif
                    endif
                elseif  id == 5
                    if  IsCanPackageActivation(pid,id)==true
                        /*i1 = 'E501'
                        if  MapLevelList[1]>=5 
                            UnitAddItem(Pu[1],CreateItem(i1,GetUnitX(Pu[1]),GetUnitY(Pu[1])))
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r第一阶段老铁领取成功！奖励道具 "+GetObjectName(i1)+"x1")
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r第一阶段老铁礼包领取失败！地图暂未达到5级。")
                        endif
                        if  MapLevelList[2]>=5
                            UnitAddItem(Pu[1],CreateItem(i1,GetUnitX(Pu[1]),GetUnitY(Pu[1])))
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r侠义天龙老铁领取成功！奖励道具 "+GetObjectName(i1)+"x1")
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r侠义天龙老铁礼包领取失败！地图暂未达到5级。")
                        endif
                        if  MapLevelList[3]>=5
                            UnitAddItem(Pu[1],CreateItem(i1,GetUnitX(Pu[1]),GetUnitY(Pu[1])))
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r异世乾坤老铁领取成功！奖励道具 "+GetObjectName(i1)+"x1")
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r异世乾坤老铁礼包领取失败！地图暂未达到5级。")
                        endif
                        if  MapLevelList[4]>=5
                            UnitAddItem(Pu[1],CreateItem(i1,GetUnitX(Pu[1]),GetUnitY(Pu[1])))
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r神庙老铁领取成功！奖励道具 "+GetObjectName(i1)+"x1")
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r神庙老铁礼包领取失败！地图暂未达到5级。")
                        endif
                        if  MapLevelList[5]>=5
                            UnitAddItem(Pu[1],CreateItem(i1,GetUnitX(Pu[1]),GetUnitY(Pu[1])))
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r九幽老铁领取成功！奖励道具 "+GetObjectName(i1)+"x1")
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r九幽老铁礼包领取失败！地图暂未达到5级。")
                        endif
                        if  MapLevelList[6]>=5
                            UnitAddItem(Pu[1],CreateItem(i1,GetUnitX(Pu[1]),GetUnitY(Pu[1])))
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r百变小英雄老铁领取成功！奖励道具 "+GetObjectName(i1)+"x1")
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r百变小英雄老铁礼包领取失败！地图暂未达到5级。")
                        endif
                        if  MapLevelList[7]>=5
                            UnitAddItem(Pu[1],CreateItem(i1,GetUnitX(Pu[1]),GetUnitY(Pu[1])))
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r魔圈TD老铁领取成功！奖励道具 "+GetObjectName(i1)+"x1")
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r魔圈TD老铁礼包领取失败！地图暂未达到5级。")
                        endif
                        if  MapLevelList[8]>=5
                            UnitAddItem(Pu[1],CreateItem(i1,GetUnitX(Pu[1]),GetUnitY(Pu[1])))
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r童话镇老铁领取成功！奖励道具 "+GetObjectName(i1)+"x1")
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r童话镇老铁礼包领取失败！地图暂未达到5级。")
                        endif*/
                    endif
                elseif  id == 6
                    if  DzAPI_Map_GetGuildName(Player(pid)) == "墨汁联盟①萌" or DzAPI_Map_GetGuildName(Player(pid)) == "墨汁联盟②萌" or DzAPI_Map_GetGuildName(Player(pid)) == "墨汁联盟③萌" or DzAPI_Map_GetGuildName(Player(pid)) == "墨汁联盟④萌" or DzAPI_Map_GetGuildName(Player(pid)) == "墨汁联盟⑤萌" or DzAPI_Map_GetGuildName(Player(pid)) == "星辰俱乐部" or DzAPI_Map_GetGuildName(Player(pid)) == "星耀俱乐部"
                        if  IsCanPackageActivation(pid,id) == true
                            AddUnitRealState(Pu[1],41,3)
                            AddUnitRealState(Pu[1],50,3)
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r工会礼包领取成功！奖励 每秒属性+3 每秒真气+3")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r你不是墨汁联盟工会或星耀俱乐部成员！")
                    endif
                
                endif
            elseif  id >= 11 and id <= 19
                if  id == 11
                    if  DzPlayerLv(Player(pid)) >= 2
                        if  IsCanPackageActivation(pid,id) == true//设置判断
                            AdjustPlayerStateBJ(10, Player(pid), PLAYER_STATE_RESOURCE_LUMBER)
                            AddUnitRealState(Pu[1],16,2)
                            AddUnitRealState(Pu[1],31,3)
                            AddUnitRealState(Pu[1],41,5)
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r等级2级礼包领取成功！奖励 木材+10 物理抵抗+2% 杀敌属性+3 每秒属性+5")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r等级不足2，无法领取该礼包！")
                    endif
                elseif  id == 12
                    if  DzPlayerLv(Player(pid)) >= 4
                        if  IsCanPackageActivation(pid,id) == true//设置判断
                            AdjustPlayerStateBJ(20, Player(pid), PLAYER_STATE_RESOURCE_LUMBER)
                            AddUnitRealState(Pu[1],15,5)
                            AddUnitRealState(Pu[1],31,5)
                            AddUnitRealState(Pu[1],41,8)
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r等级4级礼包领取成功！奖励 木材+20 物理伤害+5% 杀敌属性+5 每秒属性+8")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r等级不足4，无法领取该礼包！")
                    endif
                elseif  id == 13
                    if  DzPlayerLv(Player(pid)) >= 6
                        if  IsCanPackageActivation(pid,id) == true//设置判断
                            AdjustPlayerStateBJ(50, Player(pid), PLAYER_STATE_RESOURCE_LUMBER)
                            AddUnitRealState(Pu[1],15,5)
                            AddUnitRealState(Pu[1],31,8)
                            AddUnitRealState(Pu[1],41,10)
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r等级6级礼包领取成功！奖励 木材+50 物理伤害+5% 杀敌属性+8 每秒属性+10")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r等级不足6，无法领取该礼包！")
                    endif
                elseif  id == 14
                    if  DzPlayerLv(Player(pid)) >= 8
                        if  IsCanPackageActivation(pid,id) == true//设置判断
                            AdjustPlayerStateBJ(100, Player(pid), PLAYER_STATE_RESOURCE_LUMBER)
                            AddUnitRealState(Pu[1],15,10)
                            AddUnitRealState(Pu[1],31,10)
                            AddUnitRealState(Pu[1],41,15)
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r等级8级礼包领取成功！奖励 木材+100 物理伤害+10% 杀敌属性+10 每秒属性+15")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r等级不足8，无法领取该礼包！")
                    endif
                elseif  id == 15
                    if  DzPlayerLv(Player(pid)) >= 10
                        if  IsCanPackageActivation(pid,id) == true//设置判断
                            AdjustPlayerStateBJ(200, Player(pid), PLAYER_STATE_RESOURCE_LUMBER)
                            AddUnitRealState(Pu[1],15,10)
                            AddUnitRealState(Pu[1],31,10)
                            AddUnitRealState(Pu[1],41,15)
                            AddUnitRealState(Pu[1],48,5)
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r等级10级礼包领取成功！奖励 木材+200 物理伤害+10% 杀敌属性+10 每秒属性+15 杀敌真气+5")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r等级不足10，无法领取该礼包！")
                    endif
                endif
            elseif  id >= 51 and id <= 59
                if  id == 51
                    if  GetData(pid,3,1)>= 1
                        if  IsCanPackageActivation(pid,id) == true//设置判断
                            AddUnitRealState(Pu[1],15,10)
                            AddUnitRealState(Pu[1],31,2)
                            AddUnitRealState(Pu[1],50,10)
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r通关N1礼包领取成功！奖励 物理伤害+10% 杀敌属性+2 每秒真气+10")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r未通关N1，无法领取该礼包！")
                    endif
                elseif  id == 52
                    if  GetData(pid,3,3)>= 1
                        if  IsCanPackageActivation(pid,id) == true//设置判断
                            AddUnitRealState(Pu[1],15,30)
                            AddUnitRealState(Pu[1],31,5)
                            AddUnitRealState(Pu[1],50,20)
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r通关N3礼包领取成功！奖励 物理伤害+30% 杀敌属性+5 每秒真气+20")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r未通关N3，无法领取该礼包！")
                    endif
                elseif  id == 53
                    if  GetData(pid,3,1)>= 1
                        if  IsCanPackageActivation(pid,id) == true//设置判断
                            AddUnitRealState(Pu[1],15,50)
                            AddUnitRealState(Pu[1],31,10)
                            AddUnitRealState(Pu[1],50,30)
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r通关N1礼包领取成功！奖励 物理伤害+50% 杀敌属性+10 每秒真气+30")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]:|r未通关N1，无法领取该礼包！")
                    endif
                endif
            endif
        endfunction
        function PlayerChatCode(int pid,int id)
            if  IsCanReceivePackage(pid,id)==true
                PlayerInt[pid][200+id] = 2
                PackageActivation(pid,Pu[1],id)
            endif
        endfunction
        
        //抽奖显示
        function GetPickUpPrizeValue(int pid,string name,string b,int colorvalue,int min,int max)->int
            //玩家序号，奖励名称，最大值（决定提示颜色），随机最小，随机最大
            int value = GetRandomInt(min,max)
            real ratio = I2R(value) / (colorvalue)
            if  ratio < 0.2
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]|r:玩家"+GetPN(pid)+"通过抽奖获得|cffadff2f"+name+I2S(value)+b)
            elseif  ratio < 0.4
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]|r:玩家"+GetPN(pid)+"通过抽奖获得|cff99ccff"+name+I2S(value)+b)
            elseif  ratio < 1.0
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]|r:玩家"+GetPN(pid)+"通过抽奖获得|cffcc99ff"+name+I2S(value)+b)
            elseif  ratio < 1.5
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]|r:玩家"+GetPN(pid)+"通过抽奖获得|CFFFF8000"+name+I2S(value)+b)
            else
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]|r:玩家"+GetPN(pid)+"通过抽奖获得|cffff0000"+name+I2S(value)+b)
            endif
            
            UnitAddText(Pu[1],name+"+"+I2S(value),GetRandomInt(0,255),GetRandomInt(0,255),GetRandomInt(0,255),GetRandomInt(0,255),GetRandomInt(0,180),0.03)
            return value
        endfunction
        function PickUpPrizeItem(int pid,int itemid) //获得抽奖的道具
            int n = 0
            int t = 0
            int index = 0
            if  itemid >= 'I101' and itemid <= 'I104'
                if  itemid == 'I101'
                    n = GetPickUpPrizeValue(pid,"木材","",5000,1,100)
                elseif  itemid == 'I102'
                    n = GetPickUpPrizeValue(pid,"木材","",5000,50,600)
                elseif  itemid == 'I103'
                    n = GetPickUpPrizeValue(pid,"木材","",5000,200,1500)
                elseif  itemid == 'I104'
                    n = GetPickUpPrizeValue(pid,"木材","",5000,500,8000)
                endif
                AdjustPlayerStateBJ(n,Player(pid),PLAYER_STATE_RESOURCE_LUMBER )
            elseif  itemid == 'I108'
                n = GetPickUpPrizeValue(pid,"金币","",200000,1000,200000)
                AdjustPlayerStateBJ(n,Player(pid),PLAYER_STATE_RESOURCE_GOLD )

                
            elseif  itemid >= 'I143' and itemid <= 'I145'
                index = 101
                if  itemid == 'I143'
                    n = GetPickUpPrizeValue(pid,StateName[index],StateName[index+200],800,1,100)
                elseif  itemid == 'I144'
                    n = GetPickUpPrizeValue(pid,StateName[index],StateName[index+200],800,10,500)
                elseif  itemid == 'I145'
                    n = GetPickUpPrizeValue(pid,StateName[index],StateName[index+200],800,20,1000)
                endif
                AddUnitIntState(Pu[1],index,n)
            else
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]|r:"+GetPN(pid)+"通过抽奖获得了我没做的东西哈哈哈哈"+GetObjectName(itemid))
            endif
            
            
        endfunction
        
        
        
        /*
        function LuckDraw(unit u1,int prizeid,int ran,int num)
            int pid = GetPlayerId(GetOwningPlayer(u1))
            for n = 1,num
                if  GetRandomInt(1,100)<=ran
                    bj_lastCreatedItem = GetPrizeEx(prizeid,GetUnitX(u1),GetUnitY(u1))
                    if  GetItemType(bj_lastCreatedItem) != ITEM_TYPE_POWERUP
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]|r:"+GetPN(pid)+"通过抽奖获得了"+GetItemName(bj_lastCreatedItem))
                    endif
                    UnitAddItem(u1,bj_lastCreatedItem)
                    bj_lastCreatedItem = null
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r运气不好，什么都没得到。")
                endif
            end
        endfunction*/
        
        function LuckDrawFunc(unit u1,int itemid)
            int pid = GetPlayerId(GetOwningPlayer(u1))
 
        endfunction
        
        //杀敌数兑换
        function KillNumConvert(int pid,int itemid)
            int use = 0
            if  itemid >= 'I071' and itemid <= 'I074'
                use = 600
            endif
            if  GetUnitIntState(Pu[1],101) >= use
                AddUnitIntState(Pu[1],101,-use)
                PickUpPrizeItem(pid,itemid)
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r您的杀敌数不足"+I2S(use)+",当前为："+I2S(GetUnitIntState(Pu[1],101)))
            endif
            
        endfunction
        
    endscope

