<?php
/**
 * admin controller
 *
 ******************************************************************************/

class admin_controller extends app_controller {
	/**
	 * Init.
	 */
	public function init() {
		auth::require_user();
	}
}
