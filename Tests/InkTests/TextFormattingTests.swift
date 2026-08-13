/**
*  Ink
*  Copyright (c) Alan DeGuzman 2026
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Testing
import Ink

struct TextFormattingTests {
    @Test func paragraph() {
        let html = MarkdownParser().html(from: "Hello, world!")
        #expect(html == "<p>Hello, world!</p>")
    }

    @Test func paragraphs() {
        let html = MarkdownParser().html(from: "Hello, world!\n\nAgain.")
        #expect(html == "<p>Hello, world!</p><p>Again.</p>")
    }

    @Test func dosParagraphs() {
        let html = MarkdownParser().html(from: "Hello, world!\r\n\r\nAgain.")
        #expect(html == "<p>Hello, world!</p><p>Again.</p>")
    }

    @Test func italicText() {
        let html = MarkdownParser().html(from: "Hello, *world*!")
        #expect(html == "<p>Hello, <em>world</em>!</p>")
    }

    @Test func boldText() {
        let html = MarkdownParser().html(from: "Hello, **world**!")
        #expect(html == "<p>Hello, <strong>world</strong>!</p>")
    }

    @Test func italicBoldText() {
        let html = MarkdownParser().html(from: "Hello, ***world***!")
        #expect(html == "<p>Hello, <strong><em>world</em></strong>!</p>")
    }

    @Test func italicBoldTextWithSeparateStartMarkers() {
        let html = MarkdownParser().html(from: "**Hello, *world***!")
        #expect(html == "<p><strong>Hello, <em>world</em></strong>!</p>")
    }

    @Test func italicTextWithinBoldText() {
        let html = MarkdownParser().html(from: "**Hello, *world*!**")
        #expect(html == "<p><strong>Hello, <em>world</em>!</strong></p>")
    }

    @Test func boldTextWithinItalicText() {
        let html = MarkdownParser().html(from: "*Hello, **world**!*")
        #expect(html == "<p><em>Hello, <strong>world</strong>!</em></p>")
    }

    @Test func italicTextWithExtraLeadingMarkers() {
        let html = MarkdownParser().html(from: "**Hello*")
        #expect(html == "<p>*<em>Hello</em></p>")
    }

    @Test func boldTextWithExtraLeadingMarkers() {
        let html = MarkdownParser().html(from: "***Hello**")
        #expect(html == "<p><strong>*Hello</strong></p>")
    }

    @Test func italicTextWithExtraTrailingMarkers() {
        let html = MarkdownParser().html(from: "*Hello**")
        #expect(html == "<p><em>Hello</em>*</p>")
    }

    @Test func boldTextWithExtraTrailingMarkers() {
        let html = MarkdownParser().html(from: "**Hello***")
        #expect(html == "<p><strong>Hello</strong>*</p>")
    }

    @Test func italicBoldTextWithExtraTrailingMarkers() {
        let html = MarkdownParser().html(from: "**Hello, *world*****!")
        #expect(html == "<p><strong>Hello, <em>world</em></strong>**!</p>")
    }

    @Test func unterminatedItalicMarker() {
        let html = MarkdownParser().html(from: "*Hello")
        #expect(html == "<p>*Hello</p>")
    }

    @Test func unterminatedBoldMarker() {
        let html = MarkdownParser().html(from: "**Hello")
        #expect(html == "<p>**Hello</p>")
    }

    @Test func unterminatedItalicBoldMarker() {
        let html = MarkdownParser().html(from: "***Hello")
        #expect(html == "<p>***Hello</p>")
    }

    @Test func unterminatedItalicMarkerWithinBoldText() {
        let html = MarkdownParser().html(from: "**Hello, *world!**")
        #expect(html == "<p><strong>Hello, *world!</strong></p>")
    }

    @Test func unterminatedBoldMarkerWithinItalicText() {
        let html = MarkdownParser().html(from: "*Hello, **world!*")
        #expect(html == "<p><em>Hello, **world!</em></p>")
    }

    @Test func strikethroughText() {
        let html = MarkdownParser().html(from: "Hello, ~~world!~~")
        #expect(html == "<p>Hello, <s>world!</s></p>")
    }

    @Test func singleTildeWithinStrikethroughText() {
        let html = MarkdownParser().html(from: "Hello, ~~wor~ld!~~")
        #expect(html == "<p>Hello, <s>wor~ld!</s></p>")
    }

    @Test func unterminatedStrikethroughMarker() {
        let html = MarkdownParser().html(from: "~~Hello")
        #expect(html == "<p>~~Hello</p>")
    }

    @Test func encodingSpecialCharacters() {
        let html = MarkdownParser().html(from: "Hello < World & >")
        #expect(html == "<p>Hello &lt; World &amp; &gt;</p>")
    }

    @Test func singleLineBlockquote() {
        let html = MarkdownParser().html(from: "> Hello, world!")
        #expect(html == "<blockquote><p>Hello, world!</p></blockquote>")
    }

    @Test func multiLineBlockquote() {
        let html = MarkdownParser().html(from: """
        > One
        > Two
        > Three
        """)

        #expect(html == "<blockquote><p>One Two Three</p></blockquote>")
    }

    @Test func escapingSymbolsWithBackslash() {
        let html = MarkdownParser().html(from: """
        \\# Not a title
        \\*Not italic\\*
        """)

        #expect(html == "<p># Not a title *Not italic*</p>")
    }


    @Test func listAfterFormattedText() {
        let html = MarkdownParser().html(from: """
            This is a test
            - One
            - Two
            """)

        #expect(html == """
            <p>This is a test</p><ul><li>One</li><li>Two</li></ul>
            """)
    }

    @Test func doubleSpacedHardLinebreak() {
        let html = MarkdownParser().html(from: "Line 1  \nLine 2")

        #expect(html == "<p>Line 1<br>Line 2</p>")
    }

    @Test func escapedHardLinebreak() {
        let html = MarkdownParser().html(from: "Line 1\\\nLine 2")

        #expect(html == "<p>Line 1<br>Line 2</p>")
    }
}

extension TextFormattingTests {
}
