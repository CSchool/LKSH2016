<?php
    include_once("ej-database.php");
    function inv_cid()
    {
        echo "<h1>Invalid contest ID</h1>";
        exit;
    }
    
    if (!isset($_GET['contest_id'])) inv_cid();
    $cid = intval($_GET['contest_id']);
    if ($cid < 1) inv_cid();
    $fname = get_standings_filename($cid);
    if (file_exists($fname))
    {
?>
<link href="ejudge/unpriv.css" rel="stylesheet" type="text/css" />
<?php
        echo file_get_contents($fname);
    }
    else
        inv_cid();
?>
