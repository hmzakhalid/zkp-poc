use std::{process::Command, str};

pub fn compute_witness(networth: u64, income: u64) -> Result<(), String> {
    let compute_witness_cmd = format!(
        "../scripts/compute_witness.sh accreditedInvestor {} {}",
        income, networth
    );
    let output = Command::new("sh")
        .arg("-c")
        .arg(&compute_witness_cmd)
        .output()
        .expect("Failed to execute compute_witness.sh");

    if output.status.success() {
        println!(
            "{}",
            str::from_utf8(&output.stdout).unwrap_or("Could not decode output")
        );
        Ok(())
    } else {
        println!(
            "{}",
            str::from_utf8(&output.stderr).unwrap_or("Could not decode error output")
        );
        Err(str::from_utf8(&output.stderr)
            .unwrap_or("Execution failed")
            .to_string())
    }
}

pub fn generate_proof() -> Result<(), String> {
    let generate_proof_cmd = "../scripts/generate_proof.sh";
    let output = Command::new("sh")
        .arg("-c")
        .arg(&generate_proof_cmd)
        .output()
        .expect("Failed to execute generate_proof.sh");

    if output.status.success() {
        println!(
            "{}",
            str::from_utf8(&output.stdout).unwrap_or("Could not decode output")
        );
        Ok(())
    } else {
        println!(
            "{}",
            str::from_utf8(&output.stderr).unwrap_or("Could not decode error output")
        );
        Err(str::from_utf8(&output.stderr)
            .unwrap_or("Execution failed")
            .to_string())
    }
}
