function send() {
	if (document.frmWrite.title.value == "") {
		alert("제목을 입력하세요.");
		document.frmWrite.title.focus();
		return false;
	} else if (document.frmWrite.name.value == "") {
		alert("이름을 입력하세요.");
		document.frmWrite.name.focus();
		return false;
	} else if (document.frmWrite.pwd.value == "") {
		alert("비밀번호를 입력하세요.");
		document.frmWrite.pwd.focus();
		return false;
	} else if (document.frmWrite.content.value == "") {
		alert("내용을 입력하세요.");
		document.frmWrite.content.focus();
		return false;
	}

	if (document.frmWrite.title.value.length > 20) {
		alert("제목은 20글자까지만 가능합니다.");
		document.frmWrite.title.focus();
		return false;
	} else if (document.frmWrite.name.value.length > 20) {
		alert("이름은 20글자까지만 가능합니다.");
		document.frmWrite.name.focus();
		return false;
	} else if (document.frmWrite.pwd.value.length > 20) {
		alert("비밀번호는 20글자까지만 가능합니다.");
		document.frmWrite.pwd.focus();
		return false;
	} else if (document.frmWrite.email.value.length > 30) {
		alert("이메일은 20글자까지만 가능합니다.");
		document.frmWrite.email.focus();
		return false;
	}
}