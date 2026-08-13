/**
*  Ink
*  Copyright (c) Alan DeGuzman 2026
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Testing
import Ink

struct LinkTests {
    @Test func linkWithURL() {
        let html = MarkdownParser().html(from: "[Title](url)")
        #expect(html == #"<p><a href="url">Title</a></p>"#)
    }

    @Test func linkWithReference() {
        let html = MarkdownParser().html(from: """
        [Title][url]

        [url]: swiftbysundell.com
        """)

        #expect(html == #"<p><a href="swiftbysundell.com">Title</a></p>"#)
    }

    @Test func caseMismatchedLinkWithReference() {
        let html = MarkdownParser().html(from: """
        [Title][Foo]
        [Title][αγω]

        [FOO]: /url
        [ΑΓΩ]: /φου
        """)

        #expect(html == #"<p><a href="/url">Title</a> <a href="/φου">Title</a></p>"#)
    }

    @Test func numericLinkWithReference() {
        let html = MarkdownParser().html(from: """
        [1][1]

        [1]: swiftbysundell.com
        """)

        #expect(html == #"<p><a href="swiftbysundell.com">1</a></p>"#)
    }

    @Test func boldLinkWithInternalMarkers() {
        let html = MarkdownParser().html(from: "[**Hello**](/hello)")
        #expect(html == #"<p><a href="/hello"><strong>Hello</strong></a></p>"#)
    }

    @Test func boldLinkWithExternalMarkers() {
        let html = MarkdownParser().html(from: "**[Hello](/hello)**")
        #expect(html == #"<p><strong><a href="/hello">Hello</a></strong></p>"#)
    }

    @Test func linkWithUnderscores() {
        let html = MarkdownParser().html(from: "[He_llo](/he_llo)")
        #expect(html == "<p><a href=\"/he_llo\">He_llo</a></p>")
    }

    @Test func linkWithParenthesis() {
        let html = MarkdownParser().html(from: "[Hello](/(hello))")
        #expect(html == "<p><a href=\"/(hello)\">Hello</a></p>")
    }

    @Test func linkWithNestedParenthesis() {
        let html = MarkdownParser().html(from: "[Hello](/(h(e(l(l(o()))))))")
        #expect(html == "<p><a href=\"/(h(e(l(l(o())))))\">Hello</a></p>")
    }

    @Test func linkWithParenthesisAndClosingParenthesisInContent() {
        let html = MarkdownParser().html(from: "[Hello](/(hello)))")
        #expect(html == "<p><a href=\"/(hello)\">Hello</a>)</p>")
    }

    @Test func unterminatedLink() {
        let html = MarkdownParser().html(from: "[Hello]")
        #expect(html == "<p>[Hello]</p>")
    }
    
    @Test func linkWithEscapedSquareBrackets() {
        let html = MarkdownParser().html(from: "[\\[Hello\\]](hello)")
        #expect(html == #"<p><a href="hello">[Hello]</a></p>"#)
    }
}

extension LinkTests {
}
