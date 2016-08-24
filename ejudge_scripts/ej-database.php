<?php

/* 
 *  THIS IS INCLUDE FILE
 *
 */

function ej_connect_db()
{
    $db_name = "DATABASE";
    $db_user = "USER";
    $db_pass = "PASSWORD";
    $db_host = "HOST";

    $db = new mysqli($db_host, $db_user, $db_pass, $db_name);

    if ($db->connect_error) {
        die('Connect Error (' . $mysqli->connect_errno . ') '
            . $mysqli->connect_error);
    }

    return $db;
}

function get_contest_name($id, $dash = true)
{
    $x = sprintf("%02d", $id % 50);
    $xm = sprintf("%02d", ($id - 1) % 50);
    if ($id === 341) return 'Группа П3. Паралимпиада' . (($dash) ? (' - ') : (''));
    if ($id === 342) return 'Группа П3. Итоговая олимпиада' . (($dash) ? (' - ') : (''));
    if ($id === 241) return 'Группа П2. Олимпиада' . (($dash) ? (' - ') : (''));
    if (($id > 100) && ($id < 200)) return 'Группа П1. Тренировка ' . $x . (($dash) ? (' - ') : (''));
    if ($id === 205) return 'Группа П2. Массивы. Турнир' . (($dash) ? (' - ') : (''));
    if (($id > 200) && ($id < 205)) return 'Группа П2. Массивы. Тренировка ' . $x . (($dash) ? (' - ') : (''));
    if (($id > 205) && ($id < 249)) return 'Группа П2. Массивы. Тренировка ' . $xm . (($dash) ? (' - ') : (''));
    if (($id > 250) && ($id < 300)) return 'Группа П2. Перебор. Тренировка ' . $x . (($dash) ? (' - ') : (''));
    if (($id > 300) && ($id < 340)) return 'Группа П3. Тренировка ' . $x . (($dash) ? (' - ') : (''));
    return 'Unknown contest';
}

function get_standings_filename($id)
{
    $padded = sprintf("%06d", $id);
    $fname = "/home/judges/$padded/var/status/dir/standings.html";
    return $fname;
}

function get_colored_class($st)
{
    $status = intval($st);
    if ($status === 0) return 'ok';
    if ($status === 10) return 'dq';
    if ($status === 16) return 'pr';
    if ($status === 17) return 'rj';
    return 'fl';
}

function get_status_str($st)
{
    $status = intval($st);
    if ($status === 0) return 'OK';
    if ($status === 1) return 'CE';
    if ($status === 2) return 'RT';
    if ($status === 3) return 'TL';
    if ($status === 4) return 'PE';
    if ($status === 5) return 'WA';
    if ($status === 10) return 'DQ';
    if ($status === 12) return 'ML';
    if ($status === 13) return 'SV';
    if ($status === 16) return 'PR';
    if ($status === 17) return 'RJ';
    return '';
}

?>
