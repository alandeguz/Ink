/**
*  Ink
*  Copyright (c) Alan DeGuzman 2026
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Testing
import Ink

struct HTMLTests {
    @Test func topLevelHTML() {
        let html = MarkdownParser().html(from: """
        Hello

        <div>
            <span class="text">Whole wide</span>
        </div>

        World
        """)

        #expect(html == """
        <p>Hello</p><div>
            <span class="text">Whole wide</span>
        </div><p>World</p>
        """)
    }

    @Test func nestedTopLevelHTML() {
        let html = MarkdownParser().html(from: """
        <div>
            <div>Hello</div>
            <div>World</div>
        </div>
        """)

        #expect(html == """
        <div>
            <div>Hello</div>
            <div>World</div>
        </div>
        """)
    }

    @Test func topLevelHTMLWithPreviousNewline() {
        let html = MarkdownParser().html(from: "Text\n<h2>Heading</h2>")
        #expect(html == "<p>Text</p><h2>Heading</h2>")
    }

    @Test func ignoringFormattingWithinTopLevelHTML() {
        let html = MarkdownParser().html(from: "<div>_Hello_</div>")
        #expect(html == "<div>_Hello_</div>")
    }

    @Test func ignoringTextFormattingWithinInlineHTML() {
        let html = MarkdownParser().html(from: "Hello <span>_World_</span>")
        #expect(html == "<p>Hello <span>_World_</span></p>")
    }

    @Test func ignoringListsWithinInlineHTML() {
        let html = MarkdownParser().html(from: "<h2>1. Hello</h2><h2>- World</h2>")
        #expect(html == "<h2>1. Hello</h2><h2>- World</h2>")
    }

    @Test func inlineParagraphTagEndingCurrentParagraph() {
        let html = MarkdownParser().html(from: "One <p>Two</p> Three")
        #expect(html == "<p>One</p><p>Two</p><p>Three</p>")
    }

    @Test func topLevelSelfClosingHTMLElement() {
        let html = MarkdownParser().html(from: """
        Hello

        <img src="image.png"/>

        World
        """)

        #expect(html == #"<p>Hello</p><img src="image.png"/><p>World</p>"#)
    }

    @Test func inlineSelfClosingHTMLElement() {
        let html = MarkdownParser().html(from: #"Hello <img src="image.png"/> World"#)
        #expect(html == #"<p>Hello <img src="image.png"/> World</p>"#)
    }

    @Test func topLevelHTMLLineBreak() {
        let html = MarkdownParser().html(from: """
        Hello
        <br/>
        World
        """)

        #expect(html == "<p>Hello</p><br/><p>World</p>")
    }

    @Test func htmlComment() {
        let html = MarkdownParser().html(from: """
        Hello
        <!-- Comment -->
        World
        """)

        #expect(html == "<p>Hello</p><!-- Comment --><p>World</p>")
    }

    @Test func htmlEntities() {
        let html = MarkdownParser().html(from: """
        Hello &amp; welcome to &lt;Ink&gt;
        """)

        #expect(html == "<p>Hello &amp; welcome to &lt;Ink&gt;</p>")
    }
}

extension HTMLTests {
}
