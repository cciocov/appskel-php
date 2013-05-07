<?php
/**
 * Application Configuration
 *
 ******************************************************************************/


////////////////////////////////////////////////////////////////////////////////
//
// E-Mail Settings
//
////////////////////////////////////////////////////////////////////////////////

$CFG['EMAIL'] = array(
	'provider_name' => 'api_sendgrid',

	'from' => 'support@example.com',
	'from_name' => 'Support',

	'support_email' => 'support@example.com'
);

/**
 * E-Mail Providers
 */

// SendGrid:
$CFG['SENDGRID'] = array(
	'username' => '',
	'password' => ''
);
