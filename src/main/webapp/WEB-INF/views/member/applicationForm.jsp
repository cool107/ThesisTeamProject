<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head lang="en">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

<title>Application Page</title>
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
	height: 440px;
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
		$("#application").on('click', application);
	});
	
	function application(){
		var member1 = $("#member1").val();
		var member2 = $("#member2").val();
		var member3 = $("#member3").val();
		var member4 = $("#member4").val();
		
		if (member1 == '${sessionScope.loginId}' || member2 == '${sessionScope.loginId}' || member3 == '${sessionScope.loginId}' || member4 == '${sessionScope.loginId}') {
			alert('間違えて入力しました。');
			return;
		}
		
		$.ajax({
			method : 'post'
			, url : 'checkGroupBoardNum'
			, data : { 'member1' : member1
						, 'member2' : member2
						, 'member3' : member3
						, 'member4' : member4 }
			, success : function(resp) {
				if (resp == 1) {
					alert("もうチーム掲示板に入っています。");
					return;
				} else if (resp == 2) {
					alert("会員ではありません。");
					return;
				} else {
					$("#insertApplication").submit();
				}
			}
		});
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
		<span style="font-size: 45px;">チーム掲示板</span> 申請
	</h4>
	<br>
	<form action="insertApplication" id="insertApplication" method="post">
		<fieldset>
			<table cellspacing="30">
				<tr style="height: 35px;"></tr>
				<tr style="text-align: left; font-size: 25px;">
					<td>チーム掲示板 申請者</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<input type="text" class="form-control" name="id" id="id" value="${sessionScope.loginId}" readonly="readonly">
						</div>
					</td>
				</tr>
				<tr style="text-align: left; font-size: 25px;">
					<td>メンバー</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<input type="text" class="form-control" name="member1"
								id="member1" placeholder="チームメンバー">
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<input type="text" class="form-control" name="member2"
								id="member2" placeholder="チームメンバー">
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<input type="text" class="form-control" name="member3"
								id="member3" placeholder="チームメンバー">
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<input type="text" class="form-control" name="member4"
								id="member4" placeholder="チームメンバー">
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;"><input
						class="btn btn-primary" id="application" type="button"
						value="APPLICATION"
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
