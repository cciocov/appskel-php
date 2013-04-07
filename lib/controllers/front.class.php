<?php
/**
 * front controller
 *
 ******************************************************************************/

class front_controller extends app_controller {
	/**
	 * Init.
	 */
	public function init() {
		auth::require_user();
	}
}
