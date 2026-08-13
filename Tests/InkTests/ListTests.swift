/**
*  Ink
*  Copyright (c) Alan DeGuzman 2026
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Testing
import Ink

struct ListTests {
    @Test func orderedList() {
        let html = MarkdownParser().html(from: """
        1. One
        2. Two
        """)

        #expect(html == #"<ol><li>One</li><li>Two</li></ol>"#)
    }
    
    func test10DigitOrderedList() {
        let html = MarkdownParser().html(from: """
        1234567890. Not a list
        """)

        #expect(html == "<p>1234567890. Not a list</p>")
    }
    
    @Test func orderedListParentheses() {
        let html = MarkdownParser().html(from: """
        1) One
        2) Two
        """)

        #expect(html == #"<ol><li>One</li><li>Two</li></ol>"#)
    }

    @Test func orderedListWithoutIncrementedNumbers() {
        let html = MarkdownParser().html(from: """
        1. One
        3. Two
        17. Three
        """)

        #expect(html == "<ol><li>One</li><li>Two</li><li>Three</li></ol>")
    }

    @Test func orderedListWithInvalidNumbers() {
        let html = MarkdownParser().html(from: """
        1. One
        3!. Two
        17. Three
        """)

        #expect(html == "<ol><li>One 3!. Two</li><li>Three</li></ol>")
    }

    @Test func unorderedList() {
        let html = MarkdownParser().html(from: """
        - One
        - Two
        - Three
        """)

        #expect(html == "<ul><li>One</li><li>Two</li><li>Three</li></ul>")
    }
    
    @Test func mixedUnorderedList() {
        let html = MarkdownParser().html(from: """
        - One
        * Two
        * Three
        - Four
        """)

        #expect(html == "<ul><li>One</li></ul><ul><li>Two</li><li>Three</li></ul><ul><li>Four</li></ul>")
    }
    
    @Test func mixedList() {
        let html = MarkdownParser().html(from: """
        1. One
        2. Two
        3) Three
        * Four
        """)
        
        #expect(html == #"<ol><li>One</li><li>Two</li></ol><ol start="3"><li>Three</li></ol><ul><li>Four</li></ul>"#)
    }

    @Test func unorderedListWithMultiLineItem() {
        let html = MarkdownParser().html(from: """
        - One
        Some text
        - Two
        """)

        #expect(html == "<ul><li>One Some text</li><li>Two</li></ul>")
    }

    @Test func unorderedListWithNestedList() {
        let html = MarkdownParser().html(from: """
        - A
        - B
            - B1
                - B11
            - B2
        """)

        let expectedComponents: [String] = [
            "<ul>",
                "<li>A</li>",
                "<li>B",
                    "<ul>",
                        "<li>B1",
                            "<ul>",
                                "<li>B11</li>",
                            "</ul>",
                        "</li>",
                        "<li>B2</li>",
                    "</ul>",
                "</li>",
            "</ul>"
        ]

        #expect(html == expectedComponents.joined())
    }

    @Test func unorderedListWithInvalidMarker() {
        let html = MarkdownParser().html(from: """
        - One
        -Two
        - Three
        """)

        #expect(html == "<ul><li>One -Two</li><li>Three</li></ul>")
    }
    
    @Test func orderedIndentedList() {
        let html = MarkdownParser().html(from: """
          1. One
          2. Two
        """)

        #expect(html == #"<ol><li>One</li><li>Two</li></ol>"#)
    }
    
    @Test func unorderedIndentedList() {
        let html = MarkdownParser().html(from: """
          - One
          - Two
          - Three
        """)

        #expect(html == "<ul><li>One</li><li>Two</li><li>Three</li></ul>")
    }
}

extension ListTests {
}
