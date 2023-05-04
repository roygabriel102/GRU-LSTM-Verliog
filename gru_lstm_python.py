import math
import numpy as np

passh = True

def sig(x):
    return 1/(1 + np.exp(-x))

#input weights
Wz = 0.125
Wr = 0.125
Wh = 0.125

#state weights
Uz = 0.75
Ur = 0.75
Uh = 0.75

#Bias values
bz = 0.01
br = 0.01
bh = 0.01

#inputs
#prior state
print("type input(a value of 0 exits)")
h_in = 0
#system input
X = int(input())


while (X != 0):
    zt = sig((Wz*X)+(Uz*h_in)+bz)
    rt = sig((Wr*X)+(Ur*h_in)+br)
    hbar = math.tanh((Wh*X)+(Uh*((h_in*rt)+bh)))
    h_out = ((1-zt)*h_in)+(zt*hbar)
    print("input: "+str(X)+" output: "+str(h_out))

    print("type input(a value of 0 exits)")
    X = int(input())

    if passh:
        h_in = h_out

