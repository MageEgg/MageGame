scope SelectHero
    
    function IsPlayerHasHero(player p,int uid)->boolean
        int id = uid + 0x3000000
        if  IsPlayerHasTech(p,id) == true
            return true
        else
            DisplayTimedTextToPlayer(p,0,0,5,"|cffffcc00[系统]：|r无法选择"+GetObjectName(uid)+","+GetObjectName(id))
            return false
        endif
        
    endfunction


    //存档读属性的都放这里  找完姜子牙加载
    function SelectHeroAddSaveState(int pid)

        UnitAddAbility(Pu[1],'AG0A')//F5 F6
        UnitAddAbility(Pu[1],'AG0B')

        InitPlayerDzShopState.execute(pid)//商城属性

        InitPlayerMeridiansState.execute(pid)//经脉

        LoadPlayerTechState.execute(pid)//读取存档属性

        PlayerLoadPassCheck.execute(pid)//读取通行证

        /*if  SubString(GetPlayerName(Player(pid)),0,9) == "星耀丶"
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]：|r欢迎星耀成员"+GetPlayerColorEx(pid)+GetPN(pid)+"，奖励木材1000！")
            AdjustPlayerStateBJ(1000, Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
        endif*/


        

        
        
                

    endfunction


    //通用的都放这里
    function SelectHeroInitSkill(int pid)
        if  Player(pid)==GetLocalPlayer()
            SetPlayerCameraBoundsToRect(bj_mapInitialPlayableArea)
            PanCameraToTimed(PlayerReviveX,PlayerReviveY, 0 )
            SetCameraField( CAMERA_FIELD_TARGET_DISTANCE, 2200.00, 2.0)
            SetCameraField( CAMERA_FIELD_FARZ, 10000.00, 2.0 )
            ClearSelection()
            SelectUnit(Pu[1],true)

            DzFrameShow(BUTTON_Back[702][0], true)
        endif


        SetUnitRealState(Pu[1],5,1000)

        UnitAddAbility(Pu[1],'MF01')//魔法书

        UnitAddAbility(Pu[1],'AG01')
        UnitAddAbility(Pu[1],'AG02')
        //UnitAddAbility(Pu[1],'AG03')
        UnitAddAbility(Pu[1],'AG04')
        UnitAddAbility(Pu[1],'AG05')

        UnitAddAbility(Pu[1],'AG06')
        
        UnitAddAbility(Pu[1],'AG08')
        
        

        HeroAddAbilityByIndex(Pu[1],1,'S0Q1')
        HeroAddAbilityByIndex(Pu[1],2,'S0W1')
        //HeroAddAbilityByIndex(Pu[1],3,'S0E1')
        HeroAddAbilityByIndex(Pu[1],4,'S0R0')
        
        HeroAddAbilityByIndex(Pu[1],5,'S500'+(GetUnitTypeId(Pu[1])-'H000'))
        
        InitHeroAddStateAbility.execute(Pu[1])//读取百分比属性技能
        
        InitPlayerMonsterSoulSkill(pid)

        ShowPlayerSignInLastTime(pid) //登陆刷新

        int dzlv = GetDzHeroExpLevel(pid,GetUnitTypeId(Pu[1]))
        if  dzlv >= 1
            AddUnitRealState(Pu[1],17,5)
        endif
        if  dzlv >= 2
            AddUnitRealState(Pu[1],18,3)
        endif
        if  dzlv >= 3
            AddUnitRealState(Pu[1],18,4)
        endif
        /*
        if  dzlv >= 4
            AddUnitRealState(Pu[1],17,10)
        endif
        if  dzlv >= 5
            AddUnitRealState(Pu[1],19,5)
        endif
        */
    endfunction

   
    //正常选英雄
    function SelectHeroPrePareFunc(int pid,unit hero)
        if  IsPlaying(pid) == true
            
            
            Pu[1] = hero
            
            Pu[2] = CreateUnit(Player(pid),'hZ00',AttackRoomPostion[pid][1],AttackRoomPostion[pid][2],0)
            
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]：|r"+GetPlayerColorEx(pid)+GetPN(pid)+"|r选择了|cffffcc00"+GetUnitName(Pu[1])+"|r！")
            
            SelectHeroInitSkill(pid)//加载必要技能

            GameChallenge_0Start(pid)//加载新手任务

            ReTechFuncItemTips.execute(pid)//刷新道具兑换说明

            for i = 1,GameLevel
                SetPlayerTechResearched(Player(pid),'KNDA'+i-1,1)
            end

            //重随次数
            HeroReNumber = 1
            if  GetPlayerTechCount(Player(pid),'RY1D',true) > 0
                HeroReNumber = HeroReNumber + 1
            endif

            
        endif
    endfunction

    //重新选英雄
    function ReHeroPrePareFunc(int pid,int id)
        if  IsPlaying(pid) == true

            Pu[7] = Pu[1]
            Pu[1] = CreateUnit(Player(pid),id,PlayerReviveX,PlayerReviveY,0)
            
            for n = 10,41
                SetUnitRealState(Pu[1],n,GetUnitRealState(Pu[1],n))
            end
            for i = 0,5
                UnitAddItem(Pu[1],UnitItemInSlot(Pu[7],i))
            end
            RemoveUnit(Pu[7])
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]：|r"+GetPlayerColorEx(pid)+GetPN(pid)+"|r重新选择了|cffffcc00"+GetUnitName(Pu[1])+"|r！")

            SelectHeroInitSkill(pid)//加载必要技能
            
        endif
    endfunction
    
    
    function InitSelectHero()
        for pid = 0,3
            if  IsPlaying(pid) == true
                PlayerReviveX = -5120
                PlayerReviveY = -2976
                SelectHeroPrePareFunc(pid,PlaceRandomUnit( HeroPool, Player(pid),PlayerReviveX,PlayerReviveY,0 ))
            endif
        end
    endfunction
endscope
