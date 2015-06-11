xquery version "3.0";

import module namespace download = "http://joewiz.org/ns/xquery/download" at "../modules/download.xqm";
import module namespace unzip = "http://joewiz.org/ns/xquery/unzip" at "../modules/unzip.xqm";

import module namespace console="http://exist-db.org/xquery/console";

declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";
 
declare option output:method "html5";
declare option output:media-type "text/html";

let $login := xmldb:login('/db', 'admin', '') (: replace with proper login :)
let $start-time := util:system-time()
let $log := console:log('starting download of frus data')
let $result := 
    try {
        let $url := 'https://github.com/HistoryAtState/frus/archive/master.zip'
        let $temp := '/db/temp'
        let $download := download:http-download($url, $temp)
        let $log := console:log(concat('downloaded ', $url, ' to ', $temp))
        let $destination := '/db/data'
        let $log := console:log(concat('starting to unzip ', $download, ' to ', $destination))
        let $unzip := unzip:unzip($download, $destination)
        let $end-time := util:system-time()
        return
            <p class="text-success">{$url} successfully downloaded to {$download} and unzipped {$unzip/@count-stored/string()} items to {$destination}. Unable to store {$unzip/@count-unable-to-store/string()} items.  Completion took {$end-time - $start-time}.</p>
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
        <h1>Get FRUS Results</h1>
        {$result}
        <p><a href="index.xq">Back to index</a></p>
    </div>