library DzMoZhiMapLevel uses SystemCodes
    string DzGet62 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_"
    int array MoZhiMapLevelData[10][800]
    
    #define MapLevelList MoZhiMapLevelData[pid]
    
    func GetPublicMapLevel(int pid)->int
        int num = 0
        if  MapLevelList[3] >= 5
            num = num + 1
        endif
        if  MapLevelList[6] >= 5
            num = num + 1
        endif
        if  MapLevelList[7] >= 5
            num = num + 1
        endif
        return num
    end
    
    func String2Int10ForList(string s,int num,string list)->int
        if num != 0
            s = SubString(s,0,num)
        endif
        int len = StringLength(s)
        int a = 0
        int b = 0
        int numx=1    
        int result=0
        loop
            exitwhen b>len-1
            set numx=R2I(Pow(62,len-1-b))
            set a=1
            loop
                exitwhen a>61
                if  SubString(s,b,b+1)==SubString(list,a,a+1)
                    result=result+a*numx
                    a=62
                endif
                set a=a+1
            endloop
            set b=b+1
        endloop
        return result
    end
    
    func Int2StringForList(int n,int l,string list)->string
        string result = ""
        int charValue = 0
        int byteno = 0
        loop
            charValue = n - (n / 62) * 62
            n = n / 62
            result = SubString(list, charValue, charValue + 1) + result
            byteno = byteno + 1
            exitwhen byteno == l
        endloop
        
        return result
    end
    
    function DzSavePublic(int pid,int pos)
        string list = DzAPI_Map_GetPublicArchive(Player(pid),"MapLevel")
        if  list == ""
            list = "00000000000000000000000000000000000000000000000000000000000000"
        endif
        //BJDebugMsg("MapLevel:"+list)
        int count = 8
        int n = 2
        int num = 0
        for i= 1,count
            MapLevelList[i] = String2Int10ForList(SubString(list,num,num+n),n,DzGet62)
            num = num + n
        end
        string value = Int2StringForList(DzAPI_Map_GetMapLevel(Player(pid)),2,DzGet62)
        string data = ""
        if pos == 1
            data = value + SubString(list,2,StringLength(list))
        else
            data = SubString(list,0,(pos-1)*2)+value + SubString(list,pos*2,StringLength(list))
        endif
        DzAPI_Map_SavePublicArchive( Player(pid), "MapLevel", data)
    endfunction
endlibrary
