/**
*  Ink
*  Copyright (c) Alan DeGuzman 2026
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Testing
import Ink

struct ImageTests {
    @Test func imageWithURL() {
        let html = MarkdownParser().html(from: "![](url)")
        #expect(html == #"<img src="url">"#)
    }

    @Test func imageWithReference() {
        let html = MarkdownParser().html(from: """
        ![][url]
        [url]: https://swiftbysundell.com
        """)

        #expect(html == #"<img src="https://swiftbysundell.com">"#)
    }

    @Test func imageWithURLAndAltText() {
        let html = MarkdownParser().html(from: "![Alt text](url)")
        #expect(html == #"<img src="url" alt="Alt text">"#)
    }

    @Test func imageWithReferenceAndAltText() {
        let html = MarkdownParser().html(from: """
        ![Alt text][url]
        [url]: swiftbysundell.com
        """)

        #expect(html == #"<img src="swiftbysundell.com" alt="Alt text">"#)
    }

    @Test func imageWithinParagraph() {
        let html = MarkdownParser().html(from: "Text ![](url) text")
        #expect(html == #"<p>Text <img src="url"> text</p>"#)
    }
}

extension ImageTests {
}
