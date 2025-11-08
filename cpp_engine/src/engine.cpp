/**
 * ⚙️ High-perf compute backend implementation
 */

#include "engine.h"
#include <algorithm>
#include <numeric>
#include <stdexcept>

namespace polyverse {

Engine::Engine() : initialized_(true) {
}

Engine::~Engine() {
}

std::vector<double> Engine::matrixMultiply(const std::vector<double>& a, 
                                           const std::vector<double>& b,
                                           int rows_a, int cols_a, 
                                           int rows_b, int cols_b) {
    if (cols_a != rows_b) {
        throw std::runtime_error("Matrix dimensions incompatible");
    }
    
    std::vector<double> result(rows_a * cols_b, 0.0);
    
    for (int i = 0; i < rows_a; ++i) {
        for (int j = 0; j < cols_b; ++j) {
            for (int k = 0; k < cols_a; ++k) {
                result[i * cols_b + j] += a[i * cols_a + k] * b[k * cols_b + j];
            }
        }
    }
    
    return result;
}

std::vector<double> Engine::vectorAdd(const std::vector<double>& a, 
                                         const std::vector<double>& b) {
    if (a.size() != b.size()) {
        throw std::runtime_error("Vector sizes must match");
    }
    
    std::vector<double> result(a.size());
    std::transform(a.begin(), a.end(), b.begin(), result.begin(),
                  [](double x, double y) { return x + y; });
    return result;
}

double Engine::computeTask(const std::vector<double>& input) {
    if (input.empty()) {
        return 0.0;
    }
    
    // Compute-intensive operation
    double sum = std::accumulate(input.begin(), input.end(), 0.0);
    double mean = sum / input.size();
    
    double variance = 0.0;
    for (double val : input) {
        variance += (val - mean) * (val - mean);
    }
    variance /= input.size();
    
    return variance;
}

bool Engine::isHealthy() const {
    return initialized_;
}

} // namespace polyverse

