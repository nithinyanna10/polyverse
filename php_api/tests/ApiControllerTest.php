<?php

use PHPUnit\Framework\TestCase;
use Polyverse\Api\ApiController;

class ApiControllerTest extends TestCase
{
    public function testHealth()
    {
        $controller = new ApiController();
        $result = $controller->health();
        
        $this->assertEquals('PHP API', $result['service']);
        $this->assertEquals('operational', $result['status']);
    }
}

