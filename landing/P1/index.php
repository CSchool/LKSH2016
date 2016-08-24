<!doctype html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Группа П1</title>

    <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="../assets/css/main.css" rel="stylesheet" type="text/css" />
    <script src="../assets/js/jquery.min.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
  </head>
  <body>
    <div class="container">
        <div class="text-center">
            <div class="pageTitle page-header well">
                <h1>Группа П1</h1>
            </div> 
            
            <div class="row">
                <div class="col-xs-12">
                    <div class="panel panel-info">
                    <div class="panel-heading"><div class="panel-title">Ссылки</div></div>
                        <div class="panel-body">
                            <div class="list-group">
                                <a href="/stand.php?from=101&to=199&title=Таблица результатов группы П1" class="list-group-item">Сводная таблица</a>
                                <a href="/common/codingstyle/cppstyle.pdf" class="list-group-item">Как писать читаемый код на C++</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <div class="panel panel-info">
                <div class="panel-heading">
                    <div class="panel-title">Олимпиада</div>
                </div>
                <div class="panel-body">
                    <div class="list-group">
                        <a href="/cgi-bin/new-client?contest_id=107&locale_id=1" class="list-group-item">Вход</a>
                        <a href="statements/olimp.pdf" class="list-group-item">Условия</a>
                        <a href="/st.php?contest_id=107" class="list-group-item">Таблица результатов</a>
                    </div>
                </div>
            </div>

            <div class="row">
<?php for ($i = 1; $i <= 6; ++$i) { $x=sprintf("%02d", $i); ?>
                <div class="col-md-4">
                    <div class="panel panel-info">
                    <div class="panel-heading"><div class="panel-title">Тренировка <?php echo $x; ?></div></div>
                        <div class="panel-body">
                            <div class="list-group">
                                <a href="/cgi-bin/new-client?contest_id=1<?php echo $x; ?>&locale_id=1" class="list-group-item">Вход</a>
                                <a href="statements/<?php echo $x; ?>.pdf" class="list-group-item">Условия</a>
                                <a href="lections/lec<?php echo $x; ?>.pdf" class="list-group-item">Лекция</a>
                                <a href="/st.php?contest_id=1<?php echo $x; ?>" class="list-group-item">Таблица результатов</a>
                            </div>
                        </div>
                    </div>
                </div>
<?php }; ?>
            </div>
         </div>
    </div>
  </body>
</html>
