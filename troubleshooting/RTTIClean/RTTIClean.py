#!/usr/bin/env python3

import subprocess
import os

def get_all_vtable_name():
    f = open("vtable-output.txt")
    vtables = [line.rstrip() for line in f]
    return vtables

def vtable_list_to_file(vtables):
    f = open("vtable-input.txt", "w")
    for vtable in vtables:
        f.write(vtable + '\n')

def run_command(vtables):
    vtable_list_to_file(vtables)
    print(len(vtables))
    subprocess.run(['/home/luxufan/dev/chromium-build/troubleshooting/RTTIClean/single-run.sh', '/home/luxufan/dev/dyncastopt-benchmarks/solidity/build/vtable-input.txt'])
    retcode = os.system("./test/tools/isoltest --no-semantic-tests > /dev/null")
    #result = subprocess.Popen(["./test/tools/isoltest", "--no-semantic-tests", ">", "/dev/null"])
    return retcode == 0


def binary_search(vtables):
    success = run_command(vtables)
    if len(vtables) == 1:
        if not success:
            print(vtables[0])
            return False
        else:
            return True

    if success:
        return True

    vtables_left = vtables[:len(vtables)//2]
    vtables_right = vtables[len(vtables)//2:]
    if not binary_search(vtables_left):
        return False
    else:
        return binary_search(vtables_right)

binary_search(get_all_vtable_name())
