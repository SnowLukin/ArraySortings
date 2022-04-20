//
//  ArraySortings
//
//  Created by Snow Lukin on 20.04.2022.
//

import Foundation

struct Sortings {
    func bubbleSort(_ array: [Int]) -> [Int] {
        let start = DispatchTime.now()
        var dataSet = array
        var isSorted = false
        
        while !isSorted {
            isSorted = true
            for index in 0..<dataSet.count - 1 {
                if dataSet[index] > dataSet[index + 1] {
                    dataSet.swapAt(index, index + 1)
                    isSorted = false
                }
            }
        }
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000
        print("Time to evaluate \(timeInterval) seconds \n")
        
        return dataSet
    }
    
    func oddEvenSort(_ array: [Int]) -> [Int] {
        let start = DispatchTime.now()
        var dataSet = array
        var isSorted = false
        
        while !isSorted {
            isSorted = true
            // Bubble sort for odd indexed elements
            for index in stride(from: 0, to: dataSet.count - 2, by: 2) {
                if dataSet[index] > dataSet[index + 1] {
                    dataSet.swapAt(index, index + 1)
                    isSorted = false
                }
            }
            // Bubble sort for even indexed elements
            for index in stride(from: 1, to: dataSet.count - 2, by: 2) {
                if dataSet[index] > dataSet[index + 1] {
                    dataSet.swapAt(index, index + 1)
                    isSorted = false
                }
            }
        }
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000
        print("Time to evaluate \(timeInterval) seconds \n")
        return dataSet
    }
    
    func shellSort(_ array: [Int]) -> [Int] {
        let start = DispatchTime.now()
        var dataSet = array
        var h = 1
        
        while h < dataSet.count / 3 {
            h = 3 * h + 1
        }
        
        while h >= 1 {
            for indexI in h..<dataSet.count {
                for indexJ in stride(from: indexI, to: h - 1, by: -h) {
                    if dataSet[indexJ] < dataSet[indexJ - h] {
                        dataSet.swapAt(indexJ, indexJ - h)
                    } else {
                        break
                    }
                }
            }
            h /= 3
        }
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000
        print("Time to evaluate \(timeInterval) seconds \n")
        return dataSet
    }
    
    func parallelOddEvenSort(_ array: [Int]) -> [Int] {
        let start = DispatchTime.now()
        var dataSet = array
        var isSorted = false
        
        while !isSorted {
            isSorted = true
            DispatchQueue.main.async {
                // Bubble sort for odd indexed elements
                DispatchQueue.main.sync {
                    for index in stride(from: 0, to: dataSet.count - 2, by: 2) {
                        if dataSet[index] > dataSet[index + 1] {
                            dataSet.swapAt(index, index + 1)
                            isSorted = false
                        }
                    }
                }
                // Bubble sort for even indexed elements
                DispatchQueue.main.sync {
                    for index in stride(from: 1, to: dataSet.count - 2, by: 2) {
                        if dataSet[index] > dataSet[index + 1] {
                            dataSet.swapAt(index, index + 1)
                            isSorted = false
                        }
                    }
                }
            }
        }
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000
        print("Time to evaluate \(timeInterval) seconds \n")
        return dataSet
    }
    
    func parallelShellSort(_ array: [Int]) -> [Int] {
        let start = DispatchTime.now()
        var dataSet = array
        var h = 1
        
        
        while h < dataSet.count / 3 {
            h = 3 * h + 1
        }
        
        DispatchQueue.main.async {
            while h >= 1 {
                DispatchQueue.main.sync {
                    for indexI in h..<dataSet.count {
                        for indexJ in stride(from: indexI, to: h - 1, by: -h) {
                            if dataSet[indexJ] < dataSet[indexJ - h] {
                                dataSet.swapAt(indexJ, indexJ - h)
                            } else {
                                break
                            }
                        }
                    }
                }
                
                DispatchQueue.main.sync {
                    h /= 3
                }
            }
        }
        
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000
        print("Time to evaluate \(timeInterval) seconds \n")
        return dataSet
    }
}

func main() {
    let array = Array(0...10000)
    print("Bubble sort")
    _ = Sortings().bubbleSort(array)
    print("Odd Even sort")
    _ = Sortings().oddEvenSort(array)
    print("Prallel Odd Even sort")
    _ = Sortings().parallelOddEvenSort(array)
    print("Shell sort")
    _ = Sortings().shellSort(array)
    print("Parallel Shell sort")
    _ = Sortings().parallelShellSort(array)
}

main()
