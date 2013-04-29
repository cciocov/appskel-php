<?php
/**
 * front controller
 *
 ******************************************************************************/

class front_controller extends app_controller {
	/**
	 * User info (from session).
	 * @var array
	 */
	public $user_info;


	/**
	 * Init.
	 */
	public function init() {
		$this->user_info = auth::require_user();
	}
}
