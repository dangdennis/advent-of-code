import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [Substring] {
    data.split(separator: "\n")
  }

  func part1() -> Any {
    let digits = entities.map { line in
      let firstDigit = line.first(where: { character in
        character.isNumber
      })
      let lastDigit = line.last(where: { character in
        character.isNumber
      })

      guard let firstDigit,
        let lastDigit
      else { return 0 }

      return Int(String(firstDigit))! * 10 + Int(String(lastDigit))!
    }

    return digits.reduce(0, +)
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    // parse the line for all the individual numbers

    return ""
  }

}

extension Day01 {
  static private let numberWords: [String: Int] = [
    "one": 1,
    "two": 2,
    "three": 3,
    "four": 4,
    "five": 5,
    "six": 6,
    "seven": 7,
    "eight": 8,
    "nine": 9,
  ]

  static func parseNumbers(in string: String) -> [Int] {

    // Recursive function to parse numbers
    func backtrack(_ substring: String, _ currentIndex: Int) -> [Int]? {
      // Base case: if we've reached the end of the string
      if currentIndex >= substring.count {
        return []
      }

      // Attempt to find a valid number word at the current index
      var result: [Int] = []
      for i in currentIndex..<substring.count {
        let indexStart = substring.index(substring.startIndex, offsetBy: currentIndex)
        let indexEnd = substring.index(substring.startIndex, offsetBy: i)
        let potentialWord = String(substring[indexStart...indexEnd])

        if let number = numberWords[potentialWord] {
          if let remainingResult = backtrack(substring, i + 1) {
            var newResult = [number]
            newResult.append(contentsOf: remainingResult)
            // Choose the solution with the fewest numbers
            print("newResult = \(newResult)")
            if newResult.count < result.count {
              result = newResult
              print("result = \(result)")
            }
          }
        }
      }

      return result
    }

    return backtrack(string, 0) ?? []
  }
}
