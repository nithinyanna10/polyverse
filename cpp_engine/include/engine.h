/**
 * ⚙️ High-perf compute backend - Eigen + REST bridge
 * C++ engine header
 */

#ifndef ENGINE_H
#define ENGINE_H

#include <string>
#include <vector>
#include <memory>

namespace polyverse {

class Engine {
public:
    Engine();
    ~Engine();
    
    // Matrix operations using Eigen
    std::vector<double> matrixMultiply(const std::vector<double>& a, 
                                       const std::vector<double>& b,
                                       int rows_a, int cols_a, 
                                       int rows_b, int cols_b);
    
    // Vector operations
    std::vector<double> vectorAdd(const std::vector<double>& a, 
                                  const std::vector<double>& b);
    
    // Compute intensive task
    double computeTask(const std::vector<double>& input);
    
    // Health check
    bool isHealthy() const;

private:
    bool initialized_;
};

} // namespace polyverse

#endif // ENGINE_H

