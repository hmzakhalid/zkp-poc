#!/bin/bash
echo 'Running compute_witness'

#!/bin/bash

income=50000
assets=100000
debt=20000
debtIncomeRatio=0.4
accreditedInvestorThreshold=1000000

# Navigate to the ZoKrates program directory
cd financial-verification-zkp/zokrates/income

# Example for income verification
echo "Computing witness for income verification..."
zokrates compute-witness -a ${income} -i compiled/income.out -w out/income.witness


echo "Witness computation completed."
