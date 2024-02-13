use actix_web::{post, web, App, HttpResponse, HttpServer, Responder};
use serde::{Deserialize, Serialize};
use std::{collections::HashMap, fs};
use lazy_static::lazy_static;

mod utils;

use utils::{compute_witness, generate_proof};


const VERIFIER_CONTRACT: &str = "0xd85e84df022c1df67e00232b8bbe1639aaee996e";

struct User {
    networth: u64,
    income: u64,
}

lazy_static! {
    static ref DATABASE: HashMap<String, User> = HashMap::from([
        (
            String::from("0x123"),
            User {
                networth: 1000000,
                income: 250000,
            },
        ),
        (
            String::from("0x456"),
            User {
                networth: 500000,
                income: 50000,
            },
        ),
    ]);
}


#[derive(Deserialize)]
struct ProofRequest {
    user_id: String,
}

#[derive(Serialize)]
struct ProofResponse {
    verifier_contract: Option<String>,
    message: String,
    proof: Option<serde_json::Value>,
}


#[post("/get_proof")]
async fn get_proof(req_body: web::Json<ProofRequest>) -> impl Responder {
    let user_id = req_body.user_id.clone();
    let user = match DATABASE.get(&user_id) {
        Some(user) => user,
        None => return HttpResponse::NotFound().json(ProofResponse {
            verifier_contract: None,
            message: "User not found".to_string(),
            proof: None,
        }),
    };
    let networth = user.networth;
    let income = user.income;

    if let Err(_) = compute_witness(networth, income) {
        return HttpResponse::UnprocessableEntity().json(ProofResponse {
            verifier_contract: None,
            message: "User does not pass accredited investor checks".to_string(),
            proof: None,
        });
    }

    if let Err(_) = generate_proof() {
        return HttpResponse::InternalServerError().json(ProofResponse {
            verifier_contract: None,
            message: "Failed to generate proof".to_string(),
            proof: None,
        });
    }


    let proof_json = fs::read_to_string("../zokrates/accreditedInvestor/out/proof.json")
        .expect("Failed to read proof.json");

    let proof: serde_json::Value = serde_json::from_str(&proof_json).expect("Failed to parse proof.json");

    HttpResponse::Ok().json(ProofResponse {
        verifier_contract: Some(VERIFIER_CONTRACT.to_string()),
        message: "Proof generated successfully".to_string(),
        proof: Some(proof),
    })
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| App::new().service(get_proof))
        .bind(("127.0.0.1", 4000))?
        .run()
        .await
}

