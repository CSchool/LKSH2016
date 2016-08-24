<!doctype html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Группа П3</title>

    <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="../assets/css/main.css" rel="stylesheet" type="text/css" />
    <script src="../assets/js/jquery.min.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
  </head>
  <body>
    <div class="container">
        <div class="text-center">
            <div class="pageTitle page-header well">
                <h1>Группа П3</h1>
            </div> 

            <div class="alert alert-info">
                <p><strong>Внимание! Эксперимент!</strong>
                Теперь задача считается сданной если решение прошло все тесты и <strong>преподавателя устраивает код</strong>.
                <br />
                Что это значит - вместо OK выставляется Pending Review (Ожидает подтверждения).
                <br />
                Потом преподаватель анализирует код на предмет соответствия принятым стандартам оформления и ставит OK, если его всё устраивает, или Rejected (Отклонено) с комментарием ошибки.
                <br />
                Стандарты оформления можно найти ниже. Если Вы пишите на Python - гуглите PEP 8.

                </p> 
            </div>
            
            <div class="row">
                <div class="col-xs-12">
                    <div class="panel panel-info">
                    <div class="panel-heading"><div class="panel-title">Ссылки</div></div>
                        <div class="panel-body">
                            <div class="list-group">
                                <a href="/stand.php?from=301&to=340&title=Таблица результатов группы П3" class="list-group-item">Сводная таблица</a>
                                <a href="/common/codingstyle/cppstyle.pdf" class="list-group-item">Как писать читаемый код на C++</a>
                                <a href="/common/codingstyle/pascalstyle.pdf" class="list-group-item">Как писать читаемый код на Pascal</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4">
                    <div class="panel panel-success">
                    <div class="panel-heading"><div class="panel-title">Итоговая олимпиада</div></div>
                        <div class="panel-body">
                            <div class="list-group">
                                <a href="/cgi-bin/new-client?contest_id=342&locale_id=1" class="list-group-item">Вход</a>
                                <a href="statements/olymp.pdf" class="list-group-item">Условия</a>
                                <a href="/st.php?contest_id=342" class="list-group-item">Таблица результатов</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="panel panel-danger">
                    <div class="panel-heading"><div class="panel-title">"Паралимпиада"</div></div>
                        <div class="panel-body">
                            <div class="list-group">
                                <a href="/cgi-bin/new-client?contest_id=341&locale_id=1" class="list-group-item">Дорешивание</a>
                                <a href="statements/paralymp.pdf" class="list-group-item">Условия</a>
                                <a href="/st.php?contest_id=341" class="list-group-item">Таблица результатов</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
<hr />
            <div class="row">
<?php for ($i = 1; $i <= 8; ++$i) { $x=sprintf("%02d", $i); ?>
                <div class="col-md-4">
                    <div class="panel panel-info">
                    <div class="panel-heading"><div class="panel-title">Тренировка <?php echo $x; ?></div></div>
                        <div class="panel-body">
                            <div class="list-group">
                                <a href="/cgi-bin/new-client?contest_id=3<?php echo $x; ?>&locale_id=1" class="list-group-item">Вход</a>
                                <a href="statements/day<?php echo $x; ?>.pdf" class="list-group-item">Условия</a>
                                <a href="/st.php?contest_id=3<?php echo $x; ?>" class="list-group-item">Таблица результатов</a>
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
