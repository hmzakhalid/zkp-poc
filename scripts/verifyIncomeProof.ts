import hre from "hardhat";
import fs from "fs";
import { getContract } from "viem"
import path from "path";

async function main() {

    // Read verifier income json
    const verifierIncomeData = JSON.parse(fs.readFileSync(path.join(__dirname, "../config/verifierIncomeData.json"), "utf-8"));

    // Read proof
    const basePath = path.join(__dirname, "../zokrates/income/out");
    const processProof = JSON.parse(fs.readFileSync(path.join(basePath, "proof.json"), "utf-8"));
    console.log("Inputs: ", processProof.inputs);
    console.log("Verifier: ", processProof.proof);

    const verifierIncome = await hre.viem.getContractAt("VerifierIncome", verifierIncomeData.address);
    verifierIncome.read.verifyTx([processProof.proof, processProof.inputs]).then((result) => {
        console.log("Verify result: ", result);
    });

}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
