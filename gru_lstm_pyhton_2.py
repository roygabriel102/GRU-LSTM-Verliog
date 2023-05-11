#This file collects output data from LSTM output
import math
import numpy as np
import pandas as pd
from numpy import log

passh = False

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
bz = 0.03125
br = 0.03125
bh = 0.03125

#inputs
#prior state
# print("type input(a value of 0 exits)")
h_in = 0
#system input
X = 0
# X = int(input())

#Arrays for storing of values
# h_in_array= np.zeros(8)
# X_array= np.zeros(8)
h_out=np.zeros(18)


        # print("Input X: "+str(X)+", Input h_in: "+str(h_in))

# if (X != 0):

#Since the fractional width is 5 bits the decimal value of the variables are divided by 2^5=32

for i in range(0,1):
    h_in = i/32

    for j in range(0, 257-240):
        X = j/32

        zt = sig((Wz * X) + (Uz * h_in) + bz)
        rt = sig((Wr * X) + (Ur * h_in) + br)
        hbar = math.tanh((Wh * X) + (Uh * ((h_in * rt) + bh)))
        h_out[j] = ((1 - zt) * h_in) + (zt * hbar)
        print("Input X: " + str(X) + ", Input h_in: " + str(h_in) + " output: " + str(h_out))

        # print("Input X: "+str(X)+", Input h_in: "+str(h_in)+" output: "+str(h_out))
        #
        # print("type input(a value of 0 exits)")
        # X = int(input())
        # if (X != 0):


        # print("Input X: " + str(X_array) + ", Input h_in: " + str(h_in_array) + " output: " + str(h_out))
        # print("X_array: " + str(len(X_array)) )


    # if passh:
    #     h_in[j] = h_out[j]

    # pd.DataFrame(h_out).to_csv("C:/Users/ashah/Documents/file.csv")
        list_of_thing = []
        # a = np.arange(10)
        list_of_thing.append(h_out)
        # b = np.arange(5)
        # list_of_thing.append(X)
        csvfile = "./data.csv"
        my_df = pd.DataFrame(list_of_thing)
        my_df = my_df.T
        my_df.to_csv(csvfile, index=False, header=False)
        # np.savetxt("foo.csv", (h_out[1],X[1]), delimiter=",")




