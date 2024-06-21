#!/usr/bin/env python3

import subprocess
import os

input = "vtable-input.txt"
output = "vtable-output.txt"
test_command = "./v8_unittests --gtest_filter=CagedHeapDeathTest.AgeTableUncommittedBeforeGenerationalGCEnabled"

def get_all_vtable_name():
    f = open(output)
    vtables = [line.rstrip() for line in f]
    return vtables

def vtable_list_to_file(vtables):
    f = open(input, "w")
    for vtable in vtables:
        f.write(vtable + '\n')

def run_command(vtables):
    vtable_list_to_file(vtables)
    print(len(vtables))
    subprocess.run(['/home/luxufan/chromium-build/troubleshooting/DynCastOPT/single-run.sh', input])
    retcode = os.system(test_command)
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
