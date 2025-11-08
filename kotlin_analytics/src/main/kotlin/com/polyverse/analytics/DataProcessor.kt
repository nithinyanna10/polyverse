package com.polyverse.analytics

import kotlinx.coroutines.*

class DataProcessor {
    suspend fun processAsync(data: List<Double>): Double = withContext(Dispatchers.Default) {
        data.sum()
    }
}

