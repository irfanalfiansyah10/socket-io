<?php defined('BASEPATH') OR exit('No direct script access allowed');

require_once(APPPATH . 'models/Parents_Model.php');

class M_app extends Parents_Model {
  
	public function __construct() {
		parent::__construct();
    $this->load->model("M_menu");
    $sess = $this->M_session->get_session();
    include APPPATH . 'config/database.php';
    $this->initDB($db['default']['hostname'], $sess['session_dbuser'], $sess['session_dbpass'], $sess['session_dbname']);
  }
  
  // Number
  function romawi($angka){
    $romawi = "";
    while ($angka >= 10){
      $romawi .= "X";
      $angka -= 10;
    }
    if ($angka >= 5){
      if ($angka >= 9){
        $romawi .= "IX";
        $angka -= 9;
      } else {
        $romawi .= "V";
        $angka -= 5;
      }
    }
    while ($angka >= 1){
      if ($angka >= 4){
        $romawi .= "IV";
        $angka -= 4;
      } else {
        $romawi .= "I";
        $angka -= 1;
      }
    }
    return $romawi;
  }

  function terbilang($nilai){
    $nilai = abs($nilai);
		$huruf = array("", "satu", "dua", "tiga", "empat", "lima", "enam", "tujuh", "delapan", "sembilan", "sepuluh", "sebelas");
		$temp = "";
		if ($nilai < 12) {
			$temp = " ". $huruf[$nilai];
		} else if ($nilai <20) {
			$temp = $this->terbilang($nilai - 10). " belas";
		} else if ($nilai < 100) {
			$temp = $this->terbilang($nilai/10)." puluh". $this->terbilang($nilai % 10);
		} else if ($nilai < 200) {
			$temp = " seratus" . $this->terbilang($nilai - 100);
		} else if ($nilai < 1000) {
			$temp = $this->terbilang($nilai/100) . " ratus" . $this->terbilang($nilai % 100);
		} else if ($nilai < 2000) {
			$temp = " seribu" . $this->terbilang($nilai - 1000);
		} else if ($nilai < 1000000) {
			$temp = $this->terbilang($nilai/1000) . " ribu" . $this->terbilang($nilai % 1000);
		} else if ($nilai < 1000000000) {
			$temp = $this->terbilang($nilai/1000000) . " juta" . $this->terbilang($nilai % 1000000);
		} else if ($nilai < 1000000000000) {
			$temp = $this->terbilang($nilai/1000000000) . " milyar" . $this->terbilang(fmod($nilai,1000000000));
		} else if ($nilai < 1000000000000000) {
			$temp = $this->terbilang($nilai/1000000000000) . " trilyun" . $this->terbilang(fmod($nilai,1000000000000));
		}     
		return $temp;
  }

	// Date
	function datetimeNow() {
		date_default_timezone_set("Asia/Jakarta");
		return date("Y-m-d H:i:s");
	}

	function millisecondSinceEpoch(){
		return round(microtime(true) * 1000);
	}

	function dateNow() {
		date_default_timezone_set("Asia/Jakarta");
		return date("Y-m-d");
	}

	function yearNow() {
		date_default_timezone_set("Asia/Jakarta");
		return date("Y");
	}

	function monthNow() {
		date_default_timezone_set("Asia/Jakarta");
		return date("m");
	}

	function dayNow() {
		date_default_timezone_set("Asia/Jakarta");
		return date("d");
	}

	function bulanIndo($val="") {
		if($val == "") {
			$month = [
				'-- Bulan --' => 0,
				'Januari' => 1,
				'Februari' => 2,
				'Maret' => 3,
				'April' => 4,
				'Mei' => 5,
				'Juni' => 6,
				'Juli' => 7,
				'Agustus' => 8,
				'September' => 9,
				'Oktober' => 10,
				"November" => 11,
				"Desember" => 12
			];

			return $month;
		} else {
			$month = [
				0 => '-- Bulan --',
				1 => 'Januari',
				2 => 'Februari',
				3 => 'Maret',
				4 => 'April',
				5 => 'Mei',
				6 => 'Juni',
				7 => 'Juli',
				8 => 'Agustus',
				9 => 'September',
				10 => 'Oktober',
				11 => 'November',
				12 => 'Desember'
			];

			return $month[$val];
		}
	}

	function hariIndo() {
		$hari = [
			'-- Hari --' => 0,
			'Senin' => 'senin',
			'Selasa' => 'selasa',
			'Rabu' => 'rabu',
			'Kamis' => 'kamis',
			'Jumat' => 'jumat',
			'Sabtu' => 'sabtu',
			'Minggu' => 'minggu'
		];

		return $hari;
	}

	function dateIndo($data) {
		if($data == NULL || $data == "") {
			return "";
		} else {
			$x_data = explode("-", $data);
			$bulan = $this->bulanIndo((int) $x_data[1]);
			$output = $x_data[2]." ".$bulan." ".$x_data[0];
			
			return $output;
		}
	}

	function timeIndo($data) {
		if($data == NULL || $data == "") {
			return "";
		} else {
			$time = explode(":", $data);
			$output = $time[0].":".$time[1];

			return $output;
		}
	}

	function datetimeIndo($data) {
		$x_data = explode(" ", $data);
		$date = $this->dateIndo($x_data[0]);
		$time = $this->timeIndo($x_data[1]);
		$output = $date." - ".$time;

		return $output;
	}

