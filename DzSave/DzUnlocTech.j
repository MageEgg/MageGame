library UnlocTech initializer InitAllUnlocTech uses DamageCode
    
    int Unloc_Type_Level = 1
    int Unloc_Type_Load  = 2
    int Unloc_Type_Group = 3
    int Unloc_Type_Blue  = 4
    int Unloc_Type_Shop  = 5
    int Unloc_Type_JF    = 6
    int Unloc_Type_API   = 7
    int Unloc_Type_Dad   = 8
    
    int array UnlocTechData_TechId
    int UnlocTechData_index = 0
        
    scope UnlocTechGameData
        private int array Data_list
        private int array Data_pos
        private int array Data_data
        
        private int array Data_UseList
        private int array Data_UsePos
        private int array Data_Use
        
        private int Data_index = 0
        
        function GameDataList(int list,int pos,int data)->int
            Data_index = Data_index + 1
            
            Data_pos[Data_index]  = pos
            Data_list[Data_index] = list
            Data_data[Data_index] = data
            return Data_index
        endfunction
        
        function GameDataCanUnloc(int pid,int index)->bool
            int list = Data_list[index]
            int data = Data_data[index]
            int pos  = Data_pos[index]
            return GetDzPlayerData(pid,list,pos) == data
        endfunction
        function JFCanUnloc(int pid,int index)->bool
            int list = Data_list[index]
            int data = Data_data[index]
            int pos  = Data_pos[index]
            BJDebugMsg("积分"+I2S(GetDzPlayerData(pid,list,pos)))
            return GetDzPlayerData(pid,list,pos) >= data
        endfunction
    endscope
    
    
    scope UnlocTechShop
        private string array Data_Shop
        private int Data_index = 0
        function ShopList(string shop)->int
            Data_index = Data_index + 1
            Data_Shop[Data_index]=shop
            return Data_index
        endfunction
        function ShopCanUnloc(int pid,int index)->bool
            return DzShop(Player(pid),Data_Shop[index])==true
        endfunction
        
        function AllShopUnloc(int pid)->bool
            if  DzShop(Player(pid),"RWK")==false
                return false
            endif
            
            return true
        endfunction
        
    endscope
    
    scope UnlocTechGroup
        private string array Data_Group
        private int array Data_Level
        private int Data_index = 0
        function GroupList(string Group,int level)->int
            Data_index = Data_index + 1
            Data_Group[Data_index]=Group
            Data_Level[Data_index]=level
            return Data_index
        endfunction
        function GroupCanUnloc(int pid,int index)->bool
            
            if  DzAPI_Map_GetGuildName(Player(pid))==Data_Group[index]
                return DzAPI_Map_GetGuildRole(Player(pid)) >=  Data_Level[index]
            endif
            return false
        endfunction
    endscope
    
    scope LocalTechCond
        private int array Data_Type
        private int array Data_Data
        private int array Data_Cond
        function LoadUnlocTechCond(int id,int index)
            int listid = 0
            
            if  index != 0
                listid = index+Data_Cond[index]*10
                //BJDebugMsg("listid:"+I2S(listid))
                SetTypeIdData(id,500+listid,Data_Type[index])
                SetTypeIdData(id,600+listid,Data_Data[index])
                Data_Cond[index]= 0
                Data_Type[index]= 0
                Data_Data[index]= 0
            endif
            
        endfunction
        
        function InitCond1(int cond,int typeid,int data)->int
            int index = 1
            
            Data_Cond[index]= cond
            Data_Type[index]= typeid
            Data_Data[index]= data
            
            return index
        endfunction
        function InitCond2(int cond,int typeid,int data)->int
            int index = 2
            Data_Cond[index]= cond
            Data_Type[index]= typeid
            Data_Data[index]= data
            return index
        endfunction
        function InitCond3(int cond,int typeid,int data)->int
            int index = 3
            Data_Cond[index]= cond
            Data_Type[index]= typeid
            Data_Data[index]= data
            return index
        endfunction
        function InitCond4(int cond,int typeid,int data)->int
            int index = 4
            Data_Cond[index]= cond
            Data_Type[index]= typeid
            Data_Data[index]= data
            return index
        endfunction
        function InitCond5(int cond,int typeid,int data)->int
            int index = 5
            Data_Cond[index]= cond
            Data_Type[index]= typeid
            Data_Data[index]= data
            return index
        endfunction
    endscope
    
    
    
    function IsConditionsUnloc(int pid,int Type,int data)->bool
        if  Type == Unloc_Type_Level
            BJDebugMsg("等级判断 需求："+I2S(data))
            return DzPlayerLv(Player(pid))>= data
        elseif  Type == Unloc_Type_Load
            return GameDataCanUnloc(pid,data) == true
        elseif  Type == Unloc_Type_Group
            return GroupCanUnloc(pid,data) == true
        elseif  Type == Unloc_Type_Blue
            return DzAPI_Map_IsBlueVIP(Player(pid)) == true
        elseif  Type == Unloc_Type_Shop
            return ShopCanUnloc(pid,data)==true
        elseif  Type == Unloc_Type_JF
            BJDebugMsg("积分判断 需求："+I2S(data))
            return JFCanUnloc(pid,data)==true
        elseif  Type == Unloc_Type_API
            return DzConA[data] == 1
        elseif  Type == Unloc_Type_Dad
            return AllShopUnloc(pid)==true
        endif
        return false
    endfunction
    
    function IsPlayerUnlocTech(int pid,int id)->bool
        int Type = 0
        int data = 0
        

        
        
        
        //绝对条件
        for i = 1,5
            Type =  GetTypeIdData(id,520+i)
            if  Type > 0
                //BJDebugMsg("绝对条件")
                data = GetTypeIdData(id,620+i)
                if  IsConditionsUnloc(pid,Type,data) == true
                    return true
                endif
            endif
        end
        
        
        //必要条件
        for i = 1,5
            Type =  GetTypeIdData(id,510+i)
            if  Type > 0
                //BJDebugMsg("必要条件")
                data = GetTypeIdData(id,610+i)
                if  IsConditionsUnloc(pid,Type,data) == false
                    return false
                endif
            endif
        end
        
        
        for i = 1,5
            Type =  GetTypeIdData(id,500+i)
            if  Type > 0
                //BJDebugMsg("通用条件")
                data = GetTypeIdData(id,600+i)
                if  IsConditionsUnloc(pid,Type,data) == true
                    return true
                endif
            endif
        end
            
        
        return false
    endfunction
    
    
    
    
    
    function LoadPlayerTechState(int pid)
        int id = 0
        for i = 1,UnlocTechData_index
            id = UnlocTechData_TechId[i]
            if  IsPlayerHasTech(Player(pid),id) == true
                AddEquipState(Pu[1],id)
            endif
        end
    endfunction
    

    function LoadPlayerAllUnlocTech(int pid)
        if  GetPlayerController(Player(pid)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(pid)) == PLAYER_SLOT_STATE_PLAYING
            for i = 1,UnlocTechData_index
                if  IsPlayerUnlocTech(pid,UnlocTechData_TechId[i]) == true
                    SetPlayerTechResearched(Player(pid),UnlocTechData_TechId[i],1)
                    BJDebugMsg("unlock"+GetObjectName(UnlocTechData_TechId[i]))
                else
                    //BJDebugMsg("lock"+I2S(UnlocTechData_TechId[i]))
                endif
            end
        endif
    endfunction
    
    
    function InitUnlocTechConditions(int id,int Cond1,int Cond2,int Cond3,int Cond4,int Cond5)
        UnlocTechData_index = UnlocTechData_index + 1
        UnlocTechData_TechId[UnlocTechData_index] = id
        
        
        LoadUnlocTechCond(id,Cond1)
        
        LoadUnlocTechCond(id,Cond2)
        
        LoadUnlocTechCond(id,Cond3)
        
        LoadUnlocTechCond(id,Cond4)
        
        LoadUnlocTechCond(id,Cond5)

    endfunction
    
    //InitCond1(1,Unloc_Type_Level,0)
    scope ExChange
        private int array Data_Int[1000][7]
        private int Data_index = 0
        #define data_list       Data_Int[index][1]
        #define data_pos        Data_Int[index][2]
        #define data_uselist    Data_Int[index][3]
        #define data_usepos     Data_Int[index][4]
        #define data_use        Data_Int[index][5]
        #define data_data       Data_Int[index][6]
        #define data_level      Data_Int[index][7]
        
        function IsCanExChange(int pid,int itemid)->bool
            int index = GetTypeIdData(itemid,0x10010)
            int list = data_list
            int pos = data_pos
            return GetDzPlayerData(pid,list,pos) == 0
        endfunction
        function IsHasExChange(int pid,int itemid)->bool
            int index = GetTypeIdData(itemid,0x10010)
            int list = data_list
            int pos = data_pos
            return GetDzPlayerData(pid,list,pos) >= 1
        endfunction
        function ExChangeItem(int pid,int itemid)->bool
            int index = GetTypeIdData(itemid,0x10010)
            int list = data_list
            int pos = data_pos
            int uselist = data_uselist
            int usepos = data_usepos
            int use = data_use
            int data = data_data
            int level = data_level
            
            if  DzPlayerLv(Player(pid)) >= level
                if  GetDzPlayerData(pid,uselist,usepos) >= use
                    AddDzPlayerData(pid,uselist,usepos,-use)
                    AddDzPlayerData(pid,list,pos,data)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换成功！重新进入游戏生效！")
                    return true
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换失败！积分不足"+I2S(use))
                    return false
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:兑换失败！等级不足"+I2S(level))
                return false
            endif
        endfunction
        
        
        function ExChangeList(int itemid,int level ,int list,int pos,int uselist,int usepos,int use,int data)->int
            Data_index = Data_index + 1
            int index = Data_index
            data_level = level
            data_list = list
            data_pos = pos
            data_uselist = uselist
            data_usepos = usepos
            data_use = use
            data_data = data
            SetTypeIdData(itemid,0x10010,Data_index)
            return Data_index
        endfunction
        
        #undef data_list
        #undef data_pos
        #undef data_UseList
        #undef data_UsePos
        #undef data_Use
        #undef data_data
        #undef data_level
    endscope
    function InitAllUnlocTech()

        //英雄
        InitUnlocTechConditions('KE01',InitCond1(2,Unloc_Type_Level,0),0,0,0,0)
        InitUnlocTechConditions('KE02',InitCond1(2,Unloc_Type_Level,0),0,0,0,0)
        InitUnlocTechConditions('KE03',InitCond1(2,Unloc_Type_Level,0),0,0,0,0)
        InitUnlocTechConditions('KE04',InitCond1(2,Unloc_Type_Level,0),0,0,0,0)
        InitUnlocTechConditions('KE05',InitCond1(2,Unloc_Type_Level,0),0,0,0,0)

        InitUnlocTechConditions('KD01',InitCond1(2,Unloc_Type_Level,3),0,0,0,0)
        InitUnlocTechConditions('KD02',InitCond1(1,Unloc_Type_Level,2),InitCond2(0,Unloc_Type_JF,GameDataList(3,2,1)),0,0,0)
        InitUnlocTechConditions('KD03',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(4,1,3)),0,0,0)
        
        InitUnlocTechConditions('KC01',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(3,1,1)),0,0,0)
        InitUnlocTechConditions('KC02',InitCond1(2,Unloc_Type_Level,7),0,0,0,0)
        InitUnlocTechConditions('KC01',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_JF,GameDataList(6,1,10)),0,0,0)
        
        InitUnlocTechConditions('KB01',InitCond1(1,Unloc_Type_Level,5),InitCond2(0,Unloc_Type_Load,GameDataList(5,1,1)),0,0,0)
        InitUnlocTechConditions('KB02',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(3,4,1)),0,0,0)
        InitUnlocTechConditions('KB03',InitCond1(2,Unloc_Type_Level,12),0,0,0,0)
        
        InitUnlocTechConditions('KA01',InitCond1(1,Unloc_Type_Level,7),InitCond2(0,Unloc_Type_JF,GameDataList(4,2,14)),0,0,0)
        InitUnlocTechConditions('KA02',InitCond1(1,Unloc_Type_Level,8),InitCond2(0,Unloc_Type_Load,GameDataList(6,2,10)),0,0,0)
        
        
        InitUnlocTechConditions('KS01',InitCond1(1,Unloc_Type_Level,9),InitCond2(0,Unloc_Type_JF,GameDataList(4,2,28)),0,0,0)
        InitUnlocTechConditions('KS02',InitCond1(2,Unloc_Type_Level,18),0,0,0,0)
        InitUnlocTechConditions('KS03',InitCond1(2,Unloc_Type_Shop,ShopList("HS03")),0,0,0,0)
        InitUnlocTechConditions('KS04',InitCond1(2,Unloc_Type_Shop,ShopList("HS04")),0,0,0,0)
        InitUnlocTechConditions('KS03',InitCond1(2,Unloc_Type_Shop,ShopList("HS03")),0,0,0,0)
        
        InitUnlocTechConditions('KHS4',InitCond1(2,Unloc_Type_Shop,ShopList("KHS4")),InitCond2(2,Unloc_Type_Dad,1),0,0,0)
        


        InitUnlocTechConditions('KJ02',InitCond1(2,Unloc_Type_JF,GameDataList(3,2,1)),0,0,0,0)
        InitUnlocTechConditions('KJ03',InitCond1(2,Unloc_Type_JF,GameDataList(3,3,1)),0,0,0,0)
        InitUnlocTechConditions('KJ04',InitCond1(2,Unloc_Type_JF,GameDataList(3,4,1)),0,0,0,0)
        InitUnlocTechConditions('KJ05',InitCond1(2,Unloc_Type_JF,GameDataList(3,5,1)),0,0,0,0)
        InitUnlocTechConditions('KJ06',InitCond1(2,Unloc_Type_JF,GameDataList(3,6,1)),0,0,0,0)
        

        

        
        
        
        
        
        
        
        
    endfunction
    
    
    
endlibrary

