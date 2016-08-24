<?php
include_once("ej-database.php");

if (!isset($_GET['from']) || !isset($_GET['to'])) exit;
$from = intval($_GET['from']);
$to = intval($_GET['to']);
if (!$from || !$to) exit;
if ($from > $to) exit;

$user_pool = array();
$doc_pool = array();

$n_probs = 0;

$user_summary = array();

$user_names = array();

for ($cid = $from; $cid <= $to; ++$cid)
{
    $fname = get_standings_filename($cid);
    if (!file_exists($fname)) continue;
    $doc = new DOMDocument();
    $doc->loadHTMLFile($fname);

    $teams = $doc->getElementsByTagName("td");
    $exists = false;
    foreach ($teams as $team)
    {
        $exists = true;
        if ($team->getAttribute("class") == "st_place")
        {
            if (!intval($team->nodeValue))
                break;
        }
        if ($team->getAttribute("class") == "st_team")
        {
            if (!isset($user_pool[$team->nodeValue]))
                $user_names[] = $team->nodeValue;
            $user_pool[$team->nodeValue] = 1;
            $user_summary[$team->nodeValue] = array(
                "solved" => 0,
                "penalty" => 0
            );
        }
    }

    if ($exists)
        $doc_pool[$cid] = $doc;

    $probs = $doc->getElementsByTagName("th");
    foreach ($probs as $prob)
    {
        if ($prob->getAttribute("class") == "st_prob")
        {
            $n_probs++;
        }
    }
}

$prob_user_results = array();


foreach ($user_pool as $uname => $_)
    $prob_user_results[$uname] = array();

foreach ($user_pool as $uname => $_)
    for ($j = 0; $j < $n_probs; $j++)
        $prob_user_results[$uname][$j] = "";

$prob_pad = 0;

$cnt_probs = array();
$cnt_probs_sum = array();
$cnt_prob_names = array();

for ($cid = $from; $cid <= $to; ++$cid)
{
    if (!isset($doc_pool[$cid])) continue;
    $doc = $doc_pool[$cid];
    $nl_probs = 0;
    $probs = $doc->getElementsByTagName("th");

    $rows = $doc->getElementsByTagName("tr");
    $pp = 0;
    $cnt_prob_names[$cid] = array();
    foreach ($rows as $row)
    {
        $nl_probs = 0;
        $cells = $row->childNodes;
        $uname = "";
        foreach ($cells as $cell)
        {
            if (strtolower($cell->nodeName) == "th")
            {
                if ($cell->getAttribute("class") == "st_prob")
                {
                    $cnt_prob_names[$cid][] = $cell->nodeValue;
                }
                continue;
            }

            if ($cell->getAttribute("class") == "st_place")
            {
                if (!intval($cell->nodeValue))
                    break;
            }
            if ($cell->getAttribute("class") == "st_team")
            {
                $uname = $cell->nodeValue;
            }

            if ($cell->getAttribute("class") == "st_prob")
            {
                $prob_user_results[$uname][$nl_probs + $prob_pad] = $cell->nodeValue;
                if ($cell->hasAttribute("bgcolor") && ($cell->getAttribute("bgcolor") === "#99cc99"))
                {
                    $at = abs(intval($cell->nodeValue)); 
                    if (!$at)
                        $at = "";
                    $prob_user_results[$uname][$nl_probs + $prob_pad] = "?$at";
                }
                else
                {
                    if ($cell->hasAttribute("bgcolor") && ($cell->getAttribute("bgcolor") === "#ffcccc"))
                    {
                        $prob_user_results[$uname][$nl_probs + $prob_pad] = "DQ";
                    }
                    else
                    {
                        if (strstr($cell->nodeValue, "+") !== false)
                        {
                            $user_summary[$uname]['solved']++;
                            $user_summary[$uname]['penalty'] += intval($cell->nodeValue);
                        }
                    }
                }
                $nl_probs++;
            }
        }
        $pp = max($pp, $nl_probs);
    }

    $cnt_probs[$cid] = $pp;
    $cnt_probs_sum[$cid] = $prob_pad;
    $prob_pad += $pp;
}

