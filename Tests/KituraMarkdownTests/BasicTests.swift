/**
 * Copyright IBM Corporation 2016
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation
import XCTest

@testable import KituraMarkdown

class BasicTests: XCTestCase {
  
    func testSimpleMarkdownString() {
        let html = KituraMarkdown.render(from: "1. A\n2. B\n")
        let expected = "<ol>\n<li>A</li>\n<li>B</li>\n</ol>\n"
        XCTAssertEqual(html, expected, "Converted HTML wasn't [\(expected)] it was [\(html)]")
    }
  
    func testEngineFileExtension() {
        let engine = KituraMarkdown()
        let ext = engine.fileExtension
        XCTAssertEqual(ext, "md", "Engine fileExtension was not md, it was \(ext)")
    }

    func testSimpleMarkdownFile() {
        let engine = KituraMarkdown()
        let filename = getBaseSourceLocation() + "simple-text.md"
        do {
            let html = try engine.render(filePath: filename, context: [String:Any]())
            let expected = "<ul>\n<li>a</li>\n<li>b</li>\n<li>c</li>\n</ul>\n"
            XCTAssertEqual(html, expected, "Converted HTML wasn't [\(expected)] it was [\(html)]")
        }
        catch let error {
            XCTFail("Caught an error. The error was of type \(type(of: error))")
        }
    }

/*
    func testSwiftMarkdownString() {
        let html = KituraMarkdown.render(from: "```swift\nlet a = 123\n```\n")
        print(html)
        //XCTAssertEqual(html, "<ol>\n<li>A</li>\n<li>B</li>\n</ol>\n")
    }
*/

    private func getBaseSourceLocation() -> String {
        let fileName = NSString(string: #file)
        let resourceFilePrefixRange: NSRange
        let lastSlash = fileName.range(of: "/", options: NSString.CompareOptions.backwards)
        if  lastSlash.location != NSNotFound  {
            resourceFilePrefixRange = NSMakeRange(0, lastSlash.location+1)
        } else {
            resourceFilePrefixRange = NSMakeRange(0, fileName.length)
        }
        return fileName.substring(with: resourceFilePrefixRange)
    }
  
}

extension BasicTests {
  static var allTests : [(String, (BasicTests) -> () throws -> Void)] {
    return [
             ("testSimpleMarkdownString", testSimpleMarkdownString),
             ("testEngineFileExtension", testEngineFileExtension),
             ("testSimpleMarkdownFile", testSimpleMarkdownFile)
             /* ("testSwiftMarkdownString", testSwiftMarkdownString) */
    ]
  }
}