	// Tapel and Semester
	function getTapelActive($schid = '') {
    if ($schid != '') $this->initDBAPI($schid);
		$this->db->select("id_tapel_url");
		$this->db->where("tapel_aktif", 1);
		$q = $this->db->get("tbl_sys_tapel");
		$res = $q->row();

		if($q->num_rows() == 0) {
			return "";
		} else {
			return $res->id_tapel_url;
		}
	}

	function getSemesterActive($schid = '') {
    if ($schid != '') $this->initDBAPI($schid);
		$this->db->select("id_semester_url");
		$this->db->where("semester_aktif", 1);
		$q = $this->db->get("tbl_sys_semester");
		$res = $q->row();

		if($q->num_rows() == 0) {
			return "";
		} else {
			return $res->id_semester_url;
		}
	}

	// Misc
	function randomString($length) {
		$str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		return substr(str_shuffle($str), 0, $length);
  }
  
  function randomNumber($length) {
		$str = "0123456789";
		return substr(str_shuffle($str), 0, $length);
	}

	function showMenu($arrRole,$idUser,$mainrole) {
		$menu = [];
		for($i=0; $i<count($arrRole); $i++) {
      		$gm = $this->M_menu->GetMenuGroup($arrRole[$i],$idUser,$mainrole);
			$menu["ungrouped_menu"] = $this->M_menu->GetItemMenu(NULL);
			foreach($gm as $row) {
				$grup_menu["nama"] = $row->grup_menu;
				$grup_menu["isi"] = $this->M_menu->GetItemMenu($row->id);

				$menu["grup_menu"][] = $grup_menu;
			}
		}
		
		return $menu;
  }
  
  function getAllMenuInGroup($id_role_menu_group){
		$query = $this->db->where('id_role_menu_parent', 0)->where('id_role_menu_group', $id_role_menu_group)->order_by('sorting', 'asc')->get('tbl_sys_role_menu')->result();
		foreach ($query as $d) {
			$submenu = $this->db->where('id_role_menu_parent', $d->id_role_menu)->order_by('sorting', 'asc')->get('tbl_sys_role_menu');
			if ($submenu->num_rows() > 0){
				$d->submenu = $submenu->result();
			}
		}
		return $query;
  }

  function getAllMenuGroup(){
    return $this->db->order_by('sorting', 'asc')->get('tbl_sys_role_menu_group')->result();
  }

  function getUngroupedMenus(){
		$query = $this->db->where('id_role_menu_parent', 0)->where('id_role_menu_group', NULL)->order_by('sorting', 'asc')->get('tbl_sys_role_menu')->result();
		foreach ($query as $d) {
			$submenu = $this->db->where('id_role_menu_parent', $d->id_role_menu)->order_by('sorting', 'asc')->get('tbl_sys_role_menu');
			if ($submenu->num_rows() > 0){
				$d->submenu = $submenu->result();
			}
		}
		return $query;
  }	

	// ID
  function getLatestid($key, $table, $schid='') {
      if ($schid != '') $this->initDBAPI($schid);
      $this->db->select_max($key);
      $query = $this->db->get($table);
      $result = $query->row_array();

      return $result[$key] + 1;
  }

  function getIDFromUrlID($uid,$field,$table,$schid='') {
    if ($schid != '') $this->initDBAPI($schid);
    $f_url = $field."_url";

    $this->db->select($field);
    $this->db->where($f_url, $uid);
    $q = $this->db->get($table);
      
    if($q->num_rows() == 0) {
      return "";
    } else {
      $res = $q->row();
      return $res->$field;
    }	
  }

  function getUrlIDFromID($id,$field,$table,$schid = '') {
    if ($schid != '') $this->initDBAPI($schid);
    $f_url = $field."_url";

    $this->db->select($f_url);
    $this->db->where($field, $id);
    $q = $this->db->get($table);
      
    if($q->num_rows() == 0) {
      return "";
    } else {
      $res = $q->row();
      return $res->$f_url;
    }	
  }

  // Mengambil data dari sebuah tabel dengan satu parameter saja
  function getDataByParameter($parameters, $values, $tables, $schid = ''){
    if ($schid != '') $this->initDBAPI($schid);
    return $this->db->where($parameters, $values)->get($tables);
  }

  // Mengambil data dari sebuah tabel dengan banyak parameter (dalam bentuk array)
  function getDataByParameters($parameters, $tables, $order = NULL, $schid = ''){
    if ($schid != '') $this->initDBAPI($schid);
    $this->db->where($parameters);

    if($order != NULL) {
      $this->db->order_by($order, "ASC");
    }
    $db = $this->db->get($tables);

    return $db;
  }

  function getSiswaDataById($siswaUrl, $schid = ''){
    if ($schid != '') $this->initDBAPI($schid);
    $this->db->where("id_siswa_url",$siswaUrl);
    $sql = $this->db->get("tbl_master_siswa");
    
    return $sql->row();
  }

  function getIdByUrl($columnname,$tables,$parameters, $uid, $schid = ''){
	if ($schid != '') $this->initDBAPI($schid);
	$this->db->select($columnname.' as id');
	$sql = $this->db->where($parameters, $uid)->get($tables)->row();
	return $sql;
  }
}
?>