package global.dclass.team5.VO;

import java.time.LocalDateTime;

public class ChatMessage {
	private String id;
	private String userName;
	private String message;
	private LocalDateTime chatDate;
	
	public ChatMessage() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ChatMessage(String id, String userName, String message, LocalDateTime chatDate) {
		super();
		this.id = id;
		this.userName = userName;
		this.message = message;
		this.chatDate = chatDate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public LocalDateTime getChatDate() {
		return chatDate;
	}

	public void setChatDate(LocalDateTime chatDate) {
		this.chatDate = chatDate;
	}

	@Override
	public String toString() {
		return "ChatMessage [id=" + id + ", userName=" + userName + ", message=" + message + ", chatDate=" + chatDate
				+ "]";
	}
	
}
