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
import itertools as it

def generate_1d_coordinates(hamming_weight, subspace_length):
    '''
    function "generate_1d_coordinates" generates coordinates for the
    fault injection, such that the total number of faults to inject 
    equals the "hamming_wight" of the error.
    input   :   hamming_weight  :   (int) total hamming weight of faults
    input   :   subspace_length :   (int) length of the subspace under the test
    output  :                   :   (np.array) array of 1d coordinates 
    '''
    if hamming_weight == 0:
        return np.asarray([])
    coordinates = np.arange(0, subspace_length, dtype=int)
    coordinates = list(it.combinations(list(coordinates), hamming_weight))
    return np.asarray(coordinates)

def generate_2d_coordinates(hamming_weight, subspace_length):
    '''
    function "generate_1d_coordinates" generates coordinates for the
    fault injection, such that the total number of faults to inject 
    equals the "hamming_wight" of the error.
    input   :   hamming_weight  :   (int) total hamming weight of faults
    input   :   subspace_length :   (int) length of the subspace under the test
    output  :                   :   (np.array) array of 2d coordinates 
    '''
    if hamming_weight == 0:
        return np.asarray([])
    x = np.arange(0, subspace_length, dtype=int)
    y = np.arange(0, subspace_length-1, dtype=int)
    coordinates = [list(x), list(y)]
    coordinates = [p for p in it.product(*coordinates)]
    coordinates = list(it.combinations(list(coordinates), hamming_weight))
    return coordinates
    
