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
import keccak
import coding as cd
import argparse

def generate_test_vectors(number_of_vectors):        
    '''
    function "generate_test_vectors" generates "number_of_vectors"
    test vectors for the Keccak module
    input   :   number_of_vectors   : (int) number of test vectors to generate
    '''
    test_in = open("./test_vectors/test_in.txt", "w")
    test_out = open("./test_vectors/test_ref_out.txt", "w")
    sim_out = open("./test_vectors/simulation_out.txt", "w")

    for i in range(number_of_vectors):
        state = cd.generate_random_state()
        for y in range(5):
                for x in range(5):
                    hw = cd.bitstring_to_integer(state[y,x,32:])
                    lw = cd.bitstring_to_integer(state[y,x,:32])
                    test_in.writelines(hex(hw)[2:].zfill(8).upper() + hex(lw)[2:].zfill(8).upper() + "\n")
        test_in.writelines("-\n")

        for round_number in range(24):
            state = keccak.keccak(state,round_number)
            
        for y in range(5):
            for x in range(5):
                hw = hex(cd.bitstring_to_integer(state[y,x,32:]))
                lw = hex(cd.bitstring_to_integer(state[y,x,:32]))
                test_out.writelines(hw[2:].zfill(8).upper() + lw[2:].zfill(8).upper() + "\n")
        test_out.writelines("-\n")

    test_in.writelines(".")
    test_out.writelines(".")

    test_in.close()
    test_out.close()
    sim_out.close()
    return 0

def main():
    parser = argparse.ArgumentParser(description = "Test vectors generator")
    parser.add_argument('-n', '--num', type=int, default=2, help='Number of generated test vectors')
    args = parser.parse_args()
    generate_test_vectors(args.num)
    return 0

if __name__ == '__main__':
    main()
