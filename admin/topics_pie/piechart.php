<?php
$wd=getcwd();
$wd=str_replace('\\','/',"$wd");
$output=exec("cd $wd");
$output=shell_exec("Rscript piechart.r");
 echo "<img src='piechart.png'>";
?>