import Foundation

let startTime = Date().timeIntervalSince1970
print(fib(for: 6))
let endTime = Date().timeIntervalSince1970
print("TIME: ", endTime - startTime)
