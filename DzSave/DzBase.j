library DzBase uses SystemCodes,DzAPI

    string array DzArrayString[12][680]
    int array DzArrayPlayerInt0[200][40]
    int array DzArrayPlayerInt1[200][40]
    int array DzArrayPlayerInt2[200][40]
    int array DzArrayPlayerInt3[200][40]
    int array DzArrayPlayerInt4[200][40]
    int array DzArrayPlayerInt5[200][40]
    int array DzArrayBaseInt
    
    #define DzEdition                 DzArrayBaseInt[0]
    #define DzOriginServerNum         DzArrayBaseInt[1]
    #define DzServerNum               DzArrayBaseInt[2]
    #define DzDataGroupLength(num)    DzArrayBaseInt[10+num]
    
    #define DzS DzArrayString[pid]

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
        if  data > 0
            if  data > max 
                data = max
            endif
        else
            data = 0
        endif
        return data
    endfunction

endlibrary