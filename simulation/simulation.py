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
import fault_injection as fi
import gen_coding_matrix as gcm
import coordinates as cd
import argparse

DATA_SIZE = 64
CODE_SIZE = 128

errors = np.array([[1,0,0],
                   [0,1,0],	#rho simulation
                   #[0,0,1],	

                   [2,0,0],
                   [0,2,0],	#rho simulation
                   #[0,0,2],
                   [1,1,0],
                   [0,1,1],	#rho simulation
                   [1,0,1],

                   [3,0,0],
                   [0,3,0],	#rho simulation
                   #[0,0,3],
                   [2,1,0],
                   [2,0,1],
                   [1,2,0],
                   [1,0,2],
                   [0,2,1],	#rho simulation
                   [0,1,2],	#rho simulation
                   [1,1,1]])

#simulation of theta and rho permutations (rho(theta(state))
def simulation(e1, e2, e3):
    '''
    function "simulation" simulates the combination of theta and
    rho permutations of the Keccak function to identify successful 
    fault injection patterns.
    input   :   e1  : (int) total number of errors on the input of theta
    input   :   e2  : (int) total number of errors on the input of rho
    input   :   e3  : (int) total number of errors onthe output of rho
    '''

    # generate all possible error vectors
    e1_coordinates = cd. generate_1d_coordinates(e1, CODE_SIZE)
    e2_coordinates = cd. generate_1d_coordinates(e2, CODE_SIZE)
    e3_coordinates = cd. generate_1d_coordinates(e3, CODE_SIZE)

    # data are represented as a 128-bit array
    # [------64-bit------,------64-bit------]
    # [        a         ,        a*P       ] 
    P = gcm.gen_coding_matrix(DATA_SIZE,4)

    # matrix rotation for the theta permutation
    R1 = gcm.gen_coding_matrix(DATA_SIZE,1)
    T1 = np.matmul(np.matmul(P, R1) % 2, P) % 2

    counter = 0
    total_counter = 0

    Matrix_theta = np.zeros((128,128), dtype = int)
    Matrix_theta[:64, :64] = R1
    Matrix_theta[64:, 64:] = T1
    
    for i in range(0,24):
        
        t = ((i + 1) * (i + 2) // 2) % 64
        R = gcm.gen_shift_matrix(64, t)
        T = np.matmul(np.matmul(P,R) % 2, P) % 2
        
        Matrix_rho = np.zeros((128,128), dtype = int)
        Matrix_rho[:64, :64] = R
        Matrix_rho[64:, 64:] = T

	#do-while loop
        e1_iter = 0
        while True:
            e_in = np.zeros(128, dtype = int)
            if len(e1_coordinates) > 0:
                e_in = fi.inject_1d_precise_faults(e_in, e1_coordinates[e1_iter])
            e2_iter = 0    
            while True:
                e_int = np.matmul(e_in, Matrix_theta)
                if len(e2_coordinates) > 0:
                    e_int = fi.inject_1d_precise_faults(e_int, e2_coordinates[e2_iter])
                e3_iter = 0
                while True:
                    e_out = np.matmul(e_int, Matrix_rho)
                    if len(e3_coordinates) > 0:
                        e_out = fi.inject_1d_precise_faults(e_out, e3_coordinates[e3_iter])
                    if np.array_equal(e_out[:64], np.matmul(e_out[64:], P) % 2) and np.sum(e_out) > 0:
                        counter += 1
                    e3_iter += 1
                    if e3_iter >= len(e3_coordinates):
                        break
                e2_iter += 1
                if e2_iter >= len(e2_coordinates):
                    break
            e1_iter += 1
            if e1_iter >= len(e1_coordinates):
                break

        total_counter += counter
        counter = 0

    print(f"e1 = {e1}, e2 = {e2}, e3 = {e3}: Errors: {total_counter}")
    return 0

import time

def main():
    start_time = time.time()
    for error in errors:
        iter_time = time.time()
        simulation(error[0], error[1], error[2])
        print(f"Execution time (iteration): {(time.time() - iter_time):.3f} (sec)\n")
    print(f"Execution time (total): {(time.time() - start_time):.3f} (sec)")
    

if __name__ == "__main__":
    main()

