scope ItemSystem initializer InitItemSystem
    
    
    
    
    
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
        
        
        DBUG("666")
        if  itemid >= 'I00A'  and itemid <= 'I00Z'
                if  AttackRoomTimer==false
                DBUG("678")
                AttackRoomUid = itemid - 'I00A' + 'g00A'
                RefreshAttackRoom(pid,AttackRoomUid)
            else
                AttackRoomUid =  itemid - 'I00A' + 'g00A'
            endif
        elseif  itemid == 'IP01'
            SetPlayerPlotPartNum(pid,GetPlayerPlotPartNum(pid)+1)
        elseif  itemid >= 'IJ01' and itemid <= 'IJ10'
            AddPlayerImmortalFruit(u1,itemid)
        elseif  itemid >= 'IT01' and itemid <= 'IT15'
            PlayerHeroMoveToImmortal(u1,itemid)
        endif
        
       
         
        if  IsItemPowerup(GetManipulatedItem()) == true //清除
            
            RemoveItem(GetManipulatedItem())
        endif
        
        flush locals
    endfunction
    
 
    function IncEquipFunc(unit u1,item it)
        int pid = GetPlayerId(GetOwningPlayer(u1))
        int id = GetItemTypeId(it)
        int gold = GetTypeIdData(id,103)
        int next = GetTypeIdData(id,106)
        if  next > 0
            if  GetPlayerState(Player(pid), PLAYER_STATE_RESOURCE_GOLD)>=gold
                AdjustPlayerStateBJ(-gold, Player(pid), PLAYER_STATE_RESOURCE_GOLD )
                RemoveItem(it)
                UnitAddItem(u1,CreateItem(next,GetUnitX(u1),GetUnitY(u1)))
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]:|r升级成功！")
            else
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]:|r升级失败！金币不足"+I2S(gold))
            endif
        endif
    endfunction
    
    function UseItemActions()
        unit u1 = GetTriggerUnit()
        int itemid = GetItemTypeId(GetManipulatedItem())
        int pid = GetPlayerId(GetOwningPlayer(u1))
        int gold = 0
        int i1 = 0

        if  itemid >= 'CS01' and itemid <= 'CS04'
            PlayerUseLearnAbilityBook(pid,itemid)
        elseif  itemid >= 'E001' and itemid <= 'E024'
            IncEquipFunc(u1,GetManipulatedItem())
        elseif  itemid >= 'E101' and itemid <= 'E124'
            IncEquipFunc(u1,GetManipulatedItem())
        elseif  itemid >= 'E201' and itemid <= 'E224'
            IncEquipFunc(u1,GetManipulatedItem())
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

