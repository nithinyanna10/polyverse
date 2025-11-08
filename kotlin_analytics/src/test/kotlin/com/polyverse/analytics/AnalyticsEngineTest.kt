package com.polyverse.analytics

import kotlinx.coroutines.runBlocking
import org.junit.jupiter.api.Test
import kotlin.test.assertEquals

class AnalyticsEngineTest {
    @Test
    fun testProcessBatch() = runBlocking {
        val engine = AnalyticsEngine()
        val data = listOf(1.0, 2.0, 3.0, 4.0, 5.0)
        val result = engine.processBatch(data)
        
        assertEquals(3.0, result["mean"]!!, 0.01)
    }
}

