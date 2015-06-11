xquery version "3.0";

module namespace c = "http://history.state.gov/ns/site/content";

import module namespace t2h="http://history.state.gov/ns/site/tei-to-html" at "tei-to-html.xqm";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function c:wrap-html($title as xs:string, $content as node()*) {
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
        <head>
            <meta charset="utf-8"/>
            <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <title>{$title}</title>

            <!-- Bootstrap -->
            <link rel="stylesheet" href="/exist/apps/hsg/bower_components/bootstrap/dist/css/bootstrap.min.css"/>
            <link rel="stylesheet" href="/exist/apps/hsg/bower_components/bootstrap/dist/css/bootstrap-theme.min.css"/>
            <script src="/exist/apps/hsg/bower_components/bootstrap/dist/js/bootstrap.min.js"/>

            <!-- bigfoot -->
            <link rel="stylesheet" href="/exist/apps/hsg/bower_components/bigfoot/dist/bigfoot-number.css"/>

            <!-- Hsg -->
            <link rel="stylesheet" href="/exist/apps/hsg/style.css"/>
        </head>
        <body>
            <div class="container">{$content}</div>
            <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
            <script src="/exist/apps/hsg/bower_components/jquery/dist/jquery.min.js"/>
            <!-- Include all Bootstrap compiled plugins -->
            <script src="/exist/apps/hsg/bower_components/bootstrap/dist/js/bootstrap.min.js"/>
            
            <!-- bigfoot.js -->
            <script type="text/javascript" src="/exist/apps/hsg/bower_components/bigfoot/dist/bigfoot.min.js"/>
            <script type="text/javascript">
                var bigfoot = $.bigfoot(
                    {{
                        actionOriginalFN: "ignore"
                    }}
                );
            </script>
        </body>
    </html>
};

declare function c:fallback($message as xs:string) {
    let $title := 'Error'
    let $content := <div xmlns="http://www.w3.org/1999/xhtml"><h1>Error</h1><p class="bg-warning text-warning">{$message}</p></div>
    return
        c:wrap-html($title, $content)    
};

declare function c:homepage() {
    let $title := 'Homepage'
    let $content := <h1 xmlns="http://www.w3.org/1999/xhtml">{$title}</h1>
    return
        c:wrap-html($title, $content)    
};

declare function c:historicaldocuments-landing-page() {
    let $title := 'Historical Documents'
    let $content := 
        <div xmlns="http://www.w3.org/1999/xhtml">
            <h1>{$title}</h1>
            <p>Landing page</p>
            <ul>
                <li><a href="historicaldocuments/ebooks">Ebooks</a></li>
                <li><a href="historicaldocuments/frus1969-76v24">frus1969-76v24</a></li>
            </ul>
        </div>
    return
        c:wrap-html($title, $content)    
};

declare function c:ebooks-landing-page() {
    let $title := 'Historical Documents'
    let $content := 
        <div xmlns="http://www.w3.org/1999/xhtml">
            <h1>{$title}</h1>
            <h2>ebooks landing page</h2>
        </div>
    return
        c:wrap-html($title, $content)
};

declare function c:historicaldocuments($section, $subsection) {
    let $title := 'Historical Documents'
    let $content := 
        <div xmlns="http://www.w3.org/1999/xhtml">
            <h1>{$title}</h1>
            <h2>{c:frus-vol-title($section)}</h2>
            {c:frus-section($section, $subsection)}
        </div>
    return
        c:wrap-html($title, $content)    
};

declare function c:frus-vol($vol-id as xs:string) {
    doc(concat('/db/cms/apps/tei-content/data/frus-volumes/', $vol-id, '.xml'))
};

declare function c:frus-section($vol-id as xs:string, $section-id as xs:string) {
    let $vol := c:frus-vol($vol-id)
    return
        $vol/id($section-id)
};

declare function c:frus-vol-title($vol-id as xs:string) {
    let $vol := c:frus-vol($vol-id)
    return
        normalize-space($vol//tei:title[@type='complete'])
};

declare function c:exists-frus-vol($vol-id as xs:string) {
    exists(c:frus-vol($vol-id))
};

declare function c:exists-frus-section($vol-id as xs:string, $section-id as xs:string) {
    exists(c:frus-section($vol-id, $section-id))
};

declare function c:frus-vol-landing-page($vol-id as xs:string) {
    let $title := 'Historical Documents'
    let $content := 
        <div xmlns="http://www.w3.org/1999/xhtml">
            <h1>{$title}</h1>
            <h2>{c:frus-vol-title($vol-id)}</h2>
            <ul>{for $div in c:frus-vol($vol-id)//tei:div[@xml:id] return <li><a href="{$vol-id}/{$div/@xml:id/string()}">{$div/tei:head/string()}</a></li>}</ul>
        </div>
    return
        c:wrap-html($title, $content)
};

declare function c:frus-section($vol-id as xs:string, $section-id as xs:string) {
    let $title := 'Historical Documents'
    let $section := c:frus-section($vol-id, $section-id)
    let $section-type := $section/@type
    let $content := 
        <div xmlns="http://www.w3.org/1999/xhtml">
            <h1>{$title}</h1>
            <h2>{c:frus-vol-title($vol-id)}</h2>
            {
            switch ($section-type)
                case "document" return t2h:render($section, ())
                case "section" return t2h:render($section, ())
                default return <p class="bg-warning text-warning">Unknown type</p>
            }
        </div>
    return
        c:wrap-html($title, $content)    
};