<!doctype html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>ЛКШ "КЭШ" ejudge server</title>
    
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/main.css" rel="stylesheet" type="text/css" />
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
  </head>
  <body>    

    <div class="container">
        <div class="text-center">
            <div class="pageTitle page-header well">
                <h1>ЛКШ "КЭШ" ejudge server</h1>
            </div> 
        
            <div class="row">
                <div class="col-md-4">
                    <div class="panel panel-info">
                        <div class="panel-heading"><div class="panel-title">Учебные группы</div></div>
                        <div class="panel-body">
                            <div class="list-group">
                                <a href="P1" class="list-group-item">Группа П1</a>
                                <div class="dropdown">
                                    <a href="#" class="list-group-item dropdown-toggle" data-toggle="dropdown">Группа П2 <span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="P2/arrays.php">Массивы</a></li>
                                        <li><a href="P2/search.php">Перебор</a></li>
                                        <li><a href="P2/docs.php">Документы</a></li>
                                    </ul>
                                </div>
                                <a href="P3" class="list-group-item">Группа П3</a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="panel panel-info">
                        <div class="panel-heading"><div class="panel-title">Факультативы</div></div>
                        <div class="panel-body">
                            <div class="list-group">
                                <a href="fact/projects" class="list-group-item">Проектная деятельность</a>
                                <a href="//192.168.1.128" class="list-group-item">AIBattle</a>
                                <a href="fact/debug" class="list-group-item">Отладка</a>
                                <a href="fact/sorts" class="list-group-item">Сортировки</a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="panel panel-info">
                        <div class="panel-heading"><div class="panel-title">Cсылки</div></div>
                        <div class="panel-body">
                            <div class="list-group">
                                <a href="software.html" class="list-group-item">Полезное программное обеспечение</a>
                                <a href="memes.html" class="list-group-item">Вредные мемесы</a>
                                <a href="regftp.php" class="list-group-item">Получить доступ к FTP</a>
                                <a href="/cppreference/en" class="list-group-item">cppreference (English)</a>
                                <a href="/priv" class="list-group-item">Администраторская панель</a>
                            </div>
                        </div>
                    </div>
                </div>  
            </div>
            
            <div class="pageTitle">
                <h2>Расписание</h2>
            </div>
            
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr class="info">
                            <th>Время</th>
                            <th>1 кабинет</th>
                            <th>2 кабинет</th>
                            <th>3 кабинет</th>
                            <th>4 кабинет</th>
                        </tr>
                    </thead>
                    
                    <tbody>
                        <tr>
                            <td>9.40-10.15<br>10.20-10.55</td>
                            <td>Робототехника</td>
                            <td>Начальное программирование</td>
                            <td>Олимпиадное программирование<br>(высокий уровень)</td>
                            <td>Олимпиадное программирование<br>(средний уровень)</td>
                        </tr>
                        <tr>
                            <td>11.00-11.35</td>
                            <td>Робототехника для начальной школы</td>
                            <td></td>
                            <td>Настольные игры для начальной школы</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>11.40-12.15<br>12.20-12.55</td>
                            <td>Робототехника</td>
                            <td>Начальное программирование</td>
                            <td>Олимпиадное программирование<br>(высокий уровень)</td>
                            <td>Олимпиадное программирование<br>(средний уровень)</td>
                        </tr>
                        <tr>
                            <td>16.15-17.15</td>
                            <td colspan="4">Факультативы</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="pageTitle">
                <h2>Факультативы</h2>
            </div>
            
            <?php 
                $date = date('j');
            ?>
            
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr class="info">
                            <th>Триада</th>
                            <th>1 кабинет</th>
                            <th>2 кабинет</th>
                            <th>3 кабинет</th>
                            <th>4 кабинет</th>
                            <th>Столовая</th>
                            <th>Холл 2 эт.</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                            if (in_array($date, array(7, 8, 9)))
                            {
                        ?>
                        <tr class="success">
                        <?php
                            }
                            else
                            {
                        ?>
                        <tr>
                        <?php
                            }
                        ?>
                            <td>1</td>
                            <td><strong>Комбинаторика</strong><br>(Орлова Д.К.)<br><strong>Ардуино</strong><br>(Андреев А.А.)</td>
                            <td><strong>CeeBot4</strong><br>(Иванова М.А.)</td>
                            <td><strong>Компьютерные бои</strong><br>(Царёв Н.Е.)</td>
                            <td><strong>Проектная деятельность</strong><br>(Михайлов С.А.)</td>
                            <td><strong>Автоматы</strong><br>(Валин Г.А.)</td>
                            <td><strong>Автономный футбол</strong><br>(Иванов А.Н.)</td>
                        </tr>
                        
                        <?php
                            if (in_array($date, array(10, 11, 12, 13)))
                            {
                        ?>
                        <tr class="success">
                        <?php
                            }
                            else
                            {
                        ?>
                        <tr>
                        <?php
                            }
                        ?>
                            <td>2</td>
                            <td><strong>Комбинаторика</strong><br>(Орлова Д.К.)<br><strong>Ардуино</strong><br>(Андреев А.А.)</td>
                            <td><strong>Сортировки</strong><br>(Валин Г.А.)</td>
                            <td><strong>Компьютерные бои</strong><br>(Царёв Н.Е.)</td>
                            <td><strong>Проектная деятельность</strong><br>(Михайлов С.А.)</td>
                            <td><strong>Базы данных</strong><br>(Иванова М.А.)</td>
                            <td><strong>Автономный футбол</strong><br>(Иванов А.Н.)</td>
                        </tr>
                        
                        <?php
                            if (in_array($date, array(14, 15, 16, 17)))
                            {
                        ?>
                        <tr class="success">
                        <?php
                            }
                            else
                            {
                        ?>
                        <tr>
                        <?php
                            }
                        ?>
                            <td>3</td>
                            <td><strong>Отладка программ</strong><br>(Довгалюк П.М.)<br><strong>Ардуино</strong><br>(Андреев А.А.)</td>
                            <td><strong>Сортировки 2</strong><br>(Валин Г.А.)</td>
                            <td><strong>Компьютерные бои</strong><br>(Царёв Н.Е.)</td>
                            <td><strong>Проектная деятельность</strong><br>(Михайлов С.А.)</td>
                            <td><strong>Мат. логика</strong><br>(Иванова М.А.)</td>
                            <td><strong>Автономный футбол</strong><br>(Иванов А.Н.)</td>
                        </tr>
                        
                        <?php
                            if (in_array($date, array(18, 19, 20, 21)))
                            {
                        ?>
                        <tr class="success">
                        <?php
                            }
                            else
                            {
                        ?>
                        <tr>
                        <?php
                            }
                        ?>
                            <td>4</td>
                            <td><strong>Отладка программ</strong><br>(Довгалюк П.М.)<br><strong>Ардуино</strong><br>(Андреев А.А.)</t>
                            <td><strong>Настольные игры для начальной школы</strong><br />(Орлова Д.К.)</td>
                            <td><!--<strong>Компьютерные бои 2</strong><br>(Царёв Н.Е.)--></td>
                            <td><strong>Проектная деятельность</strong><br>(Михайлов С.А.)</td>
                            <td><strong>Мат. логика</strong><br>(Иванова М.А.)</td>
                            <td><strong>Автономный футбол</strong><br>(Иванов А.Н.)</td>
                        </tr>
                        
                        <?php
                            if (in_array($date, array(22, 23, 24)))
                            {
                        ?>
                        <tr class="success">
                        <?php
                            }
                            else
                            {
                        ?>
                        <tr>
                        <?php
                            }
                        ?>
                            <td>5</td>
                            <td><strong>Github</strong><br>(Довгалюк П.М.)<br><strong>Ардуино</strong><br>(Андреев А.А.)</td>
                            <td><strong>Настольные игры для начальной школы</strong><br />(Орлова Д.К.)</td>
                            <td></td>
                            <td><strong>Проектная деятельность</strong><br>(Михайлов С.А.)</td>
                            <td></td>
                            <td><strong>Автономный футбол</strong><br>(Иванов А.Н.)</td>
                        </tr>
                    </tbody>
                </table>
            </div>
         </div>
    </div>    
  </body>
  
</html>
