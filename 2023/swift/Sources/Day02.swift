// Sources/Day02.swift
struct Game {
  let id: Int
  let red: Int
  let green: Int
  let blue: Int
}

struct Day02: AdventDay {
  var data: String

  var entities: [Game] {
    data.split(separator: "\n").map { line in
      let lineComponents = line.split(separator: ":").map {
        $0.trimmingCharacters(in: .whitespaces)
      }

      guard
        let stringId = lineComponents[0].split(separator: " ").last,
        let id = Int(stringId)
      else {
        fatalError("Invalid game id: \(lineComponents[0])")
      }

      let drawSets = lineComponents[1].split(separator: ";").map {
        $0.trimmingCharacters(in: .whitespaces)
      }

      let parsedSets = drawSets.map { drawSet in
        drawSet.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
      }

      let (red, green, blue) = parsedSets.flatMap { $0 }.reduce((0, 0, 0)) { result, color in
        let colorComponents = color.split(separator: " ").map {
          $0.trimmingCharacters(in: .whitespaces)
        }
        let value = Int(colorComponents[0]) ?? 0

        switch colorComponents[1] {
        case "red":
          return (max(result.0, value), result.1, result.2)
        case "green":
          return (result.0, max(result.1, value), result.2)
        case "blue":
          return (result.0, result.1, max(result.2, value))
        default:
          return result
        }
      }

      return Game(id: id, red: red, green: green, blue: blue)
    }
  }

  func part1() -> Any {
    return entities.reduce(0) { partialResult, game in
      if game.red <= 12 && game.green <= 13 && game.blue <= 14 {
        return partialResult + game.id
      }

      return partialResult
    }
  }

  func part2() -> Any {
    return 0  // Replace this with your solution for the second part of the day's challenge.
  }
}
