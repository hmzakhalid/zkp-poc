import hre from "hardhat";
import fs from "fs";

async function main() {

    const verifierAccreditedInvestor = await hre.viem.deployContract("VerifierAccreditedInvestor");

    console.log(
        "VerifierAccreditedInvestor deployed to:",
        verifierAccreditedInvestor.address);

    const verifierAccreditedInvestorArtifact = await hre.artifacts.readArtifact("VerifierAccreditedInvestor");

    const verifierAccreditedInvestorAddress = verifierAccreditedInvestor.address;

    const verifierAccreditedInvestorData = {
        address: verifierAccreditedInvestorAddress,
        abi: verifierAccreditedInvestorArtifact.abi,
    };

    const verifierAccreditedInvestorDataString = JSON.stringify(verifierAccreditedInvestorData, null, 2);
    const path = "config/verifierAccreditedInvestorData.json";

    fs.writeFileSync(
        path,
        verifierAccreditedInvestorDataString
    );

}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
