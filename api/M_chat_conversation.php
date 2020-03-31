<?php defined('BASEPATH') OR exit('No direct script access allowed');

require_once(APPPATH . 'models/Parents_Model.php');

class M_chat_conversation extends Parents_Model {

    public function __construct() {
        parent::__construct();
        $this->load->model("M_app");
        $this->load->model("M_chat");
    }

    public function insertmessage($schUid, $data){
        $this->initDBAPI($schUid);
        $sql = $this->db->insert('tbl_chat_conversation', $data);
        return $sql;
    }

    public function getStatus($schUid, $conversationId){
        $this->initDBAPI($schUid);
        $this->db->select('status');
        $this->db->where('id_conversation', $conversationId);
        $query = $this->db->get('tbl_chat_conversation');
        if ($query->num_rows() > 0){
            return $query->row();
        }
    }

    public function updateMessage($schUid, $conversationId, $data){
        $this->initDBAPI($schUid);
        $this->db->update('tbl_chat_conversation', $data, ['id_conversation' => $conversationId]);
        return $this->db->affected_rows() > 0;
    }

    public function readAllMessage($schUid, $data, $where){
        $this->initDBAPI($schUid);
        $this->db->update('tbl_chat_conversation', $data, $where);
        return $this->db->affected_rows() > 0;
    }

    public function getDelayedMessage($schUid, $userUid){
        $this->initDBAPI($schUid);
        $this->db->select("
            id_conversation, conversation, 
            from_user_id_url as sender_url_id, 
            to_user_id_url as receiver_url_id,
        ");
        $this->db->from('tbl_chat_conversation');
        $this->db->where('to_user_id_url', $userUid);
        $this->db->where('status <', '2');
        $this->db->order_by('send_at', 'asc');
        $sql = $this->db->get()->result_array();

        $data = array();
        foreach($sql as $value){
            $sender = $this->M_chat->getDisplayUser($schUid, $value['sender_url_id']);
            $value['received_by_target_at'] = $this->M_app->millisecondSinceEpoch();

            $rowData = $value;
            $rowData['sender']['display_name'] = $sender->display_name;
            $rowData['sender']['display_foto'] = $sender->display_foto;

            $data[] = $rowData;
        }

        $this->db->update('tbl_chat_conversation', 
        [ 'sent_at' => $this->M_app->millisecondSinceEpoch(), 'status' => 2],
        [ 'status <' => 2, 'to_user_id_url' => $userUid]);

        return $data;
    }

    public function getLatestStatusMessage($schUid, $messages){
        $this->initDBAPI($schUid);
        $this->db->select('id_conversation, sent_at, read_at, status');
        $this->db->from('tbl_chat_conversation');
        $this->db->where('id_conversation', $messages[0]->conversation_id);
        foreach ($messages as $row => $value) {
            if($row > 0){
                $this->db->or_where('id_conversation', $value->conversation_id);
            }
        }
        $sql = $this->db->get();
        return $sql->result_array();
    }
}