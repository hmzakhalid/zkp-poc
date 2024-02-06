#!/bin/bash
echo 'Running compile'

# Navigate to the ZoKrates program directory
cd ../zokrates

# List of verifications
VERIFICATIONS=("income" "assets" "debtIncomeRatio" "accreditedInvestor")

# Compile each ZoKrates program
for VERIFICATION in "${VERIFICATIONS[@]}"
do
    echo "Compiling ${VERIFICATION}..."
    zokrates compile -i ${VERIFICATION}/${VERIFICATION}.zok -o ${VERIFICATION}/compiled/${VERIFICATION}.out
done

echo "Compilation completed."

