#!/usr/bin/env bash

rm vtable-temp.txt
touch vtable-temp.txt

while read p; do
    echo "$p"
    echo "$p" > vtable-temp.txt
    /home/luxufan/dev/llvm-dev/build-release/bin/clang++ -flto -fuse-ld=lld -fwhole-program-vtables -fuse-ld=gold -O3 -DNDEBUG -flto -fuse-ld=lld  -Wl,-plugin-opt=save-temps -Wl,--lto-whole-program-visibility -save-stats=obj -flto -fuse-ld=lld test/tools/CMakeFiles/isoltest.dir/isoltest.cpp.o test/tools/CMakeFiles/isoltest.dir/IsolTestOptions.cpp.o test/tools/CMakeFiles/isoltest.dir/__/Common.cpp.o test/tools/CMakeFiles/isoltest.dir/__/CommonSyntaxTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/EVMHost.cpp.o test/tools/CMakeFiles/isoltest.dir/__/TestCase.cpp.o test/tools/CMakeFiles/isoltest.dir/__/TestCaseReader.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/util/BytesUtils.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/util/Common.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/util/ContractABIUtils.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/util/TestFileParser.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/util/TestFunctionCall.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/GasTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/MemoryGuardTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/NatspecJSONTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/SyntaxTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/SemanticTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/AnalysisFramework.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/SolidityExecutionFramework.cpp.o test/tools/CMakeFiles/isoltest.dir/__/ExecutionFramework.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/ABIJsonTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/ASTJSONTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/ASTPropertyTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/FunctionDependencyGraphTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libsolidity/SMTCheckerTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libyul/Common.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libyul/ControlFlowGraphTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libyul/ControlFlowSideEffectsTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libyul/EVMCodeTransformTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libyul/FunctionSideEffects.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libyul/ObjectCompilerTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libyul/SyntaxTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libyul/StackShufflingTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libyul/StackLayoutGeneratorTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libyul/YulOptimizerTest.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libyul/YulOptimizerTestCommon.cpp.o test/tools/CMakeFiles/isoltest.dir/__/libyul/YulInterpreterTest.cpp.o -o test/tools/isoltest  libsolc/libsolc.a  libsolidity/libsolidity.a  test/tools/yulInterpreter/libyulInterpreter.a  libevmasm/libevmasm.a  /usr/lib/libboost_program_options.a  /usr/lib/libboost_unit_test_framework.a  test/evmc/libevmc_loader.a  -ldl  libsolidity/libsolidity.a  libyul/libyul.a  libevmasm/libevmasm.a  liblangutil/liblangutil.a  libsmtutil/libsmtutil.a  libsolutil/libsolutil.a  /usr/lib/libboost_filesystem.a  /usr/lib/libboost_atomic.a  /usr/lib/libboost_system.a -Wl,-plugin-opt=-vtable-file=vtable-temp.txt
    ./test/tools/isoltest --no-semantic-tests > /dev/null
    if [ $? -eq 0 ]; then
	echo "test pass"
    else
	echo "test fail"
    fi
done < $1
