'''
Copyright 2024 Fraunhofer Institute for Applied and Integrated Security (AISEC).

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
'''

import numpy as np

def generate_random_number(code_size):
    '''
    function "generate_random_number" generates a number in GF(2^(code_size))
    input   :   code_size   : (int) code size
    output  :               : (np.array) random number in GF(2^(code_size))
    '''
    return np.random.randint(0, 2, size=code_size, dtype=int)

def generate_random_state(code_size = 1600):
    '''
    function "generate_random_state" generates a random Keccak state
    output  :       : (np.array) a randomized Keccak state

    comment: code_size is implemented for the compatability with 
    the "generate_random_number" function, but is not used
    '''
    return np.random.randint(0,2,(5,5,64), dtype = int)

def generate_random_lane(code_size = 64):
    '''
    function "generate_random_lane" generates a random Keccak lane
    output  :       : (np.array) a randomized Keccak lane

    comment: code_size is implemented for the compatability with 
    the "generate_random_number" function, but is not used
    '''
    return np.random.randint(0,2,(64), dtype = int)

#convertion of large strings (>= 64 bit)
#has to be performed on its smaller parts to ensure
#the convertion correctness
def bitstring_to_integer(bitstring):
    '''
    function "bitstring_to_integer" converts "bitstring" into "r"
    input   :   bitstring   : (np.array) binary array
    outpu   :   r           : (int) integer representation of "bitstring"
    '''
    r : long = 0
    for i in range(bitstring.size):
        r |= bitstring[i] << i
    return r

def integer_to_bitstring(integer, code_size):
    '''
    function "integer_to_bitstring" converts an integer "r" into 
    the binary array "bitstring"
    input   :   r           : (int) integer
    output  :   bitstring   : (np.array) binary representation of "r"
    '''
    b = np.zeros(code_size, dtype=int)
    for i in range(code_size):
        b[i] = (integer & (1 << i)) >> i
    return b

