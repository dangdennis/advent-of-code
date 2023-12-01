// The Swift Programming Language
// https://docs.swift.org/swift-book

import ArgumentParser

@main
struct AOC: ParsableCommand {
  @Option(name: .shortAndLong, help: "Specify day")
  public var day: String

  @Option(name: .shortAndLong, help: "Specify part")
  public var part: Int32

  public func run() throws {
    switch day {
    case "1":
      Day1.part1()
    default:
      print("Day \(day) part \(part)")
    }
  }
}
