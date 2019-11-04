package com.herbmall.utility;

import java.util.Date;

public class Utility {

	// 긴 제목 자르기
	public static String cutString(String title, int len) {
		String result = "";
		if (title.length() > len) {
			result = title.substring(0, len) + "...";
		} else {
			result = title;
		}

		return result;
	}// cutString

	// 답변글인 경우 단계별로 이미지 보여주기
	public static String displayRe(int step) {
		String result = "";
		if (step > 0) {
			for (int i = 0; i < step * 2; i++) {
				result += "&nbsp;";
			}
			result += "<img src='../images/re.gif'>";
		}

		return result;
	}// displayRe

	// 24시간 이내의 글인 경우 new이미지 보여주기
	public static String displayNew(Date regdate) {
		Date today = new Date();
		long gap = (today.getTime() - regdate.getTime()) / 1000; // 초
		gap = gap / (60 * 60); // 시간
		String result = "";
		if (gap < 24) {
			result = "<img src='../images/new.gif'>";
		}

		return result;
	}// displayNew

	// 첨부파일이 있을 경우 파일 이미지 보여주기
	public static String displayFile(String fileName) {
		String result = "";
		if (fileName != null) {
			result = "<img src='../images/file.gif'>";
		}

		return result;
	}// displayFile

	// 첨부파일 크기 구하기
	public static String displaySize(String fileName, double fileSize) {
		String size = "0";
		if (fileName != null && fileSize != 0) {
			if (fileSize > (1024 * 1024)) {
				size = Double.toString((Math.round((fileSize / (1024 * 1024) * 100)) / 100.0)) + " MB";
			} else if (fileSize > 1024) {
				size = Double.toString(Math.round((fileSize / 1024 * 100)) / 100.0) + " KB";
			} else {
				size = Double.toString(fileSize) + " byte";
			} // if
			System.out.println(fileName + " 파일 크기 : " + size);
		} // if

		return size;
	}// displaySize

}
