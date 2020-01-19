package global.dclass.team5.VO;

public class Message {
	private String toId;
	private String fromId;
	private String messageContent;
	private String messageIndate;
	private int messageCheck;
	private int applicationSeq;
	private int confirm;
	private int msg_seq;
	


	public Message() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Message(String toId, String fromId, String messageContent, String messageIndate, int messageCheck,
			int applicationSeq, int confirm, int msg_seq) {
		super();
		this.toId = toId;
		this.fromId = fromId;
		this.messageContent = messageContent;
		this.messageIndate = messageIndate;
		this.messageCheck = messageCheck;
		this.applicationSeq = applicationSeq;
		this.confirm = confirm;
		this.msg_seq = msg_seq;
	}

	public String getToId() {
		return toId;
	}

	public void setToId(String toId) {
		this.toId = toId;
	}

	public String getFromId() {
		return fromId;
	}

	public void setFromId(String fromId) {
		this.fromId = fromId;
	}

	public String getMessageContent() {
		return messageContent;
	}

	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}

	public String getMessageIndate() {
		return messageIndate;
	}

	public void setMessageIndate(String messageIndate) {
		this.messageIndate = messageIndate;
	}

	public int getMessageCheck() {
		return messageCheck;
	}

	public void setMessageCheck(int messageCheck) {
		this.messageCheck = messageCheck;
	}

	public int getApplicationSeq() {
		return applicationSeq;
	}

	public void setApplicationSeq(int applicationSeq) {
		this.applicationSeq = applicationSeq;
	}

	public int getConfirm() {
		return confirm;
	}

	public void setConfirm(int confirm) {
		this.confirm = confirm;
	}
	

	public int getMsg_seq() {
		return msg_seq;
	}

	public void setMsg_seq(int msg_seq) {
		this.msg_seq = msg_seq;
	}

	@Override
	public String toString() {
		return "Message [toId=" + toId + ", fromId=" + fromId + ", messageContent=" + messageContent
				+ ", messageIndate=" + messageIndate + ", messageCheck=" + messageCheck + ", applicationSeq="
				+ applicationSeq + ", confirm=" + confirm + ", msg_seq=" + msg_seq + "]";
	}

	
}
