piece DzMatrix

    func GetStrZero(int i,int num)==>string
        string str = I2S(i)
        int long = num
        long = long - StringLength(str)
        if  long > 0
            for n = 1,long
                str = "0" + str
            end
        endif
        return str
    end
    
    /*func GetStrMatrix2(string st,int i,int j)==>string
        string str = st
        string array str1
        string array str2
        string new0 = ""
        string new1 = ""
        string new2 = ""
        string re = ""
        int long = i
        int num = j
        int a = long / num
        int b = 0
        for i = 1,a
            str1[i] = SubStringBJ(str,num*(i-1)+1,i*num)
        end
        if  ModuloInteger(a,2) == 1
            b = a - 1
            new0 = str1[a]
        else
            b = a
        endif
        for i = 1,b/2
            str2[i] = str1[i*2-1]
        end
        for i = 1,b/2
            str2[i+b/2] = str1[i*2]
        end
        for i = 1,b
            if  i <= b/2
                new1 = new1 + str2[i]
            else
                new2 = new2 + str2[i]
            endif
        end
        re = new0 + new2 + new1
        return re
        flush locals
    end
    
    func GetStrMatrix(string st,int i,int j)==>string
        string str = st
        string array str1
        string array str2
        string new0 = ""
        string new1 = ""
        string re = ""
        int long = i
        int num = j
        int a = long / num
        int b = 0
        int c = 0
        for i = 1,a
            str1[i] = SubStringBJ(str,num*(i-1)+1,i*num)
        end
        if  ModuloInteger(a,2) == 1
            b = a - 1
            new0 = str1[1]
        else
            b = a
        endif
        for i = 1,b/2
            if  b == a
                c = i
            else
                c = i + 1
            endif
            str2[i] = str1[c+b/2]
        end
        for i = 1,b/2
            if  b == a
                c = i
            else
                c = i + 1
            endif
            str2[i+b/2] = str1[c]
        end
        for i = 1,b
            if  ModuloInteger(i,2) == 1
                str1[i] = str2[(i+1)/2]
            else
                str1[i] = str2[i/2+b/2]
            endif
        end
        for i = 1,b
            new1 = new1 + str1[i]
        end
        re = new1 + new0
        return re
        flush locals
    end*/
    
endpiece
