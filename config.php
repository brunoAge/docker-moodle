<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype    = getenv('MOODLE_DATABASE_TYPE');
$CFG->dblibrary = 'native';
$CFG->dbhost    = getenv('MOODLE_DATABASE_HOST');
$CFG->dbname    = getenv('MOODLE_DATABASE_NAME');
$CFG->dbuser    = getenv('MOODLE_DATABASE_USER');
$CFG->dbpass    = getenv('MOODLE_DATABASE_PASSWORD');
$CFG->prefix    = getenv('MOODLE_DATABASE_PREFIX');
$CFG->dboptions = array (
  'dbpersist' => 0,
  'dbport' => getenv('MOODLE_DATABASE_PORT_NUMBER'),
  'dbsocket' => '',
  'dbcollation' => 'utf8mb4_unicode_ci',
);

if (getenv('MOODLE_SLAVE_DATABASE_HOST')) {
  $CFG->dboptions['readonly'] = [
    'instance' => getenv('MOODLE_SLAVE_DATABASE_HOST')
  ];
}

$CFG->wwwroot   = getenv('MOODLE_HOST');
$CFG->dataroot  = getenv('MOODLEDATA_PATH');
$CFG->admin     = getenv('MOODLE_USERNAME');

$CFG->directorypermissions = 0777;

if (getenv('MOODLE_ENABLE_SESSION_MEMCACHED')) {
    $CFG->session_handler_class = getenv('MOODLE_SESSION_HANDLER_CLASS');
    $CFG->session_memcached_save_path = getenv('MOODLE_SESSION_MEMCACHED_SAVE_PATH');
    $CFG->session_memcached_prefix = getenv('MOODLE_SESSION_MEMCACHED_PREFIX');
    $CFG->session_memcached_acquire_lock_timeout = getenv('MOODLE_SESSION_MEMCACHED_ACQUIRE_LOCK_TIMEOUT');
    $CFG->session_memcached_lock_expire = getenv('MOODLE_SESSION_MEMCACHED_LOCK_EXPIRE');             // Ignored if PECL memcached is below version 2.2.0
    $CFG->session_memcached_lock_retry_sleep = getenv('MOODLE_SESSION_MEMCACHED_LOCK_RETRY_SLEEP');   // Spin-lock retry sleeptime (msec). Only effective
                                                                                                      // for tuning php-memcached 3.0.x (PHP 7)
}

require_once(__DIR__ . '/lib/setup.php');

// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!