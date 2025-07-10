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
import coding as cd

round_constant = [
    0x0000_0000_0000_0001,
    0x0000_0000_0000_8082,
    0x8000_0000_0000_808a,
    0x8000_0000_8000_8000,
    0x0000_0000_0000_808b,
    0x0000_0000_8000_0001,
    0x8000_0000_8000_8081,
    0x8000_0000_0000_8009,
    0x0000_0000_0000_008a,
    0x0000_0000_0000_0088,
    0x0000_0000_8000_8009,
    0x0000_0000_8000_000a,
    0x0000_0000_8000_808b,
    0x8000_0000_0000_008b,
    0x8000_0000_0000_8089,
    0x8000_0000_0000_8003,
    0x8000_0000_0000_8002,
    0x8000_0000_0000_0080,
    0x0000_0000_0000_800a,
    0x8000_0000_8000_000a,
    0x8000_0000_8000_8081,
    0x8000_0000_0000_8080,
    0x0000_0000_8000_0001,
    0x8000_0000_8000_8008]

def theta_permutation(state):
    buffer = np.zeros((5,5,64),dtype=int)
    parity_plane = np.zeros((5,64), dtype = int)
    for x in range(5):
        for y in range(5):
            parity_plane[x,:] ^= state[y,x,:]
    for y in range(5):
        for x in range(5):
            for z in range(64):
                buffer[y,x,z] = state[y,x,z] ^ parity_plane[(x-1)%5,z] ^ parity_plane[(x+1)%5,(z-1)%64]
    return buffer

def rho_permutation(state):
    XY = np.array((1,0))
    rho_matrix = np.array(([0,1],[2,3]))
    for t in range(24):
        shift = int(((t+1) * (t+2) / 2) % 64)
        state[XY[1], XY[0], : ] = np.concatenate((state[XY[1], XY[0], 64 - shift : 64], state[XY[1],XY[0], 0 : 64-shift]))
        XY = np.matmul(rho_matrix, XY) % 5
    return state

def pi_permutation(state):
    buffer = np.zeros((5,5,64), dtype = int)
    pi_matrix = np.array(([0,1],[2,3]))
    for x in range(5):
        for y in range(5):
            X = y
            Y = (2*x + 3*y) % 5
            buffer[Y, X, :] = state[y,x,:]
    return buffer

def chi_permutation(state):
    buffer = np.zeros((5,5,64), dtype = int)
    for y in range(5):
        for x in range(5):
            for z in range(64):
                buffer[y, x, z] = state[y, x, z] ^ (((state[y, (x + 1) % 5, z]) ^ 1) & state[y, (x + 2) % 5, z])
    return buffer

def iota_permutation(state, round_number):
    r = cd.integer_to_bitstring(round_constant[round_number], 64)
    for z in range(64):
        state[0,0,z] = (state[0,0,z] + r[z]) % 2
    return state

def keccak(state, round_number):
    state = theta_permutation(state)
    state = rho_permutation(state)
    state = pi_permutation(state)
    state = chi_permutation(state)
    state = iota_permutation(state, round_number)
    return state
