library DzBase uses SystemCodes,DzAPI

    string array DzArrayString[12][680]
    int array DzArrayPlayerInt0[200][100]
    int array DzArrayPlayerInt1[200][100]
    int array DzArrayPlayerInt2[200][100]
    int array DzArrayPlayerInt3[200][100]
    int array DzArrayPlayerInt4[200][100]
    int array DzArrayPlayerInt5[200][100]
    int array DzArrayBaseInt
    bool array IsDzNewPlayer
    
    //#define DzEdition                 DzArrayBaseInt[0]
    #define DzOriginServerNum         DzArrayBaseInt[1]
    #define DzServerNum               DzArrayBaseInt[2]
    #define DzDataGroupLength(num)    DzArrayBaseInt[10+num]
    
    #define DzS DzArrayString[pid]

    int array DzPlayerInitTGCos
    int array DzPlayerInitCrazyTGCos
    int array DzPlayerInitVariationTGCos

    insert DzMatrix

    function GetDzDataGroupMaxValue(int Group)->int
        if  DzDataGroupLength(Group) == 2
            return 99
        elseif  DzDataGroupLength(Group) == 3
            return 999
        elseif  DzDataGroupLength(Group) == 4
            return 9999
        elseif  DzDataGroupLength(Group) == 5
            return 99999
        elseif  DzDataGroupLength(Group) == 6
            return 999999
        else
            return 0
        endif
    endfunction
    
    function GetDataMaximumValue(int data,int max)->int
        if  max < 0
            max = 0
        endif
        if  data > 0
            if  data > max 
                data = max
            endif
        else
            data = 0
        endif
        return data
    endfunction

    function GetDataBinaryConversion(int data,int id)->int
        int re = data - id
        int cos = 9
        if  re >= 0 and re <= 9
            return re
        elseif  re >= 256 and re <= 256+cos
            return re-256+10
        elseif  re >= 512 and re <= 512+cos
            return re-512+20
        elseif  re >= 768 and re <= 768+cos
            return re-768+30
        elseif  re >= 1024 and re <= 1024+cos
            return re-1024+40
        elseif  re >= 1280 and re <= 1280+cos
            return re-1280+50
        elseif  re >= 1536 and re <= 1536+cos
            return re-1536+60
        elseif  re >= 1792 and re <= 1792+cos
            return re-1792+70
        elseif  re >= 2048 and re <= 2048+cos
            return re-2048+80
        elseif  re >= 2304 and re <= 2304+cos
            return re-2304+90
        else
            return 0
        endif
    endfunction

endlibrary
