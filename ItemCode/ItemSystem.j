scope ItemSystem initializer InitItemSystem
    

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
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r装备"+GetObjectName(itemid)+"突破成功！")
                if  next == 'E006' or next == 'E106' or next == 'E206'
                    if  Pu[24] == null
                        Pu[24] = CreateUnit(Player(pid),'np04',AttackRoomPostion[pid][1]+512,AttackRoomPostion[pid][2]-256,270)//副本入口
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
        
        if  next > 0
            if  IsCanMoveToRoom(pid) == true
                if  GetPlayerState(Player(pid), PLAYER_STATE_RESOURCE_GOLD)>=gold
                    if  uid > 0
                            index = GetEquipIndex(id)
                            if  index != 0
                                if  GetUnitTypeId(Pu[100+index]) == 0
                                    AdjustPlayerStateBJ(-gold, Player(pid), PLAYER_STATE_RESOURCE_GOLD )


                                    Pu[100+index] = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),uid,AttackRoomPostion[pid][1]-512,AttackRoomPostion[pid][2]+384,270)
                                    
                                    SetPlayerOnlyDamage(Pu[100+index],pid)
                                    IssuePointOrderById( Pu[100+index], 851983, AttackRoomPostion[pid][1], AttackRoomPostion[pid][2] )
                                    HeroMoveToRoom(pid)

                                else
                                    HeroMoveToRoom(pid)
                                    if  id >= 'E001' and id <= 'E025'
                                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]:|r武器晋升正在挑战中！")
                                    elseif  id >= 'E101' and id <= 'E125'
                                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]:|r法杖晋升正在挑战中！")
                                    elseif  id >= 'E201' and id <= 'E225'
                                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]:|r护甲晋升正在挑战中！")
                                    endif
                                endif
                            endif
                    else
                        AdjustPlayerStateBJ(-gold, Player(pid), PLAYER_STATE_RESOURCE_GOLD )
                        RemoveItem(it)
                        UnitAddItem(u1,CreateItem(next,GetUnitX(u1),GetUnitY(u1)))
                        UnitAddEffect(Pu[1],"effect_e_buffyellow2.mdx")
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r装备"+GetObjectName(id)+"升级成功！")
                    endif
                else
                    
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r升级失败！金币不足"+I2S(gold))
                endif
            else   
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r当前无法升级装备")
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
        if  index == 1
            use = 50 * num
            if  use > 150
                use = 150
            endif
        elseif  index == 2
            use = 100 * num
            if  use > 300
                use = 300
            endif
        elseif  index == 3
            use = 360 * num
        elseif  index == 4
            use = 1080 * num
        endif
        return use
    endfunction
    function RePlayerAbilityDrawTips(int pid,int index)
        int id = 'IS00' + index
        int num = GetPlayerDrawNum(pid,index)
        int use = GetPlayerDrawUse(pid,index,num+1)
        if  GetLocalPlayer() == Player(pid)
            YDWESetItemDataString(id,2,GetObjectName(id)+"[ 第"+I2S(num)+"次 ]")
            YDWESetItemDataString(id,3,"需要"+I2S(use)+"杀敌数")
        endif
    endfunction
    //抽技能
    function PlayerAbilityDraw(int pid,int itemid)
        int index = itemid - 'IS00'
        int num = GetPlayerDrawNum(pid,index)
        int use = GetPlayerDrawUse(pid,index,num+1)
        if  use > 0
            if  GetPlayerState(Player(pid), PLAYER_STATE_RESOURCE_LUMBER)>=use

                AdjustPlayerStateBJ(-use, Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
                PlayerUseLearnAbilityBook(pid,index + 'CS00')
                AddPlayerDrawNum(pid,index)
                RePlayerAbilityDrawTips(pid,index)
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r抽取失败！杀敌数不足"+I2S(use))
            endif
        endif
    endfunction
    
    //抽兽魂
    function IsHasBeastSoul(int pid,int index)->bool
        int num = GetUnitIntState(Pu[1],190)
        if  num == 0
            return false
        else
            for i = 1,num
                if  GetUnitIntState(Pu[1],190+i) == index
                    return true
                endif
            end
        endif
        return false
    endfunction
    function PlayerBeastSoulDraw(int pid,int itemid)
        int index = itemid - 'IH00'
        int num = GetUnitIntState(Pu[1],190)
        if  num < 3
            if  true
                if  IsHasBeastSoul(pid,index) == false
                    SetUnitIntState(Pu[1],190+num + 1,index)
                    SetUnitIntState(Pu[1],190,num + 1)
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r"+GetObjectName(itemid)+"抽取成功")
                    if  num == 2
                        int id = GetUnitIntState(Pu[1],190+GetRandomInt(1,3)) + 'S230'
                        HeroAddAbilityByIndex(Pu[1],4,id)
                    endif
                    UnitAddAbility(Pu[1],'M006'+num)
                else
                    BJDebugMsg("重复的")
                endif
            endif
            
        endif

    endfunction








    
                     

    function UnitUseSilkBag(unit wu,int itemid)//使用锦囊
        int pid = GetPlayerId(GetOwningPlayer(wu))
        if  itemid == 'IN00'
            UnitAddPoolItem(wu,1)
        else
            if  itemid == 'IN01'
                if  GetTypeIdData(GetHeroAbilityID(wu,1),101) == 9
                    UnitAddItem(wu,CreateItem(itemid,GetUnitX(wu),GetUnitY(wu)))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r未学习Q技能，无法附魔！")
                else
                    PlayerHeorAddSkillMagic(pid,1,GetPoolItemId(2))
                endif
            elseif  itemid == 'IN02'
                if  GetTypeIdData(GetHeroAbilityID(wu,2),101) == 9
                    UnitAddItem(wu,CreateItem(itemid,GetUnitX(wu),GetUnitY(wu)))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r未学习W技能，无法附魔！")
                else
                    PlayerHeorAddSkillMagic(pid,2,GetPoolItemId(2))
                endif
            elseif  itemid == 'IN03'
                if  GetTypeIdData(GetHeroAbilityID(wu,3),101) == 9
                    UnitAddItem(wu,CreateItem(itemid,GetUnitX(wu),GetUnitY(wu)))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r未学习E技能，无法附魔！")
                else
                    PlayerHeorAddSkillMagic(pid,3,GetPoolItemId(2))
                endif
            elseif  itemid == 'IN07'

                AddUnitStateExTimer(Pu[1],28,30,6)
            elseif  itemid == 'IN08'
                if  AttackUnitWN >= AttackUnitWNOver - 2
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r当前无法使用该锦囊！")
                else
                    KillAttackUnitGroup()
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r您使用了锦囊"+GetObjectName(itemid)+"，消灭了所有的进攻怪！")
                endif
            elseif  itemid == 'IN09'
                //IN09	我刷一会	暂停场上已存在的进攻怪10秒
            elseif  itemid == 'IN10'
                //IN10	我再刷会	暂停场上已存在的进攻怪20秒
            elseif  itemid == 'IN11'
                AddUnitStateExTimer(Pu[1],17,300,5)
            elseif  itemid == 'IN12'
                AdjustPlayerStateBJ(20000, Player(pid), PLAYER_STATE_RESOURCE_GOLD )
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r您使用了锦囊"+GetObjectName(itemid)+",金币+20000")
            elseif  itemid == 'IN13'
                AdjustPlayerStateBJ(2000, Player(pid), PLAYER_STATE_RESOURCE_GOLD )
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r您使用了锦囊"+GetObjectName(itemid)+",金币+2000")
            elseif  itemid == 'IN14'
                /*
                IN14	精准预判	"使用后5秒内基地触发无敌，则击杀其600码范围内所有生物。
                （不分敌我）"*/
            elseif  itemid == 'IN15'
                SetPlayerMagicItemResources(pid,1,GetPlayerMagicItemResources(pid,1)+1)
                ReCollectFrameResources(pid)
            elseif  itemid == 'IN16'
                SetPlayerMagicItemResources(pid,2,GetPlayerMagicItemResources(pid,2)+1)
                ReCollectFrameResources(pid)
            elseif  itemid == 'IN17' 
                AdjustPlayerStateBJ(3000, Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r您使用了锦囊"+GetObjectName(itemid)+",杀敌数+3000")
            elseif  itemid == 'IN18'
                AdjustPlayerStateBJ(300, Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r您使用了锦囊"+GetObjectName(itemid)+",杀敌数+300")
            endif
        endif
    endfunction

    function UnitUseStarSoul(unit wu,int itemid)//使用星魂
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int kill = GetTypeIdData(itemid,103)
        int gl = 0
        if  kill == 0
            //必定出锦囊
            gl = 100
        else
            if  itemid >= 'INDA' and itemid <= 'INDE'
                gl = 40
            elseif  itemid >= 'INDG' and itemid <= 'INDK'
                gl = 50
            elseif  itemid >= 'INDM' and itemid <= 'INDQ'
                gl = 60
            elseif  itemid >= 'INDS' and itemid <= 'INDW'
                gl = 70
            endif
        endif
        
        if  GetRandomInt(1,100) <= gl
            UnitAddItem(wu,CreateItem('IN00',GetUnitX(wu),GetUnitY(wu)))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r您使用了星宿之魂，获得锦囊x1")
        else 
            kill = R2I(I2R(kill) * GetRandomReal(0.6,1))
            AdjustPlayerStateBJ(kill, Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r您使用了星宿之魂，获得杀敌数x"+I2S(kill))
        endif
    endfunction
    
    
    
    
    function PickupItemActions()
        unit u1 = GetTriggerUnit()
        int itemid = GetItemTypeId(GetManipulatedItem())
        int pid = GetPlayerId(GetOwningPlayer(u1))
        int i1 = 0
        
        if  GetItemType(GetManipulatedItem()) == ITEM_TYPE_ARTIFACT
            AddEquipState(u1,itemid)
            FormulaVerify()
        elseif  GetItemType(GetManipulatedItem()) == ITEM_TYPE_CHARGED
            AddItemCharges(u1,GetManipulatedItem())
        else
            FormulaVerify()
        endif
        
        
        if  itemid == 'IP01'
            SetPlayerPlotPartNum(pid,GetPlayerPlotPartNum(pid)+1)
        elseif  itemid >= 'IJ01' and itemid <= 'IJ10'
            AddPlayerImmortalFruit(u1,itemid)
        elseif  itemid >= 'IT01' and itemid <= 'IT15'
            PlayerHeroMoveToImmortal(u1,itemid)
        elseif  itemid >= 'IS01' and itemid <= 'IS05'
            PlayerAbilityDraw(pid,itemid)
        elseif  itemid == 'IS11'
            AstrologyFunc(pid)
        elseif  itemid >= 'IH01' and itemid <= 'IH08'
            PlayerBeastSoulDraw(pid,itemid)

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

        if  itemid >= 'CS01' and itemid <= 'CS05'
            PlayerUseLearnAbilityBook(pid,itemid)
        elseif  itemid >= 'E001' and itemid <= 'E024'
            IncEquipFunc(u1,GetManipulatedItem())
        elseif  itemid >= 'E101' and itemid <= 'E124'
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
            AddUnitStateExTimer(Pu[1],9,60,15)
            LocAddEffect(GetUnitX(u1),GetUnitY(u1),"effect_e_buffyellow2.mdl")
        elseif  itemid == 'I004'
            AddUnitStateExTimer(Pu[1],15,40,15)
            LocAddEffect(GetUnitX(u1),GetUnitY(u1),"effect_e_buffattack.mdl")
        elseif  itemid == 'I005'
            AddUnitStateExTimer(Pu[1],16,40,15)
            LocAddEffect(GetUnitX(u1),GetUnitY(u1),"effect_e_buffattack.mdl")
        elseif  itemid >= 'IN00' and itemid <= 'IN18'
            UnitUseSilkBag(u1,itemid)
        elseif  itemid >= 'INDA' and itemid <= 'INDX'
            UnitUseStarSoul(u1,itemid)
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

