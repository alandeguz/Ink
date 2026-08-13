/**
*  Ink
*  Copyright (c) Alan DeGuzman 2026
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Testing
import Ink

struct CodeTests {
    @Test func inlineCode() {
        let html = MarkdownParser().html(from: "Hello `inline.code()`")
        #expect(html == "<p>Hello <code>inline.code()</code></p>")
    }

    @Test func codeBlockWithJustBackticks() {
        let html = MarkdownParser().html(from: """
        ```
        code()
        block()
        ```
        """)

        #expect(html == "<pre><code>code()\nblock()\n</code></pre>")
    }

    @Test func codeBlockWithBackticksAndLabel() {
        let html = MarkdownParser().html(from: """
        ```swift
        code()
        ```
        """)

        #expect(html == "<pre><code class=\"language-swift\">code()\n</code></pre>")
    }
    
    @Test func codeBlockWithBackticksAndLabelNeedingTrimming() {
       // there are 2 spaces after the swift label that need trimming too
       let html = MarkdownParser().html(from: """
       ``` swift  
       code()
       ```
       """)

       #expect(html == "<pre><code class=\"language-swift\">code()\n</code></pre>")
   }
    
    @Test func codeBlockManyBackticks() {
        // there are 2 spaces after the swift label that need trimming too
        let html = MarkdownParser().html(from: """
        
        ```````````````````````````````` foo
        bar
        ````````````````````````````````
        """)

        #expect(html == "<pre><code class=\"language-foo\">bar\n</code></pre>")
    }
    
    @Test func encodingSpecialCharactersWithinCodeBlock() {
        let html = MarkdownParser().html(from: """
        ```swift
        Generic<T>() && expression()
        ```
        """)

        #expect(html == """
        <pre><code class="language-swift">Generic&lt;T&gt;() &amp;&amp; expression()\n</code></pre>
        """)
    }

    @Test func ignoringFormattingWithinCodeBlock() {
        let html = MarkdownParser().html(from: """
        ```
        # Not A Header
        return View()
        - Not a list
        ```
        """)

        #expect(html == """
        <pre><code># Not A Header
        return View()
        - Not a list\n</code></pre>
        """)
    }
}

extension CodeTests {
}
