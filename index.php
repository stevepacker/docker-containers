<?php

function heyu($code, $action, array $args = [])
{
    if (empty($action)) {
        $action = 'onstate';
    }
    return shell_exec("heyu $action $code " . join(' ', $args) . ' 2>&1');
}

$uri    = explode('/', trim($_SERVER['REQUEST_URI'], '/'));
$code   = strtoupper(urldecode(array_shift($uri)));
$action = strtolower(urldecode(array_shift($uri)));
$args   = [];
foreach ($uri as $arg) {
    $args[] = escapeshellarg(urldecode($arg));
}
if (! preg_match('/^[A-P]\d{0,2}$/', $code)) {
    header('HTTP/1.1 400 BAD REQUEST');
    die("Invalid code");
}
echo heyu($code, $action, $args);