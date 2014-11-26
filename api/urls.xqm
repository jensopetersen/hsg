xquery version "3.0";

module namespace urls = "http://history.state.gov/ns/site/urls";

import module namespace c = "http://history.state.gov/ns/site/content" at "content.xqm";

declare namespace rest = "http://exquery.org/ns/restxq";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare
    %rest:GET
    %output:media-type("text/html")
    %output:method("html5")
function urls:fallback() {
    c:fallback(concat(rest:uri(), ' could not be found.'))
};

declare
    %rest:GET
    %rest:path("/hsg")
    %output:media-type("text/html")
    %output:method("html5")
function urls:homepage() {
    c:homepage()
};

declare
    %rest:GET
    %rest:path("/hsg/historicaldocuments")
    %output:media-type("text/html")
    %output:method("html5")
function urls:historicaldocuments-landing() {
    c:historicaldocuments-landing-page()
};

declare
    %rest:GET
    %rest:path("/hsg/historicaldocuments/{$section}")
    %output:media-type("text/html")
    %output:method("html5")
function urls:historicaldocuments-section($section) {
    if ($section = 'ebooks') then
        c:ebooks-landing-page()
    else if (c:exists-frus-vol($section)) then
        c:frus-vol-landing-page($section)
    else
        urls:fallback()
};

declare
    %rest:GET
    %rest:path("/hsg/historicaldocuments/{$section}/{$subsection}")
    %output:media-type("text/html")
    %output:method("html5")
function urls:historicaldocuments-subsection($section, $subsection) {
    if (c:exists-frus-section($section, $subsection)) then
        c:frus-section($section, $subsection)
    else
        urls:fallback()
};