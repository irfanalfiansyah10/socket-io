<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Send_email {

  private $ci;

  public function __construct(){
    $this->ci =& get_instance();
  }   

  function send_email_code($email, $code){
    $config = [
      'mailtype' => 'html',
      'charset' => 'utf-8',
      'protocol' => 'smtp',
      'smtp_host' => 'smtp.hostinger.co.id',
      'smtp_user' => 'info@halokes.co.id', // isi dengan email gmail
      'smtp_pass' => 'halokes@info', // password gmail
      'smtp_port' => 587,
      'crlf' => "\r\n",
      'newline' => "\r\n"
    ];
    $this->ci->load->library('email', $config);
    $this->ci->email->from('info@halokes.co.id', 'Halokes');
    $this->ci->email->to($email);
    $this->ci->email->subject('Kode Keamanan Penggantian Password Halokes Mobile');
    $this->ci->email->message($this->email_content($code));
    return $this->ci->email->send();
  }

  function email_content($code){
    return "(RAHASIA) Kerahasiaan kode adalah tanggung jawab Anda. <br>
    Gunakan kode ini untuk melakukan reset password Halokes Anda.
    <br><br>Kode keamanan : <b>$code</b>.";
  }
}