library UnlocTech initializer InitAllUnlocTech uses DamageCode
    
    int Unloc_Type_Level = 1
    int Unloc_Type_Load  = 2
    int Unloc_Type_Group = 3
    int Unloc_Type_Blue  = 4
    int Unloc_Type_Shop  = 5
    int Unloc_Type_JF    = 6
    int Unloc_Type_API   = 7
    int Unloc_Type_Dad   = 8
    int Unloc_Type_Test  = 9
    
    int Unloc_Type_LvRank = 12

    int Unloc_Type_Comment = 13
    
    int array UnlocTechData_TechId
    int UnlocTechData_index = 0
    


    function IsPlayerInRank(int pid,int data)->bool
        int n = DzAPI_Map_GetMapLevelRank(Player(pid))
        if  n <= data
            if  n == 0
                return false
            else
                return true
            endif
        endif
        return false
    endfunction


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
        if  savebool == true
            return true
        endif
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
        elseif  Type == Unloc_Type_LvRank
            return IsPlayerInRank(pid,data)
        elseif  Type == Unloc_Type_Test
            return DzAPI_Map_GetServerValue(Player(pid), "maptest2020") == "1" or DzAPI_Map_GetServerValue(Player(pid), "preset_map_award") == "1"
        elseif  Type == Unloc_Type_Comment
            return DzAPI_Map_CommentCount(Player(pid)) > 0
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
        

        function ReExChangeTips(int pid,int itemid)
            int index = GetTypeIdData(itemid,0x10010)
            int id = itemid + 0x9000000
            string tip = ""

            if  GetDzPlayerData(pid,data_uselist,data_usepos) >= data_use
                tip = tip + "需求：|cff00ff00"+I2S(data_use)
            else
                tip = tip + "需求：|cffff0000"+I2S(data_use)
            endif
            

            if  data_uselist == 2
                if  data_usepos == 1
                    tip = tip + "|r 通关积分且地图"
                endif
            endif

            if  DzPlayerLv(Player(pid)) >= data_level
                tip = tip +" |cff00ff00"+I2S(data_level)+" |r级\n\n|cffffcc00属性：|r"
            else
                tip = tip +" |cffff0000"+I2S(data_level)+" |r级\n\n|cffffcc00属性：|r"
            endif
            

            tip = tip + GetTypeIdStateTips(id)+GetTypeIdTips(id)
            if  GetLocalPlayer() == Player(pid)
                YDWESetItemDataString(itemid,3,tip)
            endif
            BJDebugMsg(YDWEId2S(id))
            BJDebugMsg(tip)
        endfunction
        
        function ExChangeList(int itemid,int level ,int uselist,int usepos,int use,int list,int pos,int data)->int
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


    //科技注册
    function InitAllUnlocTechFunc1()    


        //商城
        InitUnlocTechConditions('RY1D',InitCond1(2,Unloc_Type_Shop,ShopList("GH1")),0,0,0,0)
        InitUnlocTechConditions('RY2D',InitCond1(2,Unloc_Type_Shop,ShopList("CB1")),0,0,0,0)
        InitUnlocTechConditions('RY3D',InitCond1(2,Unloc_Type_Shop,ShopList("WQ1")),0,0,0,0)
        InitUnlocTechConditions('RY4D',InitCond1(2,Unloc_Type_Shop,ShopList("CH1")),0,0,0,0)
        InitUnlocTechConditions('RK1A',InitCond1(2,Unloc_Type_Shop,ShopList("CW1")),0,0,0,0)
        InitUnlocTechConditions('RJ1U',InitCond1(2,Unloc_Type_Shop,ShopList("LB1")),0,0,0,0)
        InitUnlocTechConditions('RJ1V',InitCond1(2,Unloc_Type_Shop,ShopList("LB2")),0,0,0,0)
        InitUnlocTechConditions('RJ1W',InitCond1(2,Unloc_Type_Shop,ShopList("LB3")),0,0,0,0)
        
        InitUnlocTechConditions('RJ1X',InitCond1(2,Unloc_Type_Shop,ShopList("LB4")),0,0,0,0)
        InitUnlocTechConditions('RY2G',InitCond1(2,Unloc_Type_Shop,ShopList("CB2")),0,0,0,0)
        InitUnlocTechConditions('RP1A',InitCond1(2,Unloc_Type_Shop,ShopList("PF1")),0,0,0,0)
        InitUnlocTechConditions('RY3F',InitCond1(2,Unloc_Type_Shop,ShopList("WQ2")),0,0,0,0)

        InitUnlocTechConditions('RTX1',InitCond1(2,Unloc_Type_Shop,ShopList("RWK")),0,0,0,0)
        InitUnlocTechConditions('RTX2',InitCond1(2,Unloc_Type_Shop,ShopList("RWK2")),0,0,0,0)
        


        //成就  
        InitUnlocTechConditions('RJ1I',InitCond1(2,Unloc_Type_Level,1),0,0,0,0)
        InitUnlocTechConditions('RJ1L',InitCond1(2,Unloc_Type_Level,1),0,0,0,0)
        InitUnlocTechConditions('RJ1A',InitCond1(2,Unloc_Type_Level,2),0,0,0,0)
        InitUnlocTechConditions('RJ1B',InitCond1(2,Unloc_Type_Level,3),0,0,0,0)
        InitUnlocTechConditions('RJ1C',InitCond1(2,Unloc_Type_Level,5),0,0,0,0)
        InitUnlocTechConditions('RJ1D',InitCond1(2,Unloc_Type_Level,8),0,0,0,0)
        InitUnlocTechConditions('RJ1E',InitCond1(2,Unloc_Type_Level,10),0,0,0,0)
        InitUnlocTechConditions('RJ1F',InitCond1(2,Unloc_Type_Level,12),0,0,0,0)
        InitUnlocTechConditions('RJ1G',InitCond1(2,Unloc_Type_Level,15),0,0,0,0)
        InitUnlocTechConditions('RJ1H',InitCond1(2,Unloc_Type_Level,20),0,0,0,0)
        InitUnlocTechConditions('RJ1J',InitCond1(2,Unloc_Type_Level,24),0,0,0,0)
        InitUnlocTechConditions('RJ1K',InitCond1(2,Unloc_Type_Level,27),0,0,0,0)



        InitUnlocTechConditions('RGAA',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(17,2,1)),0,0,0)
        InitUnlocTechConditions('RGAB',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(17,3,1)),0,0,0)
        InitUnlocTechConditions('RGAC',InitCond1(1,Unloc_Type_Level,5),InitCond2(0,Unloc_Type_JF,GameDataList(17,4,1)),0,0,0)
        InitUnlocTechConditions('RGAD',InitCond1(1,Unloc_Type_Level,7),InitCond2(0,Unloc_Type_JF,GameDataList(17,5,1)),0,0,0)
        InitUnlocTechConditions('RGAE',InitCond1(1,Unloc_Type_Level,9),InitCond2(0,Unloc_Type_JF,GameDataList(17,6,1)),0,0,0)
        InitUnlocTechConditions('RGAF',InitCond1(1,Unloc_Type_Level,10),InitCond2(0,Unloc_Type_JF,GameDataList(17,7,1)),0,0,0)
        InitUnlocTechConditions('RGAG',InitCond1(1,Unloc_Type_Level,12),InitCond2(0,Unloc_Type_JF,GameDataList(17,8,1)),0,0,0)
        InitUnlocTechConditions('RGAH',InitCond1(1,Unloc_Type_Level,14),InitCond2(0,Unloc_Type_JF,GameDataList(17,9,1)),0,0,0)
        InitUnlocTechConditions('RGAI',InitCond1(1,Unloc_Type_Level,15),InitCond2(0,Unloc_Type_JF,GameDataList(17,10,1)),0,0,0)



        InitUnlocTechConditions('RG0B',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(3,3,5)),0,0,0)
        InitUnlocTechConditions('RG0C',InitCond1(1,Unloc_Type_Level,5),InitCond2(0,Unloc_Type_JF,GameDataList(3,4,5)),0,0,0)
        InitUnlocTechConditions('RG0D',InitCond1(1,Unloc_Type_Level,7),InitCond2(0,Unloc_Type_JF,GameDataList(3,5,5)),0,0,0)
        InitUnlocTechConditions('RG0E',InitCond1(1,Unloc_Type_Level,9),InitCond2(0,Unloc_Type_JF,GameDataList(3,6,5)),0,0,0)
        InitUnlocTechConditions('RG0F',InitCond1(1,Unloc_Type_Level,10),InitCond2(0,Unloc_Type_JF,GameDataList(3,7,5)),0,0,0)
        InitUnlocTechConditions('RG0G',InitCond1(1,Unloc_Type_Level,12),InitCond2(0,Unloc_Type_JF,GameDataList(3,8,5)),0,0,0)
        InitUnlocTechConditions('RG0H',InitCond1(1,Unloc_Type_Level,14),InitCond2(0,Unloc_Type_JF,GameDataList(3,9,5)),0,0,0)
        InitUnlocTechConditions('RG0I',InitCond1(1,Unloc_Type_Level,15),InitCond2(0,Unloc_Type_JF,GameDataList(3,10,5)),0,0,0)



        InitUnlocTechConditions('RG1B',InitCond1(1,Unloc_Type_Level,5),InitCond2(0,Unloc_Type_JF,GameDataList(3,3,15)),0,0,0)
        InitUnlocTechConditions('RG1C',InitCond1(1,Unloc_Type_Level,7),InitCond2(0,Unloc_Type_JF,GameDataList(3,4,15)),0,0,0)
        InitUnlocTechConditions('RG1D',InitCond1(1,Unloc_Type_Level,9),InitCond2(0,Unloc_Type_JF,GameDataList(3,5,15)),0,0,0)
        InitUnlocTechConditions('RG1E',InitCond1(1,Unloc_Type_Level,11),InitCond2(0,Unloc_Type_JF,GameDataList(3,6,15)),0,0,0)
        InitUnlocTechConditions('RG1F',InitCond1(1,Unloc_Type_Level,13),InitCond2(0,Unloc_Type_JF,GameDataList(3,7,15)),0,0,0)
        InitUnlocTechConditions('RG1G',InitCond1(1,Unloc_Type_Level,14),InitCond2(0,Unloc_Type_JF,GameDataList(3,8,15)),0,0,0)
        InitUnlocTechConditions('RG1H',InitCond1(1,Unloc_Type_Level,15),InitCond2(0,Unloc_Type_JF,GameDataList(3,9,15)),0,0,0)
        InitUnlocTechConditions('RG1I',InitCond1(1,Unloc_Type_Level,16),InitCond2(0,Unloc_Type_JF,GameDataList(3,10,15)),0,0,0)


        //积分兑换
        InitUnlocTechConditions('RY1C',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_Load,GameDataList(11,3,3)),0,0,0)
        InitUnlocTechConditions('RY2C',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_Load,GameDataList(12,3,3)),0,0,0)
        InitUnlocTechConditions('RY3C',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_Load,GameDataList(13,3,3)),0,0,0)
        InitUnlocTechConditions('RY4C',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_Load,GameDataList(14,3,3)),0,0,0)
        InitUnlocTechConditions('RY2E',InitCond1(1,Unloc_Type_Level,9),InitCond2(0,Unloc_Type_Load,GameDataList(12,5,5)),0,0,0)
        InitUnlocTechConditions('RY2F',InitCond1(1,Unloc_Type_Level,12),InitCond2(0,Unloc_Type_Load,GameDataList(12,6,6)),0,0,0)
        InitUnlocTechConditions('RY4O',InitCond1(1,Unloc_Type_Level,16),InitCond2(0,Unloc_Type_Load,GameDataList(14,15,15)),0,0,0)
        InitUnlocTechConditions('RY1E',InitCond1(1,Unloc_Type_Level,20),InitCond2(0,Unloc_Type_Load,GameDataList(11,5,5)),0,0,0)
        InitUnlocTechConditions('RY3E',InitCond1(1,Unloc_Type_Level,24),InitCond2(0,Unloc_Type_Load,GameDataList(13,5,5)),0,0,0)
        

        InitUnlocTechConditions('RY2I',InitCond1(2,Unloc_Type_Level,35),0,0,0,0)

        //称号
        InitUnlocTechConditions('RY4E',InitCond1(1,Unloc_Type_Level,1),InitCond2(0,Unloc_Type_JF,GameDataList(3,2,1)),0,0,0)
        InitUnlocTechConditions('RY4F',InitCond1(1,Unloc_Type_Level,2),InitCond2(0,Unloc_Type_JF,GameDataList(3,3,1)),0,0,0)
        InitUnlocTechConditions('RY4G',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(3,4,1)),0,0,0)
        InitUnlocTechConditions('RY4H',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(3,5,1)),0,0,0)
        InitUnlocTechConditions('RY4I',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_JF,GameDataList(3,6,1)),0,0,0)
        InitUnlocTechConditions('RY4L',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(3,7,1)),0,0,0)
        InitUnlocTechConditions('RY4M',InitCond1(1,Unloc_Type_Level,8),InitCond2(0,Unloc_Type_JF,GameDataList(3,8,1)),0,0,0)
        InitUnlocTechConditions('RY4Q',InitCond1(1,Unloc_Type_Level,10),InitCond2(0,Unloc_Type_JF,GameDataList(3,9,1)),0,0,0)
        InitUnlocTechConditions('RY4R',InitCond1(1,Unloc_Type_Level,12),InitCond2(0,Unloc_Type_JF,GameDataList(3,10,1)),0,0,0)

        //等级排行
        InitUnlocTechConditions('RY4J',InitCond1(2,Unloc_Type_LvRank,10),0,0,0,0)
        InitUnlocTechConditions('RY4K',InitCond1(2,Unloc_Type_LvRank,100),0,0,0,0)
        //测试先锋
        InitUnlocTechConditions('RY4N',InitCond1(1,Unloc_Type_Level,5),InitCond2(0,Unloc_Type_Test,1),0,0,0)
        

        //	InitUnlocTechConditions('RDAA',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,1,1)),0,0,0)
            InitUnlocTechConditions('RDAB',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_JF,GameDataList(15,2,2)),0,0,0)
            InitUnlocTechConditions('RDAC',InitCond1(1,Unloc_Type_Level,1),InitCond2(0,Unloc_Type_JF,GameDataList(15,3,3)),0,0,0)
            InitUnlocTechConditions('RDAD',InitCond1(1,Unloc_Type_Level,1),InitCond2(0,Unloc_Type_JF,GameDataList(15,4,4)),0,0,0)
        	InitUnlocTechConditions('RDAE',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,5,5)),0,0,0)
        	InitUnlocTechConditions('RDAF',InitCond1(1,Unloc_Type_Level,8),InitCond2(0,Unloc_Type_JF,GameDataList(15,6,6)),0,0,0)
        	InitUnlocTechConditions('RDAG',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,7,7)),0,0,0)
            InitUnlocTechConditions('RDAH',InitCond1(1,Unloc_Type_Level,1),InitCond2(0,Unloc_Type_JF,GameDataList(15,8,8)),0,0,0)
            InitUnlocTechConditions('RDAI',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_JF,GameDataList(15,9,9)),0,0,0)
            InitUnlocTechConditions('RDAJ',InitCond1(1,Unloc_Type_Level,2),InitCond2(0,Unloc_Type_JF,GameDataList(15,10,10)),0,0,0)
            InitUnlocTechConditions('RDAK',InitCond1(1,Unloc_Type_Level,2),InitCond2(0,Unloc_Type_JF,GameDataList(15,11,11)),0,0,0)
            InitUnlocTechConditions('RDAL',InitCond1(1,Unloc_Type_Level,2),InitCond2(0,Unloc_Type_JF,GameDataList(15,12,12)),0,0,0)
            InitUnlocTechConditions('RDAM',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_JF,GameDataList(15,13,13)),0,0,0)
            InitUnlocTechConditions('RDAN',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_JF,GameDataList(15,14,14)),0,0,0)
            InitUnlocTechConditions('RDAO',InitCond1(1,Unloc_Type_Level,2),InitCond2(0,Unloc_Type_JF,GameDataList(15,15,15)),0,0,0)
        //	InitUnlocTechConditions('RDAP',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,16,16)),0,0,0)
        //	InitUnlocTechConditions('RDAQ',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,17,17)),0,0,0)
        //	InitUnlocTechConditions('RDAR',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,18,18)),0,0,0)
        //	InitUnlocTechConditions('RDAS',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,19,19)),0,0,0)
        	InitUnlocTechConditions('RDAT',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,20,20)),0,0,0)
        	InitUnlocTechConditions('RDAU',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,21,21)),0,0,0)
        	InitUnlocTechConditions('RDAV',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_JF,GameDataList(15,22,22)),0,0,0)
        	InitUnlocTechConditions('RDAW',InitCond1(1,Unloc_Type_Level,2),InitCond2(0,Unloc_Type_JF,GameDataList(15,23,23)),0,0,0)
        	InitUnlocTechConditions('RDAX',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(15,24,24)),0,0,0)
            InitUnlocTechConditions('RDAY',InitCond1(1,Unloc_Type_Level,1),InitCond2(0,Unloc_Type_JF,GameDataList(15,25,25)),0,0,0)
            

            InitUnlocTechConditions('RDAZ',InitCond1(2,Unloc_Type_Comment,1),0,0,0,0)
            


            //封神谕令
            InitUnlocTechConditions('RY9A',InitCond1(1,Unloc_Type_Level,2),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,128)),0,0,0)
            InitUnlocTechConditions('RY9B',InitCond1(1,Unloc_Type_Level,3),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,640)),0,0,0)
            InitUnlocTechConditions('RY9C',InitCond1(1,Unloc_Type_Level,4),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,1792)),0,0,0)
            InitUnlocTechConditions('RY9D',InitCond1(1,Unloc_Type_Level,6),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,3840)),0,0,0)
            InitUnlocTechConditions('RY9E',InitCond1(1,Unloc_Type_Level,7),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,6400)),0,0,0)
            InitUnlocTechConditions('RY9F',InitCond1(1,Unloc_Type_Level,8),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,9472)),0,0,0)
            InitUnlocTechConditions('RY9G',InitCond1(1,Unloc_Type_Level,10),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,13619)),0,0,0)
            InitUnlocTechConditions('RY9H',InitCond1(1,Unloc_Type_Level,11),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,18180)),0,0,0)
            /*
            InitUnlocTechConditions('RY9G',InitCond1(1,Unloc_Type_Level,12),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,23198)),0,0,0)
            InitUnlocTechConditions('RY9H',InitCond1(1,Unloc_Type_Level,14),InitCond2(0,Unloc_Type_JF,GameDataList(16,1,28718)),0,0,0)
            */

    endfunction


    //物品说明修改
    
    function ReTechFuncItemTips(int pid)
        ReExChangeTips(pid,'IY1C')
        ReExChangeTips(pid,'IY2C')
        ReExChangeTips(pid,'IY3C')
        ReExChangeTips(pid,'IY4C')
        ReExChangeTips(pid,'IY2E')
        ReExChangeTips(pid,'IY2F')
        ReExChangeTips(pid,'IY4O')
        ReExChangeTips(pid,'IY1E')
        ReExChangeTips(pid,'IY3E')
    endfunction

    //物品兑换注册
    function InitAllUnlocTechFuncItem()
        ExChangeList('IY2C',3,2,1,200,12,3,3)
        ExChangeList('IY4C',3,2,1,600,14,3,3)
        ExChangeList('IY1C',4,2,1,1200,11,3,3)
        ExChangeList('IY3C',6,2,1,3000,13,3,3)
        
        ExChangeList('IY2E',9,2,1,1600,12,5,5)
        ExChangeList('IY2F',12,2,1,1900,12,6,6)

        ExChangeList('IY4O',16,2,1,2300,14,15,15)
        ExChangeList('IY1E',20,2,1,3200,11,5,5)

        ExChangeList('IY3E',24,2,1,3300,13,5,5)

    endfunction


    

    //初始化
    function InitAllUnlocTech()

        ExecuteFunc("InitAllUnlocTechFunc1")

        
    endfunction
    
    
    
endlibrary

