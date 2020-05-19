

scope ItemSystem initializer InitItemSystem
    function UnitAddPoolItemShow(unit wu,int prizeid)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int id = UnitAddPoolItem(wu,prizeid)
        if  id >= 'IC00' and id <= 'IC99'
            //不显示
        else
            if  prizeid == 16
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r恭喜玩家"+GetPlayerNameOfColor(pid)+"通过|cff00ff00《良心赞助》|r获得 "+GetObjectName(id)+"x1")
            else
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r恭喜玩家"+GetPlayerNameOfColor(pid)+"通过抽奖获得 "+GetObjectName(id)+"x1")
            endif
        endif
    endfunction
    

    //升级加血技能
    function IncHeroAddLifeAbility(int pid)
        int lv = GetUnitAbilityLevel(Pu[1],'AG06')
        int use = 0//lv * 150 + 150
        if  lv < 10
            //if  GetUnitIntState(Pu[1],108)>=use
                //AddUnitIntState(Pu[1],108,-use)
                SetUnitAbilityLevel(Pu[1],'AG06',lv+1)
                AddUnitRealState(Pu[1],45,30)
                LocAddEffect(GetUnitX(Pu[1]),GetUnitY(Pu[1]),"effect_e_buffyellow2.mdl")
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r升级成功！")
            //else
                //DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r升级失败！杀敌数不足"+I2S(use))
            //endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r升级失败！该技能已经满级！")
        endif
    endfunction
    
    function IsUnitHasItemLevel(unit wu,item it,int lv)->boolean
        int l = 0
        for n = 0,5
            l = GetItemLevel(UnitItemInSlot(wu,n))
            if  l == lv and it != UnitItemInSlot(wu,n)
                return true
            endif
        end
        return false
    endfunction


    function ItemFormula(unit wu,item it1,item it2)
        int id = (GetItemTypeId(it1) - 'IK00')*0x100 + 'IK0A'
        BJDebugMsg("ID"+YDWEId2S(id)+I2S(id))
        RemoveItem(it1)
        RemoveItem(it2)
        UnitAddItemById(wu,id)
        UnitAddEffect(wu,"Abilities\\Spells\\Items\\AIsm\\AIsmTarget.mdl")
    endfunction

    function GemItemFormula(unit wu,item it)
        int itemid = GetItemTypeId(it)
        
        for n = 0,5
            if  it != UnitItemInSlot(wu,n)
                if  GetItemTypeId(UnitItemInSlot(wu,n)) == itemid
                    BJDebugMsg("合成材料满足")
                    ItemFormula(wu,it,UnitItemInSlot(wu,n))
                    exitwhen true
                endif
            endif
        end

    endfunction

    function GemItemCardFormula(unit wu,int sid,item it) 
        int itemid = GetItemTypeId(it)
        int index = sid - 'AK90'

        if  itemid == 'IK1A' or itemid == 'IK2A' or itemid == 'IK3A' or itemid == 'IK4A' or itemid == 'IK5A' or itemid == 'IK6A' or itemid == 'IK7A' or itemid == 'IK8A'
            if  RemoveUnitHasItem(wu,sid + 0x8000000) == true
                RemoveItem(it)
                UnitAddItemById(wu,itemid + index)
                UnitAddEffect(wu,"Abilities\\Spells\\Items\\AIsm\\AIsmTarget.mdl")
            endif
        else
            DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,10,"|cffff0000[系统]：|r使用目标不正确！")
        endif


    endfunction


    //使用超级招魂幡
    function PlayerUseSuperSoul(unit wu,item it)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int id = GetItemTypeId(it)
        int use = 0
        int num = GetItemCharges(it)+1
        if  id == 'I051'
            use = 10
        elseif  id == 'I052'
            use = 20
        elseif  id == 'I053'
            use = 30
        elseif  id == 'I054'
            use = 40
        endif

        SetItemCharges(it,num)

        if  GetPlayerState(Player(pid), PLAYER_STATE_RESOURCE_LUMBER)>=use
            AdjustPlayerStateBJ(-use, Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
            
            RemoveItem(it)

            bj_lastCreatedItem = CreateItem(id+1,GetUnitX(wu),GetUnitY(wu))
            SetItemCharges(bj_lastCreatedItem,num)
            UnitAddItem(wu,bj_lastCreatedItem)


            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：恭喜您！招魂幡升级成功！")
        else    
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r强化失败！玄铁不足"+I2S(use))
        endif



    endfunction


    
        unit GameMode4ShopUnit = null
        int GameMode4ShopId1 = 0
        int GameMode4ShopId2 = 0
        int GameMode4ShopId3 = 0

        function ClearGameMode4ShopNpc(int pid)
            RemoveItemFromStock(Pu[47], GameMode4ShopId1)
            RemoveItemFromStock(Pu[47], GameMode4ShopId2)
            RemoveItemFromStock(Pu[47], GameMode4ShopId3)
        endfunction
        function ReGameMode4ShopNpc(int pid)
            ClearGameMode4ShopNpc(pid)
            GameMode4ShopId1 = GetRandomInt('IX0A','IX0R')
            GameMode4ShopId2 = GetRandomInt('IX1A','IX1R')
            GameMode4ShopId3 = GetRandomInt('IX2A','IX2R')
            AddItemToStock(Pu[47],GameMode4ShopId1,1,1)
            AddItemToStock(Pu[47],GameMode4ShopId2,1,1)
            AddItemToStock(Pu[47],GameMode4ShopId3,1,1)
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]|r：悬赏任务刷新了！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]|r：悬赏任务刷新了！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]|r：悬赏任务刷新了！")
        endfunction
    //GetUnitIntState(u,'IX0A')
        function GameMode4MissionTimer(int Pid,int Index)
            int pid = Pid
            int index = Index

            int time =  Mode4MissionData[index][2]
            int num =   Mode4MissionData[index][1]
            int uid =   'mj0A' + index - 1
            real x = 0
            real y = 0
            if  pid == 0
                x = -6016
                y = 13728
            elseif  pid == 1
                x = -2144
                y = 13728
            elseif  pid == 2
                x = -2144
                y = 9824
            elseif  pid == 3
                x = -6016
                y = 9824
            endif
            TimerStart(0.5,true)
            {
                unit u = null
                for i = 1,num
                    u = CreateUnit(Player(10),uid,x,y,0)
                    IssuePointOrderById(u,851983,x,y)
                    GroupAddUnit(AttackUnitGroup,u)
                end

                time = time - 1
                if  time <= 0
                    endtimer
                endif
                flush locals
            }
            flush locals
        endfunction

        function GiveGameMode4Prize(int pid,int itemid,int index)
            int prize = Mode4MissionData[index][3]
            int prizemin = Mode4MissionData[index][4]
            int prizemax = Mode4MissionData[index][5]
            int give = 0
            int ran = GetRandomInt(1,100)

            if  prize == 1
                give = GetRandomInt(prizemin,prizemax)
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：接受"+GetObjectName(itemid)+"！获得金币x"+I2S(give))
                AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,give)
            elseif  prize == 2
                give = GetRandomInt(prizemin,prizemax)
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：接受"+GetObjectName(itemid)+"！获得玄铁x"+I2S(give))
                AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,give)
            elseif  prize == 3
                give = GetRandomInt(prizemin,prizemax)
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：接受"+GetObjectName(itemid)+"！获得经验x"+I2S(give))
                HeroAddExp( Pu[1], give)
            elseif  prize == 11
                if  ran <= 70
                    give = 'CS51'
                elseif  ran <= 90
                    give = 'CS52'
                else
                    give = 'CS53'
                endif
                UnitAddItemById(Pu[1],give)
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：接受"+GetObjectName(itemid)+"！获得"+GetObjectName(give)+"x1")
            elseif  prize == 20
                if  ran <= 22
                    give = GetPrize(pid,14,false)
                elseif  ran <= 72
                    give = GetPrize(pid,13,false)
                elseif  ran <= 94
                    give = GetPrize(pid,12,false)
                else
                    give = GetPrize(pid,11,false)
                endif
                GivePlayerMagicItem(pid,give)
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：接受"+GetObjectName(itemid)+"！获得"+GetTypeIdName(give)+"x1")
            elseif  prize >= 21 and prize <= 25
                give = GetPrize(pid,prize - 10,false)
                GivePlayerMagicItem(pid,give)
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：接受"+GetObjectName(itemid)+"！获得"+GetTypeIdName(give)+"x1")
            else
                give = prize
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：接受"+GetObjectName(itemid)+"！获得"+GetObjectName(give)+"x"+I2S(prizemax))
                SetItemCharges(UnitAddItemById(Pu[1],give),prizemax)
            endif
            /*
            1 金币
            2 玄铁
            3 经验
            11 随机附魔石
            20 随机法宝
            21 红色法宝
            22 黄色法宝
            23 紫色法宝
            24 蓝色法宝
            25 绿色法宝
            */

        endfunction
        function PickupGameMode4Mission(int pid,int itemid)
            int index = 0
            if  itemid >= 'IX0A' and itemid <= 'IX0R'
                index = itemid - 'IX0A' + 1
            elseif  itemid >= 'IX1A' and itemid <= 'IX1R'
                index = itemid - 'IX1A' + 1
            elseif  itemid >= 'IX2A' and itemid <= 'IX2R'
                index = itemid - 'IX2A' + 1
            endif

            if  index != 0
                GiveGameMode4Prize(pid,itemid,index)
                GameMode4MissionTimer(pid,index)

                
            endif

            
        endfunction


        int array Mode4MissionData[100][80]
        function RegisterGameMode4Mission(int index,int time,int num,int prize,int prizemin,int prizemax)
            Mode4MissionData[index][1] = time
            Mode4MissionData[index][2] = num
            Mode4MissionData[index][3] = prize
            Mode4MissionData[index][4] = prizemin
            Mode4MissionData[index][5] = prizemax
        endfunction
        function InitGameMode4Mission()
            
            RegisterGameMode4Mission( 1,2,12,1,5000,12888)
            RegisterGameMode4Mission( 2,3,16,1,16888,28888)
            RegisterGameMode4Mission( 3,4,20,1,38888,88888)
            RegisterGameMode4Mission( 4,3,12,2,2,15)
            RegisterGameMode4Mission( 5,1,1,2,12,26)
            RegisterGameMode4Mission( 6,3,16,'CS52',2,2)
            RegisterGameMode4Mission( 7,2,12,11,1,1)
            RegisterGameMode4Mission( 8,3,16,'IP02',1,1)
            RegisterGameMode4Mission( 9,1,1,'IP03',1,1)
            RegisterGameMode4Mission(10,3,16,23,1,1)
            RegisterGameMode4Mission(11,4,20,20,1,1)
            RegisterGameMode4Mission(12,4,30,22,1,1)
            RegisterGameMode4Mission(13,1,1,21,1,1)
            RegisterGameMode4Mission(14,3,16,'IN31',1,1)
            RegisterGameMode4Mission(15,2,12,3,8888,1288)
            RegisterGameMode4Mission(16,3,16,3,16888,22888)
            RegisterGameMode4Mission(17,4,20,3,28888,36888)
            RegisterGameMode4Mission(18,4,20,3,44888,52888)
        endfunction
    
    


    
    
    
    function PickupItemActions()
        unit u1 = GetTriggerUnit()
        int itemid = GetItemTypeId(GetManipulatedItem())
        int pid = GetPlayerId(GetOwningPlayer(u1))
        int i1 = 0
        int i2 = 0
        real r1 = 0
        int level = GetItemLevel(GetManipulatedItem())
        int attacklv = AttackUnitWN + 1

        

        BJDebugMsg("获取物品")
        if  GetItemType(GetManipulatedItem()) == ITEM_TYPE_ARTIFACT
            BJDebugMsg("永久")
            //FormulaVerify()

            if  u1 == Pu[1]
                AddEquipState(u1,itemid)
                if  IsUnitHasItemLevel(u1,GetManipulatedItem(),level) == true
                    UnitRemoveItem(u1,GetManipulatedItem())
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：无法携带相同类型物品！|r")
                endif
            elseif  u1 == Pu[2]
                if  itemid >= 'E001' and itemid <= 'E230'
                    UnitRemoveItem(u1,GetManipulatedItem())
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：无法携带该类型物品！|r")
                endif
            endif

        elseif  GetItemType(GetManipulatedItem()) == ITEM_TYPE_CHARGED
            BJDebugMsg("可充")
            AddItemCharges(u1,GetManipulatedItem())
        else
            if  itemid >= 'IK01' and itemid <= 'IK08'
                BJDebugMsg("宝珠")
                GemItemFormula(u1,GetManipulatedItem())
            endif
            //FormulaVerify()
        endif



        if  itemid >= 'E001' and itemid <= 'E240'
            ReEquipTips(pid,GetManipulatedItem())
        endif

        
        if  itemid == 'IP01'
            SetPlayerPlotPartNum(pid,GetPlayerPlotPartNum(pid)+1)
        elseif  itemid == 'IP14'
            UnitAddItem(u1,CreateItem('IP04',GetUnitX(u1),GetUnitY(u1)))
        elseif  itemid >= 'IJ01' and itemid <= 'IJ10'
            //AddPlayerImmortalFruit(u1,itemid)
        elseif  itemid >= 'IT01' and itemid <= 'IT15'
            PlayerHeroMoveToImmortal(u1,itemid)
        elseif  (itemid >= 'IX0A' and itemid <= 'IX0R') or (itemid >= 'IX1A' and itemid <= 'IX1R') or (itemid >= 'IX2A' and itemid <= 'IX2R')
            PickupGameMode4Mission(pid,itemid)
        elseif  itemid >= 'IL1A' and itemid <= 'IL5Z'
            PlayerBuyExShopItem(pid,itemid)
        elseif  itemid >= 'IS01' and itemid <= 'IS03'
            PlayerAbilityDraw(pid,1,itemid)
        elseif  itemid >= 'IS06' and itemid <= 'IS08'
            PlayerAbilityDraw(pid,2,itemid)
        elseif  itemid == 'IS13'
            IncOrnaments(pid,Pu[1])
        elseif  itemid == 'IS14'
            IncHeroAddLifeAbility(pid)
        elseif  itemid == 'IZ10'
            if  attacklv <= 11
                UnitAddPoolItemShow(u1,11)
            else
                UnitAddPoolItemShow(u1,17)
            endif
        elseif  itemid == 'IZ11'
            if  attacklv <= 11
                for i = 1,10
                    UnitAddPoolItemShow(u1,11)
                end
            else
                for i = 1,10
                    UnitAddPoolItemShow(u1,17)
                end
            endif
        elseif  itemid == 'IZ02'
            if  DzConA[13] == 1
                if  GameLevel >= 4
                    SendToGameChallenge_10(pid)
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r该团本难度4或以上才能激活！！！")
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[团队副本]：|r|cffff0000当前团队副本暂未开放！！！|r")                         
            endif
        elseif  itemid == 'IZ03'
            if  DzConA[14] == 1
                if  GameLevel >= 4
                    if  GetUnitTypeId(GameChallengeMapUnit[501]) != 'ut21'
                        OpenChallengeWM(pid)  
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,2,"|cffffcc00[万魔窟]：|r|cffff0000未解除万魔窟的封印，请击杀秘境领主解除！|r")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r该团本难度4或以上才能激活！！！")
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[团队副本]：|r|cffff0000当前团队副本暂未开放！！！|r")
            endif
        elseif  itemid == 'IZ04'
            AddItemToStock(GameDefendUnit,itemid,1,1)
            OpenLastAttack(pid)
        elseif  itemid == 'IZ70'
            
            OpenLastAttackmb55(pid)
        elseif  itemid == 'IZ05'
            OpenMeridiansChallenge(pid)
        elseif  itemid == 'IZ08'
            SendUnitToDragonKing(pid)
        elseif  itemid == 'IZ01'
            if  GameLevel >= 2
                if  GameTeamChallengeBool[21] == false
                    OpenGameTeamChallenge(pid,1,10)
                else    
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,30000)
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,10)

                    RemoveItemFromStock(GameChallengePlayerUnit[pid][90],itemid)
                    AddItemToStock(GameChallengePlayerUnit[pid][90],itemid,0,1)

                    FlushGameTeamChallengeStockTimer(pid,itemid)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000当前已激活其他团本入口，请10秒后重新购买！|r")
                endif
            else
                AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,30000)
                AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,10)

                if  GameTeamChallengeBool[20] == true
                    if  GetUnitIntState(GameChallengePlayerUnit[pid][90],'IZ06') == 0
                        RemoveItemFromStock(GameChallengePlayerUnit[pid][90],'IZ06')
                        AddItemToStock(GameChallengePlayerUnit[pid][90],'IZ06',1,1)
                    endif
                endif

                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r该团本难度2或以上才能激活！！！")
            endif
        elseif  itemid == 'IZ06'
            if  GameLevel >= 5
                if  GameTeamChallengeBool[1] == false
                    OpenGameTeamChallenge2(pid,1,10)
                else    
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,50000)
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,15)

                    RemoveItemFromStock(GameChallengePlayerUnit[pid][90],itemid)
                    AddItemToStock(GameChallengePlayerUnit[pid][90],itemid,0,1)
                    
                    FlushGameTeamChallengeStockTimer(pid,itemid)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r|cffff0000当前已激活其他团本入口，请10秒后重新购买！|r")
                endif
            else
                AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,50000)
                AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,15)

                if  GetUnitIntState(GameChallengePlayerUnit[pid][90],'IZ01') == 0
                    RemoveItemFromStock(GameChallengePlayerUnit[pid][90],'IZ01')
                    AddItemToStock(GameChallengePlayerUnit[pid][90],'IZ01',1,1)
                endif
                if  GameMode == 3
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r该团本异变模式难度2或以上才能激活！！！")
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r该团本难度5或以上才能激活！！！")
                endif
            endif
        elseif  itemid == 'IZ07'
            if  GameSaveClose == 0
                if  DzConA[24] == 1
                    if  Player51unit == 0
                        
                        if  GetPlayerTechCount(Player(pid),'RJ1Y',true) == 1 //劳动礼包
                            i1 = 75
                        else
                            i1 = 150
                        endif
                        if  GetDzPlayerData(pid,18,1) >= i1
                            AddDzPlayerData(pid,18,1,-i1)
                            Player51unit = 1
                            if  pid == 0
                                Pu[40] = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'uh01',-8576,11008,315)
                            elseif  pid == 1
                                Pu[40] = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'uh01',-7808,11008,225)
                            elseif  pid == 2
                                Pu[40] = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'uh01',-7808,10112,135)
                            elseif  pid == 3
                                Pu[40] = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'uh01',-8576,10112,45)
                            endif
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：兑换失败！狂欢积分不足|cff00ff00"+I2S(i1)+" |r无法进入!")
                        endif
                        
                    endif
                    if  Player51unit == 1
                        if  pid == 0
                            SendPlayerUnit(pid,-8448,10880)
                        elseif  pid == 1
                            SendPlayerUnit(pid,-7936,10880)
                        elseif  pid == 2
                            SendPlayerUnit(pid,-7936,10240)
                        elseif  pid == 3
                            SendPlayerUnit(pid,-8448,10240)
                        endif
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：活动暂未开放!")
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：该模式无法使用该功能!")
            endif
        elseif  itemid == 'IC01'
            AdjustPlayerStateBJ(1, Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：玄铁+1！")
        elseif  itemid == 'IY00' 
            if  GameSaveClose == 0
                if  GetLocalPlayer() == Player(pid) 
                    ClearSelection()
                    SelectUnit(Pu[41],true)
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：该模式无法使用该功能!")
            endif
        elseif  itemid >= 'IY0A' and itemid <= 'IY5Z'
            if   GameSaveClose == 0//积分兑换
                if  IsCanExChange(pid,itemid) == true
                    ExChangeItem(pid,itemid)
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r兑换失败！已获得该道具。")
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：该模式无法使用该功能!")
            endif
        elseif  itemid >= 'IV01' and itemid <= 'IV99' 
            if  GameSaveClose == 0//活动兑换
            
                
                if  itemid == 'IV01'
                    if  GetDzPlayerData(pid,10,7) != 7
                        
                        if  DzPlayerLv(Player(pid)) >= 6
                            if  GetDzPlayerData(pid,18,1) >= 2000
                                if  GetDzPlayerData(pid,18,2) >= 3
                                    if  Holiday51 >= 2
                                        AddDzPlayerData(pid,18,1,-2000)
                                        AddDzPlayerData(pid,18,2,-3)
                                        AddDzPlayerData(pid,10,7,7)
                                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换成功！重新进入游戏生效！")
                                    else
                                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:还不到第2天，你哪来的矿铲！")
                                    endif
                                else
                                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换失败！祖传矿铲不足|cff00ff003")
                                endif
                            else
                                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换失败！狂欢积分不足|cff00ff002000")
                            endif
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换失败！等级不足|cff00ff006")
                        endif
                        
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r兑换失败！已获得该道具。")
                    endif
                elseif  itemid == 'IV02'
                    if  GetDzPlayerData(pid,19,2) != 2
                        if  DzPlayerLv(Player(pid)) >= 8
                            if  GetDzPlayerData(pid,18,1) >= 3000
                                if  GetDzPlayerData(pid,18,2) >= 7
                                    if  Holiday51 >= 4
                                        AddDzPlayerData(pid,18,1,-3000)
                                        AddDzPlayerData(pid,18,2,-7)
                                        AddDzPlayerData(pid,19,2,2)
                                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换成功！重新进入游戏生效！")
                                    else
                                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:还不到第4天，你哪来的矿铲！")
                                    endif
                                else
                                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换失败！祖传矿铲不足|cff00ff007")
                                endif
                            else
                                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换失败！狂欢积分不足|cff00ff003000")
                            endif
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换失败！等级不足|cff00ff008")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r兑换失败！已获得该道具。")
                    endif
                elseif  itemid == 'IV03'
                    if  HolidayChangeData[pid][3] == 0
                        if  GetDzPlayerData(pid,18,1) >= 50
                            AddDzPlayerData(pid,18,1,-50)
                            HolidayChangeData[pid][3] = 1
                            UnitAddItemById(u1,'IN31')
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r炽星魔盒兑换成功！")
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换失败！狂欢积分不足|cff00ff0050")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换失败！每局只可兑换一次！")
                    endif
                elseif  itemid == 'IV04'
                    if  GetDzPlayerData(pid,14,19) != 19
                        if  DzPlayerLv(Player(pid)) >= 8
                            if  GetDzPlayerData(pid,18,1) >= 4500
                                if  GetDzPlayerData(pid,18,2) >= 7
                                    if  Holiday51 >= 4
                                        AddDzPlayerData(pid,18,1,-4500)
                                        AddDzPlayerData(pid,18,2,-7)
                                        AddDzPlayerData(pid,14,19,19)
                                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换成功！重新进入游戏生效！")
                                    else
                                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:还不到第4天，你哪来的矿铲！")
                                    endif
                                else
                                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换失败！祖传矿铲不足|cff00ff007")
                                endif
                            else
                                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换失败！狂欢积分不足|cff00ff004500")
                            endif
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换失败！等级不足|cff00ff008")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r兑换失败！已获得该道具。")
                    endif
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：该模式无法使用该功能!")
            endif
        endif


        

        if  itemid == 'I00A'
            AttackOperaAGold(GetItemX(GetManipulatedItem()),GetItemY(GetManipulatedItem()))
        elseif  itemid == 'IZ0A'
            AttackUnitItemStop(pid,3,120)
        elseif  itemid == 'IZxx'
            AttackUnitItemSpeedUp(pid)
        elseif  itemid == 'IZ0B'
            OpenMeridiansChallenge(pid)
        elseif  itemid == 'IS12'
            ItemLuckOfMonsterSoul(pid)
        endif
        ItemEventOfAttackUnitChallengeState(pid,itemid)
        if  (itemid >= 'IB00' and itemid <= 'IB11') or (itemid >= 'IB50' and itemid <= 'IB61')
            PlayerGetGameGift(pid,itemid)
        endif
        
        if  IsItemPowerup(GetManipulatedItem()) == true //清除
            
            RemoveItem(GetManipulatedItem())
        endif
        
        flush locals
    endfunction

    
    
    
    function UseItemActions()
        unit u1 = GetTriggerUnit()
        int itemid = GetItemTypeId(GetManipulatedItem())
        int pid = GetPlayerId(GetOwningPlayer(u1))
        int gold = 0
        int i1 = 0
        int i2 = 0
        int attacklv = AttackUnitWN + 1

        if  GetItemType(GetManipulatedItem()) == ITEM_TYPE_CHARGED
            if  GetItemCharges(GetManipulatedItem()) == 0
                RemoveItem(GetManipulatedItem())
            endif
        endif

        if  itemid == 'CS01'
            PlayerUseAbilityBook(pid,1,itemid)
        elseif  itemid == 'CS02'
            GivePlayerRunePrizeFrame(pid)
        elseif  itemid == 'CS03'
            PlayerUseAbilityBook(pid,2,itemid)
        elseif  itemid == 'CS04'
            PlayerUseAbilityBook(pid,1,itemid)
        elseif  itemid == 'CS05'
            PlayerUseAbilityBook(pid,2,itemid)
        elseif  itemid == 'CS06'
            PlayerUseAbilityBook(pid,2,itemid)
        elseif  itemid >= 'CS21' and itemid <= 'CS24'
            PlayerUseIncAbilityGem(u1,itemid)
        elseif  itemid == 'CS41'
            PlayerUseIncEquipGem(u1,itemid)
        elseif  itemid == 'CS42'
            PlayerUseIncEquipGem(u1,itemid)
        
        elseif  itemid == 'IP06'
            if  PlayerReRandomPrize(pid,1.0) == false
                UnitAddItemById(u1,itemid)
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r当前没有副本奖励选项！")
            endif
        elseif  itemid == 'IP07'
            if  PlayerReRuneRandomPrize(pid) == false
                UnitAddItemById(u1,itemid)
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r当前没有符印奖励选项！")
            endif
        elseif  itemid == 'IP08'
            PlayerUseBoxIP08(pid)
        elseif  itemid == 'IP09'
            PlayerUseBoxIP09(pid)
        elseif  itemid >= 'I051' and itemid <= 'I055'
            PlayerUseSuperSoul(u1,GetManipulatedItem())
        elseif  itemid >= 'IK01' and itemid <= 'IK8Z'
            PlayerUseGemItem(u1,GetManipulatedItem())
        elseif  itemid == 'IP02'//鸿蒙结晶补天石
            SetPlayerMagicItemResources(pid,1,GetPlayerMagicItemResources(pid,1)+1)
            ReCollectFrameResources(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r使用道具补天石，F4内查看！")
        elseif  itemid == 'IP03'
            SetPlayerMagicItemResources(pid,2,GetPlayerMagicItemResources(pid,2)+1)
            ReCollectFrameResources(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r使用道具鸿蒙结晶，F4内查看！")
        elseif  itemid >= 'E001' and itemid <= 'E029'
            IncEquipFunc(u1,GetManipulatedItem())
        elseif  itemid >= 'E201' and itemid <= 'E229'
            IncEquipFunc(u1,GetManipulatedItem())
        elseif  itemid == 'I001'
            
            SetUnitState(Pu[1],UNIT_STATE_LIFE,GetUnitState(Pu[1],UNIT_STATE_LIFE)+GetUnitState(Pu[1],UNIT_STATE_MAX_LIFE)*0.8)
            LocAddEffect(GetUnitX(u1),GetUnitY(u1),"effect_e_buffgreen2a.mdl")
        elseif  itemid == 'I002'
            SetUnitState(Pu[1],UNIT_STATE_MANA,GetUnitState(Pu[1],UNIT_STATE_MANA)+GetUnitState(Pu[1],UNIT_STATE_MAX_MANA)*0.6)
            LocAddEffect(GetUnitX(u1),GetUnitY(u1),"effect_e_buffblue2.mdl")
        elseif  itemid == 'I003'
            AddUnitStateExTimer(Pu[1],9,50,15)
            LocAddEffect(GetUnitX(u1),GetUnitY(u1),"effect_e_buffyellow2.mdl")
        elseif  itemid == 'I004'
            AddUnitStateExTimer(Pu[1],16,30,15)
            LocAddEffect(GetUnitX(u1),GetUnitY(u1),"effect_e_buffattack.mdl")
        elseif  itemid == 'I005'
            AddUnitStateExTimer(Pu[1],15,30,15)
            LocAddEffect(GetUnitX(u1),GetUnitY(u1),"effect_e_buffattack.mdl")
        elseif  itemid == 'IP04'
            i1 = GetHeroAbilityID(Pu[1],4)
            if  i1 >= 'S230' and i1 <= 'S237'
                HeroRemoveAbilityByIndex (Pu[1],4)
                HeroAddAbilityByIndex(Pu[1],4,'S230'+GetRandomInt(0,7))
            else
                UnitAddItem(u1,CreateItem(itemid,GetUnitX(u1),GetUnitY(u1)))
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r未获得R技能！无法洗练！")
            endif


        elseif  (itemid >= 'IN07' and itemid <= 'IN24') or (itemid >= 'IN33' and itemid <= 'IN40')
            PlayerUsesstrangeItem(pid,itemid)
        elseif  itemid == 'IN30'//幸运星盒IN30注册
            
            UnitAddPoolItemShow(u1,15)
        elseif  itemid == 'IN31'//炽星魔盒IN31注册
            UnitAddPoolItemShow(u1,17)
        elseif  itemid == 'IN25'//入门道果箱IN25注册
            UnitAddPoolItemShow(u1,12)
        elseif  itemid == 'IN26'//后天道果箱IN26注册
            UnitAddPoolItemShow(u1,13)
        elseif  itemid == 'IN27'//先天道果箱IN27注册
            UnitAddPoolItemShow(u1,14)
        
        elseif  itemid == 'IN00'//锦囊IN00注册
            UnitAddPoolItemShow(u1,16)
        elseif  itemid == 'IN19'//附魔宝箱IN19注册
            UnitAddPoolItemShow(u1,20)
            if  GetRandomInt(1,100) <= 50
                UnitAddPoolItemShow(u1,20)
            endif
        elseif  itemid == 'IN28'////技能宝箱IN28注册
            UnitAddPoolItemShow(u1,21)
        elseif  itemid == 'IN29'//1附魔宝箱IN29注册
            UnitAddPoolItemShow(u1,22)
            if  GetRandomInt(1,100) <= 50
                UnitAddPoolItemShow(u1,22)
            endif
            
        elseif  itemid == 'IN32'//技能宝箱IN32注册
            UnitAddPoolItemShow(u1,25)


        elseif  itemid >= 'ID01' and itemid <= 'ID10'//道果

            if  GetUnitIntState(Pu[1],150) < 10
                if  GetHeroLevel(Pu[1]) == 1
                    i2 = 0
                else
                    i2 = DzGetUnitNeededXP(Pu[1],GetHeroLevel(Pu[1])-1)
                endif
                i1 =  GetHeroXP(Pu[1])-i2

                AddImmortalFruit(Pu[1],itemid - 'ID00' + 'IJ00',0)
                HeroAddExp(Pu[1],i1)
            else
                UnitAddItem(u1,CreateItem(itemid,GetUnitX(u1),GetUnitY(u1)))
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r等级已满，无法晋升境界！")
            endif
        elseif  itemid >= 'ID11' and itemid <= 'ID20'//道果
            if  GetUnitIntState(Pu[1],150) < 10
                if  DzGetUnitNeededXP(Pu[1],GetHeroLevel(Pu[1])) -  GetHeroXP(Pu[1]) == 1
                    AddPlayerImmortalFruit(Pu[1],itemid - 'ID10' + 'IJ00',0)
                else
                    UnitAddItem(u1,CreateItem(itemid,GetUnitX(u1),GetUnitY(u1)))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r境界经验不足，无法晋升境界！")
                endif
            else
                UnitAddItem(u1,CreateItem(itemid,GetUnitX(u1),GetUnitY(u1)))
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r等级已满，无法晋升境界！")
            endif
        endif
        
        flush locals
         
    endfunction

    function DropItemActions()
        unit u1 = GetTriggerUnit()
        int itemid = GetItemTypeId(GetManipulatedItem())
        int pid = GetPlayerId(GetOwningPlayer(u1))
        int ran = 0
        real x = 0
        real y = 0

        if  GetItemType(GetManipulatedItem()) == ITEM_TYPE_ARTIFACT
            RemoveEquipState(u1,itemid)
        endif

        flush locals
    endfunction


    
    
    function SellItemActions()
        unit u1 = GetBuyingUnit()
        int itemid = GetItemTypeId(GetSoldItem())
        int pid = GetPlayerId(GetOwningPlayer(u1))
        


        if  itemid == 'IZ71'
            
            OpenNewChallenge1(pid,GetSellingUnit())
        elseif  itemid == 'IZ72'
            ReChallengePrize(GetSellingUnit())
        endif

        BJDebugMsg(GetUnitName(GetSellingUnit())+"售出物品"+GetObjectName(itemid))


        flush locals
    endfunction
    
    
    
    
        
    func InitItemSystem()
        trigger trig
        trig = CreateTrigger()
        for i = 0,15
            TriggerRegisterPlayerUnitEvent(trig, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM, null) //获得物品
        end
        TriggerAddCondition(trig, Condition(function PickupItemActions))    
        trig = CreateTrigger()
        for i = 0,15
            TriggerRegisterPlayerUnitEvent(trig, Player(i), EVENT_PLAYER_UNIT_USE_ITEM, null) //使用物品
        end
        TriggerAddCondition(trig,Condition( function UseItemActions))
        trig = CreateTrigger()
        for i = 0,15
            TriggerRegisterPlayerUnitEvent(trig, Player(i), EVENT_PLAYER_UNIT_DROP_ITEM, null) //丢弃物品
        end
        TriggerAddCondition(trig, function DropItemActions)
        trig = CreateTrigger()
        for i = 0,15
            TriggerRegisterPlayerUnitEvent(trig, Player(i), EVENT_PLAYER_UNIT_SELL_ITEM, null) //出售物品
        end
        TriggerAddCondition(trig, function SellItemActions)
        trig = null
        InitGameMode4Mission()
    end
endscope


