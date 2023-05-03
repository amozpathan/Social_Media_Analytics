<?php
$wd=getcwd();
$wd=str_replace('\\','/',"$wd");
$output=exec("cd $wd");
$output=shell_exec("Rscript lda.R");
 echo "<img src='ldaGraph.png'>";
?>