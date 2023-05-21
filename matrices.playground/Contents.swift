import Cocoa

func minDistance(_ matrix: [[Int]]) -> [[Int]] {
    let rows = matrix.count
    let cols = matrix[0].count
    
    // Создаем новую матрицу, заполненную максимальными значениями
    var result = Array(
        repeating: Array(repeating: Int.max, count: cols),
        count: rows
    )
    
    // Проходим по матрице вперед
    for i in 0..<rows {
        for j in 0..<cols {
            // Если значение текущей ячейки равно 1, то расстояние до ближайшей ячейки со значением 1 равно 0
            if matrix[i][j] == 1 {
                result[i][j] = 0
            } else {
                // Если значение текущей ячейки равно 0, то ищем ближайшую ячейку со значением 1
                if i > 0 {
                    result[i][j] = min(result[i][j], result[i - 1][j] + 1)
                }
                if j > 0 {
                    result[i][j] = min(result[i][j], result[i][j - 1] + 1)
                }
            }
        }
    }
    
    // Проходим по матрице назад
    for i in (0..<rows).reversed() {
        for j in (0..<cols).reversed() {
            if i < rows - 1 {
                result[i][j] = min(result[i][j], result[i + 1][j] + 1)
            }
            if j < cols - 1 {
                result[i][j] = min(result[i][j], result[i][j + 1] + 1)
            }
        }
    }
    
    return result
}

let exampleInput = [
    [1,0,1],
    [0,1,0],
    [0,0,0]
]

let exampleOutput = minDistance(exampleInput)

print(exampleOutput)
