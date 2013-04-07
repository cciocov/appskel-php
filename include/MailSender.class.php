<?php
/**
 * MailSender.class.php
 * 
 ******************************************************************************/
require_once(dirname(__FILE__) . '/vendors/sendgrid/SendGrid_loader.php');

class MailSender {
	/**
	 * SendGrid object.
	 * @var object
	 */
	public $sendgrid;


	/**
	 * Constructor.
	 */
	public function __construct() {
		global $CFG;

		$this->sendgrid = new SendGrid(
			$CFG['SENDGRID']['username'],
			$CFG['SENDGRID']['password']
		);
	}

	/**
	 * Send an e-mail. The following keys are required in $params: to, from,
	 * subject, text or html.
	 */
	public function send($params) {
		global $CFG;

		$mail = new SendGrid\Mail();

		// to address:
		if (isset($params['to'])) {
			$mail->addTo($params['to']);
		}
		else {
			return false;
		}

		// from address:
		if (isset($params['from'])) {
			$mail->setFrom($params['from']);
		}
		elseif (isset($CFG['MAIL']['from'])) {
			$mail->setFrom($CFG['MAIL']['from']);
		}
		else {
			return false;
		}

		// from name:
		if (isset($params['from_name'])) {
			$mail->setFromName($params['from_name']);
		}
		elseif (isset($CFG['MAIL']['from_name'])) {
			$mail->setFromName($CFG['MAIL']['from_name']);
		}

		// subject:
		if (isset($params['subject'])) {
			$mail->setSubject($params['subject']);
		}

		// text:
		if (isset($params['text'])) {
			$mail->setText($params['text']);
		}

		// HTML:
		if (isset($params['html'])) {
			$mail->setHtml($params['html']);
		}

		// send the message:
		return $this->sendgrid->smtp->send($mail);
	}

	/**
	 * Send an e-mail from a view.
	 */
	public function sendView($params, $view, $data = array()) {
		global $CFG;

		if (is_file("$CFG[ROOT_DIR]/views/emails/$view" . '_html.tpl')) {
			$params['html'] = view::get()->render("emails/$view" . '_html', $data);
		}
		if (is_file("$CFG[ROOT_DIR]/views/emails/$view" . '_text.tpl')) {
			$params['text'] = view::get()->render("emails/$view" . '_text', $data);
		}

		return $this->send($params);
	}
}
