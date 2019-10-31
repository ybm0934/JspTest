<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드</title>
<style type="text/css">
.filebox label {
    display: inline-block;
    padding: .5em .75em;
    color: white;
    font-size: inherit;
    line-height: normal;
    vertical-align: middle;
    background-color: blue;
    cursor: pointer;
    border: 1px solid blue;
    border-bottom-color: blue;
    border-radius: .25em;
}

.filebox input[type="file"] { /* 파일 필드 숨기기 */
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}
</style>
</head>
<body>
	<form name="frm" method="post" action="uploadTest_ok1.jsp" enctype="multipart/form-data">
		작성자 : <input type="text" name="id"><br>
		파일명 : <input type="file" name="fileName" size="30"><br>
		<!-- 
		<div class="filebox">
			<label for="fileName">업로드</label>
			<input type="file" id="fileName">
		</div>
		 -->
		<input type="submit" value="파일 업로드"><br>
	</form>
</body>
</html>