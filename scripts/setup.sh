#!/bin/bash
echo 'Running setup'

# Navigate to the ZoKrates program directory
cd zokrates

# List of verifications
VERIFICATIONS=("income" "assets" "debtIncomeRatio" "accreditedInvestor")

# Perform the setup
for VERIFICATION in "${VERIFICATIONS[@]}"
do
    echo "Performing setup for ${VERIFICATION}..."
    zokrates setup -i ${VERIFICATION}/compiled/${VERIFICATION}.out -p ${VERIFICATION}/out/proving.key -v ${VERIFICATION}/out/verification.key
done

echo "Setup completed."
