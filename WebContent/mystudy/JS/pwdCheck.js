function send() {
	if (document.pwdfrm.pwd.value == "") {
		alert("비밀번호를 입력하세요.");
		document.pwdfrm.pwd.focus();
		return false;
	}
}
