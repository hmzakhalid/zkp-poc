import hre from "hardhat";
import fs from "fs";
import path from "path";

async function main() {

    // Read verifier accredited investor data
    const verifierAccreditedInvestorData = JSON.parse(fs.readFileSync(path.join(__dirname, "../config/verifierAccreditedInvestorData.json"), "utf-8"));

    // Read proof
    const basePath = path.join(__dirname, "../zokrates/accreditedInvestor/out");
    const processProof = JSON.parse(fs.readFileSync(path.join(basePath, "proof.json"), "utf-8"));
    console.log("Inputs: ", processProof.inputs);
    console.log("Verifier: ", processProof.proof);

    const verifierAccreditedInvestor = await hre.viem.getContractAt("VerifierAccreditedInvestor", verifierAccreditedInvestorData.address);
    verifierAccreditedInvestor.read.verifyTx([processProof.proof]).then((result) => {
        console.log("Verify result: ", result);
    });

}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
