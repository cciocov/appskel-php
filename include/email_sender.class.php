<?php
/**
 * email_sender.class.php
 *
 ******************************************************************************/

class email_sender extends service_provider {
	/**
	 * Constructor.
	 */
	public function __construct($provider_name = null) {
		parent::__construct('EMAIL', $provider_name);
	}
}
