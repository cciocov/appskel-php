<?php
/**
 * System Permissions
 *
 ******************************************************************************/

$CFG['PERMISSIONS'] = array(
	'System Configuration' => array(
		'manage_roles' => array(
			'name' => 'Manage Roles',
			'desc' => ''
		),

		'manage_users' => array(
			'name' => 'Manage Users',
			'desc' => ''
		)
	)
);

/**
 * Define some permission lists to keep views simple.
 */
$CFG['P_ADMIN'] = implode(',', array_merge(
	array_keys($CFG['PERMISSIONS']['System Configuration'])
));