function cmp_unames($a, $b)
{
    global $user_summary;
    if ($user_summary[$a]['solved'] < $user_summary[$b]['solved']) return 1;
    if ($user_summary[$a]['solved'] > $user_summary[$b]['solved']) return -1;
    if ($user_summary[$a]['penalty'] < $user_summary[$b]['penalty']) return -1;
    if ($user_summary[$a]['penalty'] > $user_summary[$b]['penalty']) return 1;
    return 0;
}

usort($user_names, "cmp_unames");

?>

<link href="/ejudge/unpriv.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="/assets/js/jquery.min.js"></script>
<script type="text/javascript" src="/assets/js/datatables.min.js"></script>
<script type="text/javascript" src="/assets/js/moment.min.js"></script>
<style type="text/css">
:root #header + #content > #left > #rlblock_left
{ display: none !important; }</style>

<style type="text/css">
.ok {background-color: #6f6;}
.rj {background-color: #66f;}
.fl {background-color: #f66;}
.pr {background-color: #ff6;}
.un {background-color: #aaa;}
.tm {background-color: #ddd;}
.dq {background-color: #000;}

.active a {
    color: blue;
}

.table-wrapper {
    width: 100%;
    overflow: auto;
}

.col-sm-6 {
    display: inline-block;
    padding-right: 64px;
}

td {
   border: none !important;
}

table {
    border-collapse: collapse;
}

table.st {
    width: 100%;
}

table.st td,th {
    white-space: nowrap;
    border: solid !important;
    border-width: 1px !important; 
    border-color: #000000 !important;
}

ul.pagination > li {
    display: inline-block;
    padding: 4px;
}

.dataTable td:nth-child(1) {background-color: #ddd;}
.dataTable td:nth-child(2) {background-color: #aaa;}
.dataTable td:nth-child(3) {background-color: #ddd;}
</style>

<title><?php echo (isset($_GET['title'])?($_GET['title']):('Таблица результатов')); ?></title>
<h1><?php echo (isset($_GET['title'])?($_GET['title']):('Таблица результатов')); ?></h1>

<div class="table-wrapper">
<table class="st">
<thead>
<tr>
<th class="st_place"></th>
<th class="st_team"></th>
<th class="st_total"></th>
<th class="st_pen"></th>
<?php
    for ($cid = $from; $cid <= $to; ++$cid)
    {
        if (!isset($doc_pool[$cid])) continue;
        echo "<th class=\"st_prob\" colspan=\"" . $cnt_probs[$cid] . "\">" . get_contest_name($cid, false) . "</th>";
    }
?>
</tr>
<tr>
<th class="st_place">Место</th>
<th class="st_team">Участник</th>
<th class="st_total">Всего</th>
<th class="st_pen">Штраф</th>

<?php
    $db = ej_connect_db();

    $uid_map = array();

    $res = $db->query("select distinct user_id, username from users where user_id in (select user_id as u from runs where contest_id >= $from and contest_id <= $to)");
    while ($row = $res->fetch_assoc())
    {
        $uid_map[$row['user_id']] = $row['username'];
    }

    $res->free();

    $res = $db->query("select distinct user_id, login from logins where user_id in (select user_id as u from runs where contest_id >= $from and contest_id <= $to)");
    while ($row = $res->fetch_assoc())
    {
        if (!isset($uid_map[$row['user_id']]))
            $uid_map[$row['user_id']] = $row['login'];
    }

    $res->free();

    $res = $db->query("select distinct user_id,prob_id,contest_id from runs where (contest_id >= $from and contest_id <= $to and status = 17)");

    while ($row = $res->fetch_assoc())
    {
        $uname = $uid_map[intval($row['user_id'])];
        $prob = intval($cnt_probs_sum[intval($row['contest_id'])] + intval($row['prob_id']) - 1);
        if (!isset($prob_user_results[$uname]) || !isset($prob_user_results[$uname][$prob]))
            continue;
        $at = abs(intval($prob_user_results[$uname][$prob]));
        if ((strstr($prob_user_results[$uname][$prob], "+") === false) && (strstr($prob_user_results[$uname][$prob], "?") === false))
            $prob_user_results[$uname][$prob] = "&cross; " . ($at ? strval($at) : ""); 
    }

    $res->free();

    $count = 0;

    for ($cid = $from; $cid <= $to; ++$cid)
    {
        if (!isset($doc_pool[$cid])) continue;
        for ($prob = 0; $prob < $cnt_probs[$cid]; $prob++)
            echo "<th class=\"st_prob\">" . $cnt_prob_names[$cid][$prob] . "</th>";
    }
?>
</tr>
</thead>
<tbody>
<?php
    $idx = 1;
    foreach ($user_names as $uname)
    {
        echo "<tr>";
        echo "<td class=\"st_place\">" . $idx . "</td>";
        echo "<td class=\"st_team\">" . $uname . "</td>";
        echo "<td class=\"st_total\">" . $user_summary[$uname]['solved'] . "</td>";
        echo "<td class=\"st_pen\">" . $user_summary[$uname]['penalty'] . "</td>";
        for ($prob = 0; $prob < $n_probs; $prob++)
        {
            $cl = "none";
            if (strstr($prob_user_results[$uname][$prob], "+") !== false) $cl = "ok";
            if (strstr($prob_user_results[$uname][$prob], "-") !== false) $cl = "fl";
            if (strstr($prob_user_results[$uname][$prob], "?") !== false) $cl = "pr";
            if (strstr($prob_user_results[$uname][$prob], "DQ") !== false) $cl = "dq";
            if (strstr($prob_user_results[$uname][$prob], "&cross;") !== false) $cl = "rj";
            echo "<td class=\"st_prob $cl\">" . $prob_user_results[$uname][$prob] . "</td>";
        }
        echo "</tr>";
        $idx++;
    }
?>
</tbody>
</table>
</div>
<p></p>

<p>
    <button id="btn-filter-ok">OK</button>
    <button id="btn-filter-pr">PR</button>
    <button id="btn-filter-rj">RJ</button>
    <button id="btn-filter-dq">DQ</button>
    <button id="btn-filter-clear">Clear</button>

    <script type="text/javascript">
        $("#btn-filter-ok").click(function() {$("input[type=search]").val("OK").keyup()});
        $("#btn-filter-pr").click(function() {$("input[type=search]").val("PR").keyup()});
        $("#btn-filter-rj").click(function() {$("input[type=search]").val("RJ").keyup()});
        $("#btn-filter-dq").click(function() {$("input[type=search]").val("DQ").keyup()});
        $("#btn-filter-clear").click(function() {$("input[type=search]").val("").keyup()});
    </script>
</p>

<table class="subs">
<thead>
    <tr>
        <th>Время</th>
        <th>Участник</th>
        <th>Задача</th>
        <th>Вердикт</th>
    </tr>
</thead>
<tbody>
<?php
    $res = $db->query("select contest_id,run_id,user_id,status,create_time,prob_id,test_num from runs where contest_id >= $from and contest_id <= $to and contest_id != 241 order by create_time desc");

while ($row = $res->fetch_assoc())
{
    if (get_status_str($row['status']) === '')
        continue;
    if (!isset($doc_pool[$row['contest_id']]))
        continue;
    if (!isset($cnt_prob_names[$row['contest_id']][intval($row['prob_id']) - 1]))
        continue;
    if (!isset($uid_map[$row['user_id']]))
        continue;
    echo '<tr>';
    echo '<td class="tm">' . $row['create_time'] . '</td>';
    echo '<td class="un">' . $uid_map[$row['user_id']] . '</td>';
    echo '<td class="tm">' . get_contest_name(intval($row['contest_id']), true) . ' ';
    echo $cnt_prob_names[$row['contest_id']][intval($row['prob_id']) - 1] . '</td>';
    echo '<td class="' . get_colored_class($row['status']) .'">' . get_status_str($row['status']);
    if ((get_colored_class($row['status']) === "fl") && (intval($row['status']) !== 1))
        echo ' (' . (intval($row['test_num']) + 1) . ')';
    echo '</td>';
    echo '</tr>';
   // $count++;
    if ($count >= 50)
        break;
}
?>
</tbody>
</table>

<script type="text/javascript">
    $(document).ready(function() {
        $(".subs").DataTable({
            "columnDefs": [
                {"type": "datetime-moment", targets: 0}
            ],
            "order": [[0, "desc"]]
        });
    })
</script>

<?php
    $res->free();
    $db->close();
?>
