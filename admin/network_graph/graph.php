<?php
$wd=getcwd();
$wd=str_replace('\\','/',"$wd");
$output=exec("cd $wd");
$output=shell_exec("Rscript graph.R");
 echo "<img src='graph.png'>";
?>