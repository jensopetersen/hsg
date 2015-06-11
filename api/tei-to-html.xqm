xquery version "3.0";

module namespace t2h = "http://history.state.gov/ns/site/tei-to-html";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function t2h:render($node as node()*, $options as map(*)?) {
    <div xmlns="http://www.w3.org/1999/xhtml">{
        t2h:switch($node, $options),
        t2h:footnotes($node, $options)
    }</div>
};

declare function t2h:switch($node as node()*, $options as map(*)?) {
    typeswitch ($node)
        case text() return $node
        case element(tei:div) return t2h:div($node, $options)
        case element(tei:head) return t2h:head($node, $options)
        case element(tei:p) return t2h:p($node, $options)
        case element(tei:note) return t2h:note($node, $options)
        default return t2h:descend($node, $options)
};

declare function t2h:footnotes($node as node()*, $options as map(*)?) {
    <div class="footnotes" xmlns="http://www.w3.org/1999/xhtml">
        <ol>{
            for $note at $n in $node//tei:note[@xml:id]
            return
                <li class="footnote" id="fn:{$n}">
                    <p>{t2h:descend($note, $options)}<a href="#fnref:{$n}" title="return to article"> ↩</a></p>
                </li>
        }</ol>
    </div>
};

declare function t2h:descend($node as node()*, $options as map(*)?) {
    for $child in $node/node()
    return
        t2h:switch($child, $options)
};

declare function t2h:div($node as element(tei:div), $options as map(*)?) {
    <div xmlns="http://www.w3.org/1999/xhtml">{t2h:descend($node, $options)}</div>
};

declare function t2h:head($node as element(tei:head), $options as map(*)?) {
    <h2 xmlns="http://www.w3.org/1999/xhtml">{t2h:descend($node, $options)}</h2>
};

declare function t2h:p($node as element(tei:p), $options as map(*)?) {
    <p xmlns="http://www.w3.org/1999/xhtml">{t2h:descend($node, $options)}</p>
};

declare function t2h:note($node as element(tei:note), $options as map(*)?) {
    let $n := index-of($node/ancestor::tei:div[@xml:id][1]//tei:note, $node)
    return
        <sup id="fnref:{$n}" xmlns="http://www.w3.org/1999/xhtml">
            <a href="#fn:{$n}" rel="footnote">{$node/@n/string()}</a>
        </sup>
};