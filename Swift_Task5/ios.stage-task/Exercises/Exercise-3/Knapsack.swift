import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }

    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }

    func findMaxKilometres() -> Int {
        var goodsTrash: [[Int]] = Array(repeating: Array(repeating: 0, count: maxWeight + 1),
                count: foods.count + 1)
        var drinksTrash: [[Int]] = Array(repeating: Array(repeating: 0, count: maxWeight + 1), count: drinks.count + 1)
        for i in 0..<foods.count {
            let currentFood = foods[i]
            for j in 1...maxWeight {
                if (((j - currentFood.weight > 0 && goodsTrash[i][j - currentFood.weight] > 0) ||
                        j - currentFood.weight == 0) && goodsTrash[i][j - currentFood.weight] + currentFood.value > goodsTrash[i][j]) {
                    goodsTrash[i + 1][j] = goodsTrash[i][j - currentFood.weight] + currentFood.value
                } else {
                    goodsTrash[i + 1][j] = goodsTrash[i][j]
                }
            }
        }

        for i in 0..<drinks.count {
            let currentDrink = drinks[i]
            for j in 1...maxWeight {
                if (((j - currentDrink.weight > 0 && drinksTrash[i][j - currentDrink.weight] > 0) ||
                        j - currentDrink.weight == 0) && drinksTrash[i][j - currentDrink.weight] + currentDrink.value > drinksTrash[i][j]) {
                    drinksTrash[i + 1][j] = drinksTrash[i][j - currentDrink.weight] + currentDrink.value
                } else {
                    drinksTrash[i + 1][j] = drinksTrash[i][j]
                }
            }
        }
        for i in 1...maxWeight {
            if (goodsTrash[foods.count][i] < goodsTrash[foods.count][i - 1]) {
                goodsTrash[foods.count][i] = goodsTrash[foods.count][i - 1]
            }
        }
        for i in 1...maxWeight {
            if (drinksTrash[drinks.count][i] < drinksTrash[drinks.count][i - 1]) {
                drinksTrash[drinks.count][i] = drinksTrash[drinks.count][i - 1]
            }
        }
        var max = 0
        for i in 0...maxWeight {
            let currentFood = goodsTrash[foods.count][i]
            let currentDrink = drinksTrash[drinks.count][maxWeight - i]
            var result = currentFood
            if (currentDrink < currentFood) {
                result = currentDrink
            }
            if (result > max) {
                max = result
            }
        }
        return max
    }
}