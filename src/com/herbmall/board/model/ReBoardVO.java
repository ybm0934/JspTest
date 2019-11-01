package com.herbmall.board.model;

import java.sql.Timestamp;

public class ReBoardVO {
	private int no;
	private String name;
	private String pwd;
	private String title;
	private String email;
	private Timestamp regdate;
	private int readcount;
	private String content;
	private int groupNo;
	private int step;
	private int sortNo;
	private String delFlag;
	private String ip;
	private String port;
	private String browser;

	// 자료실
	private String fileName1;
	private String originalFileName1;
	private double fileSize1;
	private int downCount1;
	private String fileName2;
	private String originalFileName2;
	private double fileSize2;
	private int downCount2;

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getSortNo() {
		return sortNo;
	}

	public void setSortNo(int sortNo) {
		this.sortNo = sortNo;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public String getBrowser() {
		return browser;
	}

	public void setBrowser(String browser) {
		this.browser = browser;
	}

	public String getFileName1() {
		return fileName1;
	}

	public void setFileName1(String fileName1) {
		this.fileName1 = fileName1;
	}

	public String getOriginalFileName1() {
		return originalFileName1;
	}

	public void setOriginalFileName1(String originalFileName1) {
		this.originalFileName1 = originalFileName1;
	}

	public double getFileSize1() {
		return fileSize1;
	}

	public void setFileSize1(double fileSize1) {
		this.fileSize1 = fileSize1;
	}

	public int getDownCount1() {
		return downCount1;
	}

	public void setDownCount1(int downCount1) {
		this.downCount1 = downCount1;
	}

	public String getFileName2() {
		return fileName2;
	}

	public void setFileName2(String fileName2) {
		this.fileName2 = fileName2;
	}

	public String getOriginalFileName2() {
		return originalFileName2;
	}

	public void setOriginalFileName2(String originalFileName2) {
		this.originalFileName2 = originalFileName2;
	}

	public double getFileSize2() {
		return fileSize2;
	}

	public void setFileSize2(double fileSize2) {
		this.fileSize2 = fileSize2;
	}

	public int getDownCount2() {
		return downCount2;
	}

	public void setDownCount2(int downCount2) {
		this.downCount2 = downCount2;
	}

	@Override
	public String toString() {
		return "ReBoardVO [no=" + no + ", name=" + name + ", pwd=" + pwd + ", title=" + title + ", email=" + email
				+ ", regdate=" + regdate + ", readcount=" + readcount + ", content=" + content + ", groupNo=" + groupNo
				+ ", step=" + step + ", sortNo=" + sortNo + ", delFlag=" + delFlag + ", ip=" + ip + ", port=" + port
				+ ", browser=" + browser + ", fileName1=" + fileName1 + ", originalFileName1=" + originalFileName1
				+ ", fileSize1=" + fileSize1 + ", downCount1=" + downCount1 + ", fileName2=" + fileName2
				+ ", originalFileName2=" + originalFileName2 + ", fileSize2=" + fileSize2 + ", downCount2=" + downCount2
				+ "]";
	}

}
