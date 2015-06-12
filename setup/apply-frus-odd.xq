xquery version "3.0";
                        
declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";

import module namespace pmu="http://www.tei-c.org/tei-simple/xquery/util" at "/db/apps/tei-simple/content/util.xql";
import module namespace odd="http://www.tei-c.org/tei-simple/odd2odd" at "/db/apps/tei-simple/content/odd2odd.xql";

let $odd-root := '/db/data/frus-master/schema'
let $odd := 'frus.odd'
let $compiled-odd-root := '/db/apps/hsg/generated'
return
    odd:get-compiled($odd-root, $odd, $compiled-odd-root)
(:let $xml := doc($config:app-root || "/" || $doc):)
(:return:)
(:    pmu:process($odd, $xml, $config:output-root, "web", "../generated", $config:module-config):)