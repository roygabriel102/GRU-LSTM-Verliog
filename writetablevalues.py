import math
from binary_fractions import Binary
from binary_fractions import TwosComplement
from fixedpoint import FixedPoint
import numpy as np

#This file is used to write the data for the look up tables, you can adjust the data width and
#placement of the fixed point with the first two variables

datawidth = 8       #total width of data
decimalwidth = 5    #number of decimal bits
sigortanh = 0       #0 for tanh, 1 for sigmoid

if sigortanh:
    writefile = 'sig_data.mem'
else:
    writefile = 'tanh_data.mem'

increment = (2 ** (datawidth-decimalwidth)/(2 ** datawidth))

f = open(writefile,"w")

def sig(x):
    return 1/(1 + np.exp(-x))

for i in range(0,(2 ** datawidth)-1):
    a = bin(i)[2:].zfill(datawidth)
    a = a[:(datawidth-decimalwidth)] + '.' + a[(datawidth - decimalwidth):]

    a2 = TwosComplement(a,datawidth+1,ndigits=decimalwidth,simplify=False)
    b = Binary().from_twoscomplement(a2,False)
    b2 = Binary.to_float(b)
    if b[0] == '-':
        if b2 > 0:
            b2 = b2 *-1

    if sigortanh:
        x = sig(b2)
    else:
        x = math.tanh(b2)
    
    fixed_num = FixedPoint(x, 1, datawidth-decimalwidth, decimalwidth)
    binary_rep = bin(fixed_num)[2:].zfill(datawidth)

    f.write(binary_rep + '\n')

f.close()

#Test code
    #z = binary_rep[:(datawidth-decimalwidth)] + '.' + binary_rep[(datawidth - decimalwidth):]
    #z2 = TwosComplement(z,datawidth+1,ndigits=decimalwidth,simplify=False)
    #z3 = Binary().from_twoscomplement(z2,False)
    #z4 = Binary.to_float(z3)
    #if z3[0] == '-':
    #    if z4 > 0:
    #        z4 = z4 *-1
    
    #print("tanh_out: "+str(x)+"  "+"out: "+str(z4))

#"i: "+str(i)+"  "+    "  "+"converted: "+b+    "in: "+a2+"  "+"tanh_in: "+str(b2)+"  "+    "out: "+binary_rep
