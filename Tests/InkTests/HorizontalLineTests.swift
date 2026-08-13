/**
*  Ink
*  Copyright (c) Alan DeGuzman 2026
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Testing
import Ink

struct HorizontalLineTests {
    @Test func horizonalLineWithDashes() {
        let html = MarkdownParser().html(from: """
        Hello

        ---

        World
        """)

        #expect(html == "<p>Hello</p><hr><p>World</p>")
    }

    @Test func horizontalLineWithDashesAtTheStartOfString() {
        let html = MarkdownParser().html(from: "---\nHello")
        #expect(html == "<hr><p>Hello</p>")
    }

    @Test func horizontalLineWithAsterisks() {
        let html = MarkdownParser().html(from: """
        Hello

        ***

        World
        """)

        #expect(html == "<p>Hello</p><hr><p>World</p>")
    }
}

extension HorizontalLineTests {
}
