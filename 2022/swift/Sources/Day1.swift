import Foundation

struct Day1 {
  static func run(part: Int32) {
    switch part {
    case 1:
      part1()
    case 2:
      part2()
    default:
      print("Part \(part)")
    }
  }

  static func inputs() -> [Int] {
    let path = "Sources/day1.input"
    let contents = try! String(contentsOfFile: path, encoding: .utf8)
    let lines = contents.components(separatedBy: .newlines)

    var elves = [Int]()
    var total = 0
    for line in lines {
      if line == "" {
        elves.append(total)
        total = 0
      } else {
        total += Int(line)!
      }
    }

    return elves
  }

  static func part1() {
    let elves = inputs()
    print(elves.max()!)
  }

  static func part2() {
    let i = inputs()
    print(i)
  }
}
