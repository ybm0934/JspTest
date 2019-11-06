package com.herbmall.register.model;

import java.sql.Timestamp;

public class RoadZipcodeVO {
	private int seq;
	private String roadNameCode;
	private String sido;
	private String gugun;
	private String roadName;
	private String buildNoMain;
	private String buildNoSub;
	private String buildName;
	private String detailBuildName;
	private String zipcode;
	private Timestamp regdate;

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getRoadNameCode() {
		return roadNameCode;
	}

	public void setRoadNameCode(String roadNameCode) {
		this.roadNameCode = roadNameCode;
	}

	public String getSido() {
		return sido;
	}

	public void setSido(String sido) {
		this.sido = sido;
	}

	public String getGugun() {
		return gugun;
	}

	public void setGugun(String gugun) {
		this.gugun = gugun;
	}

	public String getRoadName() {
		return roadName;
	}

	public void setRoadName(String roadName) {
		this.roadName = roadName;
	}

	public String getBuildNoMain() {
		return buildNoMain;
	}

	public void setBuildNoMain(String buildNoMain) {
		this.buildNoMain = buildNoMain;
	}

	public String getBuildNoSub() {
		return buildNoSub;
	}

	public void setBuildNoSub(String buildNoSub) {
		this.buildNoSub = buildNoSub;
	}

	public String getBuildName() {
		return buildName;
	}

	public void setBuildName(String buildName) {
		this.buildName = buildName;
	}

	public String getDetailBuildName() {
		return detailBuildName;
	}

	public void setDetailBuildName(String detailBuildName) {
		this.detailBuildName = detailBuildName;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "RoadZipcodeVO [seq=" + seq + ", roadNameCode=" + roadNameCode + ", sido=" + sido + ", gugun=" + gugun
				+ ", roadName=" + roadName + ", buildNoMain=" + buildNoMain + ", buildNoSub=" + buildNoSub
				+ ", buildName=" + buildName + ", detailBuildName=" + detailBuildName + ", zipcode=" + zipcode
				+ ", regdate=" + regdate + "]";
	}

}
