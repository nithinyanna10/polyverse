<?php

namespace Polyverse\Api;

/**
 * API Controller
 */
class ApiController
{
    public function health(): array
    {
        return [
            'service' => 'PHP API',
            'status' => 'operational',
            'version' => '0.1.0'
        ];
    }
    
    public function getUsers(): array
    {
        return [
            'users' => [],
            'count' => 0
        ];
    }
    
    public function createUser(array $data): array
    {
        return [
            'id' => uniqid(),
            'name' => $data['name'] ?? 'Unknown',
            'created_at' => date('c')
        ];
    }
}

