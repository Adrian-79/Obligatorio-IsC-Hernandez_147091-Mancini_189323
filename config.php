<?php
$dotenv = parse_ini_file(__DIR__ . '/.env');
define('DB_HOST', $dotenv['DB_HOST']);
define('DB_NAME', $dotenv['DB_NAME']);
define('DB_USER', $dotenv['DB_USER']);
define('DB_PASS', $dotenv['DB_PASS']);
