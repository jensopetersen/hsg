xquery version "3.0";

import module namespace download = "http://joewiz.org/ns/xquery/download" at "../modules/download.xqm";
import module namespace unzip = "http://joewiz.org/ns/xquery/unzip" at "../modules/unzip.xqm";

import module namespace console="http://exist-db.org/xquery/console";

declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";
 
declare option output:method "html5";
declare option output:media-type "text/html";

let $login := xmldb:login('/db', 'admin', '') (: TODO replace with proper method for logging in / write access :)
let $start-time := util:system-time()
let $log := console:log('preparing files needed for tei simple')
let $result := 
    try {
        let $tei-simple-odd-collection := '/db/apps/tei-simple/odd'
        let $tei-simple-odd-files := ('teisimple.odd', 'elementsummary.xml', 'headeronly.xml', 'simpleelements.xml')
        let $frus-odd-collection := '/db/data/frus-tei-simple/schema/'
        let $frus-odd-file := 'frus.odd'
        let $destination := '/db/apps/hsg/resources/odd'
        let $copy := 
            (
            for $file in $tei-simple-odd-files
            return
                xmldb:copy($tei-simple-odd-collection, $destination, $file)
            ,
            xmldb:copy($frus-odd-collection, $destination, $frus-odd-file)
            )
        let $end-time := util:system-time()
        return
            <p class="text-success">successfully copied needed ODD files into place.  Completion took {$end-time - $start-time}.</p>
    } catch * {
        let $error := 
            concat('Error while downloading frus data: ', 
                $err:code, $err:value, " module: ",
                $err:module, "(", $err:line-number, ",", $err:column-number, ") ", $err:description
                )
        let $log := console:log($error)
        return
            <p class="text-error">{$error}</p>
    }
return
    <div>
        <h1>Prepare for TEI Simple</h1>
        {$result}
        <p><a href="index.xq">Back to index</a></p>
    </div>