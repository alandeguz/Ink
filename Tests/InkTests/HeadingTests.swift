/**
*  Ink
*  Copyright (c) Alan DeGuzman 2026
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Testing
import Ink

struct HeadingTests {
    @Test func heading() {
        let html = MarkdownParser().html(from: "# Hello, world!")
        #expect(html == "<h1>Hello, world!</h1>")
    }

    @Test func headingsSeparatedBySingleNewline() {
        let html = MarkdownParser().html(from: "# Hello\n## World")
        #expect(html == "<h1>Hello</h1><h2>World</h2>")
    }

    @Test func headingsWithLeadingNumbers() {
        let html = MarkdownParser().html(from: """
        # 1. First
        ## 2. Second
        ## 3. Third
        ### 4. Forth
        """)

        #expect(html == """
        <h1>1. First</h1><h2>2. Second</h2><h2>3. Third</h2><h3>4. Forth</h3>
        """)
    }

    @Test func headingWithPreviousWhitespace() {
        let html = MarkdownParser().html(from: "Text \n## Heading")
        #expect(html == "<p>Text</p><h2>Heading</h2>")
    }

    @Test func headingWithPreviousNewlineAndWhitespace() {
        let html = MarkdownParser().html(from: "Hello\n \n## Heading\n\nWorld")
        #expect(html == "<p>Hello</p><h2>Heading</h2><p>World</p>")
    }

    @Test func invalidHeaderLevel() {
        let markdown = String(repeating: "#", count: 7)
        let html = MarkdownParser().html(from: markdown)
        #expect(html == "<p>\(markdown)</p>")
    }

    @Test func removingTrailingMarkersFromHeading() {
        let markdown = "# Heading #######"
        let html = MarkdownParser().html(from: markdown)
        #expect(html == "<h1>Heading</h1>")
    }

    @Test func headingWithOnlyTrailingMarkers() {
        let markdown = "# #######"
        let html = MarkdownParser().html(from: markdown)
        #expect(html == "<h1></h1>")
    }
}

extension HeadingTests {
}
