
echo "Generating the ABIs for the contracts"

solcjs --abi contracts/tokens/FastTestToken.sol -o abi
solcjs --abi contracts/tokens/DetailedTestToken.sol -o abi

echo "Generating the EVM bytecode for the contracts"

solcjs --bin contracts/tokens/FastTestToken.sol -o bytecode
solcjs --bin contracts/tokens/DetailedTestToken.sol -o bytecode

echo "Making directories for the to be created packages"

mkdir -p pkg/contracts/detailed_test_token
mkdir -p pkg/contracts/fast_test_token

echo "Compiling the abi and bytecode for the contracts to create go packages"

abigen --bin=./bytecode/contracts_tokens_FastTestToken_sol_FastTestToken.bin --abi=./abi/contracts_tokens_FastTestToken_sol_FastTestToken.abi --pkg=fast_test_token --out=pkg/contracts/fast_test_token/fast_test_token.go
abigen --bin=./bytecode/contracts_tokens_DetailedTestToken_sol_DetailedTestToken.bin --abi=./abi/contracts_tokens_DetailedTestToken_sol_DetailedTestToken.abi --pkg=detailed_test_token --out=pkg/contracts/detailed_test_token/detailed_test_token.go

echo "Clearing the generated bytecode files"

cd bytecode || exit
find . -name "*.bin" -type f -delete

echo "Script Execution Completed!"