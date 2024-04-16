<?php

require "stormmore.php";

$app = app('../src');
$app->addRoute("/", function() {echo "Hello World";});
$app->run();