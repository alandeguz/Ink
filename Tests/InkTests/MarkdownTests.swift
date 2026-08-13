/**
*  Ink
*  Copyright (c) Alan DeGuzman 2026
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Testing
import Ink

struct MarkdownTests {
    @Test func parsingMetadata() {
        let markdown = MarkdownParser().parse("""
        ---
        a: 1
        b : 2
        ---
        # Title
        """)

        #expect(markdown.metadata == [
            "a": "1",
            "b": "2"
        ])

        #expect(markdown.html == "<h1>Title</h1>")
    }

    @Test func discardingEmptyMetadataValues() {
        let markdown = MarkdownParser().parse("""
        ---
        a: 1
        b:
        c: 2
        ---
        # Title
        """)

        #expect(markdown.metadata == [
            "a": "1",
            "c": "2"
        ])

        #expect(markdown.html == "<h1>Title</h1>")
    }

    @Test func mergingOrphanMetadataValueIntoPreviousOne() {
        let markdown = MarkdownParser().parse("""
        ---
        a: 1
        b
        ---
        # Title
        """)

        #expect(markdown.metadata == ["a": "1 b"])
        #expect(markdown.html == "<h1>Title</h1>")
    }

    @Test func missingMetadata() {
        let markdown = MarkdownParser().parse("""
        ---
        ---
        # Title
        """)

        #expect(markdown.metadata == [:])
        #expect(markdown.html == "<h1>Title</h1>")
    }

    @Test func metadataModifiers() {
        let parser = MarkdownParser(modifiers: [
            Modifier(target: .metadataKeys) { key, _ in
                "ModifiedKey-" + key
            },
            Modifier(target: .metadataValues) { value, _ in
                "ModifiedValue-" + value
            }
        ])

        let markdown = parser.parse("""
        ---
        keyA: valueA
        keyB: valueB
        ---
        """)

        #expect(markdown.metadata == [
            "ModifiedKey-keyA" : "ModifiedValue-valueA",
            "ModifiedKey-keyB" : "ModifiedValue-valueB"
        ])
    }

    @Test func plainTextTitle() {
        let markdown = MarkdownParser().parse("""
        # Hello, world!
        """)

        #expect(markdown.title == "Hello, world!")
    }

    @Test func removingTrailingMarkersFromTitle() {
        let markdown = MarkdownParser().parse("""
        # Hello, world! ####
        """)

        #expect(markdown.title == "Hello, world!")
    }

    @Test func convertingFormattedTitleTextToPlainText() {
        let markdown = MarkdownParser().parse("""
        # *Italic* **Bold** [Link](url) ![Image](url) `Code`
        """)

        #expect(markdown.title == "Italic Bold Link Image Code")
    }

    @Test func treatingFirstHeadingAsTitle() {
        let markdown = MarkdownParser().parse("""
        # Title 1
        # Title 2
        ## Title 3
        """)

        #expect(markdown.title == "Title 1")
    }

    @Test func overridingTitle() {
        var markdown = MarkdownParser().parse("# Title")
        markdown.title = "Title 2"
        #expect(markdown.title == "Title 2")
    }
}

extension MarkdownTests {
}
