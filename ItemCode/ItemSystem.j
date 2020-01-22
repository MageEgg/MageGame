
scope ItemSystem initializer InitItemSystem
    function UnitAddPoolItemShow(unit wu,int prizeid)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int id = UnitAddPoolItem(wu,prizeid)
        if  id >= 'IC00' and id <= 'IC99'
            //不显示
        else
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r恭喜玩家"+GetPlayerNameOfColor(pid)+"通过抽奖获得 "+GetObjectName(id)+"x1")
        endif
    endfunction
    

    //装备升级
    function GetEquipIndex(int id)->int
        if  id >= 'E001' and id <= 'E025'
            return 1
        elseif  id >= 'E101' and id <= 'E125'
            return 2
        elseif  id >= 'E201' and id <= 'E225'
            return 3
        endif
        return 0
    endfunction

    function IsHeroEquipCanOpenPlot(unit wu)->bool
        int id = 0
        int e1 = 0
        int e2 = 0
        for n = 0,5
            id = GetItemTypeId(UnitItemInSlot(wu,n))
            if  id >= 'E006' and id <= 'E025'
                e1 = 1
                exitwhen true
            endif
        end
        for n = 0,5
            id = GetItemTypeId(UnitItemInSlot(wu,n))
            if  id >= 'E206' and id <= 'E225'
                e2 = 1
                exitwhen true
            endif
        end
        return e1 == 1 and e2 == 1
    endfunction

    function IncEquipKillUnitFunc(unit u1,unit u2)
        int pid = GetPlayerId(GetOwningPlayer(u1))
        int uid = GetUnitTypeId(u2)
        int next = 0
        int itemid = 0
        for i = 0,5
            itemid = GetItemTypeId(UnitItemInSlot(Pu[1],i))
            if  GetTypeIdData(itemid,105) == uid
                next = GetTypeIdData(itemid,106)
                RemoveItem(UnitItemInSlot(Pu[1],i))
                UnitAddItem(Pu[1],CreateItem(next,GetUnitX(Pu[1]),GetUnitY(Pu[1])))
                UnitAddEffect(Pu[1],"effect_e_buffyellow2.mdx")
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r装备"+GetObjectName(itemid)+"突破成功！")
                
                if  Pu[24] == null
                    if  IsHeroEquipCanOpenPlot(Pu[1]) == true
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r装备均达到|Cff00ff7f绿色|r，解锁|Cffff0000剧情副本挑战|r|Cfff0f0f0。|r")

                        Pu[24] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np04',AttackRoomPostion[pid][1],AttackRoomPostion[pid][2]+512,270)//副本入口
                        LocAddEffect(GetUnitX(Pu[24]),GetUnitY(Pu[24]),"effect_az-blue-lizi-shangsheng.mdl")
                        UnitAddAbility(Pu[1],'AG09')
                        UnitMakeAbilityPermanent(Pu[1],true,'AG09')
                        PlayerUnLockPlot(pid,1)
                    endif
                endif
            endif
        end
    endfunction
 
    function IncEquipFunc(unit u1,item it)
        int pid = GetPlayerId(GetOwningPlayer(u1))
        int id = GetItemTypeId(it)
        int gold = GetTypeIdData(id,103)
        int next = GetTypeIdData(id,106)
        int uid = GetTypeIdData(id,105)
        int index = 0
        int gl = GetTypeIdData(id,104)//概率
        if  next > 0
            
            if  GetPlayerState(Player(pid), PLAYER_STATE_RESOURCE_GOLD)>=gold
                if  uid > 0
                    if  IsCanMoveToRoom(pid) == true
                        index = GetEquipIndex(id)
                        if  index != 0
                            if  GetUnitTypeId(Pu[100+index]) == 0
                                AdjustPlayerStateBJ(-gold, Player(pid), PLAYER_STATE_RESOURCE_GOLD )


                                Pu[100+index] = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),uid,AttackRoomPostion[pid][1]-512,AttackRoomPostion[pid][2]+384,270)
                                
                                AddAttackSummonUnit(pid,Pu[100+index])

                                SetPlayerOnlyDamage(Pu[100+index],pid)
                                IssuePointOrderById( Pu[100+index], 851983, AttackRoomPostion[pid][1], AttackRoomPostion[pid][2] )
                                HeroMoveToRoom(pid)

                            else
                                HeroMoveToRoom(pid)
                                if  id >= 'E001' and id <= 'E025'
                                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r武器晋升正在挑战中！")
                                elseif  id >= 'E201' and id <= 'E225'
                                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r防具晋升正在挑战中！")
                                endif
                            endif
                        endif
                    else   
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r当前无法升级装备")
                    endif
                else
                    AdjustPlayerStateBJ(-gold, Player(pid), PLAYER_STATE_RESOURCE_GOLD )
                    if  GetRandomInt(1,100)<= gl
                        RemoveItem(it)
                        UnitAddItem(u1,CreateItem(next,GetUnitX(u1),GetUnitY(u1)))
                        UnitAddEffect(Pu[1],"effect_e_buffyellow2.mdx")
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r装备"+GetObjectName(id)+"成功升级为"+GetObjectName(next))
                    else
                        if  GetPlayerTechCount(Player(pid),'RJ1U',true) > 0
                            AdjustPlayerStateBJ(gold/5, Player(pid), PLAYER_STATE_RESOURCE_GOLD )
                            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：装备|r"+GetObjectName(id)+"|cffff0000升级失败！返还"+I2S(gold/5)+"金币|r")
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：装备|r"+GetObjectName(id)+"|cffff0000升级失败！|r")
                        endif
                        
                    endif
                    
                endif
            else
                
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r升级失败！金币不足"+I2S(gold))
            endif
            
        else    
            BJDebugMsg("next"+I2S(next))
        endif
    endfunction

    //读取玩家抽技能次数
    function GetPlayerDrawNum(int pid,int index)->int
        return PlayerInt[pid][110+index]
    endfunction
    //增加玩家抽技能次数
    function AddPlayerDrawNum(int pid,int index)
        PlayerInt[pid][110+index] ++
    endfunction
    //读取玩家抽技能需求
    function GetPlayerDrawUse(int pid,int index,int num)->int
        int use = 0
        num = num - 1
        if  index == 1
            use = 1500 + num * 1500
        elseif  index == 2
            use = 5000 + num * 5000
        elseif  index == 3
            use = 15000 + num * 15000
        endif
        if  use > 1000000
            use = 1000000
        endif
        return use
    endfunction
    //设置抽技能说明
    function RePlayerAbilityDrawTips(int pid,int index)
        int id = 'IS00' + index
        int num = GetPlayerDrawNum(pid,index)
        int use1 = GetPlayerDrawUse(pid,index,1)
        if  GetLocalPlayer() == Player(pid)
            if  num > 0
                YDWESetItemDataString(id,3,"学习或重置当前|cffffd24d"+SubString(GetObjectName(id),6,7)+"技能|r。|n|cffffcc00抽取消耗：|r"+I2S(use1)+"金币*次数|n|cffffcc00抽取次数：|r"+I2S(num)+"/10|n|n|cff00ff7f单局最多抽取10次|r")
            endif
        endif
    endfunction
    //抽技能
    function PlayerAbilityDraw(int pid,int itemid)
        int index = itemid - 'IS00'
        int num = GetPlayerDrawNum(pid,index)
        int use1 = GetPlayerDrawUse(pid,index,num+1)
        int use2 = 0
        /*
        if  num > 0
            use2 = 1
        endif
        */
        if  num < 10
            if  use1 > 0
                if  GetPlayerState(Player(pid), PLAYER_STATE_RESOURCE_LUMBER) >= use2
                    if  GetPlayerState(Player(pid), PLAYER_STATE_RESOURCE_GOLD) >= use1
                        AdjustPlayerStateBJ(-use1, Player(pid), PLAYER_STATE_RESOURCE_GOLD )

                        //AdjustPlayerStateBJ(-use2, Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
                        PlayerUseLearnAbilityBook(pid,index,GetExpectLevel(pid,index))
                        AddPlayerDrawNum(pid,index)
                        RePlayerAbilityDrawTips(pid,index)
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r|Cff00FF7FQ技能|r抽取次数"+I2S(num+1)+"/10")
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r抽取失败！金币不足"+I2S(use1)+"。")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r抽取失败！玄铁不足"+I2S(use2)+"。")
                endif
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r抽取次数已达到上限！")
        endif
    endfunction
    

    



    

    function PlayerHeroSkillMagic(unit wu,int index,int prizeid,int itemid)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        
        if  GetTypeIdData(GetHeroAbilityID(Pu[1],index),101) == 9
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r该位置未学习技能，无法附魔！")
            UnitAddItem(wu,CreateItem(itemid,GetUnitX(wu),GetUnitY(wu)))
        else
             PlayerHeorAddSkillMagic(pid,index, GetPoolItemId(prizeid))
        endif


    endfunction
    

    //读取饰品
    function GetHeroOrnamentsItem(unit wu)->item
        int id = 0
        for n = 0,5
            id = GetItemTypeId(UnitItemInSlot(wu,n))
            if  id >= 'E101' and id <= 'E124'
                return UnitItemInSlot(wu,n)
            endif
        end
        return null
    endfunction
    //手动升级饰品
    function IncOrnaments(int pid,unit wu)
        item it = GetHeroOrnamentsItem(wu)
        int next = 0
        int id = 0
        int use = 0
        if  it != null
            id = GetItemTypeId(it)
            if  id >= 'E101' and id <= 'E110'
                use = 10000
            elseif  id >= 'E111' and id <= 'E120'
                use = 20000
            else
                use = 50000
            endif
            if  GetPlayerState(Player(pid), PLAYER_STATE_RESOURCE_GOLD)>=use
                AdjustPlayerStateBJ(-use, Player(pid), PLAYER_STATE_RESOURCE_GOLD )
                next = GetTypeIdData(id,106)
                RemoveItem(it)
                UnitAddItem(wu,CreateItem(next,GetUnitX(wu),GetUnitY(wu)))
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：恭喜您成功将" + GetObjectName(id) + "晋升为" + GetObjectName(next))
            else    
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r附魔失败！金币不足"+I2S(use))
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r背包内没有可升级的饰品！")
        endif

        flush locals
    endfunction

    //升级加血技能
    function IncHeroAddLifeAbility(int pid)
        int lv = GetUnitAbilityLevel(Pu[1],'AG06')
        int use = lv * 150 + 150
        if  lv < 10
            if  GetUnitIntState(Pu[1],108)>=use
                AddUnitIntState(Pu[1],108,-use)
                SetUnitAbilityLevel(Pu[1],'AG06',lv+1)
                AddUnitRealState(Pu[1],45,30)
                LocAddEffect(GetUnitX(Pu[1]),GetUnitY(Pu[1]),"effect_e_buffyellow2.mdl")
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r升级成功！")
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r升级失败！杀敌数不足"+I2S(use))
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff000[系统]：|r升级失败！该技能已经满级！")
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


    
    
    function PickupItemActions()
        unit u1 = GetTriggerUnit()
        int itemid = GetItemTypeId(GetManipulatedItem())
        int pid = GetPlayerId(GetOwningPlayer(u1))
        int i1 = 0
        int i2 = 0
        real r1 = 0
        int level = GetItemLevel(GetManipulatedItem())
        int attacklv = AttackUnitWN + 1

        


        if  GetItemType(GetManipulatedItem()) == ITEM_TYPE_ARTIFACT
            AddEquipState(u1,itemid)
            FormulaVerify()

            if  IsUnitHasItemLevel(u1,GetManipulatedItem(),level) == true
                UnitRemoveItem(u1,GetManipulatedItem())
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：无法携带相同类型物品！|r")
            endif

        elseif  GetItemType(GetManipulatedItem()) == ITEM_TYPE_CHARGED
            AddItemCharges(u1,GetManipulatedItem())
        else
            FormulaVerify()
        endif
        
        
        if  itemid == 'IP01'
            SetPlayerPlotPartNum(pid,GetPlayerPlotPartNum(pid)+1)
        elseif  itemid == 'IP02'
            SetPlayerMagicItemResources(pid,1,GetPlayerMagicItemResources(pid,1)+1)
            ReCollectFrameResources(pid)
        elseif  itemid == 'IP03'
            SetPlayerMagicItemResources(pid,2,GetPlayerMagicItemResources(pid,2)+1)
            ReCollectFrameResources(pid)
        elseif  itemid >= 'IJ01' and itemid <= 'IJ10'
            //AddPlayerImmortalFruit(u1,itemid)
        elseif  itemid >= 'IT01' and itemid <= 'IT15'
            PlayerHeroMoveToImmortal(u1,itemid)
        elseif  itemid >= 'IS01' and itemid <= 'IS03'
            PlayerAbilityDraw(pid,itemid)
        elseif  itemid == 'IS11'
            AstrologyFunc(pid)
        elseif  itemid == 'IS13'
            IncOrnaments(pid,u1)
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
        elseif  itemid == 'IZ01'
            if  GameLevel >= 2
                if  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER) >= 2000
                    OpenGameTeamChallenge(pid,1,20)
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r玄铁不足2000！")
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r难度2或以上才能激活团本哦！！！")
            endif
        elseif  itemid >= 'IC00' and itemid <= 'IC11'
            if  itemid == 'IC00'
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffff0000[系统]：很遗憾！什么也没有得到！|r")
            else
                if  itemid == 'IC01'
                    i1 = R2I((2.0+attacklv/2.0)*GetRandomReal(0.8,1.2))
                    AdjustPlayerStateBJ(i1, Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r恭喜玩家"+GetPlayerNameOfColor(pid)+"通过抽奖获得 |cffffcc00玄铁x"+I2S(i1))
                elseif  itemid == 'IC02'
                    i1 = R2I((10.0+attacklv*5.0)*GetRandomReal(0.8,1.2))
                    AddUnitIntState(Pu[1],108,i1)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r恭喜玩家"+GetPlayerNameOfColor(pid)+"通过抽奖获得 |cffffcc00杀敌数x"+I2S(i1))
                else
                    r1 = (attacklv*attacklv*3+attacklv*300.0)*GetRandomReal(0.8,1.2)
                    if  itemid >= 'IC03' and itemid <= 'IC05'
                        r1 = r1 / 4
                        if  itemid == 'IC04'
                            r1 = r1 * 3
                        elseif  itemid == 'IC05'
                            r1 = r1 * 9
                        endif
                        AddUnitRealState(Pu[1],1,r1)
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r恭喜玩家"+GetPlayerNameOfColor(pid)+"通过抽奖获得 |cffffcc00攻击力x"+I2S(R2I(r1)))
                    elseif  itemid >= 'IC06' and itemid <= 'IC08'
                        if  itemid == 'IC07'
                            r1 = r1 * 3
                        elseif  itemid == 'IC08'
                            r1 = r1 * 9
                        endif
                        AddUnitRealState(Pu[1],5,r1)
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r恭喜玩家"+GetPlayerNameOfColor(pid)+"通过抽奖获得 |cffffcc00生命值x"+I2S(R2I(r1)))
                    elseif  itemid >= 'IC09' and itemid <= 'IC11'
                        r1 = r1 / 20
                        if  itemid == 'IC10'
                            r1 = r1 * 3
                        elseif  itemid == 'IC11'
                            r1 = r1 * 9
                        endif
                        AddUnitRealState(Pu[1],2,r1)
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r恭喜玩家"+GetPlayerNameOfColor(pid)+"通过抽奖获得 |cffffcc00业力x"+I2S(R2I(r1)))
                    endif
                endif

            endif
        endif


        if  itemid >= 'IN07' and itemid <= 'IN24'
            PlayerUsesstrangeItem(pid,itemid)
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
        if  (itemid >= 'IB00' and itemid <= 'IB09') or (itemid >= 'IB50' and itemid <= 'IB59')
            PlayerGetGameGift(pid,itemid)
        endif

        if  itemid == 'IP07'
            PickUpItemOfIP07(u1,GetUnitX(u1),GetUnitY(u1))
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

        if  itemid == 'CS01'
            PlayerUseLearnAbilityBook(pid,1,GetExpectLevel(pid,1))
            AddPlayerDrawNum(pid,1)
            RePlayerAbilityDrawTips(pid,1)
        elseif  itemid >= 'CS21' and itemid <= 'CS24'
            PlayerUseIncAbilityGem(u1,itemid)
        elseif  itemid >= 'IS21' and itemid <= 'IS23'
            PlayerHeroSkillMagic(u1,itemid - 'IS20',1,itemid)
        elseif  itemid >= 'IS24' and itemid <= 'IS26'
            PlayerHeroSkillMagic(u1,itemid - 'IS23',2,itemid)


        elseif  itemid >= 'E001' and itemid <= 'E024'
            IncEquipFunc(u1,GetManipulatedItem())
        elseif  itemid >= 'E201' and itemid <= 'E224'
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

        elseif  itemid == 'IN31'//炽星魔盒IN31注册
            if  attacklv <= 11
                UnitAddPoolItemShow(u1,11)
            else
                UnitAddPoolItemShow(u1,17)
            endif
        elseif  itemid == 'IN25'//入门道果箱IN25注册
            UnitAddPoolItemShow(u1,12)
        elseif  itemid == 'IN26'//后天道果箱IN26注册
            UnitAddPoolItemShow(u1,13)
        elseif  itemid == 'IN27'//先天道果箱IN27注册
            UnitAddPoolItemShow(u1,14)
        elseif  itemid == 'IN30'//幸运星盒IN30注册
            PickUpItemOfIN30(u1,GetUnitX(u1),GetUnitY(u1))
            UnitAddPoolItemShow(u1,15)
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
            if  GetUnitIntState(Pu[1],150) < MaxHeroLevel
                AddImmortalFruit(Pu[1],itemid - 'ID00' + 'IJ00',0)
            else
                UnitAddItem(u1,CreateItem(itemid,GetUnitX(u1),GetUnitY(u1)))
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r等级已满，无法晋升境界！")
            endif
        elseif  itemid >= 'ID11' and itemid <= 'ID20'//道果
            if  GetUnitIntState(Pu[1],150) < MaxHeroLevel
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
        elseif  itemid == 'IP06'
            HeroAddExp( Pu[1], 100)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r您使用了"+GetObjectName(itemid)+",境界经验+100")
        elseif  itemid == 'IP07'
            if  attacklv <= 11
                UnitAddPoolItemShow(u1,11)
            else
                UnitAddPoolItemShow(u1,17)
            endif
        elseif  itemid == 'IP08'
            HeroAddExp( Pu[1], 300)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r您使用了"+GetObjectName(itemid)+",境界经验+300")
        elseif  itemid == 'IP09'
            HeroAddExp( Pu[1], 500)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r您使用了"+GetObjectName(itemid)+",境界经验+500")
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
    end
endscope

