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
import random

def inject_1d_random_faults(r, errors=0):
    '''
    function "inject_1d_random_faults" injects random faults with a total
    number of "errors" into the input vector "r"
    input   :   r       :   (np.array) array to be faulted
    input   :   errors  :   (int) number of errors
    output  :           :   (np.array) faulted array
    '''
    length_r = len(r)
    if errors > 0:
        error_indecies = np.full(min(errors, length_r), -1, dtype = int)
        for i in range(min(errors, length_r)):
            index = random.randint(0, length_r-1)
            while index in error_indecies:
                index = random.randint(0, length_r-1)
            error_indecies[i] = index
            r[index] ^= 1
    return r

def inject_1d_precise_faults(r, errors=[]):
    '''
    function "inject_1d_precise_faults" injects precise faults "errors" 
    into the input vector "r"
    input   :   r       :   (np.array) array to be faulted
    input   :   errors  :   (np.array) array of 1d coordinates of faults
    output  :           :   (np.array) faulted array
    '''
    if len(errors) == 0:
        return r
    number_of_errors = min(len(r), len(errors))
    errors = errors[:number_of_errors]
    r[errors] ^= 1
    return r

def inject_2d_random_faults(R, errors=0):
    '''
    function "inject_2d_random_faults" injects random faults with a total
    number of "errors" into the input matrix "R"
    input   :   R       :   (np.array) array to be faulted
    input   :   errors  :   (int) number of errors
    output  :           :   (np.array) faulted array
    '''
    rows, columns = np.shape(R)
    size = np.size(R)
    errors = min(errors, size)
    error_coordinates = []
    for i in range(errors):
        index_row = random.randint(0, rows-1)
        index_column = random.randint(0, columns-1)
        coordinate = tuple([index_row, index_column])
        while coordinate in error_coordinates:
            index_row = random.randint(0, rows-1)
            index_column = random.randint(0, columns-1)
            coordinate = tuple([index_row, index_column])
        error_coordinates.append(coordinate)
        R[coordinate] ^= 1
    return R

def inject_2d_precise_faults(R, errors=[]):
    '''
    function "inject_2d_precise_faults" injects precise faults "errors" 
    into the input matrix "R"
    input   :   R       :   (np.array) array to be faulted
    input   :   errors  :   (np.array) array of 2d coordinates of faults
    output  :           :   (np.array) faulted array
    '''
    if len(errors) == 0:
        return R
    number_of_errors = min(np.size(R), len(errors))
    errors = errors[:number_of_errors]
    for error in errors:
        R[error] ^= 1
    return R
