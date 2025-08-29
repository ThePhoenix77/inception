<?php
/**
 * The base configuration for WordPress
 *
 * This file contains the following configurations:
 * - Database settings
 * - Secret keys
 * - Database table prefix
 * - ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 * @package WordPress
 */

// ** Database settings ** //
define( 'DB_NAME', 'wordpress' );         // WordPress database name
define( 'DB_USER', 'wp_user' );           // WordPress database user
define( 'DB_PASSWORD', 'wp_pass' );       // WordPress database password
define( 'DB_HOST', 'mariadb:3306' );      // Docker service name of MariaDB
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

// ** Enable Redis Cache ** //
define( 'WP_CACHE', true );
define( 'WP_REDIS_HOST', 'redis' ); // Docker service name of Redis
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_REDIS_TIMEOUT', 1 );          // optional
define( 'WP_REDIS_READ_TIMEOUT', 1 );     // optional
define( 'WP_REDIS_DATABASE', 0 );         // optional

// ** Authentication unique keys and salts ** //
define( 'AUTH_KEY',         'put_your_unique_phrase_here' );
define( 'SECURE_AUTH_KEY',  'put_your_unique_phrase_here' );
define( 'LOGGED_IN_KEY',    'put_your_unique_phrase_here' );
define( 'NONCE_KEY',        'put_your_unique_phrase_here' );
define( 'AUTH_SALT',        'put_your_unique_phrase_here' );
define( 'SECURE_AUTH_SALT', 'put_your_unique_phrase_here' );
define( 'LOGGED_IN_SALT',   'put_your_unique_phrase_here' );
define( 'NONCE_SALT',       'put_your_unique_phrase_here' );

// ** WordPress database table prefix ** //
$table_prefix = 'wp_';

// ** WordPress debugging mode ** //
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
