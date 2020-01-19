<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head lang="en">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

<title>Join Page</title>
<meta name="description"
	content="BlackTie.co - Free Handsome Bootstrap Themes" />
<meta name="keywords"
	content="themes, bootstrap, free, templates, bootstrap 3, freebie,">
<meta property="og:title" content="">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/style.css">
<link
	href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:400,500,700&amp;subset=japanese"
	rel="stylesheet" type='text/css'>

</head>
<style>
body {
	background-image: url('resources/images/bg1.jpg');
	background-size: 100%;
}

fieldset {
	margin: auto;
	background-color: rgba(227, 227, 227, 0.5);
	width: 500px;
	height: 390px;
	border-radius: 20px;
	text-align: center;
}

table {
	margin: auto;
	text-align: center;
}
</style>
<script src="resources/js/jquery-3.3.1.js"></script>
<script>
			$(function() {
				$("#join").on('click', joinMember);
				$("#id").on('keyup', join);
			});
			
			function joinMember() {
				var id =$("#id").val();
				var pw = $('#pw').val();
				var name = $('#name').val();
				
				if(id == ""){
					alert("IDを入力してください。");
				} else if (pw == "") {
					alert("パスワードを入力してください。");
				} else  if (name == "") {
					alert("お名前を入力してください。");
				} else if ($('input:checkbox[id="infoCheck"]').is(":checked") == false) {
					alert("個人情報の利用規約に同意する。");
				} else {
					$("#joinMember").submit();
				};
			}
		
			function join() {
				var id = $("#id").val();
				
				if (id.length < 3 || id.length > 10) {
					$("#idCheckMsg").html("IDの長さは3~10字です。").css('color', 'red');
				} else {
					$.ajax({
						method : 'GET'
						, url : 'checkId'
						, data : {'id' : id}
						, success : function(resp){
							if (resp != "") {
								$("#idCheckMsg").html("このIDは使用中です。他のIDを選んでください。").css('color', 'red');
							} else {
								$("#idCheckMsg").html("このIDは使えます。").css('color', 'green');
							};
						}
					});
				};
			};
			

		</script>
<body>
	<div class="navbar navbar-fixed-top">
		<p style="text-align: right; font-size: 20px;">
			<a class="nav-link" href="/">HOME</a> &nbsp;&nbsp;&nbsp;
		</p>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<h4 class="font-thin"
		style="text-align: center; color: white; font-size: 32px;">
		ようこそ! <span style="font-size: 45px;">SC UNIVERSITY</span>へ
	</h4>
	<br>
	<form action="joinMember" id="joinMember" method="post">
		<fieldset>
			<table cellspacing="30">
				<tr style="height: 35px;"></tr>
				<tr>
					<td>
						<div class="form-group">
							<input type="text" class="form-control" name="id"
								id="id" placeholder="ID">
						</div>
					</td>
				</tr>
				<tr style="height: 30px;  vertical-align: middle;">
					<td>
						<div id="idCheckMsg"
							style="font-size: 20px;"></div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<input type="password" class="form-control" name="pw"
								id="pw" placeholder="PASSWORD">
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<input type="text" class="form-control" name="name"
								id="name" placeholder="NAME">
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<select class="selectpicker" name="department" id="department"
								style="width: 100%; height: 40px;">
								<option value="medical">医学系研究科</option>
								<option value="education">教育学研究科</option>
								<option value="economy">経済学研究科</option>
								<option value="engineering">工学系研究科</option>
								<option value="information">情報理工学系研究科</option>
								<option value="frontier science">新領域創成科学研究科</option>
								<option value="humanities">人文社会系研究科</option>
								<option value="mathematics">数理科学研究科</option>
								<option value="culture">総合文化研究科</option>
								<option value="agriculture">農学生命科学研究科</option>
								<option value="law">法学政治学研究科</option>
								<option value="pharmacy">薬学系研究科</option>
								<option value="sciences">理学系研究科</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<input type="checkbox" id="infoCheck"><span
								style="font-size: 20px;">個人情報の取り扱いおよび、利用規約に同意する。</span>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;"><input
						class="btn btn-primary" id="join" type="button" value="会員登録"
						style="width: 200px; background-color: white; border-color: #93b2ec; color: #93b2ec;">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
						class="btn btn-primary" href="../" type="button"
						style="width: 200px; background-color: white; border-color: #93b2ec; color: #93b2ec;">キャンセル</a>
					</td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>

</html>
