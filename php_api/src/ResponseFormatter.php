<?php

namespace Polyverse\Api;

class ResponseFormatter
{
    public static function success($data): array
    {
        return [
            'success' => true,
            'data' => $data,
            'timestamp' => date('c')
        ];
    }
    
    public static function error($message): array
    {
        return [
            'success' => false,
            'error' => $message,
            'timestamp' => date('c')
        ];
    }
}

