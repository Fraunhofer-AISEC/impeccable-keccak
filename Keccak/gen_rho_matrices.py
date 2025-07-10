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

def gen_coding_matrix(N, M):
    P = np.ones((N, N), dtype=int)
    for j in range (0, N):
        for i in range (0, N):
            if ((i >= (j//M+1)*M) or (i < (j//M)*M) or (j%M + i%M == M-1)):
                P[j,i] = 0
    return P

def gen_shift_matrix(N, x):
    S = np.zeros((N, N), dtype=int)
    for i in range (0, N):
        S[i][(N-x+i)%N] = 1
    return S

def generate_file():
    rho_coefficients = np.array([0, 1, 62, 28, 27, 36, 44, 6, 55, 20, 3, 10, 43, 25, 39, 41, 45, 15, 21, 8, 18, 2, 61, 56, 14])
    P = gen_coding_matrix(64,4)
    f = open("./keccak_rho_constants.vhd", "w")
    f.writelines("--This file is generated automatically by gen_rho_matrices.py\n\n")
    f.writelines("library ieee;\nuse ieee.std_logic_1164.all;\n\n")
    f.writelines("package keccak_rho_constants is\n")
    f.writelines("type matrix_64_64_t is array (63 downto 0) of std_logic_vector(63 downto 0);\n")
    for i in range(25):
        f.writelines("constant rho_" + str(rho_coefficients[i]) + "\t:matrix_64_64_t := (\n")
        S = gen_shift_matrix(64, rho_coefficients[i])
        _S = np.matmul(np.matmul(P,S)%2,P)%2
        for i in range(64):
            f.writelines("\tb\"")
            for j in range(64):
                f.writelines(str(_S[i,j]))
            if i < 63:
                f.writelines("\",\n")
            else:
                f.writelines("\"\n")
        f.writelines(");\n\n")
    f.writelines("end package;\n")
    f.close()

if __name__ == "__main__":
    generate_file()

