<?php
define('DB_NAME', getenv('WORDPRESS_DB_NAME'));
define('DB_USER', getenv('WORDPRESS_DB_USER'));
define('DB_PASSWORD', getenv('WORDPRESS_DB_PASSWORD'));
define('DB_HOST', getenv('WORDPRESS_DB_HOST'));

define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('AUTH_KEY',         'somekey');
define('SECURE_AUTH_KEY',  'somekey');
define('LOGGED_IN_KEY',    'somekey');
define('NONCE_KEY',        'somekey');
define('AUTH_SALT',        'somekey');
define('SECURE_AUTH_SALT', 'somekey');
define('LOGGED_IN_SALT',   'somekey');
define('NONCE_SALT',       'somekey');

$table_prefix = 'wp_';
define('WP_DEBUG', false);
if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');
require_once(ABSPATH . 'wp-settings.php');
