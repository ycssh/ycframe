package cn.yc.ssh.admin.base.util;

public class Message {
	private boolean result;
	private String msg;

	public boolean getResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Message(boolean result, String msg) {
		super();
		this.result = result;
		this.msg = msg;
	}

	public Message() {
		super();
	}

}
