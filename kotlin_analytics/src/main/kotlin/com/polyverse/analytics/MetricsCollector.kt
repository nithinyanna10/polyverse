package com.polyverse.analytics

import java.util.concurrent.ConcurrentHashMap

class MetricsCollector {
    private val metrics = ConcurrentHashMap<String, Long>()
    
    fun increment(key: String) {
        metrics.compute(key) { _, value -> (value ?: 0) + 1 }
    }
    
    fun get(key: String): Long = metrics.getOrDefault(key, 0)
    
    fun getAll(): Map<String, Long> = metrics.toMap()
}

