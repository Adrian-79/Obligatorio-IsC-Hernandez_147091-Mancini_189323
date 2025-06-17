//Este archivo lee las variables del .env_entorno y las define para que otros scripts las puedan usar.
<?php
$dotenv = parse_ini_file(__DIR__ . '/.env_entorno');
define('DB_HOST', $dotenv['DB_HOST']);
define('DB_NAME', $dotenv['DB_NAME']);
define('DB_USER', $dotenv['DB_USER']);
define('DB_PASS', $dotenv['DB_PASS']);