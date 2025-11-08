/**
 * ⚡ Real-time event processor - Actix + Tokio
 * High-performance event processing service
 */

use actix_web::{web, App, HttpServer, HttpResponse, Result};
use serde::{Deserialize, Serialize};
use std::sync::Arc;
use tokio::sync::RwLock;
use std::collections::HashMap;

#[derive(Debug, Clone, Serialize, Deserialize)]
struct Event {
    event_type: String,
    payload: HashMap<String, String>,
    timestamp: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
struct ProcessedEvent {
    event_id: String,
    original_event: Event,
    processed_at: String,
    result: String,
}

struct AppState {
    event_queue: Arc<RwLock<Vec<Event>>>,
    processed_events: Arc<RwLock<Vec<ProcessedEvent>>>,
}

async fn health() -> Result<HttpResponse> {
    Ok(HttpResponse::Ok().json(serde_json::json!({
        "service": "Rust Signal",
        "status": "operational",
        "version": "0.1.0"
    })))
}

async fn process_event(
    event: web::Json<Event>,
    state: web::Data<AppState>,
) -> Result<HttpResponse> {
    let mut queue = state.event_queue.write().await;
    queue.push(event.into_inner());
    
    // Process event asynchronously
    tokio::spawn(async move {
        // Simulate processing
        tokio::time::sleep(tokio::time::Duration::from_millis(10)).await;
    });
    
    Ok(HttpResponse::Ok().json(serde_json::json!({
        "status": "queued",
        "message": "Event queued for processing"
    })))
}

async fn get_stats(state: web::Data<AppState>) -> Result<HttpResponse> {
    let queue = state.event_queue.read().await;
    let processed = state.processed_events.read().await;
    
    Ok(HttpResponse::Ok().json(serde_json::json!({
        "queue_size": queue.len(),
        "processed_count": processed.len()
    })))
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    println!("⚡ Rust Signal service starting...");
    
    let app_state = web::Data::new(AppState {
        event_queue: Arc::new(RwLock::new(Vec::new())),
        processed_events: Arc::new(RwLock::new(Vec::new())),
    });

    HttpServer::new(move || {
        App::new()
            .app_data(app_state.clone())
            .route("/health", web::get().to(health))
            .route("/events", web::post().to(process_event))
            .route("/stats", web::get().to(get_stats))
    })
    .bind("0.0.0.0:8080")?
    .run()
    .await
}

