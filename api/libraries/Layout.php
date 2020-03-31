<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Layout {
	public function config($setting) {
		$setting = (object)$setting;
		if($setting->session_role == "superadmin") {
			$output['header'] = "template/sadmin_header";
			$output["footer"] = "template/sadmin_footer";
		} else if($setting->session_role == "guru") {
			$output['header'] = "template/guru_header";
			$output["footer"] = "template/guru_footer";
		} else if($setting->session_role == "siswa") {
			$output['header'] = "template/siswa_header";
			$output["footer"] = "template/siswa_footer";
		} else if($setting->session_role == "pegawai") {
			$output['header'] = "template/pegawai_header";
			$output["footer"] = "template/pegawai_footer";
		} else {
			$output['header'] = "";
			$output["footer"] = "";
		}

		return (object) $output;
	}
}