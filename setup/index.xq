xquery version "3.0";

declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";
 
declare option output:method "html5";
declare option output:media-type "text/html";

<div>
    <h2>Data status</h2>
    <table>
        <thead>
            <tr>
                <th>Collection</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            {
                for $collection in ('/db/data/frus-master', '/db/temp')
                return
                    <tr>
                        <td>{$collection}</td>
                        <td>{
                            if (xmldb:collection-available($collection)) then
                                concat(count(collection($collection)), ' resources, created ', xmldb:created($collection))
                            else
                                'not loaded'
                        }</td>
                    </tr>
            }
        </tbody>
    </table>
    <h2>Setup</h2>
    <ul>
        <li><a href="get-frus.xq">Download FRUS data</a></li>
        <li><a href="/exist/restxq/hsg">Start hsg</a></li>
    </ul>
</div>