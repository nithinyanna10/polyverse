<?php

namespace Polyverse\Api\Middleware;

class AuthMiddleware
{
    public function handle($request, $next)
    {
        // TODO: Implement authentication
        return $next($request);
    }
}

