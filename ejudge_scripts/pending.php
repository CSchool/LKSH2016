<?php
include_once("ej-database.php");

$db = ej_connect_db();
?>

<meta charset="utf-8" />
<title>Непроверенные задачи</title>
<h1>Непроверенные задачи</h1>

<?php

$q = $db->query("select distinct count(run_id) as cnt,contest_id from runs where status=16 group by contest_id");
$runs = array();

while ($row = $q->fetch_assoc()) {
    $runs[$row['contest_id']] = $row['cnt'];
}

$q->free();
$db->close();

echo '<ul>';

foreach ($runs as $id => $am)
{
    echo '<li>';
    echo get_contest_name($id);
    echo '<a href="/cgi-bin/new-master?contest_id=' . $id . '">' . $am . '</a>';
    echo '</li>';
}

echo '</ul>';
?>
