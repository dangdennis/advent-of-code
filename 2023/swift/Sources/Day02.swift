import Algorithms

struct Game {
  let id: Int
  let red: Int
  let green: Int
  let blue: Int
}

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [Game] {
    data.split(separator: "\n").map { line in
      let lineComponents: [String] = line.split(separator: ":").compactMap({
        $0.trimmingCharacters(in: .whitespaces)
      })

      let gameId = lineComponents[0]

      guard
        let stringId = gameId.split(separator: " ").last,
        let id = Int(stringId)
      else {
        fatalError("Invalid game id: \(gameId)")
      }

      let drawSets = lineComponents[1].split(separator: ";").map({
        $0.trimmingCharacters(in: .whitespaces)
      })

      let parsedSets = drawSets.map({ drawSet in
        return drawSet.split(separator: ",").map({ $0.trimmingCharacters(in: .whitespaces) })
      })

      var red = 0
      var blue = 0
      var green = 0

      for set in parsedSets {
        for color in set {
          let colorComponents = color.split(separator: " ").map({
            $0.trimmingCharacters(in: .whitespaces)
          })
          if colorComponents[1] == "red" {
            red = max(red, Int(colorComponents[0]) ?? 0)
          } else if colorComponents[1] == "blue" {
            blue = max(blue, Int(colorComponents[0]) ?? 0)
          } else if colorComponents[1] == "green" {
            green = max(green, Int(colorComponents[0]) ?? 0)
          }
        }
      }

      return Game(id: id, red: red, green: green, blue: blue)
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    return self.entities.reduce(0) { partialResult, game in
      if game.red <= 12 && game.green <= 13 && game.blue <= 14 {
        return partialResult + game.id
      }

      return partialResult
    }
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    // Sum the maximum entries in each set of data
    // entities.map { $0.max() ?? 0 }.reduce(0, +)
    return 0
  }
}
