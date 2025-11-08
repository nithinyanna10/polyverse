package com.polyverse.analytics

import kotlinx.coroutines.*

/**
 * Analytics engine for data processing
 */
class AnalyticsEngine {
    suspend fun processBatch(data: List<Double>): Map<String, Double> = withContext(Dispatchers.Default) {
        mapOf(
            "mean" to data.average(),
            "median" to data.median(),
            "stdDev" to data.standardDeviation(),
            "variance" to data.variance()
        )
    }
    
    private fun List<Double>.median(): Double {
        val sorted = sorted()
        return if (size % 2 == 0) {
            (sorted[size / 2 - 1] + sorted[size / 2]) / 2.0
        } else {
            sorted[size / 2]
        }
    }
    
    private fun List<Double>.standardDeviation(): Double {
        val mean = average()
        val variance = map { (it - mean).pow(2) }.average()
        return kotlin.math.sqrt(variance)
    }
    
    private fun List<Double>.variance(): Double {
        val mean = average()
        return map { (it - mean).pow(2) }.average()
    }
}

