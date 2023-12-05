import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day01Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """

  let testData2 = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """

  func testPart1() throws {
    let challenge = Day01(data: testData)
    XCTAssertEqual(challenge.part1() as? Int, 142)
  }

  func testPart2() throws {
    throw XCTSkip("This test is temporarily skipped.")
    let challenge = Day00(data: testData)
    XCTAssertEqual(challenge.part2() as? Int, 281)
  }

  func testParseNumbers() throws {
    throw XCTSkip("This test is temporarily skipped.")
    let numbers = Day01.parseNumbers(in: "eightwothree")
    XCTAssertEqual(numbers, [8, 2, 3])
  }
}
