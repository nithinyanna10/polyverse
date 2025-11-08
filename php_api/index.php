<?php
/**
 * 🔌 PHP API Service
 * RESTful API service for Polyverse
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

$requestUri = $_SERVER['REQUEST_URI'];
$requestMethod = $_SERVER['REQUEST_METHOD'];

// Health check
if ($requestUri === '/health' && $requestMethod === 'GET') {
    echo json_encode([
        'service' => 'PHP API',
        'status' => 'operational',
        'version' => '0.1.0',
        'timestamp' => date('c')
    ]);
    exit;
}

// API endpoints
if (strpos($requestUri, '/api/v1') === 0) {
    $path = str_replace('/api/v1', '', $requestUri);
    
    if ($path === '/users' && $requestMethod === 'GET') {
        echo json_encode([
            'users' => [],
            'count' => 0
        ]);
        exit;
    }
    
    if ($path === '/users' && $requestMethod === 'POST') {
        $input = json_decode(file_get_contents('php://input'), true);
        echo json_encode([
            'id' => uniqid(),
            'name' => $input['name'] ?? 'Unknown',
            'created_at' => date('c')
        ]);
        exit;
    }
}

http_response_code(404);
echo json_encode(['error' => 'Not found']);

